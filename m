From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/3] libata: make ata_port_info and ata_probe_ent use xfer_mask
Date: Thu, 16 Feb 2006 23:09:06 +0900
Message-ID: <11400989462030-git-send-email-htejun@gmail.com>
References: <43F3244B.2010600@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.201]:3473 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932294AbWBPOJS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Feb 2006 09:09:18 -0500
Received: by wproxy.gmail.com with SMTP id i31so174340wra
        for <linux-ide@vger.kernel.org>; Thu, 16 Feb 2006 06:09:16 -0800 (PST)
In-Reply-To: <43F3244B.2010600@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, bzolnier@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make ata_port_info and ata_probe_ent use single unsigned int xfer_mask
instead of three masks for pio, mwdma and udma.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c         |    7 +++----
 drivers/scsi/ata_piix.c     |   37 ++++++++++++++++---------------------
 drivers/scsi/libata-bmdma.c |    4 +---
 drivers/scsi/libata-core.c  |    4 +---
 drivers/scsi/pdc_adma.c     |    8 +++-----
 drivers/scsi/sata_mv.c      |   27 +++++++++++----------------
 drivers/scsi/sata_nv.c      |    8 ++------
 drivers/scsi/sata_promise.c |   31 ++++++++++---------------------
 drivers/scsi/sata_qstor.c   |    8 +++-----
 drivers/scsi/sata_sil.c     |   19 +++++++------------
 drivers/scsi/sata_sil24.c   |   19 +++++++------------
 drivers/scsi/sata_sis.c     |    4 +---
 drivers/scsi/sata_svw.c     |    4 +---
 drivers/scsi/sata_sx4.c     |    9 +++------
 drivers/scsi/sata_uli.c     |    3 +--
 drivers/scsi/sata_via.c     |    8 ++------
 drivers/scsi/sata_vsc.c     |    4 +---
 include/linux/libata.h      |    8 ++------
 18 files changed, 75 insertions(+), 137 deletions(-)

45b6b098d03ba8570c51d20ad41804b32b0378ed
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 6b36345..cc6c8ea 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -252,8 +252,8 @@ static const struct ata_port_info ahci_p
 		.sht		= &ahci_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA,
-		.pio_mask	= 0x1f, /* pio0-4 */
-		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.xfer_mask	= ata_pack_xfermask(0x1f, 0, 0x7f),
+				  /* pio0-4, udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,
 	},
 };
@@ -1246,8 +1246,7 @@ static int ahci_init_one (struct pci_dev
 
 	probe_ent->sht		= ahci_port_info[board_idx].sht;
 	probe_ent->host_flags	= ahci_port_info[board_idx].host_flags;
-	probe_ent->pio_mask	= ahci_port_info[board_idx].pio_mask;
-	probe_ent->udma_mask	= ahci_port_info[board_idx].udma_mask;
+	probe_ent->xfer_mask	= ahci_port_info[board_idx].xfer_mask;
 	probe_ent->port_ops	= ahci_port_info[board_idx].port_ops;
 
        	probe_ent->irq = pdev->irq;
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index f806772..27d3998 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -126,6 +126,9 @@ enum {
 	ich6_sata_ahci		= 4,
 
 	PIIX_AHCI_DEVICE	= 6,
+
+	PIIX_SATA_XFERMASK	= ata_pack_xfermask(0x1f, 0x07, 0x7f),
+				  /* pio0-4, mwdma0-2, udma0-6 */
 };
 
 static int piix_init_one (struct pci_dev *pdev,
@@ -260,13 +263,13 @@ static struct ata_port_info piix_port_in
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
 				  PIIX_FLAG_CHECKINTR,
-		.pio_mask	= 0x1f,	/* pio0-4 */
+		.xfer_mask	= ata_pack_xfermask(0x1f,  /* pio0-4 */
 #if 0
-		.mwdma_mask	= 0x06, /* mwdma1-2 */
+						    0x06,  /* mwdma1-2 */
 #else
-		.mwdma_mask	= 0x00, /* mwdma broken */
+						    0x00,  /* mwdma broken */
 #endif
-		.udma_mask	= 0x3f, /* udma0-5 */
+						    0x3f), /* udma0-5 */
 		.port_ops	= &piix_pata_ops,
 	},
 
