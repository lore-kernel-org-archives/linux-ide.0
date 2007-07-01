From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/12] libata: make ->scr_read/write callbacks return error code
Date: Sun, 1 Jul 2007 18:53:37 +0900
Message-ID: <11832836172969-git-send-email-htejun@gmail.com>
References: <118328361627-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:30760 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755275AbXGAJxn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 05:53:43 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1876599wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 02:53:43 -0700 (PDT)
In-Reply-To: <118328361627-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Convert ->scr_read/write callbacks to return error code to better
indicate failure.  This will help handling of SCR_NOTIFICATION.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c          |   23 ++++++++------
 drivers/ata/libata-core.c   |   21 ++++++------
 drivers/ata/sata_inic162x.c |   16 +++++-----
 drivers/ata/sata_mv.c       |   72 ++++++++++++++++++++++++++++--------------
 drivers/ata/sata_nv.c       |   16 +++++----
 drivers/ata/sata_promise.c  |   25 +++++++++------
 drivers/ata/sata_qstor.c    |   16 +++++----
 drivers/ata/sata_sil.c      |   25 +++++++++-----
 drivers/ata/sata_sil24.c    |   17 ++++++---
 drivers/ata/sata_sis.c      |   22 +++++++------
 drivers/ata/sata_svw.c      |   13 ++++---
 drivers/ata/sata_uli.c      |   16 +++++----
 drivers/ata/sata_via.c      |   27 +++++++++-------
 drivers/ata/sata_vsc.c      |   13 ++++---
 include/linux/libata.h      |    5 +--
 15 files changed, 191 insertions(+), 136 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ff0b70d..0e001ad 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -213,8 +213,8 @@ struct ahci_port_priv {
 	unsigned int		ncq_saw_sdb:1;
 };
 
-static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg);
-static void ahci_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
+static int ahci_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val);
+static int ahci_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int ahci_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc);
 static void ahci_irq_clear(struct ata_port *ap);
@@ -593,7 +593,7 @@ static void ahci_restore_initial_config(struct ata_host *host)
 	(void) readl(mmio + HOST_PORTS_IMPL);	/* flush */
 }
 
-static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg_in)
+static int ahci_scr_read(struct ata_port *ap, unsigned int sc_reg_in, u32 *val)
 {
 	unsigned int sc_reg;
 
@@ -603,15 +603,15 @@ static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg_in)
 	case SCR_ERROR:		sc_reg = 2; break;
 	case SCR_ACTIVE:	sc_reg = 3; break;
 	default:
-		return 0xffffffffU;
+		return -EINVAL;
 	}
 
-	return readl(ap->ioaddr.scr_addr + (sc_reg * 4));
+	*val = readl(ap->ioaddr.scr_addr + (sc_reg * 4));
+	return 0;
 }
 
 
-static void ahci_scr_write (struct ata_port *ap, unsigned int sc_reg_in,
-			       u32 val)
+static int ahci_scr_write(struct ata_port *ap, unsigned int sc_reg_in, u32 val)
 {
 	unsigned int sc_reg;
 
@@ -621,10 +621,11 @@ static void ahci_scr_write (struct ata_port *ap, unsigned int sc_reg_in,
 	case SCR_ERROR:		sc_reg = 2; break;
 	case SCR_ACTIVE:	sc_reg = 3; break;
 	default:
-		return;
+		return -EINVAL;
 	}
 
 	writel(val, ap->ioaddr.scr_addr + (sc_reg * 4));
+	return 0;
 }
 
 static void ahci_start_engine(struct ata_port *ap)
