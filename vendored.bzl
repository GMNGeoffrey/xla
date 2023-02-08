def _vendored_impl(repository_ctx):
    parent_path = repository_ctx.path(repository_ctx.attr.parent).dirname
    # get_child doesn't allow slashes. Yes this is silly. bazel_skylib paths
    # doesn't work with path objects.
    relpath_parts = repository_ctx.attr.relpath.split("/")
    vendored_path = parent_path
    for part in relpath_parts:
      vendored_path = vendored_path.get_child(part)
    repository_ctx.symlink(vendored_path, ".")


vendored = repository_rule(
    implementation = _vendored_impl,
    attrs = {
        "parent": attr.label(default = "//:WORKSPACE"),
        "relpath": attr.string(),
    },
)
