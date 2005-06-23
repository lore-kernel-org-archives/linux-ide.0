From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/2] libata: Remove 'case ATA_PROT_ATAPI' in ata_host_intr()
Date: Thu, 23 Jun 2005 17:13:08 +0800
Message-ID: <42BA7D24.2070203@tw.ibm.com>
References: <42BA775B.1050601@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030902030206090007090808"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:33783 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262352AbVFWJOY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Jun 2005 05:14:24 -0400
In-Reply-To: <42BA775B.1050601@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------030902030206090007090808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

This is patch 2/2.
Problem:
  Given ATA_PROT_ATAPI is handled with interrupt off.
=> If any interrupt occurs with protocol ATA_PROT_ATAPI, it is not our interrupt and should be ignored.
(This problem is previously indicated by Bart as in:
http://marc.theaimsgroup.com/?l=linux-ide&m=111822488916620&w=2 )

  In ata_pio_complete(), we have the following code:
	ata_irq_on(ap);
	// interrupt here might cause double completion of the command.
	ata_qc_complete(qc, drv_stat);
So, there might be race condition between ata_pio_complete() and interrupt handler.

Changes:
- Remove 'case ATA_PROT_ATAPI' in ata_host_intr().

Attached please find the patch against the linux-2.6.git tree for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

--------------030902030206090007090808
Content-Type: text/plain;
 name="patch2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch2.diff"

--- linux/drivers/scsi/libata-core.c	2005-06-23 15:57:16.000000000 +0800
+++ linux-intr/drivers/scsi/libata-core.c	2005-06-23 16:06:48.000000000 +0800
@@ -3506,7 +3506,6 @@
 
 	case ATA_PROT_DMA:
 	case ATA_PROT_ATAPI_DMA:
-	case ATA_PROT_ATAPI:
 		/* check status of DMA engine */
 		host_stat = ap->ops->bmdma_status(ap);
 		VPRINTK("ata%u: host_stat 0x%X\n", ap->id, host_stat);

--------------030902030206090007090808--


