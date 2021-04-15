hooks = File.ls!("./git_hooks")

for hook <- hooks do
  hook = String.replace_trailing(hook, ".sh", "")
  File.rm(".git/hooks/#{hook}")

  if File.ln_s("../../git_hooks/#{hook}.sh", ".git/hooks/#{hook}") == :ok do
    IO.puts("Symlinked #{hook}.")
  else
    IO.puts("Couldn't symlink #{hook}.")
  end
end
