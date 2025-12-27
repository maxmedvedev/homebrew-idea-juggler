class ProjectJuggler < Formula
  desc "CLI tool that manages separate IntelliJ IDEA instances per project"
  homepage "https://github.com/maxmedvedev/project-juggler"
  url "https://github.com/maxmedvedev/project-juggler/releases/download/0.0.2/project-juggler-0.0.2.tar.gz"
  sha256 "2d3b53a45039796d3b47b0016f1b0cb73c7fa8b5365edac097deadf2d90c366f"
  license "MIT"

  depends_on "openjdk@17"

  def install
    # Install JARs to private libexec directory
    libexec.install Dir["libexec/*"]

    # Install pre-built wrapper script
    bin.install "bin/project-juggler"

    # Ensure JAVA_HOME points to Homebrew's OpenJDK
    # The wrapper script will use this automatically
    ENV.prepend_path "PATH", Formula["openjdk@17"].opt_bin
  end

  def caveats
    <<~EOS
      project-juggler requires Java 17+.

      If you encounter Java-related issues, set JAVA_HOME explicitly:
        export JAVA_HOME="#{Formula["openjdk@17"].opt_prefix}/libexec/openjdk.jdk/Contents/Home"
    EOS
  end

  test do
    output = shell_output("#{bin}/project-juggler --help 2>&1")
    assert_match "project-juggler", output.downcase
    assert_match "version", output.downcase
  end
end
