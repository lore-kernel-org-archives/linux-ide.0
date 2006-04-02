From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/15] libata: clear only affected flags during ata_dev_configure()
Date: Sun, 2 Apr 2006 18:51:53 +0900
Message-ID: <1143971513949-git-send-email-htejun@gmail.com>
References: <11439715124131-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.229]:16243 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932309AbWDBJwC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 05:52:02 -0400
Received: by wproxy.gmail.com with SMTP id i22so1139534wra
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 01:52:02 -0800 (PST)
In-Reply-To: <11439715124131-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_dev_configure() should not clear dynamic device flags determined
elsewhere.  Lower eight bits are reserved for feature flags, define
ATA_DFLAG_CFG_MASK and clear only those bits before configuring
device.  Without this patch, ATA_DFLAG_PIO gets turned off during
revalidation making PIO mode unuseable.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    2 +-
 include/linux/libata.h     |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

5554fe07da31aea352de83053420138b04dff3cb
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 3a5eb5e..167d9f1 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1241,7 +1241,7 @@ static int ata_dev_configure(struct ata_
 		       id[84], id[85], id[86], id[87], id[88]);
 
 	/* initialize to-be-configured parameters */
-	dev->flags = 0;
+	dev->flags &= ~ATA_DFLAG_CFG_MASK;
 	dev->max_sectors = 0;
 	dev->cdb_len = 0;
 	dev->n_sectors = 0;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 890262f..cbbc821 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -122,6 +122,7 @@ enum {
 	/* struct ata_device stuff */
 	ATA_DFLAG_LBA		= (1 << 0), /* device supports LBA */
 	ATA_DFLAG_LBA48		= (1 << 1), /* device supports LBA48 */
+	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device currently in PIO mode */
 
-- 
1.2.4


