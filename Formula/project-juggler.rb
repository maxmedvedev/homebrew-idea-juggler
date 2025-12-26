class ProjectJuggler < Formula
  desc "CLI tool that manages separate IntelliJ IDEA instances per project"
  homepage "https://github.com/maxmedvedev/project-juggler"
  url "https://github.com/maxmedvedev/project-juggler/releases/download/0.0.1/project-juggler-0.0.1.tar.gz"
  sha256 "4400a15edcb6664b84e93c4a35f57d8675aab76ec1d45ba32a24f85aed4833aa"
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
