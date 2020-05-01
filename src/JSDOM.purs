module JSDOM
  ( JSDOM
  , JSDOMOptions, jsdom
  , RunScripts, dangerously
  , Resources, usable, ResourceLoaderOptions, resourceLoader
  , VirtualConsole, virtualConsole
  ) where

import Prelude
import Data.MediaType (MediaType)
import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, runEffectFn1, runEffectFn2)
import Row.Class (class SubRow)
import Web.HTML (Window)
import Unsafe.Coerce (unsafeCoerce)



foreign import data JSDOM :: Type

foreign import mkJsdomImpl :: forall options. EffectFn2 String (Record options) JSDOM

type JSDOMOptions =
  ( url :: String
  , referrer :: String
  , contentType :: MediaType
  , includeNodeLocations :: Boolean
  , storageQuota :: Number
  , runScripts :: RunScripts
  , resources :: Resources
  , virtualConsole :: VirtualConsole
  )

jsdom :: forall options
       . SubRow options JSDOMOptions
      => String -> (Record options) -> Effect JSDOM
jsdom = runEffectFn2 mkJsdomImpl

newtype RunScripts = RunScripts String

dangerously :: RunScripts
dangerously = RunScripts "dangerously"

newtype Resources = Resources String

usable :: Resources
usable = Resources "usable"


foreign import mkResourceLoaderImpl :: forall options. EffectFn1 (Record options) Resources

type ResourceLoaderOptions =
  ( proxy :: String
  , strictSSL :: Boolean
  , userAgent :: String
  )

resourceLoader :: forall options
                . SubRow options ResourceLoaderOptions
               => (Record options) -> Effect Resources
resourceLoader = runEffectFn1 mkResourceLoaderImpl


window :: JSDOM -> Effect Window
window x = pure ((unsafeCoerce x).window)


foreign import data VirtualConsole :: Type

foreign import virtualConsole :: Effect VirtualConsole
