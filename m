From: Robert Hancock <hancockr@shaw.ca>
Subject: [PATCH 2/5] sata_nv: cleanup CPB and APRD initialization
Date: Mon, 19 Feb 2007 19:02:27 -0600
Message-ID: <45DA48A3.9000107@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932966AbXBTBE6@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org

Clean up the initialization of the CPB and APRD structures so that we
strictly follow the rules for ordering of writes to the CPB flags and
response flags, and prevent duplicate initialization.

Signed-off-by: Robert Hancock <hancockr@shaw.ca>

--- linux-2.6.20-git6edit/drivers/ata/sata_nv.c	2007-02-15 22:36:02.000000000 -0600
+++ linux-2.6.20-git6edit/drivers/ata/sata_nv.c.delayandfixes	2007-02-19 17:00:14.000000000 -0600
@@ -1164,11 +1159,7 @@ static void nv_adma_fill_aprd(struct ata
 			      int idx,
 			      struct nv_adma_prd *aprd)
 {
-	u8 flags;
-
-	memset(aprd, 0, sizeof(struct nv_adma_prd));
-
-	flags = 0;
+	u8 flags = 0;
 	if (qc->tf.flags & ATA_TFLAG_WRITE)
 		flags |= NV_APRD_WRITE;
 	if (idx == qc->n_elem - 1)
@@ -1179,6 +1170,7 @@ static void nv_adma_fill_aprd(struct ata
 	aprd->addr  = cpu_to_le64(((u64)sg_dma_address(sg)));
 	aprd->len   = cpu_to_le32(((u32)sg_dma_len(sg))); /* len in bytes */
 	aprd->flags = flags;
+	aprd->packet_len = 0;
 }
 
 static void nv_adma_fill_sg(struct ata_queued_cmd *qc, struct nv_adma_cpb *cpb)
@@ -1199,6 +1191,8 @@ static void nv_adma_fill_sg(struct ata_q
 	}
 	if (idx > 5)
 		cpb->next_aprd = cpu_to_le64(((u64)(pp->aprd_dma + NV_ADMA_SGTBL_SZ * qc->tag)));
+	else
+		cpb->next_aprd = cpu_to_le64(0);
 }
 
 static int nv_adma_use_reg_mode(struct ata_queued_cmd *qc)
@@ -1231,7 +1225,10 @@ static void nv_adma_qc_prep(struct ata_q
 		return;
 	}
 
-	memset(cpb, 0, sizeof(struct nv_adma_cpb));
+	cpb->resp_flags = NV_CPB_RESP_DONE;
+	wmb();
+	cpb->ctl_flags = 0;
+	wmb();
 
 	cpb->len		= 3;
 	cpb->tag		= qc->tag;
@@ -1255,6 +1252,8 @@ static void nv_adma_qc_prep(struct ata_q
 	   finished filling in all of the contents */
 	wmb();
 	cpb->ctl_flags = ctl_flags;
+	wmb();
+	cpb->resp_flags = 0;
 }
 
 static unsigned int nv_adma_qc_issue(struct ata_queued_cmd *qc)
