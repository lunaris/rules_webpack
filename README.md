# WORK IN PROGRESS

This repository does not actually do what it says it does and is at present a
copy-paste-rename-in-progress of heyhabito/rules_purescript. There is a plan,
however:

* Define some toolchains and rules so that users can write things like:

```
webpack_bundle(
  name = "...",
  ...,
  deps = [
    "//path/to/another/bundle",

    "@npm//an/npm/package",
    "@npm//another/npm/package:target",
  ],
)
```

* In JavaScript/Webpack-compatible code, import dependencies as normal, whether
  they come from the monorepo or other repositories:

```
import I1 from 'another_bundle';

import I2 from 'an_npm_package';
import I2 from 'another_npm_package';
```

* Have `webpack_bundle` call Webpack with a set of arguments that mean it
  always has a custom resolver plugin (perhaps also provided by this
  repository) which can resolve imports across the monorepo. `webpack_bundle`
  might also pass `--env` or other such flags to enable this.

* In theory, this is all there is to it -- cross-monorepository dependencies
  are now tracked by Bazel but all it does is pass them to Webpack invocations.
  Consequently it's hopefully true that one could run things like `bazel run
  //a/webpack/bundle:bundle@watch` and it'd just call the normal watch function
  of Webpack (albeit with the custom resolver trickery), allowing us to take
  advantage of all the cool features of Webpack but have Bazel know about
  inputs/outputs.

# Webpack rules for [Bazel][bazel]

Bazel automates building and testing software. It scales to very large
multi-language projects. This project extends Bazel with build rules for
Webpack.

[bazel]: https://bazel.build
[bazel-getting-started]: https://docs.bazel.build/versions/master/getting-started.html
[nix]: https://nixos.org/nix

## Requirements

* [Bazel >= 0.20.0][bazel-getting-started]

