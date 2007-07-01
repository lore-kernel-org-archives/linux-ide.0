From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/12] libata: improve SATA PHY speed down logic
Date: Sun, 1 Jul 2007 18:53:38 +0900
Message-ID: <11832836183133-git-send-email-htejun@gmail.com>
References: <118328361627-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:29536 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755365AbXGAJxp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 05:53:45 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1876615wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 02:53:45 -0700 (PDT)
In-Reply-To: <118328361627-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

sata_down_spd_limit() first reads the current SPD from SStatus and
limit the speed to the lower one of one below the current limit or one
below the current SPD in SStatus.  SPD may not be accessible or valid
when SPD down is requested making sata_down_spd_limit() fail when it's
most needed.

This patch makes the current SPD cached after each successful reset
and forces GEN I speed (1.5Gbps) if neither of SStatus or the cached
value is valid, so sata_down_spd_limit() is now guaranteed to lower
the speed limit if lower speed is available.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   29 ++++++++++++++++++++++-------
 drivers/ata/libata-eh.c   |    6 ++++++
 include/linux/libata.h    |    1 +
 3 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 147235c..49fe30a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2413,21 +2413,35 @@ int sata_down_spd_limit(struct ata_port *ap)
 	u32 sstatus, spd, mask;
 	int rc, highbit;
 
+	if (!sata_scr_valid(ap))
+		return -EOPNOTSUPP;
+
+	/* If SCR can be read, use it to determine the current SPD.
+	 * If not, use cached value in ap->sata_spd.
+	 */
 	rc = sata_scr_read(ap, SCR_STATUS, &sstatus);
-	if (rc)
-		return rc;
+	if (rc == 0)
+		spd = (sstatus >> 4) & 0xf;
+	else
+		spd = ap->sata_spd;
 
 	mask = ap->sata_spd_limit;
 	if (mask <= 1)
 		return -EINVAL;
+
+	/* unconditionally mask off the highest bit */
 	highbit = fls(mask) - 1;
 	mask &= ~(1 << highbit);
 
-	spd = (sstatus >> 4) & 0xf;
-	if (spd <= 1)
-		return -EINVAL;
-	spd--;
-	mask &= (1 << spd) - 1;
+	/* Mask off all speeds higher than or equal to the current
+	 * one.  Force 1.5Gbps if current SPD is not available.
+	 */
+	if (spd > 1)
+		mask &= (1 << (spd - 1)) - 1;
+	else
+		mask &= 1;
+
+	/* were we already at the bottom? */
 	if (!mask)
 		return -EINVAL;
 
@@ -5941,6 +5955,7 @@ void ata_dev_init(struct ata_device *dev)
 
 	/* SATA spd limit is bound to the first device */
 	ap->sata_spd_limit = ap->hw_sata_spd_limit;
+	ap->sata_spd = 0;
 
 	/* High bits of dev->flags are used to record warm plug
 	 * requests which occur asynchronously.  Synchronize using
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 8d8961f..d18c475 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1734,12 +1734,18 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 	}
 
 	if (rc == 0) {
+		u32 sstatus;
+
 		/* After the reset, the device state is PIO 0 and the
 		 * controller state is undefined.  Record the mode.
 		 */
 		for (i = 0; i < ATA_MAX_DEVICES; i++)
 			ap->device[i].pio_mode = XFER_PIO_0;
 
+		/* record current link speed */
+		if (sata_scr_read(ap, SCR_STATUS, &sstatus) == 0)
+			ap->sata_spd = (sstatus >> 4) & 0xf;
+
 		if (postreset)
 			postreset(ap, classes);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index bc91ca0..05670b5 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -531,6 +531,7 @@ struct ata_port {
 	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
 	unsigned int		hw_sata_spd_limit;
 	unsigned int		sata_spd_limit;	/* SATA PHY speed limit */
+	unsigned int		sata_spd;	/* current SATA PHY speed */
 
 	/* record runtime error info, protected by host lock */
 	struct ata_eh_info	eh_info;
-- 
1.5.0.3


