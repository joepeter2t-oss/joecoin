;; title: joecoin
;; version: 1.0.0
;; summary: JoeCoin - A SIP-010 compliant fungible token
;; description: JoeCoin is a fungible token implementation following the SIP-010 standard

;; traits
;; Note: SIP-010 trait implementation can be added when deploying to mainnet

;; token definitions
(define-fungible-token joecoin)

;; constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-token-owner (err u101))
(define-constant err-insufficient-balance (err u102))
(define-constant err-invalid-amount (err u103))

;; Token metadata
(define-constant token-name "JoeCoin")
(define-constant token-symbol "JOE")
(define-constant token-decimals u6)
(define-constant token-uri (some u"https://joecoin.xyz/metadata.json"))

;; Initial supply: 1,000,000 JOE (with 6 decimals = 1,000,000,000,000 microJOE)
(define-constant initial-supply u1000000000000)

;; data vars
(define-data-var token-supply uint u0)
(define-data-var contract-paused bool false)

;; data maps
(define-map approved-contracts principal bool)

;; Initialize contract - mint initial supply to contract owner
(begin
  (try! (ft-mint? joecoin initial-supply contract-owner))
  (var-set token-supply initial-supply)
)

;; public functions

;; SIP-010 Standard Functions

;; Transfer tokens
(define-public (transfer (amount uint) (sender principal) (recipient principal) (memo (optional (buff 34))))
  (begin
    (asserts! (or (is-eq tx-sender sender) (is-eq contract-caller sender)) err-not-token-owner)
    (asserts! (> amount u0) err-invalid-amount)
    (asserts! (not (var-get contract-paused)) (err u104))
    (ft-transfer? joecoin amount sender recipient)
  )
)

;; Get token name
(define-read-only (get-name)
  (ok token-name)
)

;; Get token symbol
(define-read-only (get-symbol)
  (ok token-symbol)
)

;; Get token decimals
(define-read-only (get-decimals)
  (ok token-decimals)
)

;; Get token balance of a principal
(define-read-only (get-balance (account principal))
  (ok (ft-get-balance joecoin account))
)

;; Get total supply
(define-read-only (get-total-supply)
  (ok (var-get token-supply))
)

;; Get token URI
(define-read-only (get-token-uri)
  (ok token-uri)
)

;; Additional functions

;; Mint new tokens (only contract owner)
(define-public (mint (amount uint) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (asserts! (> amount u0) err-invalid-amount)
    (asserts! (not (var-get contract-paused)) (err u104))
    (try! (ft-mint? joecoin amount recipient))
    (var-set token-supply (+ (var-get token-supply) amount))
    (ok true)
  )
)

;; Burn tokens
(define-public (burn (amount uint) (sender principal))
  (begin
    (asserts! (or (is-eq tx-sender sender) (is-eq contract-caller sender)) err-not-token-owner)
    (asserts! (> amount u0) err-invalid-amount)
    (asserts! (not (var-get contract-paused)) (err u104))
    (try! (ft-burn? joecoin amount sender))
    (var-set token-supply (- (var-get token-supply) amount))
    (ok true)
  )
)

;; Pause/unpause contract (only owner)
(define-public (set-paused (paused bool))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (var-set contract-paused paused)
    (ok true)
  )
)

;; Approve contract for operations (only owner)
(define-public (set-contract-approved (contract principal) (approved bool))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (map-set approved-contracts contract approved)
    (ok true)
  )
)

;; read only functions

;; Check if contract is paused
(define-read-only (is-paused)
  (var-get contract-paused)
)

;; Check if contract is approved
(define-read-only (is-contract-approved (contract principal))
  (default-to false (map-get? approved-contracts contract))
)

;; Get contract owner
(define-read-only (get-owner)
  contract-owner
)

;; private functions

;; Validate principal
(define-private (is-valid-principal (principal-to-check principal))
  (not (is-eq principal-to-check 'SP000000000000000000002Q6VF78))
)

