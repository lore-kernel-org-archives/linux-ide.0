From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/03] libata: set default cbl in probeinit
Date: Wed, 5 Apr 2006 22:16:37 +0900
Message-ID: <20060405131637.GB31998@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.238]:44075 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751145AbWDENmk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Apr 2006 09:42:40 -0400
Received: by wproxy.gmail.com with SMTP id i11so173496wra
        for <linux-ide@vger.kernel.org>; Wed, 05 Apr 2006 06:42:39 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Make setting CBL type responsibility of probeinit.  This allows using
only ap->cbl == ATA_CBL_SATA test in all other parts.  Without this,
ata_down_sata_spd_limit() doesn't work during probe reset.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

Jeff, this series is against #upstream and breaks EH patchsets.
Please let me know when you want me to regenerate and resend the EH
patchsets.

 drivers/scsi/libata-core.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

bc07abde59f78a4faec3f348b91289b39cf31e61
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 3387fe3..8d3fed4 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2369,12 +2369,16 @@ void ata_std_probeinit(struct ata_port *
 	if ((ap->flags & ATA_FLAG_SATA) && ap->ops->scr_read) {
 		u32 spd;
 
+		/* set cable type and resume link */
+		ap->cbl = ATA_CBL_SATA;
 		sata_phy_resume(ap);
 
+		/* init sata_spd_limit to the current value */
 		spd = (scr_read(ap, SCR_CONTROL) & 0xf0) >> 4;
 		if (spd)
 			ap->sata_spd_limit &= (1 << spd) - 1;
 
+		/* wait for device */
 		if (sata_dev_present(ap))
 			ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
 	}
@@ -2531,10 +2535,6 @@ void ata_std_postreset(struct ata_port *
 {
 	DPRINTK("ENTER\n");
 
-	/* set cable type if it isn't already set */
-	if (ap->cbl == ATA_CBL_NONE && ap->flags & ATA_FLAG_SATA)
-		ap->cbl = ATA_CBL_SATA;
-
 	/* print link status */
 	if (ap->cbl == ATA_CBL_SATA)
 		sata_print_link_status(ap);
@@ -2584,7 +2584,7 @@ int ata_std_probe_reset(struct ata_port 
 	ata_reset_fn_t hardreset;
 
 	hardreset = NULL;
-	if (ap->flags & ATA_FLAG_SATA && ap->ops->scr_read)
+	if (ap->cbl == ATA_CBL_SATA && ap->ops->scr_read)
 		hardreset = sata_std_hardreset;
 
 	return ata_drive_probe_reset(ap, ata_std_probeinit,
-- 
1.2.4