@@ -275,9 +278,7 @@ static struct ata_port_info piix_port_in
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
 				  PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR,
-		.pio_mask	= 0x1f,	/* pio0-4 */
-		.mwdma_mask	= 0x07, /* mwdma0-2 */
-		.udma_mask	= 0x7f,	/* udma0-6 */
+		.xfer_mask	= PIIX_SATA_XFERMASK,
 		.port_ops	= &piix_sata_ops,
 	},
 
@@ -285,13 +286,13 @@ static struct ata_port_info piix_port_in
 	{
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
-		.pio_mask	= 0x1f,	/* pio0-4 */
+		.xfer_mask	= ata_pack_xfermask(0x1f,  /* pio0-4 */
 #if 0
-		.mwdma_mask	= 0x06, /* mwdma1-2 */
+						    0x06,  /* mwdma1-2 */
 #else
-		.mwdma_mask	= 0x00, /* mwdma broken */
+						    0x00,  /* mwdma broken */
 #endif
-		.udma_mask	= ATA_UDMA_MASK_40C,
+						    ATA_UDMA_MASK_40C),
 		.port_ops	= &piix_pata_ops,
 	},
 
@@ -301,9 +302,7 @@ static struct ata_port_info piix_port_in
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
 				  PIIX_FLAG_COMBINED_ICH6 |
 				  PIIX_FLAG_CHECKINTR | ATA_FLAG_SLAVE_POSS,
-		.pio_mask	= 0x1f,	/* pio0-4 */
-		.mwdma_mask	= 0x07, /* mwdma0-2 */
-		.udma_mask	= 0x7f,	/* udma0-6 */
+		.xfer_mask	= PIIX_SATA_XFERMASK,
 		.port_ops	= &piix_sata_ops,
 	},
 
@@ -314,9 +313,7 @@ static struct ata_port_info piix_port_in
 				  PIIX_FLAG_COMBINED_ICH6 |
 				  PIIX_FLAG_CHECKINTR | ATA_FLAG_SLAVE_POSS |
 				  PIIX_FLAG_AHCI,
-		.pio_mask	= 0x1f,	/* pio0-4 */
-		.mwdma_mask	= 0x07, /* mwdma0-2 */
-		.udma_mask	= 0x7f,	/* udma0-6 */
+		.xfer_mask	= PIIX_SATA_XFERMASK,
 		.port_ops	= &piix_sata_ops,
 	},
 };
@@ -759,10 +756,8 @@ static int piix_init_one (struct pci_dev
 		/* This writes into the master table but it does not
 		   really matter for this errata as we will apply it to
 		   all the PIIX devices on the board */
-		port_info[0]->mwdma_mask = 0;
-		port_info[0]->udma_mask = 0;
-		port_info[1]->mwdma_mask = 0;
-		port_info[1]->udma_mask = 0;
+		port_info[0]->xfer_mask &= ATA_MASK_PIO;
+		port_info[1]->xfer_mask &= ATA_MASK_PIO;
 	}
 	return ata_pci_init_one(pdev, port_info, 2);
 }
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index a93336a..20b30b1 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -434,9 +434,7 @@ ata_probe_ent_alloc(struct device *dev, 
 
 	probe_ent->sht = port->sht;
 	probe_ent->host_flags = port->host_flags;
-	probe_ent->pio_mask = port->pio_mask;
-	probe_ent->mwdma_mask = port->mwdma_mask;
-	probe_ent->udma_mask = port->udma_mask;
+	probe_ent->xfer_mask = port->xfer_mask;
 	probe_ent->port_ops = port->port_ops;
 
 	return probe_ent;
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 3286df1..07bd232 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4503,9 +4503,7 @@ static void ata_host_init(struct ata_por
 	ap->port_no = port_no;
 	ap->hard_port_no =
 		ent->legacy_mode ? ent->hard_port_no : port_no;
-	ap->xfer_mask = ata_pack_xfermask(ent->pio_mask,
-					  ent->mwdma_mask,
-					  ent->udma_mask);
+	ap->xfer_mask = ent->xfer_mask;
 	ap->flags |= ent->host_flags;
 	ap->ops = ent->port_ops;
 	ap->cbl = ATA_CBL_NONE;
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index 9f9b4d5..f4920af 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -184,8 +184,8 @@ static struct ata_port_info adma_port_in
 		.sht		= &adma_ata_sht,
 		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
 				  ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO,
-		.pio_mask	= 0x10, /* pio4 */
-		.udma_mask	= 0x1f, /* udma0-4 */
+		.xfer_mask	= ata_pack_xfermask(0x10, 0, 0x1f),
+				  /* pio4, udma0-4 */
 		.port_ops	= &adma_ata_ops,
 	},
 };
