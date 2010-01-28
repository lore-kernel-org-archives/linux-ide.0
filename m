From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] libata: fix ata_id_logical_per_physical_sectors
Date: Thu, 28 Jan 2010 11:42:34 +0100
Message-ID: <20100128104234.GA25693@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:54786 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023Ab0A1Kpl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Jan 2010 05:45:41 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, stable@kernel.org

The value we get from the low byte of the ATA_ID_SECTOR_SIZE word is not not
a plain multiple, but the log of it, so fix the helper to give the correct
answer.  Without this we'll get an incorrect minimal I/O size in the block
limits VPD page for 4k sector drives.

Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/include/linux/ata.h
===================================================================
--- linux-2.6.orig/include/linux/ata.h	2010-01-28 11:17:41.968003842 +0100
+++ linux-2.6/include/linux/ata.h	2010-01-28 11:20:02.355268610 +0100
@@ -649,7 +649,7 @@ static inline int ata_id_has_large_logic
 
 static inline u8 ata_id_logical_per_physical_sectors(const u16 *id)
 {
-	return id[ATA_ID_SECTOR_SIZE] & 0xf;
+	return 1 << (id[ATA_ID_SECTOR_SIZE] & 0xf);
 }
 
 static inline int ata_id_has_lba48(const u16 *id)
