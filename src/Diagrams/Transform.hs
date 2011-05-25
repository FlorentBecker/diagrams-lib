-----------------------------------------------------------------------------
-- |
-- Module      :  Diagrams.Transform
-- Copyright   :  (c) 2011 diagrams-lib team (see LICENSE)
-- License     :  BSD-style (see LICENSE)
-- Maintainer  :  diagrams-discuss@googlegroups.com
--
-- Some convenient functions related to transformations.
--
-----------------------------------------------------------------------------

module Diagrams.Transform
       ( conjugate, under

       ) where

import Graphics.Rendering.Diagrams
import Diagrams.Util

-- | Conjugate one transformation by another. @conjugate t1 t2@ is the
--   transformation which performs first @t1@, then @t2@, then the
--   inverse of @t1@.
conjugate :: HasLinearMap v => Transformation v -> Transformation v -> Transformation v
conjugate t1 t2  = inv t1 <> t2 <> t1

-- | Carry out some transformation \"under\" another one: @f ``under``
--   t@ first applies @t@, then @f@, then the inverse of @t@.  For
--   example, @'rotateBy' (1/3) ``under`` 'translationX' 1@ is
--   equivalent to a rotation by 120 degrees about the point
--   @(-1,0)@.
under :: Transformable a => (a -> a) -> Transformation (V a) -> a -> a
f `under` t = transform (inv t) . f . transform t