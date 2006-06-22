From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/1] libata-dev: move the CDB-intr DMA blacklisting
Date: Thu, 22 Jun 2006 13:00:25 +0800
Message-ID: <449A23E9.9060907@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:32677 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030610AbWFVFAj
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Jun 2006 01:00:39 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k5M50biX005206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-ide@vger.kernel.org>; Thu, 22 Jun 2006 01:00:37 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5M50lPx087596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 21 Jun 2006 23:00:47 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5M50ZEC006351
	for <linux-ide@vger.kernel.org>; Wed, 21 Jun 2006 23:00:36 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@bebe.enoyolf.org>, Unicorn Chang <uchang@tw.ibm.com>

Move the DMA blacklisting of the CDB-intr devices
from ata_check_atapi_dma() to ata_dma_blacklisted(), where it makes more sense.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

Patch against upstream branch (d7a80dad2fe19a2b8c119c8e9cba605474a75a2b).
For your review, thanks.

--- upstream0/drivers/scsi/libata-core.c	2006-06-22 11:27:14.000000000 +0800
+++ upstream1/drivers/scsi/libata-core.c	2006-06-22 11:47:17.000000000 +0800
@@ -2943,6 +2943,14 @@ static int ata_dma_blacklisted(const str
 	unsigned int nlen, rlen;
 	int i;
 
+	/* We don't support polling DMA.
+	 * DMA blacklist those ATAPI devices with CDB-intr (and use PIO)
+	 * if the LLDD handles only interrupts in the HSM_ST_LAST state.
+	 */
+	if ((dev->ap->flags & ATA_FLAG_PIO_POLLING) &&
+	    (dev->flags & ATA_DFLAG_CDB_INTR))
+		return 1;
+
 	ata_id_string(dev->id, model_num, ATA_ID_PROD_OFS,
 			  sizeof(model_num));
 	ata_id_string(dev->id, model_rev, ATA_ID_FW_REV_OFS,
@@ -3235,15 +3243,6 @@ int ata_check_atapi_dma(struct ata_queue
 	if (ap->ops->check_atapi_dma)
 		rc = ap->ops->check_atapi_dma(qc);
 
-	/* We don't support polling DMA.
-	 * Use PIO if the LLDD handles only interrupts in
-	 * the HSM_ST_LAST state and the ATAPI device
-	 * generates CDB interrupts.
-	 */
-	if ((ap->flags & ATA_FLAG_PIO_POLLING) &&
-	    (qc->dev->flags & ATA_DFLAG_CDB_INTR))
-		rc = 1;
-
 	return rc;
 }
 /**
@@ -4551,7 +4550,7 @@ unsigned int ata_qc_issue_prot(struct at
 			break;
 		case ATA_PROT_ATAPI_DMA:
 			if (qc->dev->flags & ATA_DFLAG_CDB_INTR)
-				/* see ata_check_atapi_dma() */
+				/* see ata_dma_blacklisted() */
 				BUG();
 			break;
 		default:

