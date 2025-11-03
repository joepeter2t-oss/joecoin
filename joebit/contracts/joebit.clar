;; JoeBit fungible token (SIP-010-like, no allowances)

;; Error codes
(define-constant ERR_UNAUTHORIZED u100)
(define-constant ERR_INSUFFICIENT_BALANCE u101)
(define-constant ERR_AMOUNT_ZERO u102)
(define-constant ERR_ALREADY_INITIALIZED u103)
(define-constant ERR_NOT_INITIALIZED u104)

;; Metadata
(define-constant TOKEN_NAME "JoeBit")
(define-constant TOKEN_SYMBOL "JOEBIT")
(define-constant TOKEN_DECIMALS u6)

;; State
(define-data-var total-supply uint u0)
(define-data-var owner (optional principal) none)
(define-map balances { owner: principal } uint)

;; Initialize the contract: the first caller becomes the owner.
(define-public (initialize)
  (if (is-some (var-get owner))
      (err ERR_ALREADY_INITIALIZED)
      (begin
        (var-set owner (some tx-sender))
        (ok true))))

;; SIP-010 read-onlys
(define-read-only (get-name) (ok TOKEN_NAME))
(define-read-only (get-symbol) (ok TOKEN_SYMBOL))
(define-read-only (get-decimals) (ok TOKEN_DECIMALS))
(define-read-only (get-total-supply) (ok (var-get total-supply)))
(define-read-only (get-balance (who principal))
  (ok (get-balance-internal who)))

;; Transfer (SIP-010-like): caller must equal `sender`.
(define-public (transfer (amount uint) (sender principal) (recipient principal) (memo (optional (buff 34))))
  (if (is-eq tx-sender sender)
      (transfer-internal amount sender recipient)
      (err ERR_UNAUTHORIZED)))

;; Mint new tokens to a recipient; only owner (set via `initialize`) may mint.
(define-public (mint (amount uint) (recipient principal))
  (match (var-get owner)
    owner-principal
      (if (is-eq tx-sender owner-principal)
          (if (is-eq amount u0)
              (err ERR_AMOUNT_ZERO)
              (begin
                (var-set total-supply (+ (var-get total-supply) amount))
                (let ((dst (get-balance-internal recipient)))
                  (set-balance! recipient (+ dst amount)))
                (ok true)))
          (err ERR_UNAUTHORIZED))
    (err ERR_NOT_INITIALIZED)))

;; ===============
;; Private helpers
;; ===============

(define-private (get-balance-internal (who principal))
  (default-to u0 (map-get? balances { owner: who })))

(define-private (set-balance! (who principal) (amount uint))
  (if (is-eq amount u0)
      (begin (map-delete balances { owner: who }) true)
      (begin (map-set balances { owner: who } amount) true)))

(define-private (transfer-internal (amount uint) (sender principal) (recipient principal))
  (let
    (
      (src (get-balance-internal sender))
      (dst (get-balance-internal recipient))
    )
    (if (or (is-eq amount u0) (> amount src))
        (err (if (is-eq amount u0) ERR_AMOUNT_ZERO ERR_INSUFFICIENT_BALANCE))
        (begin
          (set-balance! sender (- src amount))
          (set-balance! recipient (+ dst amount))
          (ok true)))))
