From: Tejun Heo <tj@kernel.org>
Subject: Re: IO errors after "block: remove bio_get_nr_vecs()"
Date: Mon, 21 Dec 2015 01:55:28 -0500
Message-ID: <20151221065528.GA3873@htj.duckdns.org>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:35747 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbbLUGza (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Dec 2015 01:55:30 -0500
Content-Disposition: inline
In-Reply-To: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Artem S. Tashkinov" <t.artem@mailcity.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>, Christoph Hellwig <hch@lst.de>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, Linus Torvalds <torvalds@linux-foundation.org>, Steven Whitehouse <swhiteho@redhat.com>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Artem, can you please reproduce the issue with the following patch
applied and attach the kernel log?

Thanks.

---
 drivers/ata/libahci.c     |   40 ++++++++++++++++++++++++++++++++++++++--
 drivers/ata/libata-eh.c   |    4 ++++
 drivers/ata/libata-scsi.c |    1 +
 3 files changed, 43 insertions(+), 2 deletions(-)

--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2278,7 +2278,7 @@ static int ahci_port_start(struct ata_po
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 	struct device *dev = ap->host->dev;
 	struct ahci_port_priv *pp;
-	void *mem;
+	void *mem, *base;
 	dma_addr_t mem_dma;
 	size_t dma_sz, rx_fis_sz;
 
@@ -2319,7 +2319,9 @@ static int ahci_port_start(struct ata_po
 		rx_fis_sz = AHCI_RX_FIS_SZ;
 	}
 
-	mem = dmam_alloc_coherent(dev, dma_sz, &mem_dma, GFP_KERNEL);
+	base = mem = dmam_alloc_coherent(dev, dma_sz, &mem_dma, GFP_KERNEL);
+	printk("XXX port %d dma_sz=%zu mem=%p mem_dma=%p",
+	       ap->port_no, dma_sz, mem, (void *)mem_dma);
 	if (!mem)
 		return -ENOMEM;
 	memset(mem, 0, dma_sz);
@@ -2331,6 +2333,8 @@ static int ahci_port_start(struct ata_po
 	pp->cmd_slot = mem;
 	pp->cmd_slot_dma = mem_dma;
 
+	pr_cont(" cmd_slot=%zu", mem - base);
+
 	mem += AHCI_CMD_SLOT_SZ;
 	mem_dma += AHCI_CMD_SLOT_SZ;
 
@@ -2340,6 +2344,8 @@ static int ahci_port_start(struct ata_po
 	pp->rx_fis = mem;
 	pp->rx_fis_dma = mem_dma;
 
+	pr_cont(" rx_fis=%zu", mem - base);
+
 	mem += rx_fis_sz;
 	mem_dma += rx_fis_sz;
 
@@ -2350,6 +2356,8 @@ static int ahci_port_start(struct ata_po
 	pp->cmd_tbl = mem;
 	pp->cmd_tbl_dma = mem_dma;
 
+	pr_cont(" cmd_tbl=%zu\n", mem - base);
+
 	/*
 	 * Save off initial list of interrupts to be enabled.
 	 * This could be changed later
@@ -2540,6 +2548,34 @@ int ahci_host_activate(struct ata_host *
 }
 EXPORT_SYMBOL_GPL(ahci_host_activate);
 
+void ahci_dump_dma(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct ahci_port_priv *pp = ap->private_data;
+	struct ahci_cmd_hdr *cmd = &pp->cmd_slot[qc->tag];
+	void *cmd_tbl = pp->cmd_tbl + qc->tag * AHCI_CMD_TBL_SZ;
+	u32 *fis = cmd_tbl;
+	struct ahci_sg *ahci_sg = cmd_tbl + AHCI_CMD_TBL_HDR_SZ;
+	int prdtl = (cmd->opts & 0xffff0000) >> 16;
+	int i;
+
+	printk("XXX cmd=%p cmd_tbl=%p ahci_sg=%p\n", cmd, cmd_tbl, ahci_sg);
+	printk("XXX opts=%x st=%x addr=%x addr_hi=%x rsvd=%x:%x:%x:%x\n",
+	       cmd->opts, cmd->status, cmd->tbl_addr, cmd->tbl_addr_hi,
+	       cmd->reserved[0], cmd->reserved[1], cmd->reserved[2], cmd->reserved[3]);
+	printk("XXX fis=%08x:%08x:%08x:%08x %08x:%08x:%08x:%08x\n",
+	       fis[0], fis[1], fis[2], fis[3],
+	       fis[4], fis[5], fis[6], fis[7]);
+
+	printk("XXX qc->n_elem=%d fis_len=%d prdtl=%d\n",
+	       qc->n_elem, cmd->opts & 0xf, prdtl);
+
+	for (i = 0; i < prdtl; i++)
+		printk("XXX sg[%d] = %x %x %x (%d)\n",
+		       i, ahci_sg[i].addr, ahci_sg[i].addr_hi, ahci_sg[i].flags_size,
+		       (ahci_sg[i].flags_size & 0x7fffffff) + 1);
+}
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Common AHCI SATA low-level routines");
 MODULE_LICENSE("GPL");
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1059,6 +1059,7 @@ static int ata_do_link_abort(struct ata_
 
 		if (qc && (!link || qc->dev->link == link)) {
 			qc->flags |= ATA_QCFLAG_FAILED;
+			qc->err_mask = AC_ERR_DEV;
 			ata_qc_complete(qc);
 			nr_aborted++;
 		}
@@ -2416,6 +2417,8 @@ const char *ata_get_cmd_descript(u8 comm
 }
 EXPORT_SYMBOL_GPL(ata_get_cmd_descript);
 
+void ahci_dump_dma(struct ata_queued_cmd *qc);
+
 /**
  *	ata_eh_link_report - report error handling to user
  *	@link: ATA link EH is going on
@@ -2590,6 +2593,7 @@ static void ata_eh_link_report(struct at
 			  res->feature & ATA_IDNF ? "IDNF " : "",
 			  res->feature & ATA_ABORTED ? "ABRT " : "");
 #endif
+		ahci_dump_dma(qc);
 	}
 }
 
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4035,6 +4035,7 @@ int ata_scsi_user_scan(struct Scsi_Host
 	}
 
 	if (rc == 0) {
+		ata_port_freeze(ap);
 		ata_port_schedule_eh(ap);
 		spin_unlock_irqrestore(ap->lock, flags);
 		ata_port_wait_eh(ap);
