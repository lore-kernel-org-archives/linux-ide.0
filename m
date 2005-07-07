From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:ncq 11/11] libata: debug stuff
Date: Thu,  7 Jul 2005 22:10:09 +0900 (KST)
Message-ID: <20050707130840.A88D58E7@htj.dyndns.org>
References: <20050707130840.5046338C@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.205]:10617 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261501AbVGGNKP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jul 2005 09:10:15 -0400
Received: by wproxy.gmail.com with SMTP id i31so189712wra
        for <linux-ide@vger.kernel.org>; Thu, 07 Jul 2005 06:10:13 -0700 (PDT)
In-Reply-To: <20050707130840.5046338C@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, axboe@suse.de, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

11_libata_debug.patch

	As usual, debug messages and error triggers.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/scsi/ahci.c        |   43 +++++++++++++++++++++++++++++++
 drivers/scsi/libata-core.c |    9 ++++++
 drivers/scsi/sata_sil.c    |   61 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/libata.h     |    2 -
 4 files changed, 113 insertions(+), 2 deletions(-)

Index: work/drivers/scsi/ahci.c
===================================================================
--- work.orig/drivers/scsi/ahci.c	2005-07-07 22:08:37.000000000 +0900
+++ work/drivers/scsi/ahci.c	2005-07-07 22:08:37.000000000 +0900
@@ -681,11 +681,54 @@ static int ahci_qc_issue(struct ata_queu
 	struct ata_port *ap = qc->ap;
 	void *port_mmio = (void *) ap->ioaddr.cmd_addr;
 
+#if 0
+	if (qc->tag == 3) {
+		struct ahci_port_priv *pp = qc->ap->private_data;
+		int offset = qc->tag * AHCI_CMD_TOTAL;
+		u8 *fis = pp->cmd_tbl + offset;
+		printk("AHCI%u: FAILING %02u %p: %08x %08x %08x %08x %08x\n",
+		       ap->id, qc->tag, qc->scsicmd,
+		       ((unsigned *)fis)[0], ((unsigned *)fis)[1],
+		       ((unsigned *)fis)[2], ((unsigned *)fis)[3],
+		       ((unsigned *)fis)[4]);
+		fis[4] = 0xff;
+		fis[5] = 0xff;
+		fis[6] = 0xff;
+		fis[8] = 0xff;
+		fis[9] = 0xff;
+		fis[10] = 0xff;
+	}
+#endif
+
+#if 1
+	{
+		struct ahci_port_priv *pp = qc->ap->private_data;
+		unsigned *fis = pp->cmd_tbl + (qc->tag * AHCI_CMD_TOTAL);
+		printk("AHCI%u: FIS(tag%02u) %p: %08x %08x %08x %08x %08x\n",
+		       ap->id, qc->tag, qc->scsicmd,
+		       fis[0], fis[1], fis[2], fis[3], fis[4]);
+		if (qc->tf.command == 0xa0) {
+			u8 *p = qc->cdb;
+			printk("AHCI%u: PACKET: %02x %02x %02x %02x %02x %02x %02x %02x  %02x %02x %02x %02x %02x %02x %02x %02x\n",
+			       ap->id,
+			       p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7],
+			       p[8], p[9], p[10], p[11], p[12], p[13], p[14], p[15]);
+		}
+	}
+#endif
+
 	if (qc->flags & ATA_QCFLAG_NCQ) {
 		writel(1 << qc->tag, port_mmio + PORT_SCR_ACT);
 		readl(port_mmio + PORT_SCR_ACT);
 	}
 
+#if 0
+	if (qc->tag == 3) {
+		printk("AHCI: SKIPPING %02u\n", qc->tag);
+		return 0;
+	}
+#endif
+
 	writel(1 << qc->tag, port_mmio + PORT_CMD_ISSUE);
 	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
 
Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-07-07 22:08:37.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-07-07 22:08:37.000000000 +0900
@@ -2981,6 +2981,15 @@ static void atapi_request_sense(struct a
 
 	cmd->result = SAM_STAT_CHECK_CONDITION;
 
+#if 1
+	{
+		u8 *p = cmd->sense_buffer;
+		printk("SENSE: %02x %02x %02x %02x %02x %02x %02x %02x  %02x %02x %02x %02x %02x %02x %02x %02x\n",
+		       p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7],
+		       p[8], p[9], p[10], p[11], p[12], p[13], p[14], p[15]);
+	}
+#endif
+
 	DPRINTK("EXIT\n");
 }
 
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h	2005-07-07 22:08:37.000000000 +0900
+++ work/include/linux/libata.h	2005-07-07 22:08:37.000000000 +0900
@@ -37,7 +37,7 @@
 #undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
 #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
 #undef ATA_NDEBUG		/* define to disable quick runtime checks */