@@ -1061,6 +1062,7 @@ static int ahci_hardreset(struct ata_port *ap, unsigned int *class,
 static int ahci_vt8251_hardreset(struct ata_port *ap, unsigned int *class,
 				 unsigned long deadline)
 {
+	u32 serror;
 	int rc;
 
 	DPRINTK("ENTER\n");
@@ -1071,7 +1073,8 @@ static int ahci_vt8251_hardreset(struct ata_port *ap, unsigned int *class,
 				 deadline);
 
 	/* vt8251 needs SError cleared for the port to operate */
-	ahci_scr_write(ap, SCR_ERROR, ahci_scr_read(ap, SCR_ERROR));
+	ahci_scr_read(ap, SCR_ERROR, &serror);
+	ahci_scr_write(ap, SCR_ERROR, serror);
 
 	ahci_start_engine(ap);
 
@@ -1193,7 +1196,7 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 	ata_ehi_clear_desc(ehi);
 
 	/* AHCI needs SError cleared; otherwise, it might lock up */
-	serror = ahci_scr_read(ap, SCR_ERROR);
+	ahci_scr_read(ap, SCR_ERROR, &serror);
 	ahci_scr_write(ap, SCR_ERROR, serror);
 
 	/* analyze @irq_stat */
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8570975..147235c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5678,10 +5678,8 @@ int sata_scr_valid(struct ata_port *ap)
  */
 int sata_scr_read(struct ata_port *ap, int reg, u32 *val)
 {
-	if (sata_scr_valid(ap)) {
-		*val = ap->ops->scr_read(ap, reg);
-		return 0;
-	}
+	if (sata_scr_valid(ap))
+		return ap->ops->scr_read(ap, reg, val);
 	return -EOPNOTSUPP;
 }
 
@@ -5703,10 +5701,8 @@ int sata_scr_read(struct ata_port *ap, int reg, u32 *val)
  */
 int sata_scr_write(struct ata_port *ap, int reg, u32 val)
 {
-	if (sata_scr_valid(ap)) {
-		ap->ops->scr_write(ap, reg, val);
-		return 0;
-	}
+	if (sata_scr_valid(ap))
+		return ap->ops->scr_write(ap, reg, val);
 	return -EOPNOTSUPP;
 }
 
@@ -5727,10 +5723,13 @@ int sata_scr_write(struct ata_port *ap, int reg, u32 val)
  */
 int sata_scr_write_flush(struct ata_port *ap, int reg, u32 val)
 {
+	int rc;
+
 	if (sata_scr_valid(ap)) {
-		ap->ops->scr_write(ap, reg, val);
-		ap->ops->scr_read(ap, reg);
-		return 0;
+		rc = ap->ops->scr_write(ap, reg, val);
+		if (rc == 0)
+			rc = ap->ops->scr_read(ap, reg, &val);
+		return rc;
 	}
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 4f1fc28..2ad5690 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -190,34 +190,34 @@ static void inic_reset_port(void __iomem *port_base)
 	writew(ctl, idma_ctl);
 }
 
-static u32 inic_scr_read(struct ata_port *ap, unsigned sc_reg)
+static int inic_scr_read(struct ata_port *ap, unsigned sc_reg, u32 *val)
 {
 	void __iomem *scr_addr = ap->ioaddr.scr_addr;
 	void __iomem *addr;
-	u32 val;
 
 	if (unlikely(sc_reg >= ARRAY_SIZE(scr_map)))
-		return 0xffffffffU;
+		return -EINVAL;
 
 	addr = scr_addr + scr_map[sc_reg] * 4;
-	val = readl(scr_addr + scr_map[sc_reg] * 4);
+	*val = readl(scr_addr + scr_map[sc_reg] * 4);
 
 	/* this controller has stuck DIAG.N, ignore it */
 	if (sc_reg == SCR_ERROR)
-		val &= ~SERR_PHYRDY_CHG;
-	return val;
+		*val &= ~SERR_PHYRDY_CHG;
+	return 0;
 }
 
-static void inic_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val)
+static int inic_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val)
 {
 	void __iomem *scr_addr = ap->ioaddr.scr_addr;
 	void __iomem *addr;
 
 	if (unlikely(sc_reg >= ARRAY_SIZE(scr_map)))
-		return;
+		return -EINVAL;
 
 	addr = scr_addr + scr_map[sc_reg] * 4;
 	writel(val, scr_addr + scr_map[sc_reg] * 4);
+	return 0;
 }
 
 /*
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index c957e6e..0ced447 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -380,10 +380,10 @@ struct mv_host_priv {
 };
 
 static void mv_irq_clear(struct ata_port *ap);
-static u32 mv_scr_read(struct ata_port *ap, unsigned int sc_reg_in);
-static void mv_scr_write(struct ata_port *ap, unsigned int sc_reg_in, u32 val);
-static u32 mv5_scr_read(struct ata_port *ap, unsigned int sc_reg_in);
-static void mv5_scr_write(struct ata_port *ap, unsigned int sc_reg_in, u32 val);
+static int mv_scr_read(struct ata_port *ap, unsigned int sc_reg_in, u32 *val);
+static int mv_scr_write(struct ata_port *ap, unsigned int sc_reg_in, u32 val);
+static int mv5_scr_read(struct ata_port *ap, unsigned int sc_reg_in, u32 *val);
+static int mv5_scr_write(struct ata_port *ap, unsigned int sc_reg_in, u32 val);
 static void mv_phy_reset(struct ata_port *ap);
 static void __mv_phy_reset(struct ata_port *ap, int can_sleep);
 static int mv_port_start(struct ata_port *ap);
@@ -863,22 +863,26 @@ static unsigned int mv_scr_offset(unsigned int sc_reg_in)
 	return ofs;
 }
 
-static u32 mv_scr_read(struct ata_port *ap, unsigned int sc_reg_in)
+static int mv_scr_read(struct ata_port *ap, unsigned int sc_reg_in, u32 *val)
 {
 	unsigned int ofs = mv_scr_offset(sc_reg_in);
 
-	if (0xffffffffU != ofs)
-		return readl(mv_ap_base(ap) + ofs);
-	else
-		return (u32) ofs;
+	if (0xffffffffU != ofs) {
+		*val = readl(mv_ap_base(ap) + ofs);
+		return 0;
+	} else
+		return -EINVAL;
 }
 
-static void mv_scr_write(struct ata_port *ap, unsigned int sc_reg_in, u32 val)
+static int mv_scr_write(struct ata_port *ap, unsigned int sc_reg_in, u32 val)
 {
 	unsigned int ofs = mv_scr_offset(sc_reg_in);
 
-	if (0xffffffffU != ofs)
+	if (0xffffffffU != ofs) {
 		writelfl(val, mv_ap_base(ap) + ofs);
+		return 0;
+	} else
+		return -EINVAL;
 }
 
 static void mv_edma_cfg(struct mv_host_priv *hpriv, void __iomem *port_mmio)
@@ -1546,26 +1550,30 @@ static unsigned int mv5_scr_offset(unsigned int sc_reg_in)
 	return ofs;
 }
 
-static u32 mv5_scr_read(struct ata_port *ap, unsigned int sc_reg_in)
+static int mv5_scr_read(struct ata_port *ap, unsigned int sc_reg_in, u32 *val)
 {
 	void __iomem *mmio = ap->host->iomap[MV_PRIMARY_BAR];
 	void __iomem *addr = mv5_phy_base(mmio, ap->port_no);
 	unsigned int ofs = mv5_scr_offset(sc_reg_in);
 
-	if (ofs != 0xffffffffU)
-		return readl(addr + ofs);
-	else
-		return (u32) ofs;
+	if (ofs != 0xffffffffU) {
+		*val = readl(addr + ofs);
+		return 0;
+	} else
+		return -EINVAL;
 }
 
-static void mv5_scr_write(struct ata_port *ap, unsigned int sc_reg_in, u32 val)
+static int mv5_scr_write(struct ata_port *ap, unsigned int sc_reg_in, u32 val)
 {
 	void __iomem *mmio = ap->host->iomap[MV_PRIMARY_BAR];
 	void __iomem *addr = mv5_phy_base(mmio, ap->port_no);
 	unsigned int ofs = mv5_scr_offset(sc_reg_in);
 
-	if (ofs != 0xffffffffU)
+	if (ofs != 0xffffffffU) {
 		writelfl(val, addr + ofs);
+		return 0;
+	} else
+		return -EINVAL;
 }
 
 static void mv5_reset_bus(struct pci_dev *pdev, void __iomem *mmio)
@@ -1968,9 +1976,17 @@ static void __mv_phy_reset(struct ata_port *ap, int can_sleep)
 
 	VPRINTK("ENTER, port %u, mmio 0x%p\n", ap->port_no, port_mmio);
 
-	DPRINTK("S-regs after ATA_RST: SStat 0x%08x SErr 0x%08x "
-		"SCtrl 0x%08x\n", mv_scr_read(ap, SCR_STATUS),
-		mv_scr_read(ap, SCR_ERROR), mv_scr_read(ap, SCR_CONTROL));
+#ifdef DEBUG
+	{
+		u32 sstatus, serror, scontrol;
+
+		mv_scr_read(ap, SCR_STATUS, &sstatus);
+		mv_scr_read(ap, SCR_ERROR, &serror);
+		mv_scr_read(ap, SCR_CONTROL, &scontrol);
+		DPRINTK("S-regs after ATA_RST: SStat 0x%08x SErr 0x%08x "
+			"SCtrl 0x%08x\n", status, serror, scontrol);
+	}
+#endif
 
 	/* Issue COMRESET via SControl */
 comreset_retry:
