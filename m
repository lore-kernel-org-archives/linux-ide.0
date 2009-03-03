From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] pata-rb532-cf: platform_get_irq() failure ignored
Date: Tue, 03 Mar 2009 14:04:26 +0100
Message-ID: <49AD2ADA.5030109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:14175 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754364AbZCCNE3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Mar 2009 08:04:29 -0500
Received: by nf-out-0910.google.com with SMTP id d21so561228nfb.21
        for <linux-ide@vger.kernel.org>; Tue, 03 Mar 2009 05:04:26 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@redhat.com
Cc: linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

------------------------------>8-------------8<---------------------------------
platform_get_irq() can return -ENXIO, but since 'irq' is an unsigned int, it
does not show when the IRQ resource wasn't found.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index ebfcda2..fe8178c 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -173,11 +173,12 @@ static __devinit int rb532_pata_driver_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
+	ret = platform_get_irq(pdev, 0);
+	if (ret <= 0) {
 		dev_err(&pdev->dev, "no IRQ resource found\n");
 		return -ENOENT;
 	}
+	irq = ret;
 
 	gpio = irq_to_gpio(irq);
 	if (gpio < 0) {
