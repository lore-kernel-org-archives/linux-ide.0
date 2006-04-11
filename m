From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/15] sata_sil: add hotplug support
Date: Tue, 11 Apr 2006 23:14:08 +0900
Message-ID: <11447648482618-git-send-email-htejun@gmail.com>
References: <1144764846705-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.204]:52965 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751298AbWDKOOT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:14:19 -0400
Received: by zproxy.gmail.com with SMTP id o37so1102585nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:14:18 -0700 (PDT)
In-Reply-To: <1144764846705-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add hotplug support by enabling SATA IRQ for SError.N and scheduling
EH if the interrupt occurs.  Standard EH will do the right thing and
schedule probe after analyzing SError.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

2f423e8392edda125a3cec0269e4cd7ceb7afa46
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 0b72585..49a5098 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -346,6 +346,9 @@ static void sil_postreset(struct ata_por
 
 	ata_std_postreset(ap, classes);
 
+	/* turn on SATA IRQ */
+	writel(SIL_SIEN_N, mmio_base + sil_port[ap->port_no].sien);
+
 	/* everything is back to normal, turn on IRQ */
 	tmp = readl(mmio_base + SIL_SYSCFG);
 	tmp &= ~(SIL_MASK_IDE0_INT << ap->port_no);
@@ -364,7 +367,7 @@ static void sil_host_intr(struct ata_por
 	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
 	u8 status;
 
-	if (unlikely(!qc || qc->tf.ctl & ATA_NIEN))
+	if (unlikely(bmdma2 & SIL_DMA_SATA_IRQ || !qc || qc->tf.ctl & ATA_NIEN))
 		goto freeze;
 
 	switch (qc->tf.protocol) {
@@ -425,7 +428,7 @@ static irqreturn_t sil_interrupt(int irq
 		if (unlikely(!ap || ap->flags & ATA_FLAG_DISABLED))
 			continue;
 
-		if (!(bmdma2 & SIL_DMA_COMPLETE))
+		if (!(bmdma2 & (SIL_DMA_COMPLETE | SIL_DMA_SATA_IRQ)))
 			continue;
 
 		sil_host_intr(ap, bmdma2);
@@ -442,6 +445,9 @@ static void sil_freeze(struct ata_port *
 	void __iomem *mmio_base = ap->host_set->mmio_base;
 	u32 tmp;
 
+	/* global IRQ mask doesn't block SATA IRQ, turn off explicitly */
+	writel(0, mmio_base + sil_port[ap->port_no].sien);
+
 	/* plug IRQ */
 	tmp = readl(mmio_base + SIL_SYSCFG);
 	tmp |= SIL_MASK_IDE0_INT << ap->port_no;
@@ -622,11 +628,6 @@ static int sil_init_one (struct pci_dev 
 			       mmio_base + sil_port[2].bmdma);
 	}
 
-	/* mask all SATA phy-related interrupts */
-	/* TODO: unmask bit 6 (SError N bit) for hotplug */
-	for (i = 0; i < probe_ent->n_ports; i++)
-		writel(0, mmio_base + sil_port[i].sien);
-
 	pci_set_master(pdev);
 
 	/* FIXME: check ata_device_add return value */
-- 
1.2.4


