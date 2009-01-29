From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/8] libata: add @spd_limit to sata_down_spd_limit()
Date: Thu, 29 Jan 2009 20:31:33 +0900
Message-ID: <1233228696-10562-6-git-send-email-tj@kernel.org>
References: <1233228696-10562-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34103 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752651AbZA2LcE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jan 2009 06:32:04 -0500
In-Reply-To: <1233228696-10562-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Add @spd_limit to sata_down_spd_limit() so that the caller can specify
the SPD limit it wants.  This parameter doesn't get in the way even
when it's too low.  The closest possible limit is applied.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-core.c |   25 ++++++++++++++++++++-----
 drivers/ata/libata-eh.c   |   10 +++++-----
 drivers/ata/libata-pmp.c  |    2 +-
 drivers/ata/libata.h      |    2 +-
 4 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6a5b8e2..0cc0d8f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2777,7 +2777,7 @@ int ata_bus_probe(struct ata_port *ap)
 			/* This is the last chance, better to slow
 			 * down than lose it.
 			 */
-			sata_down_spd_limit(&ap->link);
+			sata_down_spd_limit(&ap->link, 0);
 			ata_down_xfermask_limit(dev, ATA_DNXFER_PIO);
 		}
 	}
@@ -2873,21 +2873,27 @@ void ata_port_disable(struct ata_port *ap)
 /**
  *	sata_down_spd_limit - adjust SATA spd limit downward
  *	@link: Link to adjust SATA spd limit for
+ *	@spd_limit: Additional limit
  *
  *	Adjust SATA spd limit of @link downward.  Note that this
  *	function only adjusts the limit.  The change must be applied
  *	using sata_set_spd().
  *
+ *	If @spd_limit is non-zero, the speed is limited to equal to or
+ *	lower than @spd_limit if such speed is supported.  If
+ *	@spd_limit is slower than any supported speed, only the lowest
+ *	supported speed is allowed.
+ *
  *	LOCKING:
  *	Inherited from caller.
  *
  *	RETURNS:
  *	0 on success, negative errno on failure
  */
-int sata_down_spd_limit(struct ata_link *link)
+int sata_down_spd_limit(struct ata_link *link, u32 spd_limit)
 {
 	u32 sstatus, spd, mask;
-	int rc, highbit;
+	int rc, bit;
 
 	if (!sata_scr_valid(link))
 		return -EOPNOTSUPP;
@@ -2906,8 +2912,8 @@ int sata_down_spd_limit(struct ata_link *link)
 		return -EINVAL;
 
 	/* unconditionally mask off the highest bit */
-	highbit = fls(mask) - 1;
-	mask &= ~(1 << highbit);
+	bit = fls(mask) - 1;
+	mask &= ~(1 << bit);
 
 	/* Mask off all speeds higher than or equal to the current
 	 * one.  Force 1.5Gbps if current SPD is not available.
@@ -2921,6 +2927,15 @@ int sata_down_spd_limit(struct ata_link *link)
 	if (!mask)
 		return -EINVAL;
 
+	if (spd_limit) {
+		if (mask & ((1 << spd_limit) - 1))
+			mask &= (1 << spd_limit) - 1;
+		else {
+			bit = ffs(mask) - 1;
+			mask = 1 << bit;
+		}
+	}
+
 	link->sata_spd_limit = mask;
 
 	ata_link_printk(link, KERN_WARNING, "limiting SATA link speed to %s\n",
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 90092c1..685509b 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1875,7 +1875,7 @@ static unsigned int ata_eh_speed_down(struct ata_device *dev,
 	/* speed down? */
 	if (verdict & ATA_EH_SPDN_SPEED_DOWN) {
 		/* speed down SATA link speed if possible */
-		if (sata_down_spd_limit(link) == 0) {
+		if (sata_down_spd_limit(link, 0) == 0) {
 			action |= ATA_EH_RESET;
 			goto done;
 		}
@@ -2627,11 +2627,11 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	}
 
 	if (try == max_tries - 1) {
-		sata_down_spd_limit(link);
+		sata_down_spd_limit(link, 0);
 		if (slave)
-			sata_down_spd_limit(slave);
+			sata_down_spd_limit(slave, 0);
 	} else if (rc == -EPIPE)
-		sata_down_spd_limit(failed_link);
+		sata_down_spd_limit(failed_link, 0);
 
 	if (hardreset)
 		reset = hardreset;
@@ -3011,7 +3011,7 @@ static int ata_eh_handle_dev_fail(struct ata_device *dev, int err)
 			/* This is the last chance, better to slow
 			 * down than lose it.
 			 */
-			sata_down_spd_limit(ata_dev_phys_link(dev));
+			sata_down_spd_limit(ata_dev_phys_link(dev), 0);
 			if (dev->pio_mode > XFER_PIO_0)
 				ata_down_xfermask_limit(dev, ATA_DNXFER_PIO);
 		}
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 98ca07a..619f2c3 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -729,7 +729,7 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
 		if (tries) {
 			/* consecutive revalidation failures? speed down */
 			if (reval_failed)
-				sata_down_spd_limit(link);
+				sata_down_spd_limit(link, 0);
 			else
 				reval_failed = 1;
 
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 0a6f5be..cea8014 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -99,7 +99,7 @@ extern int ata_dev_reread_id(struct ata_device *dev, unsigned int readid_flags);
 extern int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
 			      unsigned int readid_flags);
 extern int ata_dev_configure(struct ata_device *dev);
-extern int sata_down_spd_limit(struct ata_link *link);
+extern int sata_down_spd_limit(struct ata_link *link, u32 spd_limit);
 extern int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel);
 extern void ata_sg_clean(struct ata_queued_cmd *qc);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
-- 
1.6.0.2

