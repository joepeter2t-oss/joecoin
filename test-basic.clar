;; Basic test for joecoin contract

;; Test getting token name
(print "Token name:")
(print (contract-call? .joecoin get-name))

;; Test getting token symbol  
(print "Token symbol:")
(print (contract-call? .joecoin get-symbol))

;; Test getting decimals
(print "Token decimals:")
(print (contract-call? .joecoin get-decimals))

;; Test getting total supply
(print "Total supply:")
(print (contract-call? .joecoin get-total-supply))

;; Test getting balance of deployer
(print "Deployer balance:")
(print (contract-call? .joecoin get-balance tx-sender))