@@ -684,9 +684,7 @@ static int adma_ata_init_one(struct pci_
 
 	probe_ent->sht		= adma_port_info[board_idx].sht;
 	probe_ent->host_flags	= adma_port_info[board_idx].host_flags;
-	probe_ent->pio_mask	= adma_port_info[board_idx].pio_mask;
-	probe_ent->mwdma_mask	= adma_port_info[board_idx].mwdma_mask;
-	probe_ent->udma_mask	= adma_port_info[board_idx].udma_mask;
+	probe_ent->xfer_mask	= adma_port_info[board_idx].xfer_mask;
 	probe_ent->port_ops	= adma_port_info[board_idx].port_ops;
 
 	probe_ent->irq		= pdev->irq;
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index c158de2..e44267c 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -235,6 +235,9 @@ enum {
 	/* Port private flags (pp_flags) */
 	MV_PP_FLAG_EDMA_EN	= (1 << 0),
 	MV_PP_FLAG_EDMA_DS_ACT	= (1 << 1),
+
+	/* xfer_mask: pio0-4, udma0-6 */
+	MV_XFER_MASK		= ata_pack_xfermask(0x1f, 0, 0x7f),
 };
 
 #define IS_50XX(hpriv) ((hpriv)->hp_flags & MV_HP_50XX)
@@ -477,52 +480,45 @@ static const struct ata_port_info mv_por
 	{  /* chip_504x */
 		.sht		= &mv_sht,
 		.host_flags	= MV_COMMON_FLAGS,
-		.pio_mask	= 0x1f,	/* pio0-4 */
-		.udma_mask	= 0x7f,	/* udma0-6 */
+		.xfer_mask	= MV_XFER_MASK,
 		.port_ops	= &mv5_ops,
 	},
 	{  /* chip_508x */
 		.sht		= &mv_sht,
 		.host_flags	= (MV_COMMON_FLAGS | MV_FLAG_DUAL_HC),
-		.pio_mask	= 0x1f,	/* pio0-4 */
-		.udma_mask	= 0x7f,	/* udma0-6 */
+		.xfer_mask	= MV_XFER_MASK,
 		.port_ops	= &mv5_ops,
 	},
 	{  /* chip_5080 */
 		.sht		= &mv_sht,
 		.host_flags	= (MV_COMMON_FLAGS | MV_FLAG_DUAL_HC),
-		.pio_mask	= 0x1f,	/* pio0-4 */
-		.udma_mask	= 0x7f,	/* udma0-6 */
+		.xfer_mask	= MV_XFER_MASK,
 		.port_ops	= &mv5_ops,
 	},
 	{  /* chip_604x */
 		.sht		= &mv_sht,
 		.host_flags	= (MV_COMMON_FLAGS | MV_6XXX_FLAGS),
-		.pio_mask	= 0x1f,	/* pio0-4 */
-		.udma_mask	= 0x7f,	/* udma0-6 */
+		.xfer_mask	= MV_XFER_MASK,
 		.port_ops	= &mv6_ops,
 	},
 	{  /* chip_608x */
 		.sht		= &mv_sht,
 		.host_flags	= (MV_COMMON_FLAGS | MV_6XXX_FLAGS |
 				   MV_FLAG_DUAL_HC),
-		.pio_mask	= 0x1f,	/* pio0-4 */
-		.udma_mask	= 0x7f,	/* udma0-6 */
+		.xfer_mask	= MV_XFER_MASK,
 		.port_ops	= &mv6_ops,
 	},
 	{  /* chip_6042 */
 		.sht		= &mv_sht,
 		.host_flags	= (MV_COMMON_FLAGS | MV_6XXX_FLAGS),
-		.pio_mask	= 0x1f,	/* pio0-4 */
-		.udma_mask	= 0x7f,	/* udma0-6 */
+		.xfer_mask	= MV_XFER_MASK,
 		.port_ops	= &mv_iie_ops,
 	},
 	{  /* chip_7042 */
 		.sht		= &mv_sht,
 		.host_flags	= (MV_COMMON_FLAGS | MV_6XXX_FLAGS |
 				   MV_FLAG_DUAL_HC),
-		.pio_mask	= 0x1f,	/* pio0-4 */
-		.udma_mask	= 0x7f,	/* udma0-6 */
+		.xfer_mask	= MV_XFER_MASK,
 		.port_ops	= &mv_iie_ops,
 	},
 };
