From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: implement and use HORKAGE_NOSETXFER,
 take#2
Date: Thu, 09 Jul 2009 09:27:50 +0900
Message-ID: <4A553986.7010206@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51449 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754606AbZGIA3Y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Jul 2009 20:29:24 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, ide <linux-ide@vger.kernel.org>, lars21ce@gmx.de, linux-ide@momail.e4ward.com, Robert Hancock <hancockr@shaw.ca>, p

PIONEER DVD-RW DVRTD08 times out SETXFER if no media is present.  The
device is SATA and simply skipping SETXFER works around the problem.
Implement ATA_HORKAGE_NOSETXFER and apply it to the device.

Reported by Moritz Rigler in the following thread.

  http://thread.gmane.org/gmane.linux.ide/36790

and by Lars in bko#9540.

Updated to whine and ignore NOSETXFER if PATA component is detected as
suggested by Alan Cox.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Moritz Rigler <linux-ide@momail.e4ward.com>
Reported-by: Lars <lars21ce@gmx.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
Comment also added.  Thanks.

 drivers/ata/libata-core.c |   20 ++++++++++++++++++--
 include/linux/libata.h    |    1 +
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 045a486..2c6aeda 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3392,17 +3392,27 @@ int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel)
 
 static int ata_dev_set_mode(struct ata_device *dev)
 {
+	struct ata_port *ap = dev->link->ap;
 	struct ata_eh_context *ehc = &dev->link->eh_context;
+	const bool nosetxfer = dev->horkage & ATA_HORKAGE_NOSETXFER;
 	const char *dev_err_whine = "";
 	int ign_dev_err = 0;
-	unsigned int err_mask;
+	unsigned int err_mask = 0;
 	int rc;
 
 	dev->flags &= ~ATA_DFLAG_PIO;
 	if (dev->xfer_shift == ATA_SHIFT_PIO)
 		dev->flags |= ATA_DFLAG_PIO;
 
-	err_mask = ata_dev_set_xfermode(dev);
+	if (nosetxfer && ap->flags & ATA_FLAG_SATA && ata_id_is_sata(dev->id))
+		dev_err_whine = " (SET_XFERMODE skipped)";
+	else {
+		if (nosetxfer)
+			ata_dev_printk(dev, KERN_WARNING,
+				       "NOSETXFER but PATA detected - can't "
+				       "skip SETXFER, might malfunction\n");
+		err_mask = ata_dev_set_xfermode(dev);
+	}
 
 	if (err_mask & ~AC_ERR_DEV)
 		goto fail;
@@ -4297,6 +4307,12 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* Devices which aren't very happy with higher link speeds */
 	{ "WD My Book",			NULL,	ATA_HORKAGE_1_5_GBPS, },
 
+	/*
+	 * Devices which choke on SETXFER.  Applies only if both the
+	 * device and controller are SATA.
+	 */
+	{ "PIONEER DVD-RW  DVRTD08",	"1.00",	ATA_HORKAGE_NOSETXFER },
+
 	/* End Marker */
 	{ }
 };
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3d501db..79b6d7f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -385,6 +385,7 @@ enum {
 						    not multiple of 16 bytes */
 	ATA_HORKAGE_FIRMWARE_WARN = (1 << 12),	/* firmware update warning */
 	ATA_HORKAGE_1_5_GBPS	= (1 << 13),	/* force 1.5 Gbps */
+	ATA_HORKAGE_NOSETXFER	= (1 << 14),	/* skip SETXFER, SATA only */
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
