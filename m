From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/12] libata-hp-prep: implement ap->hw_sata_spd_limit
Date: Mon, 29 May 2006 15:25:58 +0900
Message-ID: <1148883958247-git-send-email-htejun@gmail.com>
References: <11488839571850-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.202]:58383 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751251AbWE2G0Y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 02:26:24 -0400
Received: by wx-out-0102.google.com with SMTP id h27so298148wxd
        for <linux-ide@vger.kernel.org>; Sun, 28 May 2006 23:26:24 -0700 (PDT)
In-Reply-To: <11488839571850-git-send-email-htejun@gmail.com>
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

0329251e5f08a8110541cbd2e64adb29c340c5d7
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index fc9989d..83fb9dd 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2466,17 +2466,9 @@ static int sata_phy_resume(struct ata_po
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
@@ -5155,6 +5147,9 @@ void ata_dev_init(struct ata_device *dev
 	struct ata_port *ap = dev->ap;
 	unsigned long flags;
 
+	/* SATA spd limit is bound to the first device */
+	ap->sata_spd_limit = ap->hw_sata_spd_limit;
+
 	/* High bits of dev->flags are used to record warm plug
 	 * requests which occur asynchronously.  Synchronize using
 	 * host_set lock.
@@ -5210,7 +5205,7 @@ static void ata_host_init(struct ata_por
 	ap->udma_mask = ent->udma_mask;
 	ap->flags |= ent->host_flags;
 	ap->ops = ent->port_ops;
-	ap->sata_spd_limit = UINT_MAX;
+	ap->hw_sata_spd_limit = UINT_MAX;
 	ap->active_tag = ATA_TAG_POISON;
 	ap->last_ctl = 0xFF;
 	ap->msg_enable = ATA_MSG_DRV;
@@ -5374,10 +5369,18 @@ int ata_device_add(const struct ata_prob
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
index 20c6aa1..c42ea93 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -488,6 +488,7 @@ struct ata_port {
 	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
 	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
+	unsigned int		hw_sata_spd_limit;
 	unsigned int		sata_spd_limit;	/* SATA PHY speed limit */
 
 	/* record runtime error info, protected by host_set lock */
-- 
1.3.2