@@ -2354,8 +2350,7 @@ static int mv_init_one(struct pci_dev *p
 
 	probe_ent->sht = mv_port_info[board_idx].sht;
 	probe_ent->host_flags = mv_port_info[board_idx].host_flags;
-	probe_ent->pio_mask = mv_port_info[board_idx].pio_mask;
-	probe_ent->udma_mask = mv_port_info[board_idx].udma_mask;
+	probe_ent->xfer_mask = mv_port_info[board_idx].xfer_mask;
 	probe_ent->port_ops = mv_port_info[board_idx].port_ops;
 
 	probe_ent->irq = pdev->irq;
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index caffadc..ac824c2 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -75,9 +75,7 @@
 #define DRV_VERSION			"0.8"
 
 #define NV_PORTS			2
-#define NV_PIO_MASK			0x1f
-#define NV_MWDMA_MASK			0x07
-#define NV_UDMA_MASK			0x7f
+#define NV_XFER_MASK			ata_pack_xfermask(0x1f, 0x07, 0x7f)
 #define NV_PORT0_SCR_REG_OFFSET		0x00
 #define NV_PORT1_SCR_REG_OFFSET		0x40
 
@@ -281,9 +279,7 @@ static struct ata_port_info nv_port_info
 			  /* ATA_FLAG_SATA_RESET | */
 			  ATA_FLAG_SRST |
 			  ATA_FLAG_NO_LEGACY,
-	.pio_mask	= NV_PIO_MASK,
-	.mwdma_mask	= NV_MWDMA_MASK,
-	.udma_mask	= NV_UDMA_MASK,
+	.xfer_mask	= NV_XFER_MASK,
 	.port_ops	= &nv_ops,
 };
 
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index ab3f39a..1c637a0 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -77,6 +77,9 @@ enum {
 
 	PDC_COMMON_FLAGS	= ATA_FLAG_NO_LEGACY | ATA_FLAG_SRST |
 				  ATA_FLAG_MMIO | ATA_FLAG_NO_ATAPI,
+
+	/* xfer_mask: pio0-4, mwdma0-2, udma0-6 ; FIXME */
+	PDC_XFER_MASK		= ata_pack_xfermask(0x1f, 0x07, 0x7f),
 };
 
 
@@ -174,9 +177,7 @@ static const struct ata_port_info pdc_po
 	{
 		.sht		= &pdc_ata_sht,
 		.host_flags	= PDC_COMMON_FLAGS | ATA_FLAG_SATA,
-		.pio_mask	= 0x1f, /* pio0-4 */
-		.mwdma_mask	= 0x07, /* mwdma0-2 */
-		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.xfer_mask	= PDC_XFER_MASK,
 		.port_ops	= &pdc_sata_ops,
 	},
 