@@ -1995,9 +2011,17 @@ comreset_retry:
 	    (retry-- > 0))
 		goto comreset_retry;
 
-	DPRINTK("S-regs after PHY wake: SStat 0x%08x SErr 0x%08x "
-		"SCtrl 0x%08x\n", mv_scr_read(ap, SCR_STATUS),
-		mv_scr_read(ap, SCR_ERROR), mv_scr_read(ap, SCR_CONTROL));
+#ifdef DEBUG
+	{
+		u32 sstatus, serror, scontrol;
+
+		mv_scr_read(ap, SCR_STATUS, &sstatus);
+		mv_scr_read(ap, SCR_ERROR, &serror);
+		mv_scr_read(ap, SCR_CONTROL, &scontrol);
+		DPRINTK("S-regs after PHY wake: SStat 0x%08x SErr 0x%08x "
+			"SCtrl 0x%08x\n", sstatus, serror, scontrol);
+	}
+#endif
 
 	if (ata_port_online(ap)) {
 		ata_port_probe(ap);
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index e9701c7..9790f3c 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -236,8 +236,8 @@ static void nv_ck804_host_stop(struct ata_host *host);
 static irqreturn_t nv_generic_interrupt(int irq, void *dev_instance);
 static irqreturn_t nv_nf2_interrupt(int irq, void *dev_instance);
 static irqreturn_t nv_ck804_interrupt(int irq, void *dev_instance);
-static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg);
-static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
+static int nv_scr_read (struct ata_port *ap, unsigned int sc_reg, u32 *val);
+static int nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
 static void nv_nf2_freeze(struct ata_port *ap);
 static void nv_nf2_thaw(struct ata_port *ap);
