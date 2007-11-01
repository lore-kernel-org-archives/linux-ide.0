From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/8] libata: add protocol data transfer tests
Date: Fri,  2 Nov 2007 00:51:38 +0900
Message-ID: <11939323043230-git-send-email-htejun@gmail.com>
References: <11939323042554-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [222.235.223.38] ([222.235.223.38]:20823 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753582AbXKAPvr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Nov 2007 11:51:47 -0400
In-Reply-To: <11939323042554-git-send-email-htejun@gmail.com>
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
index e21c002..fd73b69 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -321,6 +321,27 @@ enum ata_tf_protocols {
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