@@ -184,9 +185,7 @@ static const struct ata_port_info pdc_po
 	{
 		.sht		= &pdc_ata_sht,
 		.host_flags	= PDC_COMMON_FLAGS | ATA_FLAG_SATA,
-		.pio_mask	= 0x1f, /* pio0-4 */
-		.mwdma_mask	= 0x07, /* mwdma0-2 */
-		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.xfer_mask	= PDC_XFER_MASK,
 		.port_ops	= &pdc_sata_ops,
 	},
 
@@ -194,9 +193,7 @@ static const struct ata_port_info pdc_po
 	{
 		.sht		= &pdc_ata_sht,
 		.host_flags	= PDC_COMMON_FLAGS | ATA_FLAG_SLAVE_POSS,
-		.pio_mask	= 0x1f, /* pio0-4 */
-		.mwdma_mask	= 0x07, /* mwdma0-2 */
-		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.xfer_mask	= PDC_XFER_MASK,
 		.port_ops	= &pdc_pata_ops,
 	},
 
@@ -204,9 +201,7 @@ static const struct ata_port_info pdc_po
 	{
 		.sht		= &pdc_ata_sht,
 		.host_flags	= PDC_COMMON_FLAGS | ATA_FLAG_SATA,
-		.pio_mask	= 0x1f, /* pio0-4 */
-		.mwdma_mask	= 0x07, /* mwdma0-2 */
-		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.xfer_mask	= PDC_XFER_MASK,
 		.port_ops	= &pdc_sata_ops,
 	},
 
@@ -214,9 +209,7 @@ static const struct ata_port_info pdc_po
 	{
 		.sht		= &pdc_ata_sht,
 		.host_flags	= PDC_COMMON_FLAGS | ATA_FLAG_SATA,
-		.pio_mask	= 0x1f, /* pio0-4 */
-		.mwdma_mask	= 0x07, /* mwdma0-2 */
-		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.xfer_mask	= PDC_XFER_MASK,
 		.port_ops	= &pdc_sata_ops,
 	},
 
@@ -224,9 +217,7 @@ static const struct ata_port_info pdc_po
 	{
 		.sht		= &pdc_ata_sht,
 		.host_flags	= PDC_COMMON_FLAGS | ATA_FLAG_SATA,
-		.pio_mask	= 0x1f, /* pio0-4 */
-		.mwdma_mask	= 0x07, /* mwdma0-2 */
-		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.xfer_mask	= PDC_XFER_MASK,
 		.port_ops	= &pdc_sata_ops,
 	},
 };
@@ -725,9 +716,7 @@ static int pdc_ata_init_one (struct pci_
 
 	probe_ent->sht		= pdc_port_info[board_idx].sht;
 	probe_ent->host_flags	= pdc_port_info[board_idx].host_flags;
-	probe_ent->pio_mask	= pdc_port_info[board_idx].pio_mask;
-	probe_ent->mwdma_mask	= pdc_port_info[board_idx].mwdma_mask;
-	probe_ent->udma_mask	= pdc_port_info[board_idx].udma_mask;
+	probe_ent->xfer_mask	= pdc_port_info[board_idx].xfer_mask;
 	probe_ent->port_ops	= pdc_port_info[board_idx].port_ops;
 
        	probe_ent->irq = pdev->irq;
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index 2864826..f7b3f4e 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -178,8 +178,8 @@ static const struct ata_port_info qs_por
 				  ATA_FLAG_SATA_RESET |
 				  //FIXME ATA_FLAG_SRST |
 				  ATA_FLAG_MMIO,
-		.pio_mask	= 0x10, /* pio4 */
-		.udma_mask	= 0x7f, /* udma0-6 */
+		.xfer_mask	= ata_pack_xfermask(0x10, 0, 0x7f),
+				  /* pio4, udma0-6 */
 		.port_ops	= &qs_ata_ops,
 	},
 };
