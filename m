From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/8] libata: add protocol data transfer tests
Date: Mon,  5 Nov 2007 14:45:09 +0900
Message-ID: <1194241516284-git-send-email-htejun@gmail.com>
References: <1194241515653-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [222.235.223.38] ([222.235.223.38]:23584 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751382AbXKEFpU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Nov 2007 00:45:20 -0500
In-Reply-To: <1194241515653-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add protocol data transfer tests.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 include/linux/ata.h |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index 61535e7..2318531 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -323,6 +323,27 @@ enum ata_tf_protocols {
 	ATA_PROT_ATAPI_DMA,	/* packet command with special DMA sauce */
 };
 
+static inline int ata_is_nodata(u8 prot)
+{
+	return prot == ATA_PROT_NODATA || prot == ATA_PROT_ATAPI_NODATA;
+}
+
+static inline int ata_is_pio_data(u8 prot)
+{
+	return prot == ATA_PROT_PIO || prot == ATA_PROT_ATAPI;
+}
+
+static inline int ata_is_dma_data(u8 prot)
+{
+	return prot == ATA_PROT_DMA || prot == ATA_PROT_NCQ ||
+		prot == ATA_PROT_ATAPI_DMA;
+}
+
+static inline int ata_is_data(u8 prot)
+{
+	return ata_is_pio_data(prot) || ata_is_dma_data(prot);
+}
+
 enum ata_ioctls {
 	ATA_IOC_GET_IO32	= 0x309,
 	ATA_IOC_SET_IO32	= 0x324,
-- 
1.5.2.4

