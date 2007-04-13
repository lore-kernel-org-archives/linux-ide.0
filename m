From: Kyle McMartin <kyle@canonical.com>
Subject: [PATCH] sata_nv: Don't attempt using ADMA for (READ|SET)_MAX commands
Date: Fri, 13 Apr 2007 13:08:31 -0400
Message-ID: <20070413170831.GC27674@athena.road.mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:55761 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104AbXDMRKP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Apr 2007 13:10:15 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, bcollins@ubuntu.com

READ_NATIVE_MAX and SET_MAX were causing timeouts on sata_nv controllers.
Disabling ADMA helped, but that is quite a large hammer to use. Reverting
382a6652e91b34d5480cfc0ed840c196650493d4 also helped, but we might as well
fix it right, instead of disabling the performance gain on cache flushes
by using ADMA mode.

Signed-off-by: Kyle McMartin <kyle@canonical.com>

---

This patch depends on the Host Protected Area patch Alan sent to linux-ide
this week.

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 9d9670a..eaf9b76 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -1162,6 +1162,20 @@ static void nv_adma_fill_sg(struct ata_queued_cmd *qc, struct nv_adma_cpb *cpb)
 		cpb->next_aprd = cpu_to_le64(0);
 }
 
+static int nv_blacklist_adma_for_hpa_cmds(struct ata_taskfile *tf)
+{
+	switch(tf->command) {
+	case ATA_CMD_READ_NATIVE_MAX:
+	case ATA_CMD_READ_NATIVE_MAX_EXT:
+	case ATA_CMD_SET_MAX:
+	case ATA_CMD_SET_MAX_EXT:
+		return 1;
+
+	default:
+		return 0;
+	}
+}
+
 static int nv_adma_use_reg_mode(struct ata_queued_cmd *qc)
 {
 	struct nv_adma_port_priv *pp = qc->ap->private_data;
@@ -1173,8 +1187,12 @@ static int nv_adma_use_reg_mode(struct ata_queued_cmd *qc)
 		return 1;
 
 	if((qc->flags & ATA_QCFLAG_DMAMAP) ||
-	   (qc->tf.protocol == ATA_PROT_NODATA))
-		return 0;
+	   (qc->tf.protocol == ATA_PROT_NODATA)) {
+		if (nv_blacklist_adma_for_hpa_cmds(&qc->tf))
+			return 1;	/* (SET|READ)_NATIVE_MAX time out in ADMA mdoe */
+		else
+			return 0;
+	}
 
 	return 1;
 }
