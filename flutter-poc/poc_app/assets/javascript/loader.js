import { p as promiseResolve, b as bootstrapLazy } from './index-62e99a85.js';

/*
 Stencil Client Patch Esm v2.5.2 | MIT Licensed | https://stenciljs.com
 */
const patchEsm = () => {
    return promiseResolve();
};

const defineCustomElements = (win, options) => {
  if (typeof window === 'undefined') return Promise.resolve();
  return patchEsm().then(() => {
  return bootstrapLazy([["base-component",[[2,"base-component",{"text":[1]}]]]], options);
  });
};

export { defineCustomElements };