@@ -675,9 +675,7 @@ static int qs_ata_init_one(struct pci_de
 
 	probe_ent->sht		= qs_port_info[board_idx].sht;
 	probe_ent->host_flags	= qs_port_info[board_idx].host_flags;
-	probe_ent->pio_mask	= qs_port_info[board_idx].pio_mask;
-	probe_ent->mwdma_mask	= qs_port_info[board_idx].mwdma_mask;
-	probe_ent->udma_mask	= qs_port_info[board_idx].udma_mask;
+	probe_ent->xfer_mask	= qs_port_info[board_idx].xfer_mask;
 	probe_ent->port_ops	= qs_port_info[board_idx].port_ops;
 
 	probe_ent->irq		= pdev->irq;
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 4aeb2c3..ad702cb 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -78,6 +78,9 @@ enum {
 	SIL_INTR_STEERING	= (1 << 1),
 	SIL_QUIRK_MOD15WRITE	= (1 << 0),
 	SIL_QUIRK_UDMA5MAX	= (1 << 1),
+
+	SIL_XFER_MASK		= ata_pack_xfermask(0x1f, 0x07, 0x3f),
+				  /* pio0-4, mwdma0-2, udma0-5 */
 };
 
 static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
@@ -181,27 +184,21 @@ static const struct ata_port_info sil_po
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO,
-		.pio_mask	= 0x1f,			/* pio0-4 */
-		.mwdma_mask	= 0x07,			/* mwdma0-2 */
-		.udma_mask	= 0x3f,			/* udma0-5 */
+		.xfer_mask	= SIL_XFER_MASK,
 		.port_ops	= &sil_ops,
 	}, /* sil_3112_15w - keep it sync'd w/ sil_3112 */
 	{
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | SIL_FLAG_MOD15WRITE,
-		.pio_mask	= 0x1f,			/* pio0-4 */
-		.mwdma_mask	= 0x07,			/* mwdma0-2 */
-		.udma_mask	= 0x3f,			/* udma0-5 */
+		.xfer_mask	= SIL_XFER_MASK,
 		.port_ops	= &sil_ops,
 	}, /* sil_3114 */
 	{
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO,
-		.pio_mask	= 0x1f,			/* pio0-4 */
-		.mwdma_mask	= 0x07,			/* mwdma0-2 */
-		.udma_mask	= 0x3f,			/* udma0-5 */
+		.xfer_mask	= SIL_XFER_MASK,
 		.port_ops	= &sil_ops,
 	},
 };
@@ -413,9 +410,7 @@ static int sil_init_one (struct pci_dev 
 	probe_ent->port_ops = sil_port_info[ent->driver_data].port_ops;
 	probe_ent->sht = sil_port_info[ent->driver_data].sht;
 	probe_ent->n_ports = (ent->driver_data == sil_3114) ? 4 : 2;
-	probe_ent->pio_mask = sil_port_info[ent->driver_data].pio_mask;
-	probe_ent->mwdma_mask = sil_port_info[ent->driver_data].mwdma_mask;
-	probe_ent->udma_mask = sil_port_info[ent->driver_data].udma_mask;
+	probe_ent->xfer_mask = sil_port_info[ent->driver_data].xfer_mask;
        	probe_ent->irq = pdev->irq;
        	probe_ent->irq_flags = SA_SHIRQ;
 	probe_ent->host_flags = sil_port_info[ent->driver_data].host_flags;
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 1c54736..36b18b6 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -208,6 +208,9 @@ enum {
 	BID_SIL3131		= 2,
 
 	IRQ_STAT_4PORTS		= 0xf,
+
+	/* xfer_mask: pio0-4, mwdma0-2, udma0-5 */
+	XFER_MASK		= ata_pack_xfermask(0x1f, 0x07, 0x3f),
 };
 
 struct sil24_ata_block {
@@ -337,9 +340,7 @@ static struct ata_port_info sil24_port_i
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
 				  SIL24_NPORTS2FLAG(4),
-		.pio_mask	= 0x1f,			/* pio0-4 */
-		.mwdma_mask	= 0x07,			/* mwdma0-2 */
-		.udma_mask	= 0x3f,			/* udma0-5 */
+		.xfer_mask	= XFER_MASK,
 		.port_ops	= &sil24_ops,
 	},
 	/* sil_3132 */ 
@@ -348,9 +349,7 @@ static struct ata_port_info sil24_port_i
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
 				  SIL24_NPORTS2FLAG(2),
-		.pio_mask	= 0x1f,			/* pio0-4 */
-		.mwdma_mask	= 0x07,			/* mwdma0-2 */
-		.udma_mask	= 0x3f,			/* udma0-5 */
+		.xfer_mask	= XFER_MASK,
 		.port_ops	= &sil24_ops,
 	},
 	/* sil_3131/sil_3531 */
