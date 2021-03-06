(declare-sort Loc 0)
(declare-const loc0 Loc)
(declare-const loc1 Loc)
(declare-const loc2 Loc)
(declare-const loc3 Loc)

(assert (distinct loc0 loc1 loc2 loc3))

(define-fun cfg_init ( (pc Loc) (src Loc) (rel Bool) ) Bool 
  (and (= pc src) rel))

(define-fun cfg_trans2 ( (pc Loc) (src Loc) (pc1 Loc) (dst Loc) (rel Bool) ) Bool
  (and (= pc src) (= pc1 dst) rel))

(define-fun init_main ( (pc Loc) (k Int) (x Int) ) Bool 
  (cfg_init pc loc0 true)
)

(define-fun next_main ( (pc Loc)  (k Int)  (x Int)
                   (pc1 Loc) (k1 Int) (x1 Int)
        ) Bool 
  (or 
    (cfg_trans2 pc loc0 pc1 loc1 (and (= k1 1) (= x1 x) ) )
    (cfg_trans2 pc loc1 pc1 loc2 (and (> x 0) (= k1 k) (= x1 x) ) )
    (cfg_trans2 pc loc1 pc1 loc3 (and (not (> x 0)) (= k1 k) (= x1 x) ) )
    (cfg_trans2 pc loc2 pc1 loc1 (and (= k1 k) (or (= x1 (- x k)) (= x1 (- x 1))) (or (> x 7) (> x 10) (and (> x 14) (> x 12))) ) )
  )
)
