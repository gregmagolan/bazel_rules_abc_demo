load(":source_aspects.bzl", "sources_aspect_es5")

def _es5_consumer(ctx):
  files = depset()

  for d in ctx.attr.deps:
    if hasattr(d, "node_sources"):
      files += d.node_sources
    elif hasattr(d, "files"):
      files += d.files

  return [DefaultInfo(
      files = files,
      runfiles = ctx.runfiles(files.to_list()),
  )]

es5_consumer = rule(
    implementation = _es5_consumer,
    attrs = {
        "deps": attr.label_list(
            allow_files = True,
            aspects = [sources_aspect_es5],
          ),
    }
)