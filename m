From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] libata: ignore deverr on SETXFER if mode
 is configured
Date: Thu, 07 Feb 2008 10:34:08 +0900
Message-ID: <47AA6010.30003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:34778 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbYBGBeP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Feb 2008 20:34:15 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2079989rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 06 Feb 2008 17:34:14 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>

Some controllers (VIA CX700) raise device error on SETXFER even after
mode configuration succeeded.  Update ata_dev_set_mode() such that
device error is ignored if transfer mode is configured correctly.  To
implement this, device is revalidated even after device error on
SETXFER.

This fixes kernel bugzilla bug 8563.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 drivers/ata/libata-core.c |   48 +++++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index bdbd55a..bcd2860 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3048,6 +3048,8 @@ int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel)
 static int ata_dev_set_mode(struct ata_device *dev)
 {
 	struct ata_eh_context *ehc = &dev->link->eh_context;
+	const char *dev_err_whine = "";
+	int ign_dev_err = 0;
 	unsigned int err_mask;
 	int rc;
 
@@ -3057,41 +3059,57 @@ static int ata_dev_set_mode(struct ata_device *dev)
 
 	err_mask = ata_dev_set_xfermode(dev);
 
+	if (err_mask & ~AC_ERR_DEV)
+		goto fail;
+
+	/* revalidate */
+	ehc->i.flags |= ATA_EHI_POST_SETMODE;
+	rc = ata_dev_revalidate(dev, ATA_DEV_UNKNOWN, 0);
+	ehc->i.flags &= ~ATA_EHI_POST_SETMODE;
+	if (rc)
+		return rc;
+
 	/* Old CFA may refuse this command, which is just fine */
 	if (dev->xfer_shift == ATA_SHIFT_PIO && ata_id_is_cfa(dev->id))
-		err_mask &= ~AC_ERR_DEV;
+		ign_dev_err = 1;
 
 	/* Some very old devices and some bad newer ones fail any kind of
 	   SET_XFERMODE request but support PIO0-2 timings and no IORDY */
 	if (dev->xfer_shift == ATA_SHIFT_PIO && !ata_id_has_iordy(dev->id) &&
 			dev->pio_mode <= XFER_PIO_2)
-		err_mask &= ~AC_ERR_DEV;
+		ign_dev_err = 1;
 
 	/* Early MWDMA devices do DMA but don't allow DMA mode setting.
 	   Don't fail an MWDMA0 set IFF the device indicates it is in MWDMA0 */
 	if (dev->xfer_shift == ATA_SHIFT_MWDMA &&
 	    dev->dma_mode == XFER_MW_DMA_0 &&
 	    (dev->id[63] >> 8) & 1)
-		err_mask &= ~AC_ERR_DEV;
+		ign_dev_err = 1;
 
-	if (err_mask) {
-		ata_dev_printk(dev, KERN_ERR, "failed to set xfermode "
-			       "(err_mask=0x%x)\n", err_mask);
-		return -EIO;
-	}
+	/* if the device is actually configured correctly, ignore dev err */
+	if (dev->xfer_mode == ata_xfer_mask2mode(ata_id_xfermask(dev->id)))
+		ign_dev_err = 1;
 
-	ehc->i.flags |= ATA_EHI_POST_SETMODE;
-	rc = ata_dev_revalidate(dev, ATA_DEV_UNKNOWN, 0);
-	ehc->i.flags &= ~ATA_EHI_POST_SETMODE;
-	if (rc)
-		return rc;
+	if (err_mask & AC_ERR_DEV) {
+		if (!ign_dev_err)
+			goto fail;
+		else
+			dev_err_whine = " (device error ignored)";
+	}
 
 	DPRINTK("xfer_shift=%u, xfer_mode=0x%x\n",
 		dev->xfer_shift, (int)dev->xfer_mode);
 
-	ata_dev_printk(dev, KERN_INFO, "configured for %s\n",
-		       ata_mode_string(ata_xfer_mode2mask(dev->xfer_mode)));
+	ata_dev_printk(dev, KERN_INFO, "configured for %s%s\n",
+		       ata_mode_string(ata_xfer_mode2mask(dev->xfer_mode)),
+		       dev_err_whine);
+
 	return 0;
+
+ fail:
+	ata_dev_printk(dev, KERN_ERR, "failed to set xfermode "
+		       "(err_mask=0x%x)\n", err_mask);
+	return -EIO;
 }
 
 /**
