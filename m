From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/2] sata_mv: use {platform|pci}_get_drvdata()
Date: Fri, 7 Oct 2011 19:24:22 +0400
Message-ID: <201110071924.22270.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:45911 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753044Ab1JGPc0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Oct 2011 11:32:26 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com

The driver uses dev_get_drvdata() to get to the driver data for the platform and
PCI devices, while the corresponding wrappers exists for them -- in one case it
even declares an otherwise unneeded variable  to do that.  Switch to using the
{platform|pci}_get_drvdata() instead.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
 drivers/ata/sata_mv.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/ata/sata_mv.c
===================================================================
--- linux-2.6.orig/drivers/ata/sata_mv.c
+++ linux-2.6/drivers/ata/sata_mv.c
@@ -4110,8 +4110,7 @@ err:
  */
 static int __devexit mv_platform_remove(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
-	struct ata_host *host = dev_get_drvdata(dev);
+	struct ata_host *host = platform_get_drvdata(pdev);
 #if defined(CONFIG_HAVE_CLK)
 	struct mv_host_priv *hpriv = host->private_data;
 #endif
@@ -4129,7 +4128,7 @@ static int __devexit mv_platform_remove(
 #ifdef CONFIG_PM
 static int mv_platform_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = platform_get_drvdata(pdev);
 	if (host)
 		return ata_host_suspend(host, state);
 	else
@@ -4138,7 +4137,7 @@ static int mv_platform_suspend(struct pl
 
 static int mv_platform_resume(struct platform_device *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = platform_get_drvdata(pdev);
 	int ret;
 
 	if (host) {
@@ -4353,7 +4352,7 @@ static int mv_pci_init_one(struct pci_de
 #ifdef CONFIG_PM
 static int mv_pci_device_resume(struct pci_dev *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 	int rc;
 
 	rc = ata_pci_device_do_resume(pdev);