-#undef ATA_ENABLE_ATAPI		/* define to enable ATAPI support */
+#define ATA_ENABLE_ATAPI	/* define to enable ATAPI support */
 #undef ATA_ENABLE_PATA		/* define to enable PATA support in some
 				 * low-level drivers */
 #undef ATAPI_ENABLE_DMADIR	/* enables ATAPI DMADIR bridge support */
Index: work/drivers/scsi/sata_sil.c
===================================================================
--- work.orig/drivers/scsi/sata_sil.c	2005-07-07 22:08:35.000000000 +0900
+++ work/drivers/scsi/sata_sil.c	2005-07-07 22:08:37.000000000 +0900
@@ -138,6 +138,65 @@ static Scsi_Host_Template sil_sht = {
 	.ordered_flush		= 1,
 };
 
+static int sil_qc_debug_issue(struct ata_queued_cmd *qc)
+{
+#if 1
+	{
+		static unsigned cnt = 0;
+		struct ata_port *ap = qc->ap;
+		struct ata_taskfile *tf = &qc->tf;
+
+		if (tf->command == ATA_CMD_READ_EXT) {
+			if (++cnt % 100 == 0) {
+				printk("SIL%u: FAILING H f=%02x n=%02x l=%02x m=%02x h=%02x L f=%02x n=%02x l=%02x m=%02x h=%02x C=%02x\n",
+				       ap->id, tf->hob_feature, tf->hob_nsect,
+				       tf->hob_lbal, tf->hob_lbam, tf->hob_lbah,
+				       tf->feature, tf->nsect, tf->lbal,
+				       tf->lbam, tf->lbah, tf->command);
+				tf->hob_lbal = 0xff;
+				tf->hob_lbam = 0xff;
+				tf->hob_lbah = 0xff;
+			}
+		}
+	}
+#endif
+
+#if 1
+	{
+		struct ata_port *ap = qc->ap;
+		struct ata_taskfile *tf = &qc->tf;
+		printk("SIL%u: tf %p: H f=%02x n=%02x l=%02x m=%02x h=%02x L f=%02x n=%02x l=%02x m=%02x h=%02x C=%02x\n",
+		       ap->id, qc->scsicmd, tf->hob_feature, tf->hob_nsect,
+		       tf->hob_lbal, tf->hob_lbam, tf->hob_lbah, tf->feature,
+		       tf->nsect, tf->lbal, tf->lbam, tf->lbah, tf->command);
+
+		if (qc->tf.command == 0xa0) {
+			u8 *p = qc->cdb;
+			printk("SIL%u: PACKET: %02x %02x %02x %02x %02x %02x %02x %02x  %02x %02x %02x %02x %02x %02x %02x %02x\n",
+			       ap->id,
+			       p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7],
+			       p[8], p[9], p[10], p[11], p[12], p[13], p[14], p[15]);
+		}
+	}
+#endif
+
+#if 0
+	{
+		static unsigned cnt = 0;
+		struct ata_port *ap = qc->ap;
+		struct ata_taskfile *tf = &qc->tf;
+
+		if (tf->command == ATA_CMD_READ_EXT) {
+			if (++cnt % 100 == 0) {
+				printk("SIL%u: skipping...\n", ap->id);
+				return 0;
+			}
+		}
+	}
+#endif
+	return ata_qc_issue_prot(qc);
+}
+
 static struct ata_port_operations sil_ops = {
 	.port_disable		= ata_port_disable,
 	.dev_config		= sil_dev_config,
@@ -153,7 +212,7 @@ static struct ata_port_operations sil_op
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
+	.qc_issue		= sil_qc_debug_issue,
 	.error_handler		= ata_error_handler,
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,

