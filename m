From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/1] libata-dev: ata_check_atapi_dma() fix for ATA_FLAG_PIO_POLLING
 LLDDs
Date: Mon, 13 Mar 2006 15:57:15 +0800
Message-ID: <441525DB.40905@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:34696 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932330AbWCMH5Z
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Mar 2006 02:57:25 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2D7vKsU017930
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 02:57:20 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2D80Dfw143602
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 01:00:13 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2D7vJEq028967
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 00:57:19 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

ata_check_atapi_dma() fix for LLDDs with the ATA_FLAG_PIO_POLLING flag.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

We don't support polling DMA.
If the LLDD handles only interrupts in the HSM_ST_LAST state 
(indicated by the ATA_FLAG_PIO_POLLING flag) and the ATAPI device
generates CDB interrupts, we have to use the polling PIO protocol.
(Otherwise, the CDB interrupts might confuse the LLDD.)

We just set the protocol to PIO here in ata_check_atapi_dma().
Later in ata_qc_issue_prot(), the PIO protocol will be set as "polling"
for those LLDDs.

Patch against the irq-pio branch +
(1) irq-pio minor fixes (respin) +
(2) integrate polling pio with irq-pio (respin)

For your review, thanks,

Albert

--- 05_cleanup/drivers/scsi/libata-core.c	2006-03-13 13:29:02.000000000 +0800
+++ 06_check_atapi_dma/drivers/scsi/libata-core.c	2006-03-13 13:29:25.000000000 +0800
@@ -2850,6 +2850,15 @@ int ata_check_atapi_dma(struct ata_queue
 	if (ap->ops->check_atapi_dma)
 		rc = ap->ops->check_atapi_dma(qc);
 
+	/* We don't support polling DMA.
+	 * Use PIO if the LLDD handles only interrupts in
+	 * the HSM_ST_LAST state and the ATAPI device
+	 * generates CDB interrupts.
+	 */
+	if ((ap->flags & ATA_FLAG_PIO_POLLING) &&
+	    (qc->dev->flags & ATA_DFLAG_CDB_INTR))
+		rc = 1;
+
 	return rc;
 }
 /**
@@ -4004,6 +4013,7 @@ unsigned int ata_qc_issue_prot(struct at
 			break;
 		case ATA_PROT_ATAPI_DMA:
 			if (qc->dev->flags & ATA_DFLAG_CDB_INTR)
+				/* see ata_check_atapi_dma() */
 				BUG();
 			break;
 		default:

