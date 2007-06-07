From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/6] libata: update protocol numbers
Date: Thu, 07 Jun 2007 15:47:13 +0800
Message-ID: <4667B801.3060603@tw.ibm.com>
References: <4667B767.5060601@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:42231 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755359AbXFGHrY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jun 2007 03:47:24 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l577lNOj012451
	for <linux-ide@vger.kernel.org>; Thu, 7 Jun 2007 03:47:23 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l577lI4k223336
	for <linux-ide@vger.kernel.org>; Thu, 7 Jun 2007 01:47:23 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l577lHwX007656
	for <linux-ide@vger.kernel.org>; Thu, 7 Jun 2007 01:47:18 -0600
In-Reply-To: <4667B767.5060601@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>

Patch 1/6:
 Update the ATA passthru protocol numbers according to the new spec.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

diff -Nrup 00_libata-dev/drivers/ata/libata-scsi.c 01_protocol_update/drivers/ata/libata-scsi.c
--- 00_libata-dev/drivers/ata/libata-scsi.c	2007-06-01 12:08:21.000000000 +0800
+++ 01_protocol_update/drivers/ata/libata-scsi.c	2007-06-07 11:38:50.000000000 +0800
@@ -2512,16 +2512,15 @@ ata_scsi_map_proto(u8 byte1)
 		case 5:		/* PIO Data-out */
 			return ATA_PROT_PIO;
 
-		case 10:	/* Device Reset */
 		case 0:		/* Hard Reset */
 		case 1:		/* SRST */
-		case 2:		/* Bus Idle */
-		case 7:		/* Packet */
-		case 8:		/* DMA Queued */
-		case 9:		/* Device Diagnostic */
-		case 11:	/* UDMA Data-in */
-		case 12:	/* UDMA Data-Out */
-		case 13:	/* FPDMA */
+		case 8:		/* Device Diagnostic */
+		case 9:		/* Device Reset */
+		case 7:		/* DMA Queued */
+		case 10:	/* UDMA Data-in */
+		case 11:	/* UDMA Data-Out */
+		case 12:	/* FPDMA */
+		case 15:	/* Return Response Info */
 		default:	/* Reserved */
 			break;
 	}


