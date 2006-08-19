From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/20] libata: use remove_one() for deinit instead of ->host_stop()
Date: Sat, 19 Aug 2006 17:59:32 +0900
Message-ID: <11559779722940-git-send-email-htejun@gmail.com>
References: <11559778241753-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:43525 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751652AbWHSI77 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Aug 2006 04:59:59 -0400
Received: by py-out-1112.google.com with SMTP id n25so1465942pyg
        for <linux-ide@vger.kernel.org>; Sat, 19 Aug 2006 01:59:58 -0700 (PDT)
In-Reply-To: <11559778241753-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update LLDs such that they use ->remove_one() for deinit instead of
->host_stop().  This is how deinit is usually done in other drivers,
more in line with how callbacks are used in libata, symmetric with
initialization, and gives LLDs more flexibility.

As mmio_base release is libata-pci's responsibility, LLDs which used
the default ata_pci_host_stop() can simply switch to stock
ata_pci_remove_one().

This patch fixes the following bugs.

* ata_piix doesn't free hpriv on removal
* sata_sil24 unmaps port_base twice on removal
* sata_uli doesn't free hpriv on removal

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c         |   20 +-------------------
 drivers/ata/ata_piix.c     |   18 +++++++-----------
 drivers/ata/pdc_adma.c     |   30 +++++++++++++++---------------
 drivers/ata/sata_mv.c      |   40 +++++++++++-----------------------------
 drivers/ata/sata_nv.c      |   26 +++++++++++++-------------
 drivers/ata/sata_promise.c |   26 +++++++++++---------------
 drivers/ata/sata_qstor.c   |   27 +++++++++++++--------------
 drivers/ata/sata_sil.c     |    3 +--
 drivers/ata/sata_sil24.c   |   30 +++++++++++++++++-------------
 drivers/ata/sata_sis.c     |    1 -
 drivers/ata/sata_svw.c     |    1 -
 drivers/ata/sata_sx4.c     |   36 ++++++++++++++++++++----------------
 drivers/ata/sata_uli.c     |   13 +++++++++++--
 drivers/ata/sata_via.c     |    1 -
 drivers/ata/sata_vsc.c     |    1 -
 15 files changed, 120 insertions(+), 153 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 80b47e5..e8f8977 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1576,26 +1576,8 @@ static void ahci_remove_one (struct pci_
 	struct device *dev = pci_dev_to_dev(pdev);
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;
-	int have_msi;
 
-	ata_host_detach(host);
-
-	have_msi = host->pci_flags & ATA_PCI_RES_MSI;
-	free_irq(host->irq, host);
-
-	ata_host_stop(host);
-	pci_iounmap(pdev, host->mmio_base);
-
-	if (have_msi)
-		pci_disable_msi(pdev);
-	else
-		pci_intx(pdev, 0);
-
-	pci_release_regions(pdev);
-	pci_disable_device(pdev);
-	dev_set_drvdata(dev, NULL);
-
-	ata_host_free(host);
+	ata_pci_remove_one(pdev);
 	kfree(hpriv);
 }
 
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 0cb48a4..f13513c 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -149,9 +149,8 @@ struct piix_host_priv {
 	const struct piix_map_db *map_db;
 };
 
-static int piix_init_one (struct pci_dev *pdev,
-				    const struct pci_device_id *ent);
-static void piix_host_stop(struct ata_host *host);
+static int piix_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
+static void piix_remove_one(struct pci_dev *pdev);
 static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev);
 static void piix_set_dmamode (struct ata_port *ap, struct ata_device *adev);
 static void piix_pata_error_handler(struct ata_port *ap);
@@ -205,7 +204,7 @@ static struct pci_driver piix_pci_driver
 	.name			= DRV_NAME,
 	.id_table		= piix_pci_tbl,
 	.probe			= piix_init_one,
