From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 15/22] libata: init ap->cbl to ATA_CBL_SATA early
Date: Thu, 11 May 2006 20:59:51 +0900
Message-ID: <11473487913085-git-send-email-htejun@gmail.com>
References: <11473487893774-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.194]:49320 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751570AbWEKMAF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:00:05 -0400
Received: by wx-out-0102.google.com with SMTP id t16so118654wxc
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:00:04 -0700 (PDT)
In-Reply-To: <11473487893774-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Init ap->cbl to ATA_CBL_SATA in ata_host_init().  This is necessary
for soon-to-follow SCR handling function changes.  LLDDs are free to
change ap->cbl during probing.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

acb4ec253fe1fd0879d1afa56a97c688424d2772
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 4cb7828..3d44cff 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2370,8 +2370,7 @@ void ata_std_probeinit(struct ata_port *
 	if ((ap->flags & ATA_FLAG_SATA) && ap->ops->scr_read) {
 		u32 spd;
 
-		/* set cable type and resume link */
-		ap->cbl = ATA_CBL_SATA;
+		/* resume link */
 		sata_phy_resume(ap);
 
 		/* init sata_spd_limit to the current value */
@@ -4586,7 +4585,6 @@ static void ata_host_init(struct ata_por
 	ap->udma_mask = ent->udma_mask;
 	ap->flags |= ent->host_flags;
 	ap->ops = ent->port_ops;
-	ap->cbl = ATA_CBL_NONE;
 	ap->sata_spd_limit = UINT_MAX;
 	ap->active_tag = ATA_TAG_POISON;
 	ap->last_ctl = 0xFF;
@@ -4594,6 +4592,11 @@ static void ata_host_init(struct ata_por
 	INIT_WORK(&ap->port_task, NULL, NULL);
 	INIT_LIST_HEAD(&ap->eh_done_q);
 
+	/* set cable type */
+	ap->cbl = ATA_CBL_NONE;
+	if (ap->flags & ATA_FLAG_SATA)
+		ap->cbl = ATA_CBL_SATA;
+
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
 		dev->devno = i;
-- 
1.2.4


