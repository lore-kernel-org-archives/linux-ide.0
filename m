From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/3] libata-dev: Fix merge problem with upstream
Date: Mon, 13 Mar 2006 15:27:07 +0800
Message-ID: <44151ECB.7050104@tw.ibm.com>
References: <44119BC9.8080502@tw.ibm.com> <44136B04.4090203@pobox.com> <44151D53.3040606@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:38819 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751825AbWCMH1P
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Mar 2006 02:27:15 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2D7RCT4018732
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 02:27:12 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2D7U5fw162210
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 00:30:05 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2D7RBdl002739
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 00:27:11 -0700
In-Reply-To: <44151D53.3040606@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Fix merge problem with upstream.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Changes:
1. add missing dev->cdb_len = 16 for ATA devices
2. use ata_pio_task instead of atapi_packet_task

--- 001_whitespace/drivers/scsi/libata-core.c	2006-03-13 12:38:03.000000000 +0800
+++ 00_cdblen/drivers/scsi/libata-core.c	2006-03-13 12:25:40.000000000 +0800
@@ -1282,6 +1282,7 @@ static int ata_dev_configure(struct ata_
 				ap->id, device, dev->multi_count);
 		}
 
+		dev->cdb_len = 16;
 	}
 
 	/* ATAPI-specific feature tests */
@@ -4254,7 +4255,7 @@ unsigned int ata_qc_issue_prot(struct at
 		/* send cdb by polling if no cdb interrupt */
 		if ((!(qc->dev->flags & ATA_DFLAG_CDB_INTR)) ||
 		    (qc->tf.flags & ATA_TFLAG_POLLING))
-			ata_port_queue_task(ap, atapi_packet_task, ap, 0);
+			ata_port_queue_task(ap, ata_pio_task, ap, 0);
 		break;
 
 	case ATA_PROT_ATAPI_DMA:
@@ -4266,7 +4267,7 @@ unsigned int ata_qc_issue_prot(struct at
 
 		/* send cdb by polling if no cdb interrupt */
 		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
-			ata_port_queue_task(ap, atapi_packet_task, ap, 0);
+			ata_port_queue_task(ap, ata_pio_task, ap, 0);
 		break;
 
 	default:


