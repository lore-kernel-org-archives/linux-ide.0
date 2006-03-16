From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/1] libata-dev: Remove ATA_PROT_PIO_MULT
Date: Thu, 16 Mar 2006 17:59:22 +0800
Message-ID: <441936FA.6060501@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:12949 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751998AbWCPJ7h
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Mar 2006 04:59:37 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2G9xV8O020766
	for <linux-ide@vger.kernel.org>; Thu, 16 Mar 2006 04:59:31 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2G9uc4l250492
	for <linux-ide@vger.kernel.org>; Thu, 16 Mar 2006 02:56:38 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2G9xUNq013766
	for <linux-ide@vger.kernel.org>; Thu, 16 Mar 2006 02:59:31 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>

Remove the ATA_PROT_PIO_MULT protocol.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

The ATA_PROT_PIO_MULT can be handled as ATA_PROT_PIO.
Remove it.

Changes:
  - Remove the ATA_PROT_PIO_MULT protocol
  - Filter out the PIO multi commands in ATA pass through

Patch against the upstream branch
(fb21f0d0ec7e31cc814165e1a9d2662d9c9dd980).

For your review, thanks,

Albert

--- upstream/include/linux/ata.h	2006-03-16 17:23:56.000000000 +0800
+++ upstream2/include/linux/ata.h	2006-03-16 17:25:25.000000000 +0800
@@ -204,7 +204,6 @@ enum ata_tf_protocols {
 	ATA_PROT_UNKNOWN,	/* unknown/invalid */
 	ATA_PROT_NODATA,	/* no data */
 	ATA_PROT_PIO,		/* PIO single sector */
-	ATA_PROT_PIO_MULT,	/* PIO multiple sector */
 	ATA_PROT_DMA,		/* DMA */
 	ATA_PROT_ATAPI,		/* packet command, PIO data xfer*/
 	ATA_PROT_ATAPI_NODATA,	/* packet command, no data */
--- upstream/drivers/scsi/libata-scsi.c	2006-03-16 17:23:51.000000000 +0800
+++ upstream2/drivers/scsi/libata-scsi.c	2006-03-16 17:42:00.000000000 +0800
@@ -2356,9 +2356,6 @@ ata_scsi_map_proto(u8 byte1)
 
 		case 4:		/* PIO Data-in */
 		case 5:		/* PIO Data-out */
-			if (byte1 & 0xe0) {
-				return ATA_PROT_PIO_MULT;
-			}
 			return ATA_PROT_PIO;
 
 		case 10:	/* Device Reset */
@@ -2397,6 +2394,10 @@ ata_scsi_pass_thru(struct ata_queued_cmd
 	if ((tf->protocol = ata_scsi_map_proto(scsicmd[1])) == ATA_PROT_UNKNOWN)
 		goto invalid_fld;
 
+	if (scsicmd[1] & 0xe0)
+		/* PIO multi not supported yet */
+		goto invalid_fld;
+
 	/*
 	 * 12 and 16 byte CDBs use different offsets to
 	 * provide the various register values.
--- upstream/drivers/scsi/libata-core.c	2006-03-16 17:23:51.000000000 +0800
+++ upstream2/drivers/scsi/libata-core.c	2006-03-16 17:25:25.000000000 +0800
@@ -3905,7 +3905,6 @@ static inline int ata_should_dma_map(str
 
 	case ATA_PROT_ATAPI:
 	case ATA_PROT_PIO:
-	case ATA_PROT_PIO_MULT:
 		if (ap->flags & ATA_FLAG_PIO_DMA)
 			return 1;
 