@@ -359,9 +358,7 @@ static struct ata_port_info sil24_port_i
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
 				  SIL24_NPORTS2FLAG(1),
-		.pio_mask	= 0x1f,			/* pio0-4 */
-		.mwdma_mask	= 0x07,			/* mwdma0-2 */
-		.udma_mask	= 0x3f,			/* udma0-5 */
+		.xfer_mask	= XFER_MASK,
 		.port_ops	= &sil24_ops,
 	},
 };
@@ -890,9 +887,7 @@ static int sil24_init_one(struct pci_dev
 
 	probe_ent->sht		= pinfo->sht;
 	probe_ent->host_flags	= pinfo->host_flags;
-	probe_ent->pio_mask	= pinfo->pio_mask;
-	probe_ent->mwdma_mask	= pinfo->mwdma_mask;
-	probe_ent->udma_mask	= pinfo->udma_mask;
+	probe_ent->xfer_mask	= pinfo->xfer_mask;
 	probe_ent->port_ops	= pinfo->port_ops;
 	probe_ent->n_ports	= SIL24_FLAG2NPORTS(pinfo->host_flags);
 
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
index 7fd45f8..f572bd7 100644
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -129,9 +129,7 @@ static struct ata_port_info sis_port_inf
 	.sht		= &sis_sht,
 	.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
 			  ATA_FLAG_NO_LEGACY,
-	.pio_mask	= 0x1f,
-	.mwdma_mask	= 0x7,
-	.udma_mask	= 0x7f,
+	.xfer_mask	= ata_pack_xfermask(0x1f, 0x7, 0x7f),
 	.port_ops	= &sis_ops,
 };
 
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
index 4aaccd5..9474f5e 100644
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -431,9 +431,7 @@ static int k2_sata_init_one (struct pci_
 	/* We don't care much about the PIO/UDMA masks, but the core won't like us
 	 * if we don't fill these
 	 */
-	probe_ent->pio_mask = 0x1f;
-	probe_ent->mwdma_mask = 0x7;
-	probe_ent->udma_mask = 0x7f;
+	probe_ent->xfer_mask = ata_pack_xfermask(0x1f, 0x7, 0x7f);
 
 	/* different controllers have different number of ports - currently 4 or 8 */
 	/* All ports are on the same function. Multi-function device is no
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index 9f8a768..f715192 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -221,9 +221,8 @@ static const struct ata_port_info pdc_po
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
 				  ATA_FLAG_NO_ATAPI,
-		.pio_mask	= 0x1f, /* pio0-4 */
-		.mwdma_mask	= 0x07, /* mwdma0-2 */
-		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.xfer_mask	= ata_pack_xfermask(0x1f, 0x07, 0x7f),
+				  /* pio0-4, mwdma0-2, udma0-6 ; FIXME */
 		.port_ops	= &pdc_20621_ops,
 	},
 
