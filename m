From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 01/10] libata: return boolean values from ata_is_*
Date: Thu, 14 Jul 2016 09:05:42 +0900
Message-ID: <1468454751-12466-2-git-send-email-hch@lst.de>
References: <1468454751-12466-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:55683 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbcGNAGC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jul 2016 20:06:02 -0400
In-Reply-To: <1468454751-12466-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: hare@suse.com, damien.lemoal@hgst.com, linux-ide@vger.kernel.org

This way we don't have to worry about the exact bit postition of the
test to leak out and any crazy propagation effects in the callers.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/libata.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index d15c19e..4e5a09c 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1063,32 +1063,32 @@ static inline unsigned int ata_prot_flags(u8 prot)
 	return 0;
 }
 
-static inline int ata_is_atapi(u8 prot)
+static inline bool ata_is_atapi(u8 prot)
 {
 	return ata_prot_flags(prot) & ATA_PROT_FLAG_ATAPI;
 }
 
-static inline int ata_is_nodata(u8 prot)
+static inline bool ata_is_nodata(u8 prot)
 {
 	return !(ata_prot_flags(prot) & ATA_PROT_FLAG_DATA);
 }
 
-static inline int ata_is_pio(u8 prot)
+static inline bool ata_is_pio(u8 prot)
 {
 	return ata_prot_flags(prot) & ATA_PROT_FLAG_PIO;
 }
 
-static inline int ata_is_dma(u8 prot)
+static inline bool ata_is_dma(u8 prot)
 {
 	return ata_prot_flags(prot) & ATA_PROT_FLAG_DMA;
 }
 
-static inline int ata_is_ncq(u8 prot)
+static inline bool ata_is_ncq(u8 prot)
 {
 	return ata_prot_flags(prot) & ATA_PROT_FLAG_NCQ;
 }
 
-static inline int ata_is_data(u8 prot)
+static inline bool ata_is_data(u8 prot)
 {
 	return ata_prot_flags(prot) & ATA_PROT_FLAG_DATA;
 }
@@ -1407,7 +1407,7 @@ static inline bool sata_pmp_attached(struct ata_port *ap)
 	return ap->nr_pmp_links != 0;
 }
 
-static inline int ata_is_host_link(const struct ata_link *link)
+static inline bool ata_is_host_link(const struct ata_link *link)
 {
 	return link == &link->ap->link || link == link->ap->slave_link;
 }
@@ -1422,7 +1422,7 @@ static inline bool sata_pmp_attached(struct ata_port *ap)
 	return false;
 }
 
-static inline int ata_is_host_link(const struct ata_link *link)
+static inline bool ata_is_host_link(const struct ata_link *link)
 {
 	return 1;
 }
-- 
2.1.4

