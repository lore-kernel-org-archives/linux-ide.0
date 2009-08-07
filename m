From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] pata_at91: fix resource release
Date: Fri, 07 Aug 2009 11:15:20 +0900
Message-ID: <4A7B8E38.3010300@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55140 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754239AbZHGCQe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Aug 2009 22:16:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Sergey Matyukevich <geomatsi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, julia@diku.dk

Julias Lawall discovered that pata_at91 wasn't freeing a memory region
allocated with kzalloc() on init failure paths.  Upon review,
pata_at91 also seems to be doing unnecessary explicit resource
releases for managed resources too.  Convert memory allocation to
managed one and drop unnecessary explicit resource releases.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Julia Lawall <julia@diku.dk>
Cc: Sergey Matyukevich <geomatsi@gmail.com>
---
 drivers/ata/pata_at91.c |   17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
index 5702aff..41c94b1 100644
--- a/drivers/ata/pata_at91.c
+++ b/drivers/ata/pata_at91.c
@@ -250,7 +250,7 @@ static int __devinit pata_at91_probe(struct platform_device *pdev)
 		ata_port_desc(ap, "no IRQ, using PIO polling");
 	}

-	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);

 	if (!info) {
 		dev_err(dev, "failed to allocate memory for private data\n");
@@ -275,7 +275,7 @@ static int __devinit pata_at91_probe(struct platform_device *pdev)
 	if (!info->ide_addr) {
 		dev_err(dev, "failed to map IO base\n");
 		ret = -ENOMEM;
-		goto err_ide_ioremap;
+		goto err_put;
 	}

 	info->alt_addr = devm_ioremap(dev,
@@ -284,7 +284,7 @@ static int __devinit pata_at91_probe(struct platform_device *pdev)
 	if (!info->alt_addr) {
 		dev_err(dev, "failed to map CTL base\n");
 		ret = -ENOMEM;
-		goto err_alt_ioremap;
+		goto err_put;
 	}

 	ap->ioaddr.cmd_addr = info->ide_addr;
@@ -303,13 +303,8 @@ static int __devinit pata_at91_probe(struct platform_device *pdev)
 			irq ? ata_sff_interrupt : NULL,
 			irq_flags, &pata_at91_sht);

-err_alt_ioremap:
-	devm_iounmap(dev, info->ide_addr);
-
-err_ide_ioremap:
+err_put:
 	clk_put(info->mck);
-	kfree(info);
-
 	return ret;
 }

@@ -317,7 +312,6 @@ static int __devexit pata_at91_remove(struct platform_device *pdev)
 {
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
 	struct at91_ide_info *info;
-	struct device *dev = &pdev->dev;

 	if (!host)
 		return 0;
@@ -328,11 +322,8 @@ static int __devexit pata_at91_remove(struct platform_device *pdev)
 	if (!info)
 		return 0;

-	devm_iounmap(dev, info->ide_addr);
-	devm_iounmap(dev, info->alt_addr);
 	clk_put(info->mck);

-	kfree(info);
 	return 0;
 }