-	.remove			= ata_pci_remove_one,
+	.remove			= piix_remove_one,
 	.suspend		= ata_pci_device_suspend,
 	.resume			= ata_pci_device_resume,
 };
@@ -260,7 +259,6 @@ static const struct ata_port_operations 
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= piix_host_stop,
 };
 
 static const struct ata_port_operations piix_sata_ops = {
@@ -290,7 +288,6 @@ static const struct ata_port_operations 
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= piix_host_stop,
 };
 
 static const struct piix_map_db ich5_map_db = {
@@ -930,13 +927,12 @@ static int piix_init_one (struct pci_dev
 	return ata_pci_init_one(pdev, ppinfo, 2);
 }
 
-static void piix_host_stop(struct ata_host *host)
+static void piix_remove_one(struct pci_dev *pdev)
 {
-	struct piix_host_priv *hpriv = host->private_data;
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
 
-	ata_pci_host_stop(host);
-
-	kfree(hpriv);
+	kfree(host->private_data);
+	ata_pci_remove_one(pdev);
 }
 
 static int __init piix_init(void)
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index ab5d06b..d999235 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -122,10 +122,10 @@ struct adma_port_priv {
 	adma_state_t		state;
 };
 
-static int adma_ata_init_one (struct pci_dev *pdev,
-				const struct pci_device_id *ent);
+static int adma_ata_init_one(struct pci_dev *pdev,
+			     const struct pci_device_id *ent);
+static void adma_ata_remove_one(struct pci_dev *pdev);
 static int adma_port_start(struct ata_port *ap);
-static void adma_host_stop(struct ata_host *host);
 static void adma_port_stop(struct ata_port *ap);
 static void adma_phy_reset(struct ata_port *ap);
 static void adma_qc_prep(struct ata_queued_cmd *qc);
@@ -170,7 +170,6 @@ static const struct ata_port_operations 
 	.irq_clear		= adma_irq_clear,
 	.port_start		= adma_port_start,
 	.port_stop		= adma_port_stop,
-	.host_stop		= adma_host_stop,
 	.bmdma_stop		= adma_bmdma_stop,
 	.bmdma_status		= adma_bmdma_status,
 };
@@ -199,7 +198,7 @@ static struct pci_driver adma_ata_pci_dr
 	.name			= DRV_NAME,
 	.id_table		= adma_ata_pci_tbl,
 	.probe			= adma_ata_init_one,
-	.remove			= ata_pci_remove_one,
+	.remove			= adma_ata_remove_one,
 };
 
 static int adma_check_atapi_dma(struct ata_queued_cmd *qc)
@@ -593,16 +592,6 @@ static void adma_port_stop(struct ata_po
 	ata_port_stop(ap);
 }
 
