From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 15/21] libata: improve SATA PHY speed down logic
Date: Mon, 16 Jul 2007 14:29:40 +0900
Message-ID: <11845637802220-git-send-email-htejun@gmail.com>
References: <11845637782629-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:11877 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760518AbXGPF3x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 01:29:53 -0400
Received: by nz-out-0506.google.com with SMTP id s18so736627nze
        for <linux-ide@vger.kernel.org>; Sun, 15 Jul 2007 22:29:52 -0700 (PDT)
In-Reply-To: <11845637782629-git-send-email-htejun@gmail.com>
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
index be1d96a..c60155e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2389,21 +2389,35 @@ int sata_down_spd_limit(struct ata_port *ap)
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
 
@@ -5994,6 +6008,7 @@ void ata_dev_init(struct ata_device *dev)
 
 	/* SATA spd limit is bound to the first device */
 	ap->sata_spd_limit = ap->hw_sata_spd_limit;
+	ap->sata_spd = 0;
 
 	/* High bits of dev->flags are used to record warm plug
 	 * requests which occur asynchronously.  Synchronize using
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 19f9947..183eaf4 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1799,12 +1799,18 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
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
index c732b3e..16ebdf1 100644
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


