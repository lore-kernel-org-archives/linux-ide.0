From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_sil: convert to new EH
Date: Mon, 3 Apr 2006 12:40:59 +0900
Message-ID: <11440356591927-git-send-email-htejun@gmail.com>
References: <11440356574107-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:60238 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964823AbWDCDlI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 23:41:08 -0400
Received: by zproxy.gmail.com with SMTP id o37so1664796nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 20:41:07 -0700 (PDT)
In-Reply-To: <11440356574107-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Convert sata_sil to new EH.  As these controllers have hardware
interrupt mask and are known to have screaming interrupts issues, use
hardware IRQ masking for freezing.  sil_freeze() masks interrupts for
the port and sil_postreset() thaws it.  As ports are automatically
frozen before probing reset, there is no need to initialize interrupt
masks sil_init_onde().  Remove related code.

Other than freezing, sata_sil uses stock BMDMA EH routines.a

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil.c |   63 +++++++++++++++++++++++++++++++++++------------
 1 files changed, 47 insertions(+), 16 deletions(-)

1ed544ba5e576ec76f13776dd32e8ced0bd0f97a
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index d6c7086..2bb1ce1 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -95,7 +95,10 @@ static int sil_init_one (struct pci_dev 
 static void sil_dev_config(struct ata_port *ap, struct ata_device *dev);
 static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
+static int sil_probe_reset(struct ata_port *ap, unsigned int *classes);
 static void sil_post_set_mode (struct ata_port *ap);
+static void sil_freeze(struct ata_port *ap);
+static void sil_error_handler(struct ata_port *ap);
 
 
 static const struct pci_device_id sil_pci_tbl[] = {
@@ -167,7 +170,7 @@ static const struct ata_port_operations 
 	.check_status		= ata_check_status,
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
-	.probe_reset		= ata_std_probe_reset,
+	.probe_reset		= sil_probe_reset,
 	.post_set_mode		= sil_post_set_mode,
 	.bmdma_setup            = ata_bmdma_setup,
 	.bmdma_start            = ata_bmdma_start,
@@ -175,7 +178,9 @@ static const struct ata_port_operations 
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
-	.eng_timeout		= ata_eng_timeout,
+	.freeze			= sil_freeze,
+	.error_handler		= sil_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= sil_scr_read,
@@ -315,6 +320,45 @@ static void sil_scr_write (struct ata_po
 		writel(val, mmio);
 }
 
+static void sil_postreset(struct ata_port *ap, unsigned int *classes)
+{
+	void __iomem *mmio_base = ap->host_set->mmio_base;
+	u32 tmp;
+
+	/* reset complete, turn on IRQ */
+	tmp = readl(mmio_base + SIL_SYSCFG);
+	tmp &= ~(SIL_MASK_IDE0_INT << ap->port_no);
+	writel(tmp, mmio_base + SIL_SYSCFG);
+	readl(mmio_base + SIL_SYSCFG);	/* flush */
+
+	ata_std_postreset(ap, classes);
+}
+
+static int sil_probe_reset(struct ata_port *ap, unsigned int *classes)
+{
+	return ata_drive_probe_reset(ap, ata_std_probeinit,
+				     ata_std_softreset, sata_std_hardreset,
+				     sil_postreset, classes);
+}
+
+static void sil_freeze(struct ata_port *ap)
+{
+	void __iomem *mmio_base = ap->host_set->mmio_base;
+	u32 tmp;
+
+	/* plug IRQ */
+	tmp = readl(mmio_base + SIL_SYSCFG);
+	tmp |= SIL_MASK_IDE0_INT << ap->port_no;
+	writel(tmp, mmio_base + SIL_SYSCFG);
+	readl(mmio_base + SIL_SYSCFG);	/* flush */
+}
+
+static void sil_error_handler(struct ata_port *ap)
+{
+	ata_bmdma_drive_eh(ap, ata_std_softreset, sata_std_hardreset,
+			   sil_postreset);
+}
+
 /**
  *	sil_dev_config - Apply device/host-specific errata fixups
  *	@ap: Port containing device to be examined
@@ -385,7 +429,7 @@ static int sil_init_one (struct pci_dev 
 	int rc;
 	unsigned int i;
 	int pci_dev_busy = 0;
-	u32 tmp, irq_mask;
+	u32 tmp;
 	u8 cls;
 
 	if (!printed_version++)
@@ -479,24 +523,11 @@ static int sil_init_one (struct pci_dev 
 	}
 
 	if (ent->driver_data == sil_3114) {
-		irq_mask = SIL_MASK_4PORT;
-
 		/* flip the magic "make 4 ports work" bit */
 		tmp = readl(mmio_base + sil_port[2].bmdma);
 		if ((tmp & SIL_INTR_STEERING) == 0)
 			writel(tmp | SIL_INTR_STEERING,
 			       mmio_base + sil_port[2].bmdma);
-
-	} else {
-		irq_mask = SIL_MASK_2PORT;
-	}
-
-	/* make sure IDE0/1/2/3 interrupts are not masked */
-	tmp = readl(mmio_base + SIL_SYSCFG);
-	if (tmp & irq_mask) {
-		tmp &= ~irq_mask;
-		writel(tmp, mmio_base + SIL_SYSCFG);
-		readl(mmio_base + SIL_SYSCFG);	/* flush */
 	}
 
 	/* mask all SATA phy-related interrupts */
-- 
1.2.4