-static void adma_host_stop(struct ata_host *host)
-{
-	unsigned int port_no;
-
-	for (port_no = 0; port_no < ADMA_PORTS; ++port_no)
-		adma_reset_engine(ADMA_REGS(host->mmio_base, port_no));
-
-	ata_pci_host_stop(host);
-}
-
 static void adma_host_init(unsigned int chip_id, struct ata_host *host)
 {
 	unsigned int port_no;
@@ -689,6 +678,17 @@ static int adma_ata_init_one(struct pci_
 	return rc;
 }
 
+static void adma_ata_remove_one(struct pci_dev *pdev)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	unsigned int port_no;
+
+	for (port_no = 0; port_no < ADMA_PORTS; ++port_no)
+		adma_reset_engine(ADMA_REGS(host->mmio_base, port_no));
+
+	ata_pci_remove_one(pdev);
+}
+
 static int __init adma_ata_init(void)
 {
 	return pci_register_driver(&adma_ata_pci_driver);
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 71e877c..9a87937 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -341,7 +341,6 @@ static u32 mv5_scr_read(struct ata_port 
 static void mv5_scr_write(struct ata_port *ap, unsigned int sc_reg_in, u32 val);
 static void mv_phy_reset(struct ata_port *ap);
 static void __mv_phy_reset(struct ata_port *ap, int can_sleep);
-static void mv_host_stop(struct ata_host *host);
 static int mv_port_start(struct ata_port *ap);
 static void mv_port_stop(struct ata_port *ap);
 static void mv_qc_prep(struct ata_queued_cmd *qc);
@@ -349,6 +348,7 @@ static void mv_qc_prep_iie(struct ata_qu
 static unsigned int mv_qc_issue(struct ata_queued_cmd *qc);
 static void mv_eng_timeout(struct ata_port *ap);
 static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
+static void mv_remove_one(struct pci_dev *pdev);
 
 static void mv5_phy_errata(struct mv_host_priv *hpriv, void __iomem *mmio,
 			   unsigned int port);
@@ -415,7 +415,6 @@ static const struct ata_port_operations 
 
 	.port_start		= mv_port_start,
 	.port_stop		= mv_port_stop,
-	.host_stop		= mv_host_stop,
 };
 
 static const struct ata_port_operations mv6_ops = {
@@ -442,7 +441,6 @@ static const struct ata_port_operations 
 
 	.port_start		= mv_port_start,
 	.port_stop		= mv_port_stop,
-	.host_stop		= mv_host_stop,
 };
 
 static const struct ata_port_operations mv_iie_ops = {
@@ -468,7 +466,6 @@ static const struct ata_port_operations 
 
 	.port_start		= mv_port_start,
 	.port_stop		= mv_port_stop,
-	.host_stop		= mv_host_stop,
 };
 
 static const struct ata_port_info mv_port_info[] = {
@@ -545,7 +542,7 @@ static struct pci_driver mv_pci_driver =
 	.name			= DRV_NAME,
 	.id_table		= mv_pci_tbl,
 	.probe			= mv_init_one,
-	.remove			= ata_pci_remove_one,
+	.remove			= mv_remove_one,
 };
 
 static const struct mv_hw_ops mv5xxx_ops = {
@@ -801,30 +798,6 @@ static void mv_scr_write(struct ata_port
 	}
 }
 
-/**
- *      mv_host_stop - Host specific cleanup/stop routine.
- *      @host: host data structure
- *
- *      Disable ints, cleanup host memory, call general purpose
- *      host_stop.
- *
- *      LOCKING:
- *      Inherited from caller.
- */
-static void mv_host_stop(struct ata_host *host)
-{
-	struct mv_host_priv *hpriv = host->private_data;
-	struct pci_dev *pdev = to_pci_dev(host->dev);
-
-	if (host->pci_flags & ATA_PCI_RES_MSI) {
-		pci_disable_msi(pdev);
-	} else {
-		pci_intx(pdev, 0);
-	}
-	kfree(hpriv);
-	ata_pci_host_stop(host);
-}
-
 static inline void mv_priv_free(struct mv_port_priv *pp, struct device *dev)
 {
 	dma_free_coherent(dev, MV_PORT_PRIV_DMA_SZ, pp->crpb, pp->crpb_dma);
@@ -2406,6 +2379,15 @@ static int mv_init_one(struct pci_dev *p
 	return rc;
 }
 
+static void mv_remove_one(struct pci_dev *pdev)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct mv_host_priv *hpriv = host->private_data;
+
+	ata_pci_remove_one(pdev);
+	kfree(hpriv);
+}
+
 static int __init mv_init(void)
 {
 	return pci_register_driver(&mv_pci_driver);
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index f5b94af..59ee99a 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -80,8 +80,8 @@ enum {
 	NV_MCP_SATA_CFG_20_SATA_SPACE_EN = 0x04,
 };
 
-static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
-static void nv_ck804_host_stop(struct ata_host *host);
+static int nv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
+static void nv_remove_one(struct pci_dev *pdev);
 static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
@@ -145,7 +145,7 @@ static struct pci_driver nv_pci_driver =
 	.name			= DRV_NAME,
 	.id_table		= nv_pci_tbl,
 	.probe			= nv_init_one,
-	.remove			= ata_pci_remove_one,
+	.remove			= nv_remove_one,
 };
 
 static struct scsi_host_template nv_sht = {
@@ -189,7 +189,6 @@ static const struct ata_port_operations 
 	.scr_write		= nv_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_pci_host_stop,
 };
 
 static const struct ata_port_operations nv_nf2_ops = {
@@ -215,7 +214,6 @@ static const struct ata_port_operations 
 	.scr_write		= nv_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_pci_host_stop,
 };
 
 static const struct ata_port_operations nv_ck804_ops = {
@@ -241,7 +239,6 @@ static const struct ata_port_operations 
 	.scr_write		= nv_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= nv_ck804_host_stop,
 };
 
 static struct ata_port_info nv_port_info[] = {
@@ -564,17 +561,20 @@ static int nv_init_one (struct pci_dev *
 	return rc;
 }
 
-static void nv_ck804_host_stop(struct ata_host *host)
+static void nv_remove_one(struct pci_dev *pdev)
 {
-	struct pci_dev *pdev = to_pci_dev(host->dev);
-	u8 regval;
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
 
 	/* disable SATA space for CK804 */
-	pci_read_config_byte(pdev, NV_MCP_SATA_CFG_20, &regval);
-	regval &= ~NV_MCP_SATA_CFG_20_SATA_SPACE_EN;
-	pci_write_config_byte(pdev, NV_MCP_SATA_CFG_20, regval);
+	if (host->ops == &nv_ck804_ops) {
+		u8 regval;
+
+		pci_read_config_byte(pdev, NV_MCP_SATA_CFG_20, &regval);
+		regval &= ~NV_MCP_SATA_CFG_20_SATA_SPACE_EN;
+		pci_write_config_byte(pdev, NV_MCP_SATA_CFG_20, regval);
+	}
 
-	ata_pci_host_stop(host);
+	ata_pci_remove_one(pdev);
 }
 
 static int __init nv_init(void)
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index 6cae44a..92571f7 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -97,7 +97,8 @@ struct pdc_host_priv {
 
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void pdc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
-static int pdc_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+static int pdc_ata_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
+static void pdc_ata_remove_one(struct pci_dev *pdev);
 static void pdc_eng_timeout(struct ata_port *ap);
 static int pdc_port_start(struct ata_port *ap);
 static void pdc_port_stop(struct ata_port *ap);
@@ -108,7 +109,6 @@ static void pdc_tf_load_mmio(struct ata_
 static void pdc_exec_command_mmio(struct ata_port *ap, const struct ata_taskfile *tf);
 static void pdc_irq_clear(struct ata_port *ap);
 static unsigned int pdc_qc_issue_prot(struct ata_queued_cmd *qc);
-static void pdc_host_stop(struct ata_host *host);
 
 
 static struct scsi_host_template pdc_ata_sht = {
@@ -149,7 +149,6 @@ static const struct ata_port_operations 
 	.scr_write		= pdc_sata_scr_write,
 	.port_start		= pdc_port_start,
 	.port_stop		= pdc_port_stop,
-	.host_stop		= pdc_host_stop,
 };
 
 static const struct ata_port_operations pdc_pata_ops = {
@@ -170,7 +169,6 @@ static const struct ata_port_operations 
 
 	.port_start		= pdc_port_start,
 	.port_stop		= pdc_port_stop,
-	.host_stop		= pdc_host_stop,
 };
 
 /* Use bits 30-31 of port_flags to encode available port numbers.
@@ -300,7 +298,7 @@ static struct pci_driver pdc_ata_pci_dri
 	.name			= DRV_NAME,
 	.id_table		= pdc_ata_pci_tbl,
 	.probe			= pdc_ata_init_one,
-	.remove			= ata_pci_remove_one,
+	.remove			= pdc_ata_remove_one,
 };
 
 
@@ -350,16 +348,6 @@ static void pdc_port_stop(struct ata_por
 }
 
 
-static void pdc_host_stop(struct ata_host *host)
-{
-	struct pdc_host_priv *hp = host->private_data;
-
-	ata_pci_host_stop(host);
-
-	kfree(hp);
-}
-
-
 static void pdc_reset_port(struct ata_port *ap)
 {
 	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr + PDC_CTLSTAT;
@@ -789,6 +777,14 @@ static int pdc_ata_init_one(struct pci_d
 	return rc;
 }
 
+static void pdc_ata_remove_one(struct pci_dev *pdev)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct pdc_host_priv *hp = host->private_data;
+
+	ata_pci_remove_one(pdev);
+	kfree(hp);
+}
 
 static int __init pdc_ata_init(void)
 {
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 48ed01f..c564ac4 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -114,8 +114,8 @@ struct qs_port_priv {
 static u32 qs_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void qs_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int qs_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+static void qs_ata_remove_one(struct pci_dev *pdev);
 static int qs_port_start(struct ata_port *ap);
-static void qs_host_stop(struct ata_host *host);
 static void qs_port_stop(struct ata_port *ap);
 static void qs_phy_reset(struct ata_port *ap);
 static void qs_qc_prep(struct ata_queued_cmd *qc);
@@ -163,7 +163,6 @@ static const struct ata_port_operations 
 	.scr_write		= qs_scr_write,
 	.port_start		= qs_port_start,
 	.port_stop		= qs_port_stop,
-	.host_stop		= qs_host_stop,
 	.bmdma_stop		= qs_bmdma_stop,
 	.bmdma_status		= qs_bmdma_status,
 };
@@ -193,7 +192,7 @@ static struct pci_driver qs_ata_pci_driv
 	.name			= DRV_NAME,
 	.id_table		= qs_ata_pci_tbl,
 	.probe			= qs_ata_init_one,
-	.remove			= ata_pci_remove_one,
+	.remove			= qs_ata_remove_one,
 };
 
 static int qs_check_atapi_dma(struct ata_queued_cmd *qc)
@@ -541,17 +540,6 @@ static void qs_port_stop(struct ata_port
 	ata_port_stop(ap);
 }
 
-static void qs_host_stop(struct ata_host *host)
-{
-	void __iomem *mmio_base = host->mmio_base;
-	struct pci_dev *pdev = to_pci_dev(host->dev);
-
-	writeb(0, mmio_base + QS_HCT_CTRL); /* disable host interrupts */
-	writeb(QS_CNFG3_GSRST, mmio_base + QS_HCF_CNFG3); /* global reset */
-
-	pci_iounmap(pdev, mmio_base);
-}
-
 static void qs_host_init(unsigned int chip_id, struct ata_host *host)
 {
 	void __iomem *mmio_base = host->mmio_base;
@@ -688,6 +676,17 @@ static int qs_ata_init_one(struct pci_de
 	return rc;
 }
 
+static void qs_ata_remove_one(struct pci_dev *pdev)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	void __iomem *mmio_base = host->mmio_base;
+
+	writeb(0, mmio_base + QS_HCT_CTRL); /* disable host interrupts */
+	writeb(QS_CNFG3_GSRST, mmio_base + QS_HCF_CNFG3); /* global reset */
+
+	ata_pci_remove_one(pdev);
+}
+
 static int __init qs_ata_init(void)
 {
 	return pci_register_driver(&qs_ata_pci_driver);
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 75c611a..3619f86 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -108,7 +108,7 @@ enum {
 	SIL_QUIRK_UDMA5MAX	= (1 << 1),
 };
 
-static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+static int sil_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
 static int sil_pci_device_resume(struct pci_dev *pdev);
 static void sil_dev_config(struct ata_port *ap, struct ata_device *dev);
 static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
@@ -204,7 +204,6 @@ static const struct ata_port_operations 
 	.scr_write		= sil_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_pci_host_stop,
 };
 
 static const struct ata_port_info sil_port_info[] = {
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 59351b3..3c6d668 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -336,8 +336,8 @@ static void sil24_error_handler(struct a
 static void sil24_post_internal_cmd(struct ata_queued_cmd *qc);
 static int sil24_port_start(struct ata_port *ap);
 static void sil24_port_stop(struct ata_port *ap);
-static void sil24_host_stop(struct ata_host *host);
 static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
+static void sil24_remove_one(struct pci_dev *pdev);
 static int sil24_pci_device_resume(struct pci_dev *pdev);
 
 static const struct pci_device_id sil24_pci_tbl[] = {
@@ -353,7 +353,7 @@ static struct pci_driver sil24_pci_drive
 	.name			= DRV_NAME,
 	.id_table		= sil24_pci_tbl,
 	.probe			= sil24_init_one,
-	.remove			= ata_pci_remove_one, /* safe? */
+	.remove			= sil24_remove_one,
 	.suspend		= ata_pci_device_suspend,
 	.resume			= sil24_pci_device_resume,
 };
@@ -405,7 +405,6 @@ static const struct ata_port_operations 
 
 	.port_start		= sil24_port_start,
 	.port_stop		= sil24_port_stop,
-	.host_stop		= sil24_host_stop,
 };
 
 /*
@@ -982,16 +981,6 @@ static void sil24_port_stop(struct ata_p
 	kfree(pp);
 }
 
-static void sil24_host_stop(struct ata_host *host)
-{
-	struct sil24_host_priv *hpriv = host->private_data;
-	struct pci_dev *pdev = to_pci_dev(host->dev);
-
-	pci_iounmap(pdev, hpriv->host_base);
-	pci_iounmap(pdev, hpriv->port_base);
-	kfree(hpriv);
-}
-
 static void sil24_init_controller(struct ata_host *host)
 {
 	struct pci_dev *pdev = to_pci_dev(host->dev);
@@ -1154,6 +1143,21 @@ static int sil24_init_one(struct pci_dev
 	return rc;
 }
 
+static void sil24_remove_one(struct pci_dev *pdev)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct sil24_host_priv *hpriv = host->private_data;
+
+	ata_host_detach(host);
+	ata_host_stop(host);
+
+	pci_iounmap(pdev, hpriv->host_base);
+	pci_iounmap(pdev, hpriv->port_base);
+
+	ata_pci_host_destroy(host);
+	kfree(hpriv);
+}
+
 static int sil24_pci_device_resume(struct pci_dev *pdev)
 {
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index 6bf4533..56ad81d 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -122,7 +122,6 @@ static const struct ata_port_operations 
 	.scr_write		= sis_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_pci_host_stop,
 };
 
 static struct ata_port_info sis_port_info = {
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index b12b288..79c526d 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -329,7 +329,6 @@ static const struct ata_port_operations 
 	.scr_write		= k2_sata_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_pci_host_stop,
 };
 
 static void k2_sata_setup_port(struct ata_ioports *port, unsigned long base)
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 5b94e53..794dbed 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -151,7 +151,9 @@ struct pdc_host_priv {
 };
 
 
-static int pdc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+static int pdc_sata_init_one(struct pci_dev *pdev,
+			     const struct pci_device_id *ent);
+static void pdc_sata_remove_one(struct pci_dev *pdev);
 static void pdc_eng_timeout(struct ata_port *ap);
 static void pdc_20621_phy_reset (struct ata_port *ap);
 static int pdc_port_start(struct ata_port *ap);
@@ -159,7 +161,6 @@ static void pdc_port_stop(struct ata_por
 static void pdc20621_qc_prep(struct ata_queued_cmd *qc);
 static void pdc_tf_load_mmio(struct ata_port *ap, const struct ata_taskfile *tf);
 static void pdc_exec_command_mmio(struct ata_port *ap, const struct ata_taskfile *tf);
-static void pdc20621_host_stop(struct ata_host *host);
 static unsigned int pdc20621_dimm_init(struct ata_host *hs);
 static int pdc20621_detect_dimm(struct ata_host *hs);
 static unsigned int pdc20621_i2c_read(struct ata_host *hs,
@@ -209,7 +210,6 @@ static const struct ata_port_operations 
 	.irq_clear		= pdc20621_irq_clear,
 	.port_start		= pdc_port_start,
 	.port_stop		= pdc_port_stop,
-	.host_stop		= pdc20621_host_stop,
 };
 
 static const struct ata_port_info pdc_port_info[] = {
@@ -238,22 +238,10 @@ static struct pci_driver pdc_sata_pci_dr
 	.name			= DRV_NAME,
 	.id_table		= pdc_sata_pci_tbl,
 	.probe			= pdc_sata_init_one,
-	.remove			= ata_pci_remove_one,
+	.remove			= pdc_sata_remove_one,
 };
 
 
-static void pdc20621_host_stop(struct ata_host *host)
-{
-	struct pci_dev *pdev = to_pci_dev(host->dev);
-	struct pdc_host_priv *hpriv = host->private_data;
-	void __iomem *dimm_mmio = hpriv->dimm_mmio;
-
-	pci_iounmap(pdev, dimm_mmio);
-	kfree(hpriv);
-
-	pci_iounmap(pdev, host->mmio_base);
-}
-
 static int pdc_port_start(struct ata_port *ap)
 {
 	struct device *dev = ap->host->dev;
@@ -1456,6 +1444,22 @@ static int pdc_sata_init_one(struct pci_
 }
 
 
+static void pdc_sata_remove_one(struct pci_dev *pdev)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct pdc_host_priv *hpriv = host->private_data;
+
+	ata_host_detach(host);
+	ata_host_stop(host);
+
+	pci_iounmap(pdev, host->mmio_base);
+	pci_iounmap(pdev, hpriv->dimm_mmio);
+
+	ata_pci_host_destroy(host);
+	kfree(hpriv);
+}
+
+
 static int __init pdc_sata_init(void)
 {
 	return pci_register_driver(&pdc_sata_pci_driver);
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index b1498bb..540bdd5 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -57,6 +57,7 @@ struct uli_priv {
 };
 
 static int uli_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+static void uli_remove_one(struct pci_dev *pdev);
 static u32 uli_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void uli_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
@@ -72,7 +73,7 @@ static struct pci_driver uli_pci_driver 
 	.name			= DRV_NAME,
 	.id_table		= uli_pci_tbl,
 	.probe			= uli_init_one,
-	.remove			= ata_pci_remove_one,
+	.remove			= uli_remove_one,
 };
 
 static struct scsi_host_template uli_sht = {
@@ -122,7 +123,6 @@ static const struct ata_port_operations 
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_pci_host_stop,
 };
 
 static struct ata_port_info uli_port_info = {
@@ -278,6 +278,15 @@ static int uli_init_one(struct pci_dev *
 	return rc;
 }
 
+static void uli_remove_one(struct pci_dev *pdev)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct uli_priv *hpriv = host->private_data;
+
+	ata_pci_remove_one(pdev);
+	kfree(hpriv);
+}
+
 static int __init uli_init(void)
 {
 	return pci_register_driver(&uli_pci_driver);
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index fc85b59..db7b09e 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -137,7 +137,6 @@ static const struct ata_port_operations 
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_pci_host_stop,
 };
 
 static struct ata_port_info svia_port_info = {
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index 2fa3e7e..ac00d17 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -307,7 +307,6 @@ static const struct ata_port_operations 
 	.scr_write		= vsc_sata_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_pci_host_stop,
 };
 
 static const struct ata_port_info vsc_sata_port_info = {
-- 
1.4.1.1


