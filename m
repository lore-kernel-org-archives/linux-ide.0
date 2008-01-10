From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] sata_sil24: prevent hba lockup when pass-through
 ATA commands are used
Date: Thu, 10 Jan 2008 15:47:56 +0900
Message-ID: <4785BF9C.4010503@gmail.com>
References: <e7510f760801010850l11b14086oc80ebe5b1f738eb5@mail.gmail.com> <47842EAD.9010302@gmail.com> <4785A4E6.90107@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:35744 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbYAJGsD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jan 2008 01:48:03 -0500
Received: by rv-out-0910.google.com with SMTP id k20so481911rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 09 Jan 2008 22:48:02 -0800 (PST)
In-Reply-To: <4785A4E6.90107@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Gwendal Grignou <gwendal@google.com>, linux-ide@vger.kernel.org

From: Gwendal Grignou <gwendal@google.com>

Fix commands timeout with Sil3124/3132 based HBA when pass-through ATA
commands [where ATA_QCFLAG_RESULT_TF is set] are used while other
commands are active on other devices connected to the same port with a
Port Multiplier.  Due to a hardware bug, these commands must be sent
alone, like ATAPI commands.

Signed-off-by: Gwendal Grignou <gwendal@google.com>
Acked-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_sil24.c |   37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 96fd526..b4c674d 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -832,16 +832,31 @@ static int sil24_qc_defer(struct ata_queued_cmd *qc)
 	struct ata_link *link = qc->dev->link;
 	struct ata_port *ap = link->ap;
 	u8 prot = qc->tf.protocol;
-	int is_atapi = (prot == ATA_PROT_ATAPI ||
-			prot == ATA_PROT_ATAPI_NODATA ||
-			prot == ATA_PROT_ATAPI_DMA);
-
-	/* ATAPI commands completing with CHECK_SENSE cause various
-	 * weird problems if other commands are active.  PMP DMA CS
-	 * errata doesn't cover all and HSM violation occurs even with
-	 * only one other device active.  Always run an ATAPI command
-	 * by itself.
-	 */
+
+	/*
+	 * There is a bug in the chip:
+	 * Port LRAM Causes the PRB/SGT Data to be Corrupted
+	 * If the host issues a read request for LRAM and SActive registers
+	 * while active commands are available in the port, PRB/SGT data in
+	 * the LRAM can become corrupted. This issue applies only when
+	 * reading from, but not writing to, the LRAM.
+	 *
+	 * Therefore, reading LRAM when there is no particular error [and
+	 * other commands may be outstanding] is prohibited.
+	 *
+	 * To avoid this bug there are two situations where a command must run
+	 * exclusive of any other commands on the port:
+	 *
+	 * - ATAPI commands which check the sense data
+	 * - Passthrough ATA commands which always have ATA_QCFLAG_RESULT_TF
+	 *   set.
+	 *
+ 	 */
+	int is_excl = (prot == ATA_PROT_ATAPI ||
+		       prot == ATA_PROT_ATAPI_NODATA ||
+		       prot == ATA_PROT_ATAPI_DMA ||
+		       (qc->flags & ATA_QCFLAG_RESULT_TF));
+
 	if (unlikely(ap->excl_link)) {
 		if (link == ap->excl_link) {
 			if (ap->nr_active_links)
@@ -849,7 +864,7 @@ static int sil24_qc_defer(struct ata_queued_cmd *qc)
 			qc->flags |= ATA_QCFLAG_CLEAR_EXCL;
 		} else
 			return ATA_DEFER_PORT;
-	} else if (unlikely(is_atapi)) {
+	} else if (unlikely(is_excl)) {
 		ap->excl_link = link;
 		if (ap->nr_active_links)
 			return ATA_DEFER_PORT;
