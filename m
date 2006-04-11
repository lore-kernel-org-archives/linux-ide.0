From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/13] libata-hp: implement ap->orig_sata_spd_limit
Date: Tue, 11 Apr 2006 23:06:21 +0900
Message-ID: <114476438172-git-send-email-htejun@gmail.com>
References: <11447643813451-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.192]:52105 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750840AbWDKOG2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:06:28 -0400
Received: by zproxy.gmail.com with SMTP id o37so1100710nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:06:27 -0700 (PDT)
In-Reply-To: <11447643813451-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add ap->orig_sata_spd_limit and initialize it once during the boot
initialization (or driver load initialization).  ap->sata_spd_limit is
reset to ap->orig_sata_spd_limit on hotplug.  This prevents limits
introduced by earlier devices from affecting new devices.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   20 ++++++++++++--------
 include/linux/libata.h     |    1 +
 2 files changed, 13 insertions(+), 8 deletions(-)

37d8c01b360760e0c22e5cede70921c116c21ad4
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 930f387..45ef1e2 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1444,6 +1444,9 @@ err_out_nosup:
  */
 static void ata_dev_init(struct ata_port *ap, struct ata_device *dev)
 {
+	/* for now, SATA spd limit is bound to the first device */
+	ap->sata_spd_limit = ap->orig_sata_spd_limit;
+
 	dev->flags &= ~ATA_DFLAG_INIT_MASK;
 
 	memset((void *)dev + ATA_DEVICE_CLEAR_OFFSET, 0,
@@ -2503,17 +2506,10 @@ static int sata_phy_resume(struct ata_po
 void ata_std_probeinit(struct ata_port *ap)
 {
 	if ((ap->flags & ATA_FLAG_SATA) && ap->ops->scr_read) {
-		u32 spd;
-
 		/* set cable type and resume link */
 		ap->cbl = ATA_CBL_SATA;
 		sata_phy_resume(ap);
 
-		/* init sata_spd_limit to the current value */
-		spd = (scr_read(ap, SCR_CONTROL) & 0xf0) >> 4;
-		if (spd)
-			ap->sata_spd_limit &= (1 << spd) - 1;
-
 		/* wait for device */
 		if (sata_dev_present(ap))
 			ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
@@ -4878,7 +4874,7 @@ static void ata_host_init(struct ata_por
 	ap->flags |= ent->host_flags;
 	ap->ops = ent->port_ops;
 	ap->cbl = ATA_CBL_NONE;
-	ap->sata_spd_limit = UINT_MAX;
+	ap->orig_sata_spd_limit = UINT_MAX;
 	ap->active_tag = ATA_TAG_POISON;
 	ap->last_ctl = 0xFF;
 
@@ -5037,6 +5033,14 @@ int ata_device_add(const struct ata_prob
 
 		ap = host_set->ports[i];
 
+		/* init ap->orig_sata_spd_limit to boot value */
+		if ((ap->flags & ATA_FLAG_SATA) && ap->ops->scr_read) {
+			u32 spd;
+			spd = (scr_read(ap, SCR_CONTROL) & 0xf0) >> 4;
+			if (spd)
+				ap->orig_sata_spd_limit &= (1 << spd) - 1;
+		}
+
 		DPRINTK("ata%u: bus probe begin\n", ap->id);
 		rc = ata_bus_probe(ap);
 		DPRINTK("ata%u: bus probe end\n", ap->id);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 33ce8a4..94f1e9a 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -449,6 +449,7 @@ struct ata_port {
 	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
 	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
+	unsigned int		orig_sata_spd_limit; /* boot value */
 	unsigned int		sata_spd_limit;	/* SATA PHY speed limit */
 
 	struct ata_device	device[ATA_MAX_DEVICES];
-- 
1.2.4


