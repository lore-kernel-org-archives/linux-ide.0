From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/5] libata: separate out ata_id_major_version()
Date: Sun, 12 Feb 2006 22:47:04 +0900
Message-ID: <11397520242979-git-send-email-htejun@gmail.com>
References: <11397520242602-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.182]:23915 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751055AbWBLNrJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2006 08:47:09 -0500
Received: by pproxy.gmail.com with SMTP id z74so766548pyg
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2006 05:47:08 -0800 (PST)
In-Reply-To: <11397520242602-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Separate out ATA major version calculation from ata_dev_identify()
into ata_id_major_version().  It's preparation for splitting
ata_dev_identify().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    6 +-----
 include/linux/ata.h        |   10 ++++++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

66ee6dfccf92daec72aa80724f37f26abfb3352d
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 1fe63ee..7bb99b0 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -927,7 +927,6 @@ static void ata_dev_identify(struct ata_
 {
 	struct ata_device *dev = &ap->device[device];
 	unsigned int major_version;
-	u16 tmp;
 	unsigned long xfer_modes;
 	unsigned int using_edd;
 	struct ata_taskfile tf;
@@ -1030,10 +1029,7 @@ retry:
 			goto err_out_nosup;
 
 		/* get major version */
-		tmp = dev->id[ATA_ID_MAJOR_VER];
-		for (major_version = 14; major_version >= 1; major_version--)
-			if (tmp & (1 << major_version))
-				break;
+		major_version = ata_id_major_version(dev->id);
 
 		/*
 		 * The exact sequence expected by certain pre-ATA4 drives is:
diff --git a/include/linux/ata.h b/include/linux/ata.h
index a8155ca..b02a16c 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -267,6 +267,16 @@ struct ata_taskfile {
 	  ((u64) (id)[(n) + 1] << 16) |	\
 	  ((u64) (id)[(n) + 0]) )
 
+static inline unsigned int ata_id_major_version(const u16 *id)
+{
+	unsigned int mver;
+
+	for (mver = 14; mver >= 1; mver--)
+		if (id[ATA_ID_MAJOR_VER] & (1 << mver))
+			break;
+	return mver;
+}
+
 static inline int ata_id_current_chs_valid(const u16 *id)
 {
 	/* For ATA-1 devices, if the INITIALIZE DEVICE PARAMETERS command 
-- 
1.1.5


