From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 04/04] sata_mv async notify for genIIe only
Date: Wed, 14 May 2008 09:24:39 -0400
Message-ID: <482AE817.2020809@rtr.ca>
References: <482AE694.5080604@rtr.ca> <482AE6E2.4080900@rtr.ca> <482AE767.8090103@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3372 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129AbYENNYk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 May 2008 09:24:40 -0400
In-Reply-To: <482AE767.8090103@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Now that we handle the FIS_IRQ_CAUSE register correctly,
we can also now handle SATA asynchronous notification events.

So enable them, but only for the more modern GenIIe chips.
(older chips have unaddressed errata issues related to this).

This fixes hot plug/unplug for port-muliplier ports.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-05-14 09:00:36.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-14 09:04:38.000000000 -0400
@@ -133,7 +133,7 @@
 
 	MV_GENIIE_FLAGS		= MV_COMMON_FLAGS | MV_6XXX_FLAGS |
 				  ATA_FLAG_PMP | ATA_FLAG_ACPI_SATA |
-				  ATA_FLAG_NCQ,
+				  ATA_FLAG_NCQ | ATA_FLAG_AN,
 
 	CRQB_FLAG_READ		= (1 << 0),
 	CRQB_TAG_SHIFT		= 1,
@@ -226,6 +226,7 @@
 	SATA_STATUS_OFS		= 0x300,  /* ctrl, err regs follow status */
 	SATA_ACTIVE_OFS		= 0x350,
 	SATA_FIS_IRQ_CAUSE_OFS	= 0x364,
+	SATA_FIS_IRQ_AN		= (1 << 9),	/* async notification */
 
 	LTMODE_OFS		= 0x30c,
 	LTMODE_BIT8		= (1 << 8),	/* unknown, but necessary */
@@ -1849,8 +1850,17 @@
 	ata_ehi_push_desc(ehi, "edma_err_cause=%08x pp_flags=%08x",
 			  edma_err_cause, pp->pp_flags);
 
-	if (IS_GEN_IIE(hpriv) && (edma_err_cause & EDMA_ERR_TRANS_IRQ_7))
+	if (IS_GEN_IIE(hpriv) && (edma_err_cause & EDMA_ERR_TRANS_IRQ_7)) {
 		ata_ehi_push_desc(ehi, "fis_cause=%08x", fis_cause);
+		if (fis_cause & SATA_FIS_IRQ_AN) {
+			u32 ec = edma_err_cause &
+			       ~(EDMA_ERR_TRANS_IRQ_7 | EDMA_ERR_IRQ_TRANSIENT);
+			sata_async_notification(ap);
+			if (!ec)
+				return; /* Just an AN; no need for the nukes */
+			ata_ehi_push_desc(ehi, "SDB notify");
+		}
+	}
 	/*
 	 * All generations share these EDMA error cause bits:
 	 */
