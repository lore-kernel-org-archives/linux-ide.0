From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3] libata: set default cbl in probeinit
Date: Tue, 11 Apr 2006 22:16:44 +0900
Message-ID: <11447614043099-git-send-email-htejun@gmail.com>
References: <11447614041095-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.226]:54135 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750817AbWDKNQ5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:16:57 -0400
Received: by wproxy.gmail.com with SMTP id i11so920396wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:16:57 -0700 (PDT)
In-Reply-To: <11447614041095-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make setting CBL type responsibility of probeinit.  This allows using
only ap->cbl == ATA_CBL_SATA test in all other parts.  Without this,
ata_down_sata_spd_limit() doesn't work during probe reset.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

8e8d8e326ca269f1cf38c6cf715a71a98e773600
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


