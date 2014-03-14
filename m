From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ata: ahci_platform: fix devm_ioremap_resource() return value
 checking
Date: Fri, 14 Mar 2014 18:22:09 +0100
Message-ID: <2139783.QvectlX5nq@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:51105 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755432AbaCNRW1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Mar 2014 13:22:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

devm_ioremap_resource() returns a pointer to the remapped memory or
an ERR_PTR() encoded error code on failure.  Fix the check inside
ahci_platform_get_resources() accordingly.

Also while at it remove a needless line break.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Compile tested only.

 drivers/ata/ahci_platform.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: b/drivers/ata/ahci_platform.c
===================================================================
--- a/drivers/ata/ahci_platform.c	2014-03-14 16:45:04.056724383 +0100
+++ b/drivers/ata/ahci_platform.c	2014-03-14 17:54:12.504653647 +0100
@@ -199,8 +199,7 @@ static void ahci_platform_put_resources(
  * RETURNS:
  * The allocated ahci_host_priv on success, otherwise an ERR_PTR value
  */
-struct ahci_host_priv *ahci_platform_get_resources(
-	struct platform_device *pdev)
+struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
@@ -219,8 +218,9 @@ struct ahci_host_priv *ahci_platform_get
 
 	hpriv->mmio = devm_ioremap_resource(dev,
 			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
-	if (!hpriv->mmio) {
+	if (IS_ERR(hpriv->mmio)) {
 		dev_err(dev, "no mmio space\n");
+		rc = PTR_ERR(hpriv->mmio);
 		goto err_out;
 	}
 

