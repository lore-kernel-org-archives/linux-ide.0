From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/3] libata: add missing CONFIG_PM in LLDs
Date: Fri, 2 Mar 2007 17:31:26 +0900
Message-ID: <20070302083126.GL20322@htj.dyndns.org>
References: <20070302083001.GK20322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:29084 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933115AbXCBIb2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Mar 2007 03:31:28 -0500
Received: by py-out-1112.google.com with SMTP id a29so394850pyi
        for <linux-ide@vger.kernel.org>; Fri, 02 Mar 2007 00:31:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20070302083001.GK20322@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Add missing #ifdef CONFIG_PM conditionals around all PM related parts
in libata LLDs.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c              |   14 ++++++++++++++
 drivers/ata/ata_generic.c       |    4 ++++
 drivers/ata/ata_piix.c          |    4 ++++
 drivers/ata/pata_ali.c          |    6 ++++++
 drivers/ata/pata_amd.c          |    6 ++++++
 drivers/ata/pata_atiixp.c       |    4 ++++
 drivers/ata/pata_cmd64x.c       |    6 ++++++
 drivers/ata/pata_cs5520.c       |    6 ++++++
 drivers/ata/pata_cs5530.c       |    6 ++++++
 drivers/ata/pata_cs5535.c       |    4 ++++
 drivers/ata/pata_cypress.c      |    4 ++++
 drivers/ata/pata_efar.c         |    4 ++++
 drivers/ata/pata_hpt366.c       |    7 ++++++-
 drivers/ata/pata_hpt3x3.c       |    6 ++++++
 drivers/ata/pata_it8213.c       |    4 ++++
 drivers/ata/pata_it821x.c       |    6 ++++++
 drivers/ata/pata_jmicron.c      |    4 ++++
 drivers/ata/pata_marvell.c      |    4 ++++
 drivers/ata/pata_mpiix.c        |    4 ++++
 drivers/ata/pata_netcell.c      |    4 ++++
 drivers/ata/pata_ns87410.c      |    4 ++++
 drivers/ata/pata_oldpiix.c      |    4 ++++
 drivers/ata/pata_opti.c         |    4 ++++
 drivers/ata/pata_optidma.c      |    4 ++++
 drivers/ata/pata_pdc202xx_old.c |    4 ++++
 drivers/ata/pata_radisys.c      |    4 ++++
 drivers/ata/pata_rz1000.c       |    6 ++++++
 drivers/ata/pata_sc1200.c       |    4 ++++
 drivers/ata/pata_scc.c          |    2 ++
 drivers/ata/pata_serverworks.c  |    6 ++++++
 drivers/ata/pata_sil680.c       |    4 ++++
 drivers/ata/pata_sis.c          |    4 ++++
 drivers/ata/pata_triflex.c      |    4 ++++
 drivers/ata/pata_via.c          |    6 ++++++
 drivers/ata/sata_inic162x.c     |    7 ++++++-
 drivers/ata/sata_nv.c           |   16 ++++++++++++++++
 drivers/ata/sata_sil.c          |    2 ++
 drivers/ata/sata_sil24.c        |    2 ++
 38 files changed, 192 insertions(+), 2 deletions(-)

Index: work/drivers/ata/pata_jmicron.c
===================================================================
--- work.orig/drivers/ata/pata_jmicron.c
+++ work/drivers/ata/pata_jmicron.c
@@ -222,6 +222,7 @@ static int jmicron_init_one (struct pci_
 	return ata_pci_init_one(pdev, port_info, 2);
 }
 
+#ifdef CONFIG_PM
 static int jmicron_reinit_one(struct pci_dev *pdev)
 {
 	u32 reg;
@@ -242,6 +243,7 @@ static int jmicron_reinit_one(struct pci
 	}
 	return ata_pci_device_resume(pdev);
 }
+#endif
 
 static const struct pci_device_id jmicron_pci_tbl[] = {
 	{ PCI_VDEVICE(JMICRON, PCI_DEVICE_ID_JMICRON_JMB361), 361},
@@ -258,8 +260,10 @@ static struct pci_driver jmicron_pci_dri
 	.id_table		= jmicron_pci_tbl,
 	.probe			= jmicron_init_one,
 	.remove			= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend		= ata_pci_device_suspend,
 	.resume			= jmicron_reinit_one,
+#endif
 };
 
 static int __init jmicron_init(void)
Index: work/drivers/ata/pata_sil680.c
===================================================================
--- work.orig/drivers/ata/pata_sil680.c
+++ work/drivers/ata/pata_sil680.c
@@ -381,11 +381,13 @@ static int sil680_init_one(struct pci_de
 	return ata_pci_init_one(pdev, port_info, 2);
 }
 
+#ifdef CONFIG_PM
 static int sil680_reinit_one(struct pci_dev *pdev)
 {
 	sil680_init_chip(pdev);
 	return ata_pci_device_resume(pdev);
 }
+#endif
 
 static const struct pci_device_id sil680[] = {
 	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_SII_680), },
