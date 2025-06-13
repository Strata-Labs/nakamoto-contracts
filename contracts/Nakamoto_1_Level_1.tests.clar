


(define-public (test-update-minting-paused)
    (begin
        ;;(try! (stx-transfer? u290696900 tx-sender 'SP2EEV5QBZA454MSMW9W3WJNRXVJF36VPV17FFKYH.Nakamoto_1_Level_1))
        ;;(contract-call? 'SP2EEV5QBZA454MSMW9W3WJNRXVJF36VPV17FFKYH.Nakamoto_1_Level_1 Mint_2_Nakamoto_1_Level_1)
        (if (is-eq tx-sender 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)
            (begin
                (try! (update-minting-paused false))
                (ok true)
            )
            (ok false)
        )
    )
)

(define-public (test-minting)
    (if (and
            (not (var-get minting-paused))
            (> (stx-get-balance tx-sender) u300000000))
        (begin
            (try! (Mint_2_Nakamoto_1_Level_1 tx-sender))
            (ok true)
        )
        (ok false)
    )
)

(define-public (test-airdrop)
    (if (is-eq tx-sender 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)
        (begin
            ;; 174 owned by SP3HB08HQRFSZFQNMPBDSR56QZVPX4KKV093KFB00
            ;; 16686 was burnt
            (try! (airdrop-uints (list u174 u16686)))
            (asserts! (is-eq (nft-get-owner? Nakamoto_1_Level_1 u1) (some 'SP3HB08HQRFSZFQNMPBDSR56QZVPX4KKV093KFB00)) (err u9998))
            (asserts! (is-eq (nft-get-owner? Nakamoto_1_Level_1 u2) (some 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)) (err u9999))
            (ok true)
        )
        (ok false)
    )
)

