From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/1] libata-dev: print out information for ATAPI devices with
 CDB interrupts
Date: Fri, 31 Mar 2006 13:29:04 +0800
Message-ID: <442CBE20.2010602@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:44993 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750787AbWCaF3N
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Mar 2006 00:29:13 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k2V5T7Np027300
	for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 00:29:07 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2V5WDZr155386
	for <linux-ide@vger.kernel.org>; Thu, 30 Mar 2006 22:32:15 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2V5T5HI003418
	for <linux-ide@vger.kernel.org>; Thu, 30 Mar 2006 22:29:05 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

print out information for ATAPI devices with CDB interrupts

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Minor patch to help identify the CD-ROM drives with CDB interrupts
in dmesg. After the patch, the dmesg looks like:

pata_pdc2027x 0000:02:05.0: PLL input clock 16717 kHz
ata3: PATA max UDMA/133 cmd 0x989517C0 ctl 0x98951FDA bmdma 0x98951000 irq 10
ata4: PATA max UDMA/133 cmd 0x989515C0 ctl 0x98951DDA bmdma 0x98951008 irq 10
ata3: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0000
ata3: dev 0 ATAPI, max MWDMA2, CDB intr
ata3: dev 0 configured for MWDMA2
scsi2 : pata_pdc2027x
ata4: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003 88:407f
ata4: dev 0 ATA-7, max UDMA/133, 160086528 sectors: LBA
ata4: dev 1 cfg 49:2f00 82:346b 83:7d01 84:5823 85:3469 86:3c01 87:4023 88:203f
ata4: dev 1 ATA-6, max UDMA/100, 156301488 sectors: LBA48
ata4: dev 0 configured for UDMA/100
ata4: dev 1 configured for UDMA/100
scsi3 : pata_pdc2027x
  Vendor: E-IDE     Model: CD-ROM 36X/AKW    Rev: U22 
  Type:   CD-ROM                             ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6Y080L0    Rev: YAR4
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)

Patch against the irq-pio branch
(4f0e7c51ae392d841be395a9c6b8d26a9fbf33d2).

For your review, thanks.

Albert

--- irq-pio0/drivers/scsi/libata-core.c	2006-03-31 13:12:35.000000000 +0800
+++ cdb_printk/drivers/scsi/libata-core.c	2006-03-31 13:14:59.000000000 +0800
@@ -1305,6 +1305,8 @@ static int ata_dev_configure(struct ata_
 
 	/* ATAPI-specific feature tests */
 	else if (dev->class == ATA_DEV_ATAPI) {
+		char *cdb_intr_string = "";
+
 		rc = atapi_cdb_len(id);
 		if ((rc < 12) || (rc > ATAPI_CDB_LEN)) {
 			printk(KERN_WARNING "ata%u: unsupported CDB len\n", ap->id);
@@ -1313,13 +1315,16 @@ static int ata_dev_configure(struct ata_
 		}
 		dev->cdb_len = (unsigned int) rc;
 
-		if (ata_id_cdb_intr(dev->id))
+		if (ata_id_cdb_intr(dev->id)) {
 			dev->flags |= ATA_DFLAG_CDB_INTR;
+			cdb_intr_string = ", CDB intr";
+		}
 
 		/* print device info to dmesg */
 		if (print_info)
-			printk(KERN_INFO "ata%u: dev %u ATAPI, max %s\n",
-			       ap->id, dev->devno, ata_mode_string(xfer_mask));
+			printk(KERN_INFO "ata%u: dev %u ATAPI, max %s%s\n",
+			       ap->id, dev->devno, ata_mode_string(xfer_mask),
+			       cdb_intr_string);
 	}
 
 	ap->host->max_cmd_len = 0;

