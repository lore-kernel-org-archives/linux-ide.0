From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2.6.22-rc6] sata_inic162x: add big fat warning about broken
 LBA48 support
Date: Fri, 29 Jun 2007 01:07:47 +0900
Message-ID: <4683DCD3.1040303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:15297 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbXF1QHx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jun 2007 12:07:53 -0400
Received: by nz-out-0506.google.com with SMTP id s18so145868nze
        for <linux-ide@vger.kernel.org>; Thu, 28 Jun 2007 09:07:52 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

sata_inic162x can't do LBA48 properly yet.  Whine loudly about it to
reduce confusion.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_inic162x.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: work/drivers/ata/sata_inic162x.c
===================================================================
--- work.orig/drivers/ata/sata_inic162x.c
+++ work/drivers/ata/sata_inic162x.c
@@ -664,8 +664,12 @@ static int inic_init_one(struct pci_dev 
 	void __iomem * const *iomap;
 	int i, rc;
 
-	if (!printed_version++)
+	if (!printed_version++) {
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
+		printk(KERN_WARNING "WARNING: sata_inic162x doesn't support "
+		       "LBA48 yet. Devices larger than\n         "
+		       "2^28 - 1 sectors (~127GiB) won't work.\n");
+	}
 
 	/* alloc host */
 	host = ata_host_alloc_pinfo(&pdev->dev, ppi, NR_PORTS);