@@ -1391,20 +1391,22 @@ static irqreturn_t nv_ck804_interrupt(int irq, void *dev_instance)
 	return ret;
 }
 
-static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg)
+static int nv_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val)
 {
 	if (sc_reg > SCR_CONTROL)
-		return 0xffffffffU;
+		return -EINVAL;
 
-	return ioread32(ap->ioaddr.scr_addr + (sc_reg * 4));
+	*val = ioread32(ap->ioaddr.scr_addr + (sc_reg * 4));
+	return 0;
 }
 
-static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
+static int nv_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val)
 {
 	if (sc_reg > SCR_CONTROL)
-		return;
+		return -EINVAL;
 
 	iowrite32(val, ap->ioaddr.scr_addr + (sc_reg * 4));
+	return 0;
 }
 
 static void nv_nf2_freeze(struct ata_port *ap)
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index ff3d5c8..c710059 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -130,8 +130,8 @@ struct pdc_port_priv {
 	dma_addr_t		pkt_dma;
 };
 
-static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg);
-static void pdc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
+static int pdc_sata_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val);
+static int pdc_sata_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int pdc_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static int pdc_common_port_start(struct ata_port *ap);
 static int pdc_sata_port_start(struct ata_port *ap);
@@ -431,20 +431,21 @@ static int pdc_sata_cable_detect(struct ata_port *ap)
 	return ATA_CBL_SATA;
 }
 
