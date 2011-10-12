From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] pata_arasan_cf: remove bogus to_platform_device() calls
Date: Wed, 12 Oct 2011 19:09:09 +0400
Message-ID: <201110121909.09664.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:49233 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753126Ab1JLPKf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Oct 2011 11:10:35 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com, viresh.kumar@st.com

The suspend()/resume() methods already get the right 'struct device' to get the
driver data from -- there's no need to get to the 'struct platform_device' that
contains that 'struct device' just to call dev_get_drvdata()...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is against the recent Linus' tree.

 drivers/ata/pata_arasan_cf.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/ata/pata_arasan_cf.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_arasan_cf.c
+++ linux-2.6/drivers/ata/pata_arasan_cf.c
@@ -922,8 +922,7 @@ static int __devexit arasan_cf_remove(st
 #ifdef CONFIG_PM
 static int arasan_cf_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = dev_get_drvdata(dev);
 	struct arasan_cf_dev *acdev = host->ports[0]->private_data;
 
 	if (acdev->dma_chan) {
@@ -937,8 +936,7 @@ static int arasan_cf_suspend(struct devi
 
 static int arasan_cf_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = dev_get_drvdata(dev);
 	struct arasan_cf_dev *acdev = host->ports[0]->private_data;
 
 	cf_init(acdev);
