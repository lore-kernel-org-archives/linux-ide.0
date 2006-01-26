From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/16] libata: make ata_dump_id() take @id instead of @dev
Date: Fri, 27 Jan 2006 00:39:11 +0900
Message-ID: <11382899513848-git-send-email-htejun@gmail.com>
References: <1138289951261-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:61520 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964772AbWAZPjZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 10:39:25 -0500
Received: by zproxy.gmail.com with SMTP id 34so372373nzf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jan 2006 07:39:25 -0800 (PST)
In-Reply-To: <1138289951261-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk
Cc: Tejun Heo <htejun@gmail.com>

Make ata_dump_id() take @id instead of @dev.  This is preparation for
splitting ata_dev_identify().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   42 ++++++++++++------------------------------
 1 files changed, 12 insertions(+), 30 deletions(-)

332f5a854f0662e15289e3fd8e34e7fd76345bb7
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index dd31f3b..776d00d 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1049,41 +1049,23 @@ void ata_dev_select(struct ata_port *ap,
 
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
-	DPRINTK("49==0x%04x  "
-		"53==0x%04x  "
-		"63==0x%04x  "
-		"64==0x%04x  "
-		"75==0x%04x  \n",
-		dev->id[49],
-		dev->id[53],
-		dev->id[63],
-		dev->id[64],
-		dev->id[75]);
-	DPRINTK("80==0x%04x  "
-		"81==0x%04x  "
-		"82==0x%04x  "
-		"83==0x%04x  "
-		"84==0x%04x  \n",
-		dev->id[80],
-		dev->id[81],
-		dev->id[82],
-		dev->id[83],
-		dev->id[84]);
-	DPRINTK("88==0x%04x  "
-		"93==0x%04x\n",
-		dev->id[88],
-		dev->id[93]);
+	DPRINTK("49==0x%04x  53==0x%04x  63==0x%04x  64==0x%04x  75==0x%04x  \n",
+		id[49], id[53], id[63], id[64], id[75]);
+	DPRINTK("80==0x%04x  81==0x%04x  82==0x%04x  83==0x%04x  84==0x%04x  \n",
+		id[80], id[81], id[82], id[83], id[84]);
+	DPRINTK("88==0x%04x  93==0x%04x\n",
+		id[88], id[93]);
 }
 
 /*
@@ -1418,7 +1400,7 @@ retry:
 	if (!xfer_modes)
 		xfer_modes = ata_pio_modes(dev);
 
-	ata_dump_id(dev);
+	ata_dump_id(dev->id);
 
 	/* ATA-specific feature tests */
 	if (dev->class == ATA_DEV_ATA) {
@@ -2854,7 +2836,7 @@ static void ata_dev_reread_id(struct ata
 
 	swap_buf_le16(dev->id, ATA_ID_WORDS);
 
-	ata_dump_id(dev);
+	ata_dump_id(dev->id);
 
 	DPRINTK("EXIT\n");
 
-- 
1.1.3


