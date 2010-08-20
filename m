From: Mark Lord <kernel@teksavvy.com>
Subject: [PATCH] libata-sff: remove harmful BUG_ON from ata_bmdma_qc_issue
Date: Fri, 20 Aug 2010 10:13:16 -0400
Message-ID: <1282313596.1634.0.camel@corey>
References: <1282267195.8909.6.camel@corey> <1282268444.9628.4.camel@corey>
	 <4C6E89A8.2000600@teksavvy.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-8qJtj+uDoHGFiWOmAGbQ"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:54154 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752428Ab0HTONR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Aug 2010 10:13:17 -0400
In-Reply-To: <4C6E89A8.2000600@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: tj@kernel.org, jeff@garzik.org


--=-8qJtj+uDoHGFiWOmAGbQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Remove harmful BUG_ON() from ata_bmdma_qc_issue(),
as it casts too wide of a net and breaks sata_mv.
It also crashes the kernel while doing the BUG_ON().

There's already a WARN_ON_ONCE() further down to catch
the case of POLLING for a BMDMA operation.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- 2.6.35.3-rc1/drivers/ata/libata-sff.c	2010-08-01 18:11:14.000000000 -0400
+++ linux/drivers/ata/libata-sff.c	2010-08-20 10:06:36.531914889 -0400
@@ -2735,10 +2735,6 @@
 {
 	struct ata_port *ap = qc->ap;
 
-	/* see ata_dma_blacklisted() */
-	BUG_ON((ap->flags & ATA_FLAG_PIO_POLLING) &&
-	       qc->tf.protocol == ATAPI_PROT_DMA);
-
 	/* defer PIO handling to sff_qc_issue */
 	if (!ata_is_dma(qc->tf.protocol))
 		return ata_sff_qc_issue(qc);


--=-8qJtj+uDoHGFiWOmAGbQ
Content-Disposition: attachment; filename="02_libata_sff_remove_bug.patch"
Content-Type: text/x-patch; name="02_libata_sff_remove_bug.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Remove harmful BUG_ON() from ata_bmdma_qc_issue(),
as it casts too wide of a net and breaks sata_mv.
It also crashes the kernel while doing the BUG_ON().

There's already a WARN_ON_ONCE() further down to catch
the case of POLLING for a BMDMA operation.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- 2.6.35.3-rc1/drivers/ata/libata-sff.c	2010-08-01 18:11:14.000000000 -0400
+++ linux/drivers/ata/libata-sff.c	2010-08-20 10:06:36.531914889 -0400
@@ -2735,10 +2735,6 @@
 {
 	struct ata_port *ap = qc->ap;
 
-	/* see ata_dma_blacklisted() */
-	BUG_ON((ap->flags & ATA_FLAG_PIO_POLLING) &&
-	       qc->tf.protocol == ATAPI_PROT_DMA);
-
 	/* defer PIO handling to sff_qc_issue */
 	if (!ata_is_dma(qc->tf.protocol))
 		return ata_sff_qc_issue(qc);

--=-8qJtj+uDoHGFiWOmAGbQ--

