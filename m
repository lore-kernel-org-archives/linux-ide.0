From: Tony Battersby <tonyb@cybernetics.com>
Subject: [PATCH] libata: increase 128 KB / cmd limit for ATAPI tape drives
Date: Tue, 30 Oct 2007 11:44:35 -0400
Message-ID: <47275163.9020809@cybernetics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host06.cybernetics.com ([206.246.200.22]:2352 "EHLO
	mail.cybernetics.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1756538AbXJ3Pof (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 11:44:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

Commands sent to ATAPI tape drives via the SCSI generic (sg) driver are
limited in the amount of data that they can transfer by the max_sectors
value.  The max_sectors value is currently calculated according to the
command set for disk drives, which doesn't apply to tape drives.  The
default max_sectors value of 256 limits ATAPI tape drive commands to
128 KB.  This patch against 2.6.24-rc1 increases the max_sectors value
for tape drives to 65535, which permits tape drive commands to transfer
just under 32 MB.

Tested with a SuperMicro PDSME motherboard, AHCI, and a Sony SDX-570V
SATA tape drive.

Note that some of the chipset drivers also set their own max_sectors
value, which may override the value set in libata-core.  I don't have
any of these chipsets to test, so I didn't go messing with them.  Also,
ATAPI devices other than tape drives may benefit from similar changes,
but I have only tape drives and disk drives to test.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
diff -urpN linux-2.6.24-rc1-vanilla/drivers/ata/libata-core.c linux-2.6.24-rc1/drivers/ata/libata-core.c
--- linux-2.6.24-rc1-vanilla/drivers/ata/libata-core.c	2007-10-30 09:21:38.000000000 -0400
+++ linux-2.6.24-rc1/drivers/ata/libata-core.c	2007-10-30 11:35:57.000000000 -0400
@@ -2126,6 +2126,10 @@ int ata_dev_configure(struct ata_device 
 		dev->max_sectors = ATA_MAX_SECTORS;
 	}
 
+	if ((dev->class == ATA_DEV_ATAPI) &&
+	    (atapi_command_packet_set(id) == TYPE_TAPE))
+		dev->max_sectors = ATA_MAX_SECTORS_TAPE;
+
 	if (dev->horkage & ATA_HORKAGE_MAX_SEC_128)
 		dev->max_sectors = min_t(unsigned int, ATA_MAX_SECTORS_128,
 					 dev->max_sectors);
diff -urpN linux-2.6.24-rc1-vanilla/include/linux/ata.h linux-2.6.24-rc1/include/linux/ata.h
--- linux-2.6.24-rc1-vanilla/include/linux/ata.h	2007-10-30 09:21:54.000000000 -0400
+++ linux-2.6.24-rc1/include/linux/ata.h	2007-10-30 10:30:59.000000000 -0400
@@ -43,6 +43,7 @@ enum {
 	ATA_MAX_SECTORS_128	= 128,
 	ATA_MAX_SECTORS		= 256,
 	ATA_MAX_SECTORS_LBA48	= 65535,/* TODO: 65536? */
+	ATA_MAX_SECTORS_TAPE	= 65535,
 
 	ATA_ID_WORDS		= 256,
 	ATA_ID_SERNO		= 10,
@@ -522,6 +523,11 @@ static inline int atapi_cdb_len(const u1
 	}
 }
 
+static inline int atapi_command_packet_set(const u16 *dev_id)
+{
+	return (dev_id[0] >> 8) & 0x1f;
+}
+
 static inline int is_atapi_taskfile(const struct ata_taskfile *tf)
 {
 	return (tf->protocol == ATA_PROT_ATAPI) ||


