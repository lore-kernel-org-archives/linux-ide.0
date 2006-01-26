From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/16] libata: separate out ata_id_major_version()
Date: Fri, 27 Jan 2006 00:39:11 +0900
Message-ID: <11382899513003-git-send-email-htejun@gmail.com>
References: <1138289951261-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:21074 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932324AbWAZPjV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 10:39:21 -0500
Received: by zproxy.gmail.com with SMTP id 34so372383nzf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jan 2006 07:39:18 -0800 (PST)
In-Reply-To: <1138289951261-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk
Cc: Tejun Heo <htejun@gmail.com>

Separate out ATA major version calculation from ata_dev_identify()
into ata_id_major_version().  It's preparation for splitting
ata_dev_identify().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    6 +-----
 include/linux/ata.h        |   10 ++++++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

4bb86c7dff884e19b8d611950c9928d38837c905
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 5719e4c..dd31f3b 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1325,7 +1325,6 @@ static void ata_dev_identify(struct ata_
 {
 	struct ata_device *dev = &ap->device[device];
 	unsigned int major_version;
-	u16 tmp;
 	unsigned long xfer_modes;
 	unsigned int using_edd;
 	struct ata_taskfile tf;
@@ -1429,10 +1428,7 @@ retry:
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
1.1.3