-static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
+static int pdc_sata_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val)
 {
 	if (sc_reg > SCR_CONTROL)
-		return 0xffffffffU;
-	return readl(ap->ioaddr.scr_addr + (sc_reg * 4));
+		return -EINVAL;
+	*val = readl(ap->ioaddr.scr_addr + (sc_reg * 4));
+	return 0;
 }
 
 
-static void pdc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg,
-			       u32 val)
+static int pdc_sata_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val)
 {
 	if (sc_reg > SCR_CONTROL)
-		return;
+		return -EINVAL;
 	writel(val, ap->ioaddr.scr_addr + (sc_reg * 4));
+	return 0;
 }
 
 static void pdc_atapi_pkt(struct ata_queued_cmd *qc)
@@ -647,8 +648,12 @@ static void pdc_error_intr(struct ata_port *ap, struct ata_queued_cmd *qc,
 			   | PDC_PCI_SYS_ERR | PDC1_PCI_PARITY_ERR))
 		ac_err_mask |= AC_ERR_HOST_BUS;
 
-	if (sata_scr_valid(ap))
-		ehi->serror |= pdc_sata_scr_read(ap, SCR_ERROR);
+	if (sata_scr_valid(ap)) {
+		u32 serror;
+
+		pdc_sata_scr_read(ap, SCR_ERROR, &serror);
+		ehi->serror |= serror;
+	}
 
 	qc->err_mask |= ac_err_mask;
 
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 6688ccb..13348a6 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -111,8 +111,8 @@ struct qs_port_priv {
 	qs_state_t		state;
 };
 
-static u32 qs_scr_read (struct ata_port *ap, unsigned int sc_reg);
-static void qs_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
+static int qs_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val);
+static int qs_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int qs_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static int qs_port_start(struct ata_port *ap);
 static void qs_host_stop(struct ata_host *host);
@@ -255,18 +255,20 @@ static void qs_eng_timeout(struct ata_port *ap)
 	ata_eng_timeout(ap);
 }
 
-static u32 qs_scr_read (struct ata_port *ap, unsigned int sc_reg)
+static int qs_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val)
 {
 	if (sc_reg > SCR_CONTROL)
-		return ~0U;
-	return readl(ap->ioaddr.scr_addr + (sc_reg * 8));
+		return -EINVAL;
+	*val = readl(ap->ioaddr.scr_addr + (sc_reg * 8));
+	return 0;
 }
 
-static void qs_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
+static int qs_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val)
 {
 	if (sc_reg > SCR_CONTROL)
-		return;
+		return -EINVAL;
 	writel(val, ap->ioaddr.scr_addr + (sc_reg * 8));
+	return 0;
 }
 
 static unsigned int qs_fill_sg(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index c3f0a86..94a528f 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -115,8 +115,8 @@ static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static int sil_pci_device_resume(struct pci_dev *pdev);
 #endif
 static void sil_dev_config(struct ata_device *dev);
-static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
-static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
+static int sil_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val);
+static int sil_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int sil_set_mode (struct ata_port *ap, struct ata_device **r_failed);
 static void sil_freeze(struct ata_port *ap);
 static void sil_thaw(struct ata_port *ap);
@@ -350,19 +350,26 @@ static inline void __iomem *sil_scr_addr(struct ata_port *ap, unsigned int sc_re
 	return NULL;
 }
 
-static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg)
+static int sil_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val)
 {
 	void __iomem *mmio = sil_scr_addr(ap, sc_reg);
-	if (mmio)
-		return readl(mmio);
-	return 0xffffffffU;
+
+	if (mmio) {
+		*val = readl(mmio);
+		return 0;
+	}
+	return -EINVAL;
 }
 
