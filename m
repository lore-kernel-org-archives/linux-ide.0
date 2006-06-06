From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: add ata_port->private_flags
Date: Tue, 6 Jun 2006 22:29:53 +0900
Message-ID: <20060606132953.GF8106@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.203]:6250 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932162AbWFFNaA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Jun 2006 09:30:00 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1546211nze
        for <linux-ide@vger.kernel.org>; Tue, 06 Jun 2006 06:29:59 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Add ap->private_flags and convert all in-kernel LLDs which use private
flags to use the field instead of high 8 bits of ap->host_flags, which
is fully occupied without this patch.  This patch also modifies
ata_host_init() such that unconverted LLDs trigger WARN_ON.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

Jeff, this patch is on top of the current upstream(ef2824073f...)  +
hotplug patchsets + ata_piix-fix-ghost-device-probing patch, and
available in the following git tree tagged fj-ap-private_flags.

git://htj.dyndns.org/libata-tj for-jeff

Thanks.

 drivers/scsi/ahci.c         |   11 ++++++-----
 drivers/scsi/ata_piix.c     |   45 +++++++++++++++++++++++++------------------
 drivers/scsi/libata-bmdma.c |    1 +
 drivers/scsi/libata-core.c  |    3 +++
 drivers/scsi/sata_mv.c      |   39 ++++++++++++++++++++++---------------
 drivers/scsi/sata_sil.c     |   25 +++++++++++++++---------
 drivers/scsi/sata_sil24.c   |   28 ++++++++++++++++-----------
 drivers/scsi/sata_sis.c     |   14 +++++++------
 include/linux/libata.h      |    7 +++++--
 9 files changed, 104 insertions(+), 69 deletions(-)

