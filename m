From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/13] sata_sil24: fix on-memory structure byteorder
Date: Fri, 7 Apr 2006 17:16:54 +0900
Message-ID: <11443978143342-git-send-email-htejun@gmail.com>
References: <114439781363-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.236]:62430 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932380AbWDGIRE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Apr 2006 04:17:04 -0400
Received: by wproxy.gmail.com with SMTP id 58so295241wri
        for <linux-ide@vger.kernel.org>; Fri, 07 Apr 2006 01:17:03 -0700 (PDT)
In-Reply-To: <114439781363-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, Carlos.Pardo@siliconimage.com
Cc: Tejun Heo <htejun@gmail.com>

Data structures residing on memory and fetched by the controller
should have LE ordering.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

c65a82b53f25bf7ef1c5d08d65c34770fd5bc55c
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 46c0f2a..0b96ab1 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -482,7 +482,7 @@ static int sil24_softreset(struct ata_po
 	}
 
 	/* do SRST */
-	prb->ctrl = PRB_CTRL_SRST;
+	prb->ctrl = cpu_to_le16(PRB_CTRL_SRST);
 	prb->fis[1] = 0; /* no PM yet */
 
 	writel((u32)paddr, port + PORT_CMD_ACTIVATE);
@@ -598,6 +598,7 @@ static void sil24_qc_prep(struct ata_que
 	union sil24_cmd_block *cb = pp->cmd_block + qc->tag;
 	struct sil24_prb *prb;
 	struct sil24_sge *sge;
+	u16 ctrl = 0;
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_PIO:
@@ -605,7 +606,6 @@ static void sil24_qc_prep(struct ata_que
 	case ATA_PROT_NODATA:
 		prb = &cb->ata.prb;
 		sge = cb->ata.sge;
-		prb->ctrl = 0;
 		break;
 
 	case ATA_PROT_ATAPI:
@@ -618,12 +618,10 @@ static void sil24_qc_prep(struct ata_que
 
 		if (qc->tf.protocol != ATA_PROT_ATAPI_NODATA) {
 			if (qc->tf.flags & ATA_TFLAG_WRITE)
-				prb->ctrl = PRB_CTRL_PACKET_WRITE;
+				ctrl = PRB_CTRL_PACKET_WRITE;
 			else
-				prb->ctrl = PRB_CTRL_PACKET_READ;
-		} else
-			prb->ctrl = 0;
-
+				ctrl = PRB_CTRL_PACKET_READ;
+		}
 		break;
 
 	default:
@@ -632,6 +630,7 @@ static void sil24_qc_prep(struct ata_que
 		BUG();
 	}
 
+	prb->ctrl = cpu_to_le16(ctrl);
 	ata_tf_to_fis(&qc->tf, prb->fis, 0);
 
 	if (qc->flags & ATA_QCFLAG_DMAMAP)
-- 
1.2.4