-static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
+static int sil_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val)
 {
 	void __iomem *mmio = sil_scr_addr(ap, sc_reg);
-	if (mmio)
+
+	if (mmio) {
 		writel(val, mmio);
+		return 0;
+	}
+	return -EINVAL;
 }
 
 static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
@@ -378,7 +385,7 @@ static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
 		 * controllers continue to assert IRQ as long as
 		 * SError bits are pending.  Clear SError immediately.
 		 */
-		serror = sil_scr_read(ap, SCR_ERROR);
+		sil_scr_read(ap, SCR_ERROR, &serror);
 		sil_scr_write(ap, SCR_ERROR, serror);
 
 		/* Trigger hotplug and accumulate SError only if the
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 23650f3..07489a0 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -326,8 +326,8 @@ struct sil24_port_priv {
 
 static void sil24_dev_config(struct ata_device *dev);
 static u8 sil24_check_status(struct ata_port *ap);
-static u32 sil24_scr_read(struct ata_port *ap, unsigned sc_reg);
-static void sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val);
+static int sil24_scr_read(struct ata_port *ap, unsigned sc_reg, u32 *val);
+static int sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val);
 static void sil24_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void sil24_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc);
@@ -488,25 +488,30 @@ static int sil24_scr_map[] = {
 	[SCR_ACTIVE]	= 3,
 };
 
-static u32 sil24_scr_read(struct ata_port *ap, unsigned sc_reg)
+static int sil24_scr_read(struct ata_port *ap, unsigned sc_reg, u32 *val)
 {
 	void __iomem *scr_addr = ap->ioaddr.scr_addr;
+
 	if (sc_reg < ARRAY_SIZE(sil24_scr_map)) {
 		void __iomem *addr;
 		addr = scr_addr + sil24_scr_map[sc_reg] * 4;
-		return readl(scr_addr + sil24_scr_map[sc_reg] * 4);
+		*val = readl(scr_addr + sil24_scr_map[sc_reg] * 4);
+		return 0;
 	}
-	return 0xffffffffU;
+	return -EINVAL;
 }
 
-static void sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val)
+static int sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val)
 {
 	void __iomem *scr_addr = ap->ioaddr.scr_addr;
+
 	if (sc_reg < ARRAY_SIZE(sil24_scr_map)) {
 		void __iomem *addr;
 		addr = scr_addr + sil24_scr_map[sc_reg] * 4;
 		writel(val, scr_addr + sil24_scr_map[sc_reg] * 4);
+		return 0;
 	}
+	return -EINVAL;
 }
 
 static void sil24_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index 221099d..b1d5e23 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -64,8 +64,8 @@ enum {
 };
 
 static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
-static u32 sis_scr_read (struct ata_port *ap, unsigned int sc_reg);
-static void sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
+static int sis_scr_read (struct ata_port *ap, unsigned int sc_reg, u32 *val);
+static int sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
 static const struct pci_device_id sis_pci_tbl[] = {
 	{ PCI_VDEVICE(SI, 0x0180), sis_180 },		/* SiS 964/180 */
@@ -208,36 +208,37 @@ static void sis_scr_cfg_write (struct ata_port *ap, unsigned int sc_reg, u32 val
 		pci_write_config_dword(pdev, cfg_addr+0x10, val);
 }
 
-static u32 sis_scr_read (struct ata_port *ap, unsigned int sc_reg)
+static int sis_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	u32 val, val2 = 0;
 	u8 pmr;
 
 	if (sc_reg > SCR_CONTROL)
-		return 0xffffffffU;
+		return -EINVAL;
 
 	if (ap->flags & SIS_FLAG_CFGSCR)
 		return sis_scr_cfg_read(ap, sc_reg);
 
 	pci_read_config_byte(pdev, SIS_PMR, &pmr);
 
