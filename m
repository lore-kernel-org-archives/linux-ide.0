From: "Gwendal Grignou" <gwendal@google.com>
Subject: [PATCH 2.6.24 1/1] sata_sil24: prevent hba lockup when pass-through ATA commands are used
Date: Tue, 1 Jan 2008 08:50:59 -0800
Message-ID: <e7510f760801010850l11b14086oc80ebe5b1f738eb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:21368 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604AbYAAQvE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Jan 2008 11:51:04 -0500
Received: from zps18.corp.google.com (zps18.corp.google.com [172.25.146.18])
	by smtp-out.google.com with ESMTP id m01Gp1hj018613
	for <linux-ide@vger.kernel.org>; Tue, 1 Jan 2008 16:51:01 GMT
Received: from wa-out-1112.google.com (wafm38.prod.google.com [10.114.189.38])
	by zps18.corp.google.com with ESMTP id m01GoxoK011634
	for <linux-ide@vger.kernel.org>; Tue, 1 Jan 2008 08:51:00 -0800
Received: by wa-out-1112.google.com with SMTP id m38so8684456waf.5
        for <linux-ide@vger.kernel.org>; Tue, 01 Jan 2008 08:50:59 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Fix commands timeout with Sil3124/3132 based HBA when pass-through ATA
commands [where ATA_QCFLAG_RESULT_TF is set] are used while other
commands are active on other devices
connected to the same port with a Port Multiplier.
Due to a hardware bug, these commands must be sent alone, like ATAPI commands.
---
 drivers/ata/sata_sil24.c |   36 ++++++++++++++++++++++++++----------
 1 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 96fd526..56cddc7 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -832,16 +832,32 @@ static int sil24_qc_defer(struct ata_que
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
 	 */
+	int is_excl = (prot == ATA_PROT_ATAPI ||
+		       prot == ATA_PROT_ATAPI_NODATA ||
+		       prot == ATA_PROT_ATAPI_DMA ||
+		       (qc->flags & ATA_QCFLAG_RESULT_TF));
+
 	if (unlikely(ap->excl_link)) {
 		if (link == ap->excl_link) {
 			if (ap->nr_active_links)
@@ -849,7 +865,7 @@ static int sil24_qc_defer(struct ata_que
 			qc->flags |= ATA_QCFLAG_CLEAR_EXCL;
 		} else
 			return ATA_DEFER_PORT;
-	} else if (unlikely(is_atapi)) {
+	} else if (unlikely(is_excl)) {
 		ap->excl_link = link;
 		if (ap->nr_active_links)
 			return ATA_DEFER_PORT;