515797c7ad416af9126cfbee104f382ec8b85370
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index e261b37..5cf9946 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -162,8 +162,8 @@ enum {
 	/* hpriv->flags bits */
 	AHCI_FLAG_MSI		= (1 << 0),
 
-	/* ap->flags bits */
-	AHCI_FLAG_RESET_NEEDS_CLO	= (1 << 24),
+	/* ap->private_flags bits */
+	AHCI_FLAG_RESET_NEEDS_CLO	= (1 << 0),
 };
 
 struct ahci_cmd_hdr {
@@ -276,8 +276,8 @@ static const struct ata_port_info ahci_p
 		.sht		= &ahci_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  ATA_FLAG_SKIP_D2H_BSY |
-				  AHCI_FLAG_RESET_NEEDS_CLO,
+				  ATA_FLAG_SKIP_D2H_BSY,
+		.hpriv_flags	= AHCI_FLAG_RESET_NEEDS_CLO,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,
@@ -571,7 +571,7 @@ static int ahci_clo(struct ata_port *ap)
 
 static int ahci_prereset(struct ata_port *ap)
 {
-	if ((ap->flags & AHCI_FLAG_RESET_NEEDS_CLO) &&
+	if ((ap->private_flags & AHCI_FLAG_RESET_NEEDS_CLO) &&
 	    (ata_busy_wait(ap, ATA_BUSY, 1000) & ATA_BUSY)) {
 		/* ATA_BUSY hasn't cleared, so send a CLO */
 		ahci_clo(ap);
@@ -1341,6 +1341,7 @@ static int ahci_init_one (struct pci_dev
 
 	probe_ent->sht		= ahci_port_info[board_idx].sht;
 	probe_ent->host_flags	= ahci_port_info[board_idx].host_flags;
+	probe_ent->hpriv_flags	= ahci_port_info[board_idx].hpriv_flags;
 	probe_ent->pio_mask	= ahci_port_info[board_idx].pio_mask;
 	probe_ent->udma_mask	= ahci_port_info[board_idx].udma_mask;
 	probe_ent->port_ops	= ahci_port_info[board_idx].port_ops;
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index c8fdad5..f15bd2f 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -101,13 +101,13 @@ enum {
 	ICH5_PCS		= 0x92,	/* port control and status */
 	PIIX_SCC		= 0x0A, /* sub-class code register */
 
-	PIIX_FLAG_IGNORE_PCS	= (1 << 25), /* ignore PCS present bits */
-	PIIX_FLAG_SCR		= (1 << 26), /* SCR available */
-	PIIX_FLAG_AHCI		= (1 << 27), /* AHCI possible */
-	PIIX_FLAG_CHECKINTR	= (1 << 28), /* make sure PCI INTx enabled */
-	PIIX_FLAG_COMBINED	= (1 << 29), /* combined mode possible */
+	PIIX_FLAG_IGNORE_PCS	= (1 << 0), /* ignore PCS present bits */
+	PIIX_FLAG_SCR		= (1 << 1), /* SCR available */
+	PIIX_FLAG_AHCI		= (1 << 2), /* AHCI possible */
+	PIIX_FLAG_CHECKINTR	= (1 << 3), /* make sure PCI INTx enabled */
+	PIIX_FLAG_COMBINED	= (1 << 4), /* combined mode possible */
 	/* ICH6/7 use different scheme for map value */
-	PIIX_FLAG_COMBINED_ICH6	= PIIX_FLAG_COMBINED | (1 << 30),
+	PIIX_FLAG_COMBINED_ICH6	= PIIX_FLAG_COMBINED | (1 << 5),
 
 	/* combined mode.  if set, PATA is channel 0.
 	 * if clear, PATA is channel 1.
@@ -342,7 +342,8 @@ #endif
 	/* ich5_pata */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SLAVE_POSS | PIIX_FLAG_CHECKINTR,
+		.host_flags	= ATA_FLAG_SLAVE_POSS,
+		.hpriv_flags	= PIIX_FLAG_CHECKINTR,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 #if 0
 		.mwdma_mask	= 0x06, /* mwdma1-2 */
@@ -356,8 +357,8 @@ #endif
 	/* ich5_sata */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED |
-				  PIIX_FLAG_CHECKINTR,
+		.host_flags	= ATA_FLAG_SATA,
+		.hpriv_flags	= PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
@@ -368,8 +369,9 @@ #endif
 	/* i6300esb_sata */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED |
-				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_IGNORE_PCS,
+		.host_flags	= ATA_FLAG_SATA,
+		.hpriv_flags	= PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR |
+				  PIIX_FLAG_IGNORE_PCS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
@@ -380,7 +382,8 @@ #endif
 	/* ich6_sata */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED_ICH6 |
+		.host_flags	= ATA_FLAG_SATA,
+		.hpriv_flags	= PIIX_FLAG_COMBINED_ICH6 |
 				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -392,7 +395,8 @@ #endif
 	/* ich6_sata_ahci */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED_ICH6 |
+		.host_flags	= ATA_FLAG_SATA,
+		.hpriv_flags	= PIIX_FLAG_COMBINED_ICH6 |
 				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR |
 				  PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
@@ -405,7 +409,8 @@ #endif
 	/* ich6m_sata_ahci */
 	{
 		.sht		= &piix_sht,
-		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_COMBINED_ICH6 |
+		.host_flags	= ATA_FLAG_SATA,
+		.hpriv_flags	= PIIX_FLAG_COMBINED_ICH6 |
 				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR |
 				  PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
@@ -533,14 +538,15 @@ static unsigned int piix_sata_present_ma
 		port = map[base + i];
 		if (port < 0)
 			continue;
-		if (ap->flags & PIIX_FLAG_IGNORE_PCS || pcs & 1 << (4 + port))
+		if ((ap->private_flags & PIIX_FLAG_IGNORE_PCS) ||
+		    (pcs & 1 << (4 + port)))
 			present_mask |= 1 << i;
 		else
 			pcs &= ~(1 << port);
 	}
 
 	/* disable offline ports on non-AHCI controllers */
-	if (!(ap->flags & PIIX_FLAG_AHCI))
+	if (!(ap->private_flags & PIIX_FLAG_AHCI))
 		pci_write_config_byte(pdev, ICH5_PCS, pcs);
 
 	DPRINTK("ata%u: LEAVE, pcs=0x%x present_mask=0x%x\n",
@@ -856,7 +862,7 @@ static int piix_init_one (struct pci_dev
 	static int printed_version;
 	struct ata_port_info port_info[2];
 	struct ata_port_info *ppinfo[2] = { &port_info[0], &port_info[1] };
-	unsigned long host_flags;
+	unsigned long host_flags, hpriv_flags;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev,
@@ -870,8 +876,9 @@ static int piix_init_one (struct pci_dev
 	port_info[1] = piix_port_info[ent->driver_data];
 
 	host_flags = port_info[0].host_flags;
+	hpriv_flags = port_info[0].hpriv_flags;
 
-	if (host_flags & PIIX_FLAG_AHCI) {
+	if (hpriv_flags & PIIX_FLAG_AHCI) {
 		u8 tmp;
 		pci_read_config_byte(pdev, PIIX_SCC, &tmp);
 		if (tmp == PIIX_AHCI_DEVICE) {
@@ -891,7 +898,7 @@ static int piix_init_one (struct pci_dev
 	 * MSI is disabled (and it is disabled, as we don't use
 	 * message-signalled interrupts currently).
 	 */
-	if (host_flags & PIIX_FLAG_CHECKINTR)
+	if (hpriv_flags & PIIX_FLAG_CHECKINTR)
 		pci_intx(pdev, 1);
 
 	if (piix_check_450nx_errata(pdev)) {
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index 4bc0537..c2c7fa2 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -816,6 +816,7 @@ ata_probe_ent_alloc(struct device *dev, 
 
 	probe_ent->sht = port->sht;
 	probe_ent->host_flags = port->host_flags;
+	probe_ent->hpriv_flags = port->hpriv_flags;
 	probe_ent->pio_mask = port->pio_mask;
 	probe_ent->mwdma_mask = port->mwdma_mask;
 	probe_ent->udma_mask = port->udma_mask;
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 40d1612..f874bfe 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5158,6 +5158,8 @@ static void ata_host_init(struct ata_por
 {
 	unsigned int i;
 
+	WARN_ON(ent->host_flags & ~ATA_FLAG_CAP_MASK);
+
 	host->max_id = 16;
 	host->max_lun = 1;
 	host->max_channel = 1;
@@ -5177,6 +5179,7 @@ static void ata_host_init(struct ata_por
 	ap->mwdma_mask = ent->mwdma_mask;
 	ap->udma_mask = ent->udma_mask;
 	ap->flags |= ent->host_flags;
+	ap->private_flags |= ent->hpriv_flags;
 	ap->ops = ent->port_ops;
 	ap->hw_sata_spd_limit = UINT_MAX;
 	ap->active_tag = ATA_TAG_POISON;
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 634bab1..523ce41 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -89,11 +89,13 @@ enum {
 	MV_PORT_MASK		= 3,
 
 	/* Host Flags */
-	MV_FLAG_DUAL_HC		= (1 << 30),  /* two SATA Host Controllers */
-	MV_FLAG_IRQ_COALESCE	= (1 << 29),  /* IRQ coalescing capability */
-	MV_COMMON_FLAGS		= (ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+	MV_HOST_FLAGS		= (ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				   ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
 				   ATA_FLAG_NO_ATAPI | ATA_FLAG_PIO_POLLING),
+
+	/* Private Flags */
+	MV_FLAG_DUAL_HC		= (1 << 0),  /* two SATA Host Controllers */
+	MV_FLAG_IRQ_COALESCE	= (1 << 1),  /* IRQ coalescing capability */
 	MV_6XXX_FLAGS		= MV_FLAG_IRQ_COALESCE,
 
 	CRQB_FLAG_READ		= (1 << 0),
@@ -480,51 +482,55 @@ static const struct ata_port_operations 
 static const struct ata_port_info mv_port_info[] = {
 	{  /* chip_504x */
 		.sht		= &mv_sht,
-		.host_flags	= MV_COMMON_FLAGS,
+		.host_flags	= MV_HOST_FLAGS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &mv5_ops,
 	},
 	{  /* chip_508x */
 		.sht		= &mv_sht,
-		.host_flags	= (MV_COMMON_FLAGS | MV_FLAG_DUAL_HC),
+		.host_flags	= MV_HOST_FLAGS,
+		.hpriv_flags	= MV_FLAG_DUAL_HC,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &mv5_ops,
 	},
 	{  /* chip_5080 */
 		.sht		= &mv_sht,
-		.host_flags	= (MV_COMMON_FLAGS | MV_FLAG_DUAL_HC),
+		.host_flags	= MV_HOST_FLAGS,
+		.hpriv_flags	= MV_FLAG_DUAL_HC,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &mv5_ops,
 	},
 	{  /* chip_604x */
 		.sht		= &mv_sht,
-		.host_flags	= (MV_COMMON_FLAGS | MV_6XXX_FLAGS),
+		.host_flags	= MV_HOST_FLAGS,
+		.hpriv_flags	= MV_6XXX_FLAGS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &mv6_ops,
 	},
 	{  /* chip_608x */
 		.sht		= &mv_sht,
-		.host_flags	= (MV_COMMON_FLAGS | MV_6XXX_FLAGS |
-				   MV_FLAG_DUAL_HC),
+		.host_flags	= MV_HOST_FLAGS,
+		.hpriv_flags	= MV_6XXX_FLAGS | MV_FLAG_DUAL_HC,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &mv6_ops,
 	},
 	{  /* chip_6042 */
 		.sht		= &mv_sht,
-		.host_flags	= (MV_COMMON_FLAGS | MV_6XXX_FLAGS),
+		.host_flags	= MV_HOST_FLAGS,
+		.hpriv_flags	= MV_6XXX_FLAGS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &mv_iie_ops,
 	},
 	{  /* chip_7042 */
 		.sht		= &mv_sht,
-		.host_flags	= (MV_COMMON_FLAGS | MV_6XXX_FLAGS |
-				   MV_FLAG_DUAL_HC),
+		.host_flags	= MV_HOST_FLAGS,
+		.hpriv_flags	= MV_6XXX_FLAGS | MV_FLAG_DUAL_HC,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &mv_iie_ops,
@@ -621,9 +627,9 @@ static inline void __iomem *mv_ap_base(s
 	return mv_port_base(ap->host_set->mmio_base, ap->port_no);
 }
 
-static inline int mv_get_hc_count(unsigned long host_flags)
+static inline int mv_get_hc_count(unsigned long private_flags)
 {
-	return ((host_flags & MV_FLAG_DUAL_HC) ? 2 : 1);
+	return ((private_flags & MV_FLAG_DUAL_HC) ? 2 : 1);
 }
 
 static void mv_irq_clear(struct ata_port *ap)
@@ -1465,7 +1471,7 @@ static irqreturn_t mv_interrupt(int irq,
 		return IRQ_NONE;
 	}
 
-	n_hcs = mv_get_hc_count(host_set->ports[0]->flags);
+	n_hcs = mv_get_hc_count(host_set->ports[0]->private_flags);
 	spin_lock(&host_set->lock);
 
 	for (hc = 0; hc < n_hcs; hc++) {
@@ -2233,7 +2239,7 @@ static int mv_init_host(struct pci_dev *
 	if (rc)
 		goto done;
 
-	n_hc = mv_get_hc_count(probe_ent->host_flags);
+	n_hc = mv_get_hc_count(probe_ent->hpriv_flags);
 	probe_ent->n_ports = MV_PORTS_PER_HC * n_hc;
 
 	for (port = 0; port < probe_ent->n_ports; port++)
@@ -2387,6 +2393,7 @@ static int mv_init_one(struct pci_dev *p
 
 	probe_ent->sht = mv_port_info[board_idx].sht;
 	probe_ent->host_flags = mv_port_info[board_idx].host_flags;
+	probe_ent->hpriv_flags = mv_port_info[board_idx].hpriv_flags;
 	probe_ent->pio_mask = mv_port_info[board_idx].pio_mask;
 	probe_ent->udma_mask = mv_port_info[board_idx].udma_mask;
 	probe_ent->port_ops = mv_port_info[board_idx].port_ops;
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 0898cbe..7444e2e 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -52,13 +52,16 @@ enum {
 	/*
 	 * host flags
 	 */
-	SIL_FLAG_RERR_ON_DMA_ACT = (1 << 29),
-	SIL_FLAG_MOD15WRITE	= (1 << 30),
-
-	SIL_DFL_HOST_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+	SIL_HOST_FLAGS		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_HRST_TO_RESUME,
 
 	/*
+	 * private flags
+	 */
+	SIL_FLAG_RERR_ON_DMA_ACT = (1 << 0),
+	SIL_FLAG_MOD15WRITE	= (1 << 1),
+
+	/*
 	 * Controller IDs
 	 */
 	sil_3112		= 0,
@@ -211,7 +214,8 @@ static const struct ata_port_info sil_po
 	/* sil_3112 */
 	{
 		.sht		= &sil_sht,
-		.host_flags	= SIL_DFL_HOST_FLAGS | SIL_FLAG_MOD15WRITE,
+		.host_flags	= SIL_HOST_FLAGS,
+		.hpriv_flags	= SIL_FLAG_MOD15WRITE,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -220,7 +224,8 @@ static const struct ata_port_info sil_po
 	/* sil_3512 */
 	{
 		.sht		= &sil_sht,
-		.host_flags	= SIL_DFL_HOST_FLAGS | SIL_FLAG_RERR_ON_DMA_ACT,
+		.host_flags	= SIL_HOST_FLAGS,
+		.hpriv_flags	= SIL_FLAG_RERR_ON_DMA_ACT,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -229,7 +234,8 @@ static const struct ata_port_info sil_po
 	/* sil_3114 */
 	{
 		.sht		= &sil_sht,
-		.host_flags	= SIL_DFL_HOST_FLAGS | SIL_FLAG_RERR_ON_DMA_ACT,
+		.host_flags	= SIL_HOST_FLAGS,
+		.hpriv_flags	= SIL_FLAG_RERR_ON_DMA_ACT,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -508,7 +514,7 @@ static void sil_dev_config(struct ata_po
 
 	/* limit requests to 15 sectors */
 	if (slow_down ||
-	    ((ap->flags & SIL_FLAG_MOD15WRITE) &&
+	    ((ap->private_flags & SIL_FLAG_MOD15WRITE) &&
 	     (quirks & SIL_QUIRK_MOD15WRITE))) {
 		ata_dev_printk(dev, KERN_INFO, "applying Seagate errata fix "
 			       "(mod15write workaround)\n");
@@ -574,6 +580,7 @@ static int sil_init_one (struct pci_dev 
        	probe_ent->irq = pdev->irq;
        	probe_ent->irq_flags = SA_SHIRQ;
 	probe_ent->host_flags = sil_port_info[ent->driver_data].host_flags;
+	probe_ent->hpriv_flags = sil_port_info[ent->driver_data].hpriv_flags;
 
 	mmio_base = pci_iomap(pdev, 5, 0);
 	if (mmio_base == NULL) {
@@ -607,7 +614,7 @@ static int sil_init_one (struct pci_dev 
 			   "cache line size not set.  Driver may not function\n");
 
 	/* Apply R_ERR on DMA activate FIS errata workaround */
-	if (probe_ent->host_flags & SIL_FLAG_RERR_ON_DMA_ACT) {
+	if (probe_ent->hpriv_flags & SIL_FLAG_RERR_ON_DMA_ACT) {
 		int cnt;
 
 		for (i = 0, cnt = 0; i < probe_ent->n_ports; i++) {
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 97e9339..477761a 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -227,10 +227,12 @@ enum {
 	BID_SIL3131		= 2,
 
 	/* host flags */
-	SIL24_COMMON_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+	SIL24_HOST_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
 				  ATA_FLAG_NCQ | ATA_FLAG_SKIP_D2H_BSY,
-	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 24), /* IRQ loss errata on PCI-X */
+
+	/* private flags */
+	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 0), /* IRQ loss errata on PCI-X */
 
 	IRQ_STAT_4PORTS		= 0xf,
 };
@@ -405,7 +407,7 @@ static const struct ata_port_operations 
 };
 
 /*
- * Use bits 30-31 of host_flags to encode available port numbers.
+ * Use bits 30-31 of private_flags to encode available port numbers.
  * Current maxium is 4.
  */
 #define SIL24_NPORTS2FLAG(nports)	((((unsigned)(nports) - 1) & 0x3) << 30)
@@ -415,7 +417,8 @@ static struct ata_port_info sil24_port_i
 	/* sil_3124 */
 	{
 		.sht		= &sil24_sht,
-		.host_flags	= SIL24_COMMON_FLAGS | SIL24_NPORTS2FLAG(4) |
+		.host_flags	= SIL24_HOST_FLAGS,
+		.hpriv_flags	= SIL24_NPORTS2FLAG(4) |
 				  SIL24_FLAG_PCIX_IRQ_WOC,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
@@ -425,7 +428,8 @@ static struct ata_port_info sil24_port_i
 	/* sil_3132 */
 	{
 		.sht		= &sil24_sht,
-		.host_flags	= SIL24_COMMON_FLAGS | SIL24_NPORTS2FLAG(2),
+		.host_flags	= SIL24_HOST_FLAGS,
+		.hpriv_flags	= SIL24_NPORTS2FLAG(2),
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -434,7 +438,8 @@ static struct ata_port_info sil24_port_i
 	/* sil_3131/sil_3531 */
 	{
 		.sht		= &sil24_sht,
-		.host_flags	= SIL24_COMMON_FLAGS | SIL24_NPORTS2FLAG(1),
+		.host_flags	= SIL24_HOST_FLAGS,
+		.hpriv_flags	= SIL24_NPORTS2FLAG(1),
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -838,7 +843,7 @@ static inline void sil24_host_intr(struc
 		return;
 	}
 
-	if (ap->flags & SIL24_FLAG_PCIX_IRQ_WOC)
+	if (ap->private_flags & SIL24_FLAG_PCIX_IRQ_WOC)
 		writel(PORT_IRQ_COMPLETE, port + PORT_IRQ_STAT);
 
 	qc_active = slot_stat & ~HOST_SSTAT_ATTN;
@@ -1034,11 +1039,12 @@ static int sil24_init_one(struct pci_dev
 
 	probe_ent->sht		= pinfo->sht;
 	probe_ent->host_flags	= pinfo->host_flags;
+	probe_ent->hpriv_flags	= pinfo->hpriv_flags;
 	probe_ent->pio_mask	= pinfo->pio_mask;
 	probe_ent->mwdma_mask	= pinfo->mwdma_mask;
 	probe_ent->udma_mask	= pinfo->udma_mask;
 	probe_ent->port_ops	= pinfo->port_ops;
-	probe_ent->n_ports	= SIL24_FLAG2NPORTS(pinfo->host_flags);
+	probe_ent->n_ports	= SIL24_FLAG2NPORTS(pinfo->hpriv_flags);
 
 	probe_ent->irq = pdev->irq;
 	probe_ent->irq_flags = SA_SHIRQ;
@@ -1080,14 +1086,14 @@ static int sil24_init_one(struct pci_dev
 	writel(0, host_base + HOST_FLASH_CMD);
 
 	/* Apply workaround for completion IRQ loss on PCI-X errata */
-	if (probe_ent->host_flags & SIL24_FLAG_PCIX_IRQ_WOC) {
+	if (probe_ent->hpriv_flags & SIL24_FLAG_PCIX_IRQ_WOC) {
 		tmp = readl(host_base + HOST_CTRL);
 		if (tmp & (HOST_CTRL_TRDY | HOST_CTRL_STOP | HOST_CTRL_DEVSEL))
 			dev_printk(KERN_INFO, &pdev->dev,
 				   "Applying completion IRQ loss on PCI-X "
 				   "errata fix\n");
 		else
-			probe_ent->host_flags &= ~SIL24_FLAG_PCIX_IRQ_WOC;
+			probe_ent->hpriv_flags &= ~SIL24_FLAG_PCIX_IRQ_WOC;
 	}
 
 	/* clear global reset & mask interrupts during initialization */
@@ -1118,7 +1124,7 @@ static int sil24_init_one(struct pci_dev
 		}
 
 		/* Configure IRQ WoC */
-		if (probe_ent->host_flags & SIL24_FLAG_PCIX_IRQ_WOC)
+		if (probe_ent->hpriv_flags & SIL24_FLAG_PCIX_IRQ_WOC)
 			writel(PORT_CS_IRQ_WOC, port + PORT_CTRL_STAT);
 		else
 			writel(PORT_CS_IRQ_WOC, port + PORT_CTRL_CLR);
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
index a07e6e5..bd2408b 100644
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -58,7 +58,7 @@ enum {
 	SIS_PMR_COMBINED	= 0x30,
 
 	/* random bits */
-	SIS_FLAG_CFGSCR		= (1 << 30), /* host flag: SCRs via PCI cfg */
+	SIS_FLAG_CFGSCR		= (1 << 0), /* hpriv flag: SCRs via PCI cfg */
 
 	GENCTL_IOMAPPED_SCR	= (1 << 26), /* if set, SCRs are in IO space */
 };
@@ -202,7 +202,7 @@ static u32 sis_scr_read (struct ata_port
 	if (sc_reg > SCR_CONTROL)
 		return 0xffffffffU;
 
-	if (ap->flags & SIS_FLAG_CFGSCR)
+	if (ap->private_flags & SIS_FLAG_CFGSCR)
 		return sis_scr_cfg_read(ap, sc_reg);
 
 	pci_read_config_byte(pdev, SIS_PMR, &pmr);
@@ -225,7 +225,7 @@ static void sis_scr_write (struct ata_po
 
 	pci_read_config_byte(pdev, SIS_PMR, &pmr);
 
-	if (ap->flags & SIS_FLAG_CFGSCR)
+	if (ap->private_flags & SIS_FLAG_CFGSCR)
 		sis_scr_cfg_write(ap, sc_reg, val);
 	else {
 		outl(val, ap->ioaddr.scr_addr + (sc_reg * 4));
@@ -275,17 +275,17 @@ static int sis_init_one (struct pci_dev 
 	/* check and see if the SCRs are in IO space or PCI cfg space */
 	pci_read_config_dword(pdev, SIS_GENCTL, &genctl);
 	if ((genctl & GENCTL_IOMAPPED_SCR) == 0)
-		probe_ent->host_flags |= SIS_FLAG_CFGSCR;
+		probe_ent->hpriv_flags |= SIS_FLAG_CFGSCR;
 
 	/* if hardware thinks SCRs are in IO space, but there are
 	 * no IO resources assigned, change to PCI cfg space.
 	 */
-	if ((!(probe_ent->host_flags & SIS_FLAG_CFGSCR)) &&
+	if ((!(probe_ent->hpriv_flags & SIS_FLAG_CFGSCR)) &&
 	    ((pci_resource_start(pdev, SIS_SCR_PCI_BAR) == 0) ||
 	     (pci_resource_len(pdev, SIS_SCR_PCI_BAR) < 128))) {
 		genctl &= ~GENCTL_IOMAPPED_SCR;
 		pci_write_config_dword(pdev, SIS_GENCTL, genctl);
-		probe_ent->host_flags |= SIS_FLAG_CFGSCR;
+		probe_ent->hpriv_flags |= SIS_FLAG_CFGSCR;
 	}
 
 	pci_read_config_byte(pdev, SIS_PMR, &pmr);
@@ -306,7 +306,7 @@ static int sis_init_one (struct pci_dev 
 		port2_start = 0x20;
 	}
 
-	if (!(probe_ent->host_flags & SIS_FLAG_CFGSCR)) {
+	if (!(probe_ent->hpriv_flags & SIS_FLAG_CFGSCR)) {
 		probe_ent->port[0].scr_addr =
 			pci_resource_start(pdev, SIS_SCR_PCI_BAR);
 		probe_ent->port[1].scr_addr =
diff --git a/include/linux/libata.h b/include/linux/libata.h
index a2a33a9..437061e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -160,6 +160,8 @@ enum {
 	ATA_FLAG_SKIP_D2H_BSY	= (1 << 12), /* can't wait for the first D2H
 					      * Register FIS clearing BSY */
 
+	ATA_FLAG_CAP_MASK	= (1 << 13) - 1, /* capability flag mask */
+
 	ATA_FLAG_DEBUGMSG	= (1 << 13),
 	ATA_FLAG_FLUSH_PORT_TASK = (1 << 14), /* flush port task */
 
@@ -174,8 +176,6 @@ enum {
 	ATA_FLAG_DISABLED	= (1 << 22), /* port is disabled, ignore it */
 	ATA_FLAG_SUSPENDED	= (1 << 23), /* port is suspended (power) */
 
-	/* bits 24:31 of ap->flags are reserved for LLDD specific flags */
-
 	/* struct ata_queued_cmd flags */
 	ATA_QCFLAG_ACTIVE	= (1 << 0), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 1), /* have s/g table? */
@@ -340,6 +340,7 @@ struct ata_probe_ent {
 	unsigned long		irq;
 	unsigned int		irq_flags;
 	unsigned long		host_flags;
+	unsigned long		hpriv_flags;
 	unsigned long		host_set_flags;
 	void __iomem		*mmio_base;
 	void			*private_data;
@@ -528,6 +529,7 @@ struct ata_port {
 	struct list_head	eh_done_q;
 	wait_queue_head_t	eh_wait_q;
 
+	unsigned long		private_flags;	/* LLD specific flags */
 	void			*private_data;
 
 	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
@@ -594,6 +596,7 @@ struct ata_port_operations {
 struct ata_port_info {
 	struct scsi_host_template	*sht;
 	unsigned long		host_flags;
+	unsigned long		hpriv_flags;
 	unsigned long		pio_mask;
 	unsigned long		mwdma_mask;
 	unsigned long		udma_mask;
-- 
1.3.2