@@ -398,8 +400,10 @@ static struct pci_driver sil680_pci_driv
 	.id_table	= sil680,
 	.probe 		= sil680_init_one,
 	.remove		= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
 	.resume		= sil680_reinit_one,
+#endif
 };
 
 static int __init sil680_init(void)
Index: work/drivers/ata/ahci.c
===================================================================
--- work.orig/drivers/ata/ahci.c
+++ work/drivers/ata/ahci.c
@@ -218,10 +218,12 @@ static void ahci_thaw(struct ata_port *a
 static void ahci_error_handler(struct ata_port *ap);
 static void ahci_vt8251_error_handler(struct ata_port *ap);
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
+#ifdef CONFIG_PM
 static int ahci_port_suspend(struct ata_port *ap, pm_message_t mesg);
 static int ahci_port_resume(struct ata_port *ap);
 static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
 static int ahci_pci_device_resume(struct pci_dev *pdev);
+#endif
 
 static struct scsi_host_template ahci_sht = {
 	.module			= THIS_MODULE,
@@ -240,8 +242,10 @@ static struct scsi_host_template ahci_sh
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.suspend		= ata_scsi_device_suspend,
 	.resume			= ata_scsi_device_resume,
+#endif
 };
 
 static const struct ata_port_operations ahci_ops = {
@@ -270,8 +274,10 @@ static const struct ata_port_operations 
 	.error_handler		= ahci_error_handler,
 	.post_internal_cmd	= ahci_post_internal_cmd,
 
+#ifdef CONFIG_PM
 	.port_suspend		= ahci_port_suspend,
 	.port_resume		= ahci_port_resume,
+#endif
 
 	.port_start		= ahci_port_start,
 	.port_stop		= ahci_port_stop,
@@ -303,8 +309,10 @@ static const struct ata_port_operations 
 	.error_handler		= ahci_vt8251_error_handler,
 	.post_internal_cmd	= ahci_post_internal_cmd,
 
+#ifdef CONFIG_PM
 	.port_suspend		= ahci_port_suspend,
 	.port_resume		= ahci_port_resume,
+#endif
 
 	.port_start		= ahci_port_start,
 	.port_stop		= ahci_port_stop,
@@ -438,8 +446,10 @@ static struct pci_driver ahci_pci_driver
 	.id_table		= ahci_pci_tbl,
 	.probe			= ahci_init_one,
 	.remove			= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend		= ahci_pci_device_suspend,
 	.resume			= ahci_pci_device_resume,
+#endif
 };
 
 
@@ -579,6 +589,7 @@ static void ahci_power_up(void __iomem *
 	writel(cmd | PORT_CMD_ICC_ACTIVE, port_mmio + PORT_CMD);
 }
 
+#ifdef CONFIG_PM
 static void ahci_power_down(void __iomem *port_mmio, u32 cap)
 {
 	u32 cmd, scontrol;
@@ -596,6 +607,7 @@ static void ahci_power_down(void __iomem
 	cmd &= ~PORT_CMD_SPIN_UP;
 	writel(cmd, port_mmio + PORT_CMD);
 }
+#endif
 
 static void ahci_init_port(void __iomem *port_mmio, u32 cap,
 			   dma_addr_t cmd_slot_dma, dma_addr_t rx_fis_dma)
@@ -1329,6 +1341,7 @@ static void ahci_post_internal_cmd(struc
 	}
 }
 
+#ifdef CONFIG_PM
 static int ahci_port_suspend(struct ata_port *ap, pm_message_t mesg)
 {
 	struct ahci_host_priv *hpriv = ap->host->private_data;
@@ -1407,6 +1420,7 @@ static int ahci_pci_device_resume(struct
 
 	return 0;
 }
+#endif
 
 static int ahci_port_start(struct ata_port *ap)
 {
Index: work/drivers/ata/ata_generic.c
===================================================================
--- work.orig/drivers/ata/ata_generic.c
+++ work/drivers/ata/ata_generic.c
@@ -119,8 +119,10 @@ static struct scsi_host_template generic
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static struct ata_port_operations generic_port_ops = {
@@ -230,8 +232,10 @@ static struct pci_driver ata_generic_pci
 	.id_table	= ata_generic,
 	.probe 		= ata_generic_init_one,
 	.remove		= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
 	.resume		= ata_pci_device_resume,
+#endif
 };
 
 static int __init ata_generic_init(void)
Index: work/drivers/ata/ata_piix.c
===================================================================
--- work.orig/drivers/ata/ata_piix.c
+++ work/drivers/ata/ata_piix.c
@@ -253,8 +253,10 @@ static struct pci_driver piix_pci_driver
 	.id_table		= piix_pci_tbl,
 	.probe			= piix_init_one,
 	.remove			= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend		= ata_pci_device_suspend,
 	.resume			= ata_pci_device_resume,
+#endif
 };
 
 static struct scsi_host_template piix_sht = {
@@ -273,8 +275,10 @@ static struct scsi_host_template piix_sh
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static const struct ata_port_operations piix_pata_ops = {
Index: work/drivers/ata/pata_ali.c
===================================================================
--- work.orig/drivers/ata/pata_ali.c
+++ work/drivers/ata/pata_ali.c
@@ -345,8 +345,10 @@ static struct scsi_host_template ali_sht
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 /*
@@ -667,11 +669,13 @@ static int ali_init_one(struct pci_dev *
 	return ata_pci_init_one(pdev, port_info, 2);
 }
 
+#ifdef CONFIG_PM
 static int ali_reinit_one(struct pci_dev *pdev)
 {
 	ali_init_chipset(pdev);
 	return ata_pci_device_resume(pdev);
 }
+#endif
 
 static const struct pci_device_id ali[] = {
 	{ PCI_VDEVICE(AL, PCI_DEVICE_ID_AL_M5228), },
@@ -685,8 +689,10 @@ static struct pci_driver ali_pci_driver 
 	.id_table	= ali,
 	.probe 		= ali_init_one,
 	.remove		= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
 	.resume		= ali_reinit_one,
+#endif
 };
 
 static int __init ali_init(void)
Index: work/drivers/ata/pata_amd.c
===================================================================
--- work.orig/drivers/ata/pata_amd.c
+++ work/drivers/ata/pata_amd.c
@@ -334,8 +334,10 @@ static struct scsi_host_template amd_sht
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static struct ata_port_operations amd33_port_ops = {
@@ -663,6 +665,7 @@ static int amd_init_one(struct pci_dev *
 	return ata_pci_init_one(pdev, port_info, 2);
 }
 
+#ifdef CONFIG_PM
 static int amd_reinit_one(struct pci_dev *pdev)
 {
 	if (pdev->vendor == PCI_VENDOR_ID_AMD) {
@@ -679,6 +682,7 @@ static int amd_reinit_one(struct pci_dev
 	}
 	return ata_pci_device_resume(pdev);
 }
+#endif
 
 static const struct pci_device_id amd[] = {
 	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_COBRA_7401),		0 },
@@ -708,8 +712,10 @@ static struct pci_driver amd_pci_driver 
 	.id_table	= amd,
 	.probe 		= amd_init_one,
 	.remove		= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
 	.resume		= amd_reinit_one,
+#endif
 };
 
 static int __init amd_init(void)
Index: work/drivers/ata/pata_atiixp.c
===================================================================
--- work.orig/drivers/ata/pata_atiixp.c
+++ work/drivers/ata/pata_atiixp.c
@@ -224,8 +224,10 @@ static struct scsi_host_template atiixp_
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static struct ata_port_operations atiixp_port_ops = {
@@ -290,8 +292,10 @@ static struct pci_driver atiixp_pci_driv
 	.id_table	= atiixp,
 	.probe 		= atiixp_init_one,
 	.remove		= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.resume		= ata_pci_device_resume,
 	.suspend	= ata_pci_device_suspend,
+#endif
 };
 
 static int __init atiixp_init(void)
Index: work/drivers/ata/pata_cmd64x.c
===================================================================
--- work.orig/drivers/ata/pata_cmd64x.c
+++ work/drivers/ata/pata_cmd64x.c
@@ -285,8 +285,10 @@ static struct scsi_host_template cmd64x_
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static struct ata_port_operations cmd64x_port_ops = {
@@ -479,6 +481,7 @@ static int cmd64x_init_one(struct pci_de
 	return ata_pci_init_one(pdev, port_info, 2);
 }
 
+#ifdef CONFIG_PM
 static int cmd64x_reinit_one(struct pci_dev *pdev)
 {
 	u8 mrdmode;
@@ -492,6 +495,7 @@ static int cmd64x_reinit_one(struct pci_
 #endif
 	return ata_pci_device_resume(pdev);
 }
+#endif
 
 static const struct pci_device_id cmd64x[] = {
 	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_643), 0 },
@@ -507,8 +511,10 @@ static struct pci_driver cmd64x_pci_driv
 	.id_table	= cmd64x,
 	.probe 		= cmd64x_init_one,
 	.remove		= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
 	.resume		= cmd64x_reinit_one,
+#endif
 };
 
 static int __init cmd64x_init(void)
Index: work/drivers/ata/pata_cs5520.c
===================================================================
--- work.orig/drivers/ata/pata_cs5520.c
+++ work/drivers/ata/pata_cs5520.c
@@ -167,8 +167,10 @@ static struct scsi_host_template cs5520_
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static struct ata_port_operations cs5520_port_ops = {
@@ -309,6 +311,7 @@ static void __devexit cs5520_remove_one(
 	dev_set_drvdata(dev, NULL);
 }
 
+#ifdef CONFIG_PM
 /**
  *	cs5520_reinit_one	-	device resume
  *	@pdev: PCI device
@@ -348,6 +351,7 @@ static int cs5520_pci_device_suspend(str
 	pci_save_state(pdev);
 	return 0;
 }
+#endif /* CONFIG_PM */
 
 /* For now keep DMA off. We can set it for all but A rev CS5510 once the
    core ATA code can handle it */
@@ -364,8 +368,10 @@ static struct pci_driver cs5520_pci_driv
 	.id_table	= pata_cs5520,
 	.probe 		= cs5520_init_one,
 	.remove		= cs5520_remove_one,
+#ifdef CONFIG_PM
 	.suspend	= cs5520_pci_device_suspend,
 	.resume		= cs5520_reinit_one,
+#endif
 };
 
 static int __init cs5520_init(void)
Index: work/drivers/ata/pata_cs5530.c
===================================================================
--- work.orig/drivers/ata/pata_cs5530.c
+++ work/drivers/ata/pata_cs5530.c
@@ -188,8 +188,10 @@ static struct scsi_host_template cs5530_
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static struct ata_port_operations cs5530_port_ops = {
@@ -376,6 +378,7 @@ static int cs5530_init_one(struct pci_de
 	return ata_pci_init_one(pdev, port_info, 2);
 }
 
+#ifdef CONFIG_PM
 static int cs5530_reinit_one(struct pci_dev *pdev)
 {
 	/* If we fail on resume we are doomed */
@@ -383,6 +386,7 @@ static int cs5530_reinit_one(struct pci_
 		BUG();
 	return ata_pci_device_resume(pdev);
 }
+#endif /* CONFIG_PM */
 
 static const struct pci_device_id cs5530[] = {
 	{ PCI_VDEVICE(CYRIX, PCI_DEVICE_ID_CYRIX_5530_IDE), },
@@ -395,8 +399,10 @@ static struct pci_driver cs5530_pci_driv
 	.id_table	= cs5530,
 	.probe 		= cs5530_init_one,
 	.remove		= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
 	.resume		= cs5530_reinit_one,
+#endif
 };
 
 static int __init cs5530_init(void)
Index: work/drivers/ata/pata_cs5535.c
===================================================================
--- work.orig/drivers/ata/pata_cs5535.c
+++ work/drivers/ata/pata_cs5535.c
@@ -185,8 +185,10 @@ static struct scsi_host_template cs5535_
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static struct ata_port_operations cs5535_port_ops = {
@@ -270,8 +272,10 @@ static struct pci_driver cs5535_pci_driv
 	.id_table	= cs5535,
 	.probe 		= cs5535_init_one,
 	.remove		= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
 	.resume		= ata_pci_device_resume,
+#endif
 };
 
 static int __init cs5535_init(void)
Index: work/drivers/ata/pata_cypress.c
===================================================================
--- work.orig/drivers/ata/pata_cypress.c
+++ work/drivers/ata/pata_cypress.c
@@ -136,8 +136,10 @@ static struct scsi_host_template cy82c69
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static struct ata_port_operations cy82c693_port_ops = {
@@ -206,8 +208,10 @@ static struct pci_driver cy82c693_pci_dr
 	.id_table	= cy82c693,
 	.probe 		= cy82c693_init_one,
 	.remove		= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
 	.resume		= ata_pci_device_resume,
+#endif
 };
 
 static int __init cy82c693_init(void)
Index: work/drivers/ata/pata_efar.c
===================================================================
--- work.orig/drivers/ata/pata_efar.c
+++ work/drivers/ata/pata_efar.c
@@ -234,8 +234,10 @@ static struct scsi_host_template efar_sh
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static const struct ata_port_operations efar_ops = {
@@ -317,8 +319,10 @@ static struct pci_driver efar_pci_driver
 	.id_table		= efar_pci_tbl,
 	.probe			= efar_init_one,
 	.remove			= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend		= ata_pci_device_suspend,
 	.resume			= ata_pci_device_resume,
+#endif
 };
 
 static int __init efar_init(void)
Index: work/drivers/ata/pata_hpt366.c
===================================================================
--- work.orig/drivers/ata/pata_hpt366.c
+++ work/drivers/ata/pata_hpt366.c
@@ -328,8 +328,10 @@ static struct scsi_host_template hpt36x_
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 /*
@@ -457,12 +459,13 @@ static int hpt36x_init_one(struct pci_de
 	return ata_pci_init_one(dev, port_info, 2);
 }
 
+#ifdef CONFIG_PM
 static int hpt36x_reinit_one(struct pci_dev *dev)
 {
 	hpt36x_init_chipset(dev);
 	return ata_pci_device_resume(dev);
 }
-
+#endif
 
 static const struct pci_device_id hpt36x[] = {
 	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT366), },
@@ -474,8 +477,10 @@ static struct pci_driver hpt36x_pci_driv
 	.id_table	= hpt36x,
 	.probe 		= hpt36x_init_one,
 	.remove		= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
 	.resume		= hpt36x_reinit_one,
+#endif
 };
 
 static int __init hpt36x_init(void)
Index: work/drivers/ata/pata_hpt3x3.c
===================================================================
--- work.orig/drivers/ata/pata_hpt3x3.c
+++ work/drivers/ata/pata_hpt3x3.c
@@ -119,8 +119,10 @@ static struct scsi_host_template hpt3x3_
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static struct ata_port_operations hpt3x3_port_ops = {
@@ -206,11 +208,13 @@ static int hpt3x3_init_one(struct pci_de
 	return ata_pci_init_one(dev, port_info, 2);
 }
 
+#ifdef CONFIG_PM
 static int hpt3x3_reinit_one(struct pci_dev *dev)
 {
 	hpt3x3_init_chipset(dev);
 	return ata_pci_device_resume(dev);
 }
+#endif
 
 static const struct pci_device_id hpt3x3[] = {
 	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT343), },
@@ -223,8 +227,10 @@ static struct pci_driver hpt3x3_pci_driv
 	.id_table	= hpt3x3,
 	.probe 		= hpt3x3_init_one,
 	.remove		= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
 	.resume		= hpt3x3_reinit_one,
+#endif
 };
 
 static int __init hpt3x3_init(void)
Index: work/drivers/ata/pata_it8213.c
===================================================================
--- work.orig/drivers/ata/pata_it8213.c
+++ work/drivers/ata/pata_it8213.c
@@ -246,8 +246,10 @@ static struct scsi_host_template it8213_
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static const struct ata_port_operations it8213_ops = {
@@ -330,8 +332,10 @@ static struct pci_driver it8213_pci_driv
 	.id_table		= it8213_pci_tbl,
 	.probe			= it8213_init_one,
 	.remove			= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend		= ata_pci_device_suspend,
 	.resume			= ata_pci_device_resume,
+#endif
 };
 
 static int __init it8213_init(void)
Index: work/drivers/ata/pata_it821x.c
===================================================================
--- work.orig/drivers/ata/pata_it821x.c
+++ work/drivers/ata/pata_it821x.c
@@ -646,8 +646,10 @@ static struct scsi_host_template it821x_
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static struct ata_port_operations it821x_smart_port_ops = {
@@ -780,6 +782,7 @@ static int it821x_init_one(struct pci_de
 	return ata_pci_init_one(pdev, port_info, 2);
 }
 
+#ifdef CONFIG_PM
 static int it821x_reinit_one(struct pci_dev *pdev)
 {
 	/* Resume - turn raid back off if need be */
@@ -787,6 +790,7 @@ static int it821x_reinit_one(struct pci_
 		it821x_disable_raid(pdev);
 	return ata_pci_device_resume(pdev);
 }
+#endif
 
 static const struct pci_device_id it821x[] = {
 	{ PCI_VDEVICE(ITE, PCI_DEVICE_ID_ITE_8211), },
@@ -800,8 +804,10 @@ static struct pci_driver it821x_pci_driv
 	.id_table	= it821x,
 	.probe 		= it821x_init_one,
 	.remove		= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
 	.resume		= it821x_reinit_one,
+#endif
 };
 
 static int __init it821x_init(void)
Index: work/drivers/ata/pata_marvell.c
===================================================================
--- work.orig/drivers/ata/pata_marvell.c
+++ work/drivers/ata/pata_marvell.c
@@ -103,8 +103,10 @@ static struct scsi_host_template marvell
 	.slave_destroy		= ata_scsi_slave_destroy,
 	/* Use standard CHS mapping rules */
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static const struct ata_port_operations marvell_ops = {
@@ -199,8 +201,10 @@ static struct pci_driver marvell_pci_dri
 	.id_table		= marvell_pci_tbl,
 	.probe			= marvell_init_one,
 	.remove			= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend		= ata_pci_device_suspend,
 	.resume			= ata_pci_device_resume,
+#endif
 };
 
 static int __init marvell_init(void)
Index: work/drivers/ata/pata_mpiix.c
===================================================================
--- work.orig/drivers/ata/pata_mpiix.c
+++ work/drivers/ata/pata_mpiix.c
@@ -165,8 +165,10 @@ static struct scsi_host_template mpiix_s
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static struct ata_port_operations mpiix_port_ops = {
@@ -270,8 +272,10 @@ static struct pci_driver mpiix_pci_drive
 	.id_table	= mpiix,
 	.probe 		= mpiix_init_one,
 	.remove		= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
 	.resume		= ata_pci_device_resume,
+#endif
 };
 
 static int __init mpiix_init(void)
Index: work/drivers/ata/pata_netcell.c
===================================================================
--- work.orig/drivers/ata/pata_netcell.c
+++ work/drivers/ata/pata_netcell.c
@@ -63,8 +63,10 @@ static struct scsi_host_template netcell
 	.slave_destroy		= ata_scsi_slave_destroy,
 	/* Use standard CHS mapping rules */
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static const struct ata_port_operations netcell_ops = {
@@ -153,8 +155,10 @@ static struct pci_driver netcell_pci_dri
 	.id_table		= netcell_pci_tbl,
 	.probe			= netcell_init_one,
 	.remove			= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend		= ata_pci_device_suspend,
 	.resume			= ata_pci_device_resume,
+#endif
 };
 
 static int __init netcell_init(void)
Index: work/drivers/ata/pata_ns87410.c
===================================================================
--- work.orig/drivers/ata/pata_ns87410.c
+++ work/drivers/ata/pata_ns87410.c
@@ -157,8 +157,10 @@ static struct scsi_host_template ns87410
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static struct ata_port_operations ns87410_port_ops = {
@@ -212,8 +214,10 @@ static struct pci_driver ns87410_pci_dri
 	.id_table	= ns87410,
 	.probe 		= ns87410_init_one,
 	.remove		= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
 	.resume		= ata_pci_device_resume,
+#endif
 };
 
 static int __init ns87410_init(void)
Index: work/drivers/ata/pata_oldpiix.c
===================================================================
--- work.orig/drivers/ata/pata_oldpiix.c
+++ work/drivers/ata/pata_oldpiix.c
@@ -233,8 +233,10 @@ static struct scsi_host_template oldpiix
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static const struct ata_port_operations oldpiix_pata_ops = {
@@ -316,8 +318,10 @@ static struct pci_driver oldpiix_pci_dri
 	.id_table		= oldpiix_pci_tbl,
 	.probe			= oldpiix_init_one,
 	.remove			= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend		= ata_pci_device_suspend,
 	.resume			= ata_pci_device_resume,
+#endif
 };
 
 static int __init oldpiix_init(void)
Index: work/drivers/ata/pata_opti.c
===================================================================
--- work.orig/drivers/ata/pata_opti.c
+++ work/drivers/ata/pata_opti.c
@@ -179,8 +179,10 @@ static struct scsi_host_template opti_sh
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static struct ata_port_operations opti_port_ops = {
@@ -244,8 +246,10 @@ static struct pci_driver opti_pci_driver
 	.id_table	= opti,
 	.probe 		= opti_init_one,
 	.remove		= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
 	.resume		= ata_pci_device_resume,
+#endif
 };
 
 static int __init opti_init(void)
Index: work/drivers/ata/pata_optidma.c
===================================================================
--- work.orig/drivers/ata/pata_optidma.c
+++ work/drivers/ata/pata_optidma.c
@@ -360,8 +360,10 @@ static struct scsi_host_template optidma
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static struct ata_port_operations optidma_port_ops = {
@@ -524,8 +526,10 @@ static struct pci_driver optidma_pci_dri
 	.id_table	= optidma,
 	.probe 		= optidma_init_one,
 	.remove		= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
 	.resume		= ata_pci_device_resume,
+#endif
 };
 
 static int __init optidma_init(void)
Index: work/drivers/ata/pata_pdc202xx_old.c
===================================================================
--- work.orig/drivers/ata/pata_pdc202xx_old.c
+++ work/drivers/ata/pata_pdc202xx_old.c
@@ -267,8 +267,10 @@ static struct scsi_host_template pdc202x
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static struct ata_port_operations pdc2024x_port_ops = {
@@ -399,8 +401,10 @@ static struct pci_driver pdc202xx_pci_dr
 	.id_table	= pdc202xx,
 	.probe 		= pdc202xx_init_one,
 	.remove		= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
 	.resume		= ata_pci_device_resume,
+#endif
 };
 
 static int __init pdc202xx_init(void)
Index: work/drivers/ata/pata_radisys.c
===================================================================
--- work.orig/drivers/ata/pata_radisys.c
+++ work/drivers/ata/pata_radisys.c
@@ -228,8 +228,10 @@ static struct scsi_host_template radisys
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static const struct ata_port_operations radisys_pata_ops = {
@@ -312,8 +314,10 @@ static struct pci_driver radisys_pci_dri
 	.id_table		= radisys_pci_tbl,
 	.probe			= radisys_init_one,
 	.remove			= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend		= ata_pci_device_suspend,
 	.resume			= ata_pci_device_resume,
+#endif
 };
 
 static int __init radisys_init(void)
Index: work/drivers/ata/pata_rz1000.c
===================================================================
--- work.orig/drivers/ata/pata_rz1000.c
+++ work/drivers/ata/pata_rz1000.c
@@ -94,8 +94,10 @@ static struct scsi_host_template rz1000_
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static struct ata_port_operations rz1000_port_ops = {
@@ -178,6 +180,7 @@ static int rz1000_init_one (struct pci_d
 	return -ENODEV;
 }
 
+#ifdef CONFIG_PM
 static int rz1000_reinit_one(struct pci_dev *pdev)
 {
 	/* If this fails on resume (which is a "cant happen" case), we
@@ -186,6 +189,7 @@ static int rz1000_reinit_one(struct pci_
 		panic("rz1000 fifo");
 	return ata_pci_device_resume(pdev);
 }
+#endif
 
 static const struct pci_device_id pata_rz1000[] = {
 	{ PCI_VDEVICE(PCTECH, PCI_DEVICE_ID_PCTECH_RZ1000), },
@@ -199,8 +203,10 @@ static struct pci_driver rz1000_pci_driv
 	.id_table	= pata_rz1000,
 	.probe 		= rz1000_init_one,
 	.remove		= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
 	.resume		= rz1000_reinit_one,
+#endif
 };
 
 static int __init rz1000_init(void)
Index: work/drivers/ata/pata_sc1200.c
===================================================================
--- work.orig/drivers/ata/pata_sc1200.c
+++ work/drivers/ata/pata_sc1200.c
@@ -194,8 +194,10 @@ static struct scsi_host_template sc1200_
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static struct ata_port_operations sc1200_port_ops = {
@@ -266,8 +268,10 @@ static struct pci_driver sc1200_pci_driv
 	.id_table	= sc1200,
 	.probe 		= sc1200_init_one,
 	.remove		= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
 	.resume		= ata_pci_device_resume,
+#endif
 };
 
 static int __init sc1200_init(void)
Index: work/drivers/ata/pata_scc.c
===================================================================
--- work.orig/drivers/ata/pata_scc.c
+++ work/drivers/ata/pata_scc.c
@@ -984,8 +984,10 @@ static struct scsi_host_template scc_sht
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static const struct ata_port_operations scc_pata_ops = {
Index: work/drivers/ata/pata_serverworks.c
===================================================================
--- work.orig/drivers/ata/pata_serverworks.c
+++ work/drivers/ata/pata_serverworks.c
@@ -319,8 +319,10 @@ static struct scsi_host_template serverw
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static struct ata_port_operations serverworks_osb4_port_ops = {
@@ -548,6 +550,7 @@ static int serverworks_init_one(struct p
 	return ata_pci_init_one(pdev, port_info, ports);
 }
 
+#ifdef CONFIG_PM
 static int serverworks_reinit_one(struct pci_dev *pdev)
 {
 	/* Force master latency timer to 64 PCI clocks */
@@ -571,6 +574,7 @@ static int serverworks_reinit_one(struct
 	}
 	return ata_pci_device_resume(pdev);
 }
+#endif
 
 static const struct pci_device_id serverworks[] = {
 	{ PCI_VDEVICE(SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4IDE), 0},
@@ -587,8 +591,10 @@ static struct pci_driver serverworks_pci
 	.id_table	= serverworks,
 	.probe 		= serverworks_init_one,
 	.remove		= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
 	.resume		= serverworks_reinit_one,
+#endif
 };
 
 static int __init serverworks_init(void)
Index: work/drivers/ata/pata_sis.c
===================================================================
--- work.orig/drivers/ata/pata_sis.c
+++ work/drivers/ata/pata_sis.c
@@ -575,8 +575,10 @@ static struct scsi_host_template sis_sht
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static const struct ata_port_operations sis_133_ops = {
@@ -1032,8 +1034,10 @@ static struct pci_driver sis_pci_driver 
 	.id_table		= sis_pci_tbl,
 	.probe			= sis_init_one,
 	.remove			= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend		= ata_pci_device_suspend,
 	.resume			= ata_pci_device_resume,
+#endif
 };
 
 static int __init sis_init(void)
Index: work/drivers/ata/pata_triflex.c
===================================================================
--- work.orig/drivers/ata/pata_triflex.c
+++ work/drivers/ata/pata_triflex.c
@@ -193,8 +193,10 @@ static struct scsi_host_template triflex
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static struct ata_port_operations triflex_port_ops = {
@@ -260,8 +262,10 @@ static struct pci_driver triflex_pci_dri
 	.id_table	= triflex,
 	.probe 		= triflex_init_one,
 	.remove		= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
 	.resume		= ata_pci_device_resume,
+#endif
 };
 
 static int __init triflex_init(void)
Index: work/drivers/ata/pata_via.c
===================================================================
--- work.orig/drivers/ata/pata_via.c
+++ work/drivers/ata/pata_via.c
@@ -305,8 +305,10 @@ static struct scsi_host_template via_sht
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static struct ata_port_operations via_port_ops = {
@@ -560,6 +562,7 @@ static int via_init_one(struct pci_dev *
 	return ata_pci_init_one(pdev, port_info, 2);
 }
 
+#ifdef CONFIG_PM
 /**
  *	via_reinit_one		-	reinit after resume
  *	@pdev; PCI device
@@ -592,6 +595,7 @@ static int via_reinit_one(struct pci_dev
 	}
 	return ata_pci_device_resume(pdev);
 }
+#endif
 
 static const struct pci_device_id via[] = {
 	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_82C576_1), },
@@ -607,8 +611,10 @@ static struct pci_driver via_pci_driver 
 	.id_table	= via,
 	.probe 		= via_init_one,
 	.remove		= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
 	.resume		= via_reinit_one,
+#endif
 };
 
 static int __init via_init(void)
Index: work/drivers/ata/sata_inic162x.c
===================================================================
--- work.orig/drivers/ata/sata_inic162x.c
+++ work/drivers/ata/sata_inic162x.c
@@ -135,8 +135,10 @@ static struct scsi_host_template inic_sh
 	.slave_configure	= inic_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.suspend		= ata_scsi_device_suspend,
 	.resume			= ata_scsi_device_resume,
+#endif
 };
 
 static const int scr_map[] = {
@@ -632,6 +634,7 @@ static int init_controller(void __iomem 
 	return 0;
 }
 
+#ifdef CONFIG_PM
 static int inic_pci_device_resume(struct pci_dev *pdev)
 {
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
@@ -642,7 +645,6 @@ static int inic_pci_device_resume(struct
 	ata_pci_device_do_resume(pdev);
 
 	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
-		printk("XXX\n");
 		rc = init_controller(mmio_base, hpriv->cached_hctl);
 		if (rc)
 			return rc;
@@ -652,6 +654,7 @@ static int inic_pci_device_resume(struct
 
 	return 0;
 }
+#endif
 
 static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
@@ -755,8 +758,10 @@ static const struct pci_device_id inic_p
 static struct pci_driver inic_pci_driver = {
 	.name 		= DRV_NAME,
 	.id_table	= inic_pci_tbl,
+#ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
 	.resume		= inic_pci_device_resume,
+#endif
 	.probe 		= inic_init_one,
 	.remove		= ata_pci_remove_one,
 };
Index: work/drivers/ata/sata_nv.c
===================================================================
--- work.orig/drivers/ata/sata_nv.c
+++ work/drivers/ata/sata_nv.c
@@ -230,7 +230,9 @@ struct nv_host_priv {
 
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static void nv_remove_one (struct pci_dev *pdev);
+#ifdef CONFIG_PM
 static int nv_pci_device_resume(struct pci_dev *pdev);
+#endif
 static void nv_ck804_host_stop(struct ata_host *host);
 static irqreturn_t nv_generic_interrupt(int irq, void *dev_instance);
 static irqreturn_t nv_nf2_interrupt(int irq, void *dev_instance);
@@ -251,8 +253,10 @@ static irqreturn_t nv_adma_interrupt(int
 static void nv_adma_irq_clear(struct ata_port *ap);
 static int nv_adma_port_start(struct ata_port *ap);
 static void nv_adma_port_stop(struct ata_port *ap);
+#ifdef CONFIG_PM
 static int nv_adma_port_suspend(struct ata_port *ap, pm_message_t mesg);
 static int nv_adma_port_resume(struct ata_port *ap);
+#endif
 static void nv_adma_error_handler(struct ata_port *ap);
 static void nv_adma_host_stop(struct ata_host *host);
 static void nv_adma_post_internal_cmd(struct ata_queued_cmd *qc);
@@ -295,8 +299,10 @@ static struct pci_driver nv_pci_driver =
 	.name			= DRV_NAME,
 	.id_table		= nv_pci_tbl,
 	.probe			= nv_init_one,
+#ifdef CONFIG_PM
 	.suspend		= ata_pci_device_suspend,
 	.resume			= nv_pci_device_resume,
+#endif
 	.remove			= nv_remove_one,
 };
 
@@ -316,8 +322,10 @@ static struct scsi_host_template nv_sht 
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.suspend		= ata_scsi_device_suspend,
 	.resume			= ata_scsi_device_resume,
+#endif
 };
 
 static struct scsi_host_template nv_adma_sht = {
@@ -336,8 +344,10 @@ static struct scsi_host_template nv_adma
 	.slave_configure	= nv_adma_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.suspend		= ata_scsi_device_suspend,
 	.resume			= ata_scsi_device_resume,
+#endif
 };
 
 static const struct ata_port_operations nv_generic_ops = {
@@ -449,8 +459,10 @@ static const struct ata_port_operations 
 	.scr_write		= nv_scr_write,
 	.port_start		= nv_adma_port_start,
 	.port_stop		= nv_adma_port_stop,
+#ifdef CONFIG_PM
 	.port_suspend		= nv_adma_port_suspend,
 	.port_resume		= nv_adma_port_resume,
+#endif
 	.host_stop		= nv_adma_host_stop,
 };
 
@@ -1003,6 +1015,7 @@ static void nv_adma_port_stop(struct ata
 	writew(0, mmio + NV_ADMA_CTL);
 }
 
+#ifdef CONFIG_PM
 static int nv_adma_port_suspend(struct ata_port *ap, pm_message_t mesg)
 {
 	struct nv_adma_port_priv *pp = ap->private_data;
@@ -1053,6 +1066,7 @@ static int nv_adma_port_resume(struct at
 
 	return 0;
 }
+#endif
 
 static void nv_adma_setup_port(struct ata_probe_ent *probe_ent, unsigned int port)
 {
@@ -1555,6 +1569,7 @@ static void nv_remove_one (struct pci_de
 	kfree(hpriv);
 }
 
+#ifdef CONFIG_PM
 static int nv_pci_device_resume(struct pci_dev *pdev)
 {
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
@@ -1602,6 +1617,7 @@ static int nv_pci_device_resume(struct p
 
 	return 0;
 }
+#endif
 
 static void nv_ck804_host_stop(struct ata_host *host)
 {
Index: work/drivers/ata/sata_sil.c
===================================================================
--- work.orig/drivers/ata/sata_sil.c
+++ work/drivers/ata/sata_sil.c
@@ -183,8 +183,10 @@ static struct scsi_host_template sil_sht
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.suspend		= ata_scsi_device_suspend,
 	.resume			= ata_scsi_device_resume,
+#endif
 };
 
 static const struct ata_port_operations sil_ops = {
Index: work/drivers/ata/sata_sil24.c
===================================================================
--- work.orig/drivers/ata/sata_sil24.c
+++ work/drivers/ata/sata_sil24.c
@@ -380,8 +380,10 @@ static struct scsi_host_template sil24_s
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.suspend		= ata_scsi_device_suspend,
 	.resume			= ata_scsi_device_resume,
+#endif
 };
 
 static const struct ata_port_operations sil24_ops = {
