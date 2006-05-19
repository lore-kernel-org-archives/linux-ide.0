From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/14] libata-hp-prep: implement ap->hw_sata_spd_limit
Date: Fri, 19 May 2006 06:06:40 -0700 (PDT)
Message-ID: <11480439891257-git-send-email-htejun@gmail.com>
References: <1148043989758-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.198]:41012 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751258AbWESNGl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 09:06:41 -0400
Received: by nz-out-0102.google.com with SMTP id 8so624359nzo
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 06:06:41 -0700 (PDT)
In-Reply-To: <1148043989758-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add ap->hw_sata_spd_limit and initialize it once during the boot
initialization (or driver load initialization).  ap->sata_spd_limit is
reset to ap->hw_sata_spd_limit on hotplug.  This prevents spd limits
introduced by earlier devices from affecting new devices.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   21 ++++++++++++---------
 include/linux/libata.h     |    1 +
 2 files changed, 13 insertions(+), 9 deletions(-)

b2fd37ae97c04c7d19e5ae17dd50ad8d3ad8c725
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index ccdb867..9e10b79 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2457,17 +2457,9 @@ static int sata_phy_resume(struct ata_po
  */
 void ata_std_probeinit(struct ata_port *ap)
 {
-	u32 scontrol;
-
 	/* resume link */
 	sata_phy_resume(ap);
 
-	/* init sata_spd_limit to the current value */
-	if (sata_scr_read(ap, SCR_CONTROL, &scontrol) == 0) {
-		int spd = (scontrol >> 4) & 0xf;
-		ap->sata_spd_limit &= (1 << spd) - 1;
-	}
-
 	/* wait for device */
 	if (ata_port_online(ap))
 		ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
@@ -5122,6 +5114,9 @@ void ata_dev_init(struct ata_device *dev
 	struct ata_port *ap = dev->ap;
 	unsigned long flags;
 
+	/* SATA spd limit is bound to the first device */
+	ap->sata_spd_limit = ap->hw_sata_spd_limit;
+
 	/* High bits of dev->flags are used to record warm plug
 	 * requests which occur asynchronously.  Synchronize using
 	 * host_set lock.
@@ -5177,7 +5172,7 @@ static void ata_host_init(struct ata_por
 	ap->udma_mask = ent->udma_mask;
 	ap->flags |= ent->host_flags;
 	ap->ops = ent->port_ops;
-	ap->sata_spd_limit = UINT_MAX;
+	ap->hw_sata_spd_limit = UINT_MAX;
 	ap->active_tag = ATA_TAG_POISON;
 	ap->last_ctl = 0xFF;
 
@@ -5340,10 +5335,18 @@ int ata_device_add(const struct ata_prob
 	DPRINTK("probe begin\n");
 	for (i = 0; i < count; i++) {
 		struct ata_port *ap;
+		u32 scontrol;
 		int rc;
 
 		ap = host_set->ports[i];
 
+		/* init sata_spd_limit to the current value */
+		if (sata_scr_read(ap, SCR_CONTROL, &scontrol) == 0) {
+			int spd = (scontrol >> 4) & 0xf;
+			ap->hw_sata_spd_limit &= (1 << spd) - 1;
+		}
+		ap->sata_spd_limit = ap->hw_sata_spd_limit;
+
 		DPRINTK("ata%u: bus probe begin\n", ap->id);
 		rc = ata_bus_probe(ap);
 		DPRINTK("ata%u: bus probe end\n", ap->id);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 99808c5..07c98c2 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -486,6 +486,7 @@ struct ata_port {
 	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
 	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
+	unsigned int		hw_sata_spd_limit;
 	unsigned int		sata_spd_limit;	/* SATA PHY speed limit */
 
 	/* record runtime error info, protected by host_set lock */
-- 
1.3.2

