From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/8] sata_sil24: fix on-memory structure byteorder
Date: Wed, 5 Apr 2006 22:29:02 +0900
Message-ID: <11442437422203-git-send-email-htejun@gmail.com>
References: <11442437413563-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.229]:7450 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751126AbWDEN3L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Apr 2006 09:29:11 -0400
Received: by wproxy.gmail.com with SMTP id i7so187751wra
        for <linux-ide@vger.kernel.org>; Wed, 05 Apr 2006 06:29:10 -0700 (PDT)
In-Reply-To: <11442437413563-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Data structures residing on memory and fetched by the controller
should have LE ordering.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

f6545e5248fe3c2c7ded43131c505032bc6ba080
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 60dd6f1..3d301b2 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -454,7 +454,7 @@ static int sil24_softreset(struct ata_po
 	 */
 	msleep(10);
 
-	prb->ctrl = PRB_CTRL_SRST;
+	prb->ctrl = cpu_to_le16(PRB_CTRL_SRST);
 	prb->fis[1] = 0; /* no PM yet */
 
 	writel((u32)paddr, port + PORT_CMD_ACTIVATE);
@@ -530,6 +530,7 @@ static void sil24_qc_prep(struct ata_que
 	union sil24_cmd_block *cb = pp->cmd_block + qc->tag;
 	struct sil24_prb *prb;
 	struct sil24_sge *sge;
+	u16 ctrl = 0;
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_PIO:
@@ -537,7 +538,6 @@ static void sil24_qc_prep(struct ata_que
 	case ATA_PROT_NODATA:
 		prb = &cb->ata.prb;
 		sge = cb->ata.sge;
-		prb->ctrl = 0;
 		break;
 
 	case ATA_PROT_ATAPI:
@@ -550,12 +550,10 @@ static void sil24_qc_prep(struct ata_que
 
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
@@ -564,6 +562,7 @@ static void sil24_qc_prep(struct ata_que
 		BUG();
 	}
 
+	prb->ctrl = cpu_to_le16(ctrl);
 	ata_tf_to_fis(&qc->tf, prb->fis, 0);
 
 	if (qc->flags & ATA_QCFLAG_DMAMAP)
-- 
1.2.4


