Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F065C4332F
	for <linux-ide@archiver.kernel.org>; Fri,  3 Nov 2023 23:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjKCXBK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 3 Nov 2023 19:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbjKCXBJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 3 Nov 2023 19:01:09 -0400
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EED618B
        for <linux-ide@vger.kernel.org>; Fri,  3 Nov 2023 16:01:04 -0700 (PDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 0F384147703; Fri,  3 Nov 2023 19:01:02 -0400 (EDT)
From:   Phillip Susi <phill@thesusis.net>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org
Subject: Re: [PATCH v8 04/23] scsi: sd: Differentiate system and runtime
 start/stop management
In-Reply-To: <87h6m24srm.fsf@vps.thesusis.net>
References: <87edhz3bry.fsf@vps.thesusis.net>
 <672365d4-bdd6-47c9-b0be-6756f523db59@kernel.org>
 <871qdyh9na.fsf@vps.thesusis.net>
 <ff334ece-ca5b-490b-91d7-6bb51fd2e2b3@kernel.org>
 <87sf63hnbg.fsf@vps.thesusis.net>
 <969790e6-7050-43b9-bb0b-4b55baa21cc9@kernel.org>
 <87h6m24srm.fsf@vps.thesusis.net>
Date:   Fri, 03 Nov 2023 19:01:02 -0400
Message-ID: <87wmuyqw5t.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

--=-=-=
Content-Type: text/plain

Here is the patch.  The hang I saw before appears to be related to how
I'm trying to force the runtime_pm status in
ata_eh_revalidate_and_attach().  If I comment that part out, the hang
goes away.  I'm not sure why I can't work out the right way to force the
runtime pm status of the block device to agree with the actual status of
the disk as known to libata during system resume.  Even with a disk not
behind a PMP, while it does not cause a hang, it does not manage to get
the runtime pm state to reflect reality.  It still says active even
though the PuiS disk was left asleep.


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-libata-don-t-start-disks-on-resume.patch

From 93f2f75072e54bc49ccbceea0044ecf55fbf0bea Mon Sep 17 00:00:00 2001
From: Phillip Susi <phill@thesusis.net>
Date: Mon, 16 Oct 2023 17:03:51 -0400
Subject: [PATCH] libata: don't start disks on resume

Disks with Power Up In Standby enabled that required the
SET FEATURES command to start up were being issued the
command during resume.  Suppress this until the disk
is actually accessed.
---
 drivers/ata/libata-core.c | 22 +++++++++++++++++++++-
 drivers/ata/libata-eh.c   | 16 +++++++++++++++-
 drivers/ata/libata.h      |  1 +
 include/linux/libata.h    |  1 +
 4 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0cd7bfb261f5..465391150232 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1912,7 +1912,21 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 			goto err_out;
 	}
 
