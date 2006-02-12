From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/5] libata: make ata_dump_id() take @id instead of @dev
Date: Sun, 12 Feb 2006 22:47:05 +0900
Message-ID: <1139752025853-git-send-email-htejun@gmail.com>
References: <11397520242602-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.176]:26219 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751120AbWBLNrM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2006 08:47:12 -0500
Received: by pproxy.gmail.com with SMTP id d42so433981pyd
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2006 05:47:11 -0800 (PST)
In-Reply-To: <11397520242602-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make ata_dump_id() take @id instead of @dev.  This is preparation for
splitting ata_dev_identify().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

1e6421a8c452cdce9853077482b130f8b228a6a7
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 7bb99b0..9744ed3 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -651,41 +651,41 @@ void ata_dev_select(struct ata_port *ap,
 
 /**
  *	ata_dump_id - IDENTIFY DEVICE info debugging output
- *	@dev: Device whose IDENTIFY DEVICE page we will dump
+ *	@id: IDENTIFY DEVICE page to dump
  *
- *	Dump selected 16-bit words from a detected device's
- *	IDENTIFY PAGE page.
+ *	Dump selected 16-bit words from the given IDENTIFY DEVICE
+ *	page.
  *
  *	LOCKING:
  *	caller.
  */
 
-static inline void ata_dump_id(const struct ata_device *dev)
+static inline void ata_dump_id(const u16 *id)
 {
 	DPRINTK("49==0x%04x  "
 		"53==0x%04x  "
 		"63==0x%04x  "
 		"64==0x%04x  "
 		"75==0x%04x  \n",
-		dev->id[49],
-		dev->id[53],
-		dev->id[63],
-		dev->id[64],
-		dev->id[75]);
+		id[49],
+		id[53],
+		id[63],
+		id[64],
+		id[75]);
 	DPRINTK("80==0x%04x  "
 		"81==0x%04x  "
 		"82==0x%04x  "
 		"83==0x%04x  "
 		"84==0x%04x  \n",
-		dev->id[80],
-		dev->id[81],
-		dev->id[82],
-		dev->id[83],
-		dev->id[84]);
+		id[80],
+		id[81],
+		id[82],
+		id[83],
+		id[84]);
 	DPRINTK("88==0x%04x  "
 		"93==0x%04x\n",
-		dev->id[88],
-		dev->id[93]);
+		id[88],
+		id[93]);
 }
 
 /*
@@ -1019,7 +1019,7 @@ retry:
 	if (!xfer_modes)
 		xfer_modes = ata_pio_modes(dev);
 
-	ata_dump_id(dev);
+	ata_dump_id(dev->id);
 
 	/* ATA-specific feature tests */
 	if (dev->class == ATA_DEV_ATA) {
@@ -2507,7 +2507,7 @@ static void ata_dev_reread_id(struct ata
 
 	swap_buf_le16(dev->id, ATA_ID_WORDS);
 
-	ata_dump_id(dev);
+	ata_dump_id(dev->id);
 
 	DPRINTK("EXIT\n");
 
-- 
1.1.5


