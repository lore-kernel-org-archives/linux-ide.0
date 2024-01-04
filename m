Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8EC2C863
	for <linux-ide@vger.kernel.org>; Thu,  4 Jan 2024 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 0F3B3151D64; Thu,  4 Jan 2024 17:40:21 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Phillip Susi <phill@thesusis.net>
Subject: [PATCH 4/4] libata: don't start PuiS disks on resume
Date: Thu,  4 Jan 2024 17:39:40 -0500
Message-Id: <20240104223940.339290-4-phill@thesusis.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240104223940.339290-1-phill@thesusis.net>
References: <87y1d5kxcc.fsf@vps.thesusis.net>
 <20240104223940.339290-1-phill@thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disks with Power Up In Standby enabled that required the
SET FEATURES command to start up were being issued the
command during resume.  Suppress this until the disk
is actually accessed.
---
 drivers/ata/libata-core.c | 24 ++++++++++++++++++++++--
 drivers/ata/libata-eh.c   | 12 +++++++++++-
 drivers/ata/libata.h      |  1 +
 include/linux/libata.h    |  1 +
 4 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d9e889fa2881..3f6187c75b16 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1912,7 +1912,25 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
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
+		ata_tf_init(dev, &tf);
+		tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
+		tf.protocol = ATA_PROT_NODATA;
+		tf.command = ATA_CMD_SLEEP;
+		err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
+		ata_dev_info(dev, "PuiS detected, putting drive to sleep");
+		return -EAGAIN;
+	}
+
+	if (!(flags & ATA_READID_NOSTART) &&
+	    !tried_spinup && (id[2] == 0x37c8 || id[2] == 0x738c)) {
 		tried_spinup = 1;
 		/*
 		 * Drive powered-up in standby mode, and requires a specific
@@ -3973,6 +3991,8 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
 
 	/* re-read ID */
 	rc = ata_dev_reread_id(dev, readid_flags);
+	if (rc == -EAGAIN)
+		return rc;
 	if (rc)
 		goto fail;
 
@@ -5241,7 +5261,7 @@ static void ata_port_suspend(struct ata_port *ap, pm_message_t mesg,
 	 * http://thread.gmane.org/gmane.linux.ide/46764
 	 */
 	ata_port_request_pm(ap, mesg, 0,
-			    ATA_EHI_QUIET | ATA_EHI_NO_AUTOPSY |
+			    ATA_EHI_QUIET | ATA_EHI_NO_AUTOPSY | ATA_EHI_NOSTART
 			    ATA_EHI_NO_RECOVERY,
 			    async);
 }
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 799a1b8bc384..74e0d54a204e 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -22,6 +22,7 @@
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_dbg.h>
 #include "../scsi/scsi_transport_api.h"
+#include <linux/pm_runtime.h>
 
 #include <linux/libata.h>
 
@@ -3046,6 +3047,8 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 
 		if (ehc->i.flags & ATA_EHI_DID_RESET)
 			readid_flags |= ATA_READID_POSTRESET;
+		if (ehc->i.flags & ATA_EHI_NOSTART)
+			readid_flags |= ATA_READID_NOSTART;
 
 		if ((action & ATA_EH_REVALIDATE) && ata_dev_enabled(dev)) {
 			WARN_ON(dev->class == ATA_DEV_PMP);
@@ -3075,9 +3078,16 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 			ata_eh_about_to_do(link, dev, ATA_EH_REVALIDATE);
 			rc = ata_dev_revalidate(dev, ehc->classes[dev->devno],
 						readid_flags);
-			if (rc)
+			if (rc == -EAGAIN) {
+				rc = 0; /* start required but suppressed, handle later */
+				ehc->i.dev_action[dev->devno] &= ~ATA_EH_SET_ACTIVE;
+				ata_dev_warn(dev, "Leaving PuiS disk asleep for now");
+				continue;
+			}
+			else if (rc)
 				goto err;
 
+			pm_runtime_resume(&dev->sdev->sdev_gendev);
 			ata_eh_done(link, dev, ATA_EH_REVALIDATE);
 
 			/* Configuration may have changed, reconfigure
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 43ad1ef9b63a..cff3facad055 100644
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
index 1dbb14daccfa..50d6fa933946 100644
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