-	val = ioread32(ap->ioaddr.scr_addr + (sc_reg * 4));
+	*val = ioread32(ap->ioaddr.scr_addr + (sc_reg * 4));
 
 	if ((pdev->device == 0x0182) || (pdev->device == 0x0183) || (pdev->device == 0x1182) ||
 	    (pdev->device == 0x1183) || (pmr & SIS_PMR_COMBINED))
-		val2 = ioread32(ap->ioaddr.scr_addr + (sc_reg * 4) + 0x10);
+		*val |= ioread32(ap->ioaddr.scr_addr + (sc_reg * 4) + 0x10);
+
+	*val &= 0xfffffffb;
 
-	return (val | val2) &  0xfffffffb;
+	return 0;
 }
 
-static void sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
+static int sis_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 pmr;
 
 	if (sc_reg > SCR_CONTROL)
-		return;
+		return -EINVAL;
 
 	pci_read_config_byte(pdev, SIS_PMR, &pmr);
 
@@ -249,6 +250,7 @@ static void sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
 		    (pdev->device == 0x1183) || (pmr & SIS_PMR_COMBINED))
 			iowrite32(val, ap->ioaddr.scr_addr + (sc_reg * 4)+0x10);
 	}
+	return 0;
 }
 
 static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index 4fd4f10..d8191d8 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -103,20 +103,21 @@ static int k2_sata_check_atapi_dma(struct ata_queued_cmd *qc)
 	return 0;
 }
 
-static u32 k2_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
+static int k2_sata_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val)
 {
 	if (sc_reg > SCR_CONTROL)
-		return 0xffffffffU;
-	return readl(ap->ioaddr.scr_addr + (sc_reg * 4));
+		return -EINVAL;
+	*val = readl(ap->ioaddr.scr_addr + (sc_reg * 4));
+	return 0;
 }
 
 
-static void k2_sata_scr_write (struct ata_port *ap, unsigned int sc_reg,
-			       u32 val)
+static int k2_sata_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val)
 {
 	if (sc_reg > SCR_CONTROL)
-		return;
+		return -EINVAL;
 	writel(val, ap->ioaddr.scr_addr + (sc_reg * 4));
+	return 0;
 }
 
 
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index 6815de7..957c747 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -57,8 +57,8 @@ struct uli_priv {
 };
 
 static int uli_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
-static u32 uli_scr_read (struct ata_port *ap, unsigned int sc_reg);
-static void uli_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
+static int uli_scr_read (struct ata_port *ap, unsigned int sc_reg, u32 *val);
+static int uli_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
 static const struct pci_device_id uli_pci_tbl[] = {
 	{ PCI_VDEVICE(AL, 0x5289), uli_5289 },
@@ -164,20 +164,22 @@ static void uli_scr_cfg_write (struct ata_port *ap, unsigned int scr, u32 val)
 	pci_write_config_dword(pdev, cfg_addr, val);
 }
 
-static u32 uli_scr_read (struct ata_port *ap, unsigned int sc_reg)
+static int uli_scr_read (struct ata_port *ap, unsigned int sc_reg, u32 *val)
 {
 	if (sc_reg > SCR_CONTROL)
-		return 0xffffffffU;
+		return -EINVAL;
 
-	return uli_scr_cfg_read(ap, sc_reg);
+	*val = uli_scr_cfg_read(ap, sc_reg);
+	return 0;
 }
 
-static void uli_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
+static int uli_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
 {
 	if (sc_reg > SCR_CONTROL)	//SCR_CONTROL=2, SCR_ERROR=1, SCR_STATUS=0
-		return;
+		return -EINVAL;
 
 	uli_scr_cfg_write(ap, sc_reg, val);
+	return 0;
 }
 
 static int uli_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index e816965..d39d68d 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -72,8 +72,8 @@ enum {
 };
 
 static int svia_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
-static u32 svia_scr_read (struct ata_port *ap, unsigned int sc_reg);
-static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
+static int svia_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val);
+static int svia_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val);
 static void svia_noop_freeze(struct ata_port *ap);
 static void vt6420_error_handler(struct ata_port *ap);
 static int vt6421_pata_cable_detect(struct ata_port *ap);
