class IdeaJuggler < Formula
  desc "CLI tool that manages separate IntelliJ IDEA instances per project"
  homepage "https://github.com/maxmedvedev/idea-juggler"
  url "https://github.com/maxmedvedev/idea-juggler/releases/download/0.0.1/idea-juggler-0.0.1.tar.gz"
  sha256 "0d522a21a5b10635bc337370973c39875c0fab6c18f52d7a93ea51e78e3cf973"
  license "MIT"

  depends_on "openjdk@17"

  def install
    # Install JARs to private libexec directory
    libexec.install Dir["libexec/*"]

    # Install pre-built wrapper script
    bin.install "bin/idea-juggler"

    # Ensure JAVA_HOME points to Homebrew's OpenJDK
    # The wrapper script will use this automatically
    ENV.prepend_path "PATH", Formula["openjdk@17"].opt_bin
  end

  def caveats
    <<~EOS
      idea-juggler requires Java 17+.

      If you encounter Java-related issues, set JAVA_HOME explicitly:
        export JAVA_HOME="#{Formula["openjdk@17"].opt_prefix}/libexec/openjdk.jdk/Contents/Home"
    EOS
  end

  test do
    output = shell_output("#{bin}/idea-juggler --help 2>&1")
    assert_match "idea-juggler", output.downcase
    assert_match "version", output.downcase
  end
end