@@ -1433,9 +1432,7 @@ static int pdc_sata_init_one (struct pci
 
 	probe_ent->sht		= pdc_port_info[board_idx].sht;
 	probe_ent->host_flags	= pdc_port_info[board_idx].host_flags;
-	probe_ent->pio_mask	= pdc_port_info[board_idx].pio_mask;
-	probe_ent->mwdma_mask	= pdc_port_info[board_idx].mwdma_mask;
-	probe_ent->udma_mask	= pdc_port_info[board_idx].udma_mask;
+	probe_ent->xfer_mask	= pdc_port_info[board_idx].xfer_mask;
 	probe_ent->port_ops	= pdc_port_info[board_idx].port_ops;
 
        	probe_ent->irq = pdev->irq;
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
index 37a487b..e8286e3 100644
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -124,8 +124,7 @@ static struct ata_port_info uli_port_inf
 	.sht            = &uli_sht,
 	.host_flags     = ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
 			  ATA_FLAG_NO_LEGACY,
-	.pio_mask       = 0x1f,		/* pio0-4 */
-	.udma_mask      = 0x7f,		/* udma0-6 */
+	.xfer_mask	= ata_pack_xfermask(0x1f, 0, 0x7f), /* pio0-4, udma0-6 */
 	.port_ops       = &uli_ops,
 };
 
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index ff65a0b..707a9d9 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -143,9 +143,7 @@ static const struct ata_port_operations 
 static struct ata_port_info svia_port_info = {
 	.sht		= &svia_sht,
 	.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST | ATA_FLAG_NO_LEGACY,
-	.pio_mask	= 0x1f,
-	.mwdma_mask	= 0x07,
-	.udma_mask	= 0x7f,
+	.xfer_mask	= ata_pack_xfermask(0x1f, 0x07, 0x7f),
 	.port_ops	= &svia_sata_ops,
 };
 
@@ -243,9 +241,7 @@ static struct ata_probe_ent *vt6421_init
 	probe_ent->n_ports	= N_PORTS;
 	probe_ent->irq		= pdev->irq;
 	probe_ent->irq_flags	= SA_SHIRQ;
-	probe_ent->pio_mask	= 0x1f;
-	probe_ent->mwdma_mask	= 0x07;
-	probe_ent->udma_mask	= 0x7f;
+	probe_ent->xfer_mask	= ata_pack_xfermask(0x1f, 0x07, 0x7f);
 
 	for (i = 0; i < N_PORTS; i++)
 		vt6421_init_addrs(probe_ent, pdev, i);
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index e124db8..55865fd 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -357,9 +357,7 @@ static int __devinit vsc_sata_init_one (
 	/* We don't care much about the PIO/UDMA masks, but the core won't like us
 	 * if we don't fill these
 	 */
-	probe_ent->pio_mask = 0x1f;
-	probe_ent->mwdma_mask = 0x07;
-	probe_ent->udma_mask = 0x7f;
+	probe_ent->xfer_mask = ata_pack_xfermask(0x1f, 0x07, 0x7f);
 
 	/* We have 4 ports per PCI function */
 	vsc_sata_setup_port(&probe_ent->port[0], base + 1 * VSC_SATA_PORT_OFFSET);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e0ffca4..d2c04ab 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -272,9 +272,7 @@ struct ata_probe_ent {
 	struct ata_ioports	port[ATA_MAX_PORTS];
 	unsigned int		n_ports;
 	unsigned int		hard_port_no;
-	unsigned int		pio_mask;
-	unsigned int		mwdma_mask;
-	unsigned int		udma_mask;
+	unsigned int		xfer_mask;
 	unsigned int		legacy_mode;
 	unsigned long		irq;
 	unsigned int		irq_flags;
@@ -453,9 +451,7 @@ struct ata_port_operations {
 struct ata_port_info {
 	struct scsi_host_template	*sht;
 	unsigned long		host_flags;
-	unsigned long		pio_mask;
-	unsigned long		mwdma_mask;
-	unsigned long		udma_mask;
+	unsigned int		xfer_mask;
 	const struct ata_port_operations *port_ops;
 	void 			*private_data;
 };
-- 
1.1.5


