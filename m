From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH ide-2.6] pdc202xx_new: Enable ATAPI DMA
Date: Tue, 08 Mar 2005 18:50:15 +0800
Message-ID: <422D8367.1050606@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from bluehawaii.tikira.net ([61.62.22.51]:10239 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261979AbVCHKuf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 Mar 2005 05:50:35 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Hi Bart,

   These is the patch to turn on pdc202xx_new for ATAPI DMA.
When testing, it works fine without the (request_bufflen % 256) workaround as needed in libata.
ide-scsi filters out (pc->request_transfer % 1024) and use PIO, so the pdc202xx ATAPI DMA problem is avoid.
Both ide-cd and ide-scsi won't hit the ATAPI DMA problem on pdc202xx_new.


Changes:
  - Turn on ATAPI DMA for pdc202xx_new

  Attached please find the patch against the ide-2.6 tree for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
-------
diff -Nru libata-dev-2.6-hwauto/drivers/ide/pci/pdc202xx_new.c libata-dev-2.6-atapidma/drivers/ide/pci/pdc202xx_new.c
--- libata-dev-2.6-hwauto/drivers/ide/pci/pdc202xx_new.c	2005-03-07 18:19:06.000000000 +0800
+++ libata-dev-2.6-atapidma/drivers/ide/pci/pdc202xx_new.c	2005-03-08 18:34:23.000000000 +0800
@@ -290,7 +290,8 @@
  		printk(KERN_WARNING "%s reduced to Ultra33 mode.\n", drive->name);
  	}

-	if (drive->media != ide_disk)
+	if (drive->media != ide_disk &&
+	    drive->media != ide_cdrom)
  		return 0;

  	if (id->capability & 4) {	/* IORDY_EN & PREFETCH_EN */
@@ -633,6 +634,7 @@

  	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;

+	hwif->atapi_dma  = 1;
  	hwif->ultra_mask = 0x7f;
  	hwif->mwdma_mask = 0x07;



