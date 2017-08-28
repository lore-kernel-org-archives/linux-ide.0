From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] libata: quirk read log on no-name M.2 SSD
Date: Mon, 28 Aug 2017 08:28:08 +0200
Message-ID: <20170828062808.20717-1-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:50037 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbdH1G2Q (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 28 Aug 2017 02:28:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: idosch@mellanox.com, linux-ide@vger.kernel.org

Ivo reported that reading the log page on his systems fails,
so quirk it as it won't support ZBC or security protocols.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Ido Schimmel <idosch@mellanox.com>
Tested-by: Ido Schimmel <idosch@mellanox.com>
---
 drivers/ata/libata-core.c | 4 ++++
 include/linux/libata.h    | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index fa7dd4394c02..697f5f896b19 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2079,6 +2079,8 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 	 */
 	if (ap_flags & ATA_FLAG_NO_LOG_PAGE)
 		return AC_ERR_DEV;
+	if (dev->horkage & ATA_HORKAGE_NO_LOG_PAGE)
+		return AC_ERR_DEV;
 
 retry:
 	ata_tf_init(dev, &tf);
@@ -4578,6 +4580,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "WDC WD3000JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
 	{ "WDC WD3200JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
 
+
+	{ "M.2 (S42) 3ME3",		NULL,	ATA_HORKAGE_NO_LOG_PAGE },
 	/* End Marker */
 	{ }
 };
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 931c32f1f18d..9e927ae7fced 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -438,6 +438,7 @@ enum {
 	ATA_HORKAGE_NO_DMA_LOG	= (1 << 23),	/* don't use DMA for log read */
 	ATA_HORKAGE_NOTRIM	= (1 << 24),	/* don't use TRIM */
 	ATA_HORKAGE_MAX_SEC_1024 = (1 << 25),	/* Limit max sects to 1024 */
+	ATA_HORKAGE_NO_LOG_PAGE = (1 << 26),	/* Doesn't like Get Log Page */
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
-- 
2.11.0

