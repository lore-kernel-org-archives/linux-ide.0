From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 12/15] alim15x3: ->speedproc, filter out invalid modes passed from user-space
Date: Sat, 30 Jun 2007 21:10:20 +0200
Message-ID: <200706302110.20766.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:51198 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754406AbXF3TAT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jun 2007 15:00:19 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1759202mue
        for <linux-ide@vger.kernel.org>; Sat, 30 Jun 2007 12:00:18 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* ->speedproc, filter out invalid modes passed from user-space.

* Add FIXME about DMA timings never being set.

* Bump driver version.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/alim15x3.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -425,6 +425,17 @@ static int ali15x3_tune_chipset (ide_dri
 	u8 tmpbyte		= 0x00;
 	int m5229_udma		= (hwif->channel) ? 0x57 : 0x56;
 
+	/*
+	 * Paranoia, filter out invalid modes passed from user-space
+	 * (unsupported UDMA modes are dealt by ide_rate_filter() call).
+	 *
+	 * This will go away once ide_set_xfer() is fixed.
+	 */
+	if ((speed > XFER_PIO_5 && speed < XFER_SW_DMA_0) ||
+	    (speed > XFER_SW_DMA_2 && speed < XFER_MW_DMA_0) ||
+	    (speed > XFER_MW_DMA_2 && speed < XFER_UDMA_0))
+		return -1;
+
 	if (speed == XFER_UDMA_6)
 		speed1 = 0x47;
 
@@ -437,6 +448,10 @@ static int ali15x3_tune_chipset (ide_dri
 		tmpbyte &= ultra_enable;
 		pci_write_config_byte(dev, m5229_udma, tmpbyte);
 
+		/*
+		 * FIXME: Oh, my... DMA timings are never set.
+		 */
+
 		if (speed < XFER_SW_DMA_0)
 			(void) ali15x3_tune_pio(drive, speed - XFER_PIO_0);
 	} else {