-	if (!tried_spinup && (id[2] == 0x37c8 || id[2] == 0x738c)) {
+	if (flags & ATA_READID_NOSTART && id[2] == 0x37c8)
+	{
+		/*
+		 * the drive has powered up in standby, and returned incomplete IDENTIFY info
+		 * so we can't revalidate it yet.  We have also been asked to avoid starting the
+		 * drive, so stop  here and leave the drive asleep and the EH pending, to be
+		 * restarted on later IO request
+		 */
+		dev->flags |= ATA_DFLAG_SLEEPING;
+		ata_dev_warn(dev, "PuiS detected");
+		return -EAGAIN;
+	}
+
+	if (!(flags & ATA_READID_NOSTART) &&
+	    !tried_spinup && (id[2] == 0x37c8 || id[2] == 0x738c)) {
 		tried_spinup = 1;
 		/*
 		 * Drive powered-up in standby mode, and requires a specific
@@ -3957,6 +3971,8 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
 
 	/* re-read ID */
 	rc = ata_dev_reread_id(dev, readid_flags);
+	if (rc == -EAGAIN)
+		return rc;
 	if (rc)
 		goto fail;
 
@@ -5173,6 +5189,10 @@ static void ata_port_request_pm(struct ata_port *ap, pm_message_t mesg,
 		spin_lock_irqsave(ap->lock, flags);
 	}
 
+	/* on system resume, don't wake PuiS drives */
+	if (mesg.event == PM_EVENT_RESUME)
+		ehi_flags |= ATA_EHI_NOSTART;
+	
 	/* Request PM operation to EH */
 	ap->pm_mesg = mesg;
 	ap->pflags |= ATA_PFLAG_PM_PENDING;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 09be31723a3c..b4b3f17de27d 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -22,6 +22,7 @@
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_dbg.h>
 #include "../scsi/scsi_transport_api.h"
+#include <linux/pm_runtime.h>
 
 #include <linux/libata.h>
 
@@ -3042,6 +3043,8 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 
 		if (ehc->i.flags & ATA_EHI_DID_RESET)
 			readid_flags |= ATA_READID_POSTRESET;
+		if (ehc->i.flags & ATA_EHI_NOSTART)
+			readid_flags |= ATA_READID_NOSTART;
 
 		if ((action & ATA_EH_REVALIDATE) && ata_dev_enabled(dev)) {
 			WARN_ON(dev->class == ATA_DEV_PMP);
@@ -3071,9 +3074,19 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 			ata_eh_about_to_do(link, dev, ATA_EH_REVALIDATE);
 			rc = ata_dev_revalidate(dev, ehc->classes[dev->devno],
 						readid_flags);
-			if (rc)
+			if (rc == -EAGAIN) {
+				rc = 0; /* start required but suppressed, handle later */
+				pm_runtime_get_noresume(&dev->sdev->sdev_gendev);
+				pm_runtime_allow(&dev->sdev->sdev_gendev);
+				pm_runtime_suspend(&dev->sdev->sdev_gendev);
+				ehc->i.dev_action[dev->devno] &= ~ATA_EH_SET_ACTIVE;
+				ata_dev_warn(dev, "Leaving PuiS disk asleep for now");
+				continue;
+			}
+			else if (rc)
 				goto err;
 
+			pm_runtime_resume(&dev->sdev->sdev_gendev);
 			ata_eh_done(link, dev, ATA_EH_REVALIDATE);
 
 			/* Configuration may have changed, reconfigure
@@ -3845,6 +3858,7 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 		 */
 		ata_for_each_dev(dev, link, ENABLED) {
 			if (ehc->i.dev_action[dev->devno] & ATA_EH_SET_ACTIVE) {
+				ata_dev_warn(dev, "Activating");
 				ata_dev_power_set_active(dev);
 				ata_eh_done(link, dev, ATA_EH_SET_ACTIVE);
 			}
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 05ac80da8ebc..cc13777d2811 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -19,6 +19,7 @@
 enum {
 	/* flags for ata_dev_read_id() */
 	ATA_READID_POSTRESET	= (1 << 0), /* reading ID after reset */
+	ATA_READID_NOSTART	= (1 << 1), /* do not start drive */
 
 	/* selector for ata_down_xfermask_limit() */
 	ATA_DNXFER_PIO		= 0,	/* speed down PIO */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 2a7d2af0ed80..77769351ab99 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -328,6 +328,7 @@ enum {
 
 	/* ata_eh_info->flags */
 	ATA_EHI_HOTPLUGGED	= (1 << 0),  /* could have been hotplugged */
+	ATA_EHI_NOSTART		= (1 << 1),  /* don't start the disk */
 	ATA_EHI_NO_AUTOPSY	= (1 << 2),  /* no autopsy */
 	ATA_EHI_QUIET		= (1 << 3),  /* be quiet */
 	ATA_EHI_NO_RECOVERY	= (1 << 4),  /* no recovery */
-- 
2.30.2


--=-=-=--