@@ -249,18 +249,20 @@ MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, svia_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
-static u32 svia_scr_read (struct ata_port *ap, unsigned int sc_reg)
+static int svia_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val)
 {
 	if (sc_reg > SCR_CONTROL)
-		return 0xffffffffU;
-	return ioread32(ap->ioaddr.scr_addr + (4 * sc_reg));
+		return -EINVAL;
+	*val = ioread32(ap->ioaddr.scr_addr + (4 * sc_reg));
+	return 0;
 }
 
-static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
+static int svia_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val)
 {
 	if (sc_reg > SCR_CONTROL)
-		return;
+		return -EINVAL;
 	iowrite32(val, ap->ioaddr.scr_addr + (4 * sc_reg));
+	return 0;
 }
 
 static void svia_noop_freeze(struct ata_port *ap)
@@ -305,18 +307,19 @@ static int vt6420_prereset(struct ata_port *ap, unsigned long deadline)
 
 	/* Resume phy.  This is the old SATA resume sequence */
 	svia_scr_write(ap, SCR_CONTROL, 0x300);
-	svia_scr_read(ap, SCR_CONTROL); /* flush */
+	svia_scr_read(ap, SCR_CONTROL, &scontrol); /* flush */
 
 	/* wait for phy to become ready, if necessary */
 	do {
 		msleep(200);
-		if ((svia_scr_read(ap, SCR_STATUS) & 0xf) != 1)
+		svia_scr_read(ap, SCR_STATUS, &sstatus);
+		if ((sstatus & 0xf) != 1)
 			break;
 	} while (time_before(jiffies, timeout));
 
 	/* open code sata_print_link_status() */
-	sstatus = svia_scr_read(ap, SCR_STATUS);
-	scontrol = svia_scr_read(ap, SCR_CONTROL);
+	svia_scr_read(ap, SCR_STATUS, &sstatus);
+	svia_scr_read(ap, SCR_CONTROL, &scontrol);
 
 	online = (sstatus & 0xf) == 0x3;
 
@@ -325,7 +328,7 @@ static int vt6420_prereset(struct ata_port *ap, unsigned long deadline)
 			online ? "up" : "down", sstatus, scontrol);
 
 	/* SStatus is read one more time */
-	svia_scr_read(ap, SCR_STATUS);
+	svia_scr_read(ap, SCR_STATUS, &sstatus);
 
 	if (!online) {
 		/* tell EH to bail */
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index 8133017..8b7a9c6 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -98,20 +98,21 @@ enum {
 			      VSC_SATA_INT_PHY_CHANGE),
 };
 
-static u32 vsc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
+static int vsc_sata_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val)
 {
 	if (sc_reg > SCR_CONTROL)
-		return 0xffffffffU;
-	return readl(ap->ioaddr.scr_addr + (sc_reg * 4));
+		return -EINVAL;
+	*val = readl(ap->ioaddr.scr_addr + (sc_reg * 4));
+	return 0;
 }
 
 
-static void vsc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg,
-			       u32 val)
+static int vsc_sata_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val)
 {
 	if (sc_reg > SCR_CONTROL)
-		return;
+		return -EINVAL;
 	writel(val, ap->ioaddr.scr_addr + (sc_reg * 4));
+	return 0;
 }
 
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c2cad0f..bc91ca0 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -620,9 +620,8 @@ struct ata_port_operations {
 	u8 (*irq_on) (struct ata_port *);
 	u8 (*irq_ack) (struct ata_port *ap, unsigned int chk_drq);
 
-	u32 (*scr_read) (struct ata_port *ap, unsigned int sc_reg);
-	void (*scr_write) (struct ata_port *ap, unsigned int sc_reg,
-			   u32 val);
+	int (*scr_read) (struct ata_port *ap, unsigned int sc_reg, u32 *val);
+	int (*scr_write) (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
 	int (*port_suspend) (struct ata_port *ap, pm_message_t mesg);
 	int (*port_resume) (struct ata_port *ap);
-- 
1.5.0.3


