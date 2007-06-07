From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 3/6] libata: map UDMA protocols
Date: Thu, 07 Jun 2007 15:50:44 +0800
Message-ID: <4667B8D4.2010505@tw.ibm.com>
References: <4667B767.5060601@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:44858 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbXFGHut (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jun 2007 03:50:49 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l577omrp016473
	for <linux-ide@vger.kernel.org>; Thu, 7 Jun 2007 03:50:48 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l577omPD265674
	for <linux-ide@vger.kernel.org>; Thu, 7 Jun 2007 01:50:48 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l577ombn011859
	for <linux-ide@vger.kernel.org>; Thu, 7 Jun 2007 01:50:48 -0600
In-Reply-To: <4667B767.5060601@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>

Patch 3/6:
 Map the ATA passthru UDMA protocols to ATA_PROT_DMA.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Don't know why SAT distinguishs "UDMA Data In" and "UDMA Data Out" from "DMA".
These UDMA protocols only matter for on-the-wire-protocol and are mostly transparent
to the software. Anyway, map both of UDMA protocols to "ATA_PROT_DMA" here.

diff -Nrup 02_pio_multi/drivers/ata/libata-scsi.c 03_udma_supp/drivers/ata/libata-scsi.c
--- 02_pio_multi/drivers/ata/libata-scsi.c	2007-06-07 11:38:53.000000000 +0800
+++ 03_udma_supp/drivers/ata/libata-scsi.c	2007-06-07 11:41:30.000000000 +0800
@@ -2506,6 +2506,8 @@ ata_scsi_map_proto(u8 byte1)
 			return ATA_PROT_NODATA;
 
 		case 6:		/* DMA */
+		case 10:	/* UDMA Data-in */
+		case 11:	/* UDMA Data-Out */
 			return ATA_PROT_DMA;
 
 		case 4:		/* PIO Data-in */
@@ -2517,8 +2519,6 @@ ata_scsi_map_proto(u8 byte1)
 		case 8:		/* Device Diagnostic */
 		case 9:		/* Device Reset */
 		case 7:		/* DMA Queued */
-		case 10:	/* UDMA Data-in */
-		case 11:	/* UDMA Data-Out */
 		case 12:	/* FPDMA */
 		case 15:	/* Return Response Info */
 		default:	/* Reserved */


