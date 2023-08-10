@isTest
public class IntelligentFilesSearchPostInstallTest {
    @isTest
    static void testInstallScript() {
    IntelligentFilesSearchPostInstall postinstall = new IntelligentFilesSearchPostInstall();
    Test.testInstall(postinstall, null);
    Test.testInstall(postinstall, new Version(1,0), true);
    }
}