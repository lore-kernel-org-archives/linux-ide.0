From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/14] libata-link: make two port flags HRST_TO_RESUME and SKIP_D2H_BSY link flags
Date: Mon, 16 Jul 2007 18:34:39 +0900
Message-ID: <11845784793405-git-send-email-htejun@gmail.com>
References: <11845784783033-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:64330 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754836AbXGPJeu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 05:34:50 -0400
Received: by py-out-1112.google.com with SMTP id d32so2168488pye
        for <linux-ide@vger.kernel.org>; Mon, 16 Jul 2007 02:34:49 -0700 (PDT)
In-Reply-To: <11845784783033-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

HRST_TO_RESUME and SKIP_D2H_BSY are link attributes.  Move them to
ata_link->flags.  This will allow host and PMP links to have different
attributes.  ata_port_info->link_flags is added and used by LLDs to
specify these flags during initialization.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c        |   16 ++++++++++------
 drivers/ata/libata-core.c |    5 +++--
 drivers/ata/sata_nv.c     |   14 +++++++-------
 drivers/ata/sata_sil.c    |    7 ++++++-
 drivers/ata/sata_sil24.c  |    7 +++++--
 include/linux/libata.h    |   11 ++++++++---
 6 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 0497fc2..8c1cad9 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -178,8 +178,8 @@ enum {
 
 	AHCI_FLAG_COMMON		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 					  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-					  ATA_FLAG_SKIP_D2H_BSY |
 					  ATA_FLAG_ACPI_SATA,
+	AHCI_LFLAG_COMMON		= ATA_LFLAG_SKIP_D2H_BSY,
 };
 
 struct ahci_cmd_hdr {
@@ -333,6 +333,7 @@ static const struct ata_port_info ahci_port_info[] = {
 	/* board_ahci */
 	{
 		.flags		= AHCI_FLAG_COMMON,
+		.link_flags	= AHCI_LFLAG_COMMON,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
@@ -340,14 +341,15 @@ static const struct ata_port_info ahci_port_info[] = {
 	/* board_ahci_pi */
 	{
 		.flags		= AHCI_FLAG_COMMON | AHCI_FLAG_HONOR_PI,
+		.link_flags	= AHCI_LFLAG_COMMON,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
 	/* board_ahci_vt8251 */
 	{
-		.flags		= AHCI_FLAG_COMMON | ATA_FLAG_HRST_TO_RESUME |
-				  AHCI_FLAG_NO_NCQ,
+		.flags		= AHCI_FLAG_COMMON | AHCI_FLAG_NO_NCQ,
+		.link_flags	= AHCI_LFLAG_COMMON | ATA_LFLAG_HRST_TO_RESUME,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_vt8251_ops,
@@ -355,6 +357,7 @@ static const struct ata_port_info ahci_port_info[] = {
 	/* board_ahci_ign_iferr */
 	{
 		.flags		= AHCI_FLAG_COMMON | AHCI_FLAG_IGN_IRQ_IF_ERR,
+		.link_flags	= AHCI_LFLAG_COMMON,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
@@ -364,6 +367,7 @@ static const struct ata_port_info ahci_port_info[] = {
 		.flags		= AHCI_FLAG_COMMON |
 				  AHCI_FLAG_IGN_SERR_INTERNAL |
 				  AHCI_FLAG_32BIT_ONLY,
+		.link_flags	= AHCI_LFLAG_COMMON,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
@@ -373,9 +377,9 @@ static const struct ata_port_info ahci_port_info[] = {
 		.sht		= &ahci_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  ATA_FLAG_SKIP_D2H_BSY | AHCI_FLAG_HONOR_PI |
-				  AHCI_FLAG_NO_NCQ | AHCI_FLAG_NO_MSI |
-				  AHCI_FLAG_MV_PATA,
+				  AHCI_FLAG_HONOR_PI | AHCI_FLAG_NO_NCQ |
+				  AHCI_FLAG_NO_MSI | AHCI_FLAG_MV_PATA,
+		.link_flags	= AHCI_LFLAG_COMMON,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d4e29b9..f580903 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3331,7 +3331,7 @@ int ata_std_prereset(struct ata_link *link, unsigned long deadline)
 
 	/* handle link resume */
 	if ((ehc->i.flags & ATA_EHI_RESUME_LINK) &&
-	    (ap->flags & ATA_FLAG_HRST_TO_RESUME))
+	    (link->flags & ATA_LFLAG_HRST_TO_RESUME))
 		ehc->i.action |= ATA_EH_HARDRESET;
 
 	/* if we're about to do hardreset, nothing more to do */
@@ -3350,7 +3350,7 @@ int ata_std_prereset(struct ata_link *link, unsigned long deadline)
 	/* Wait for !BSY if the controller can wait for the first D2H
 	 * Reg FIS and we don't know that no device is attached.
 	 */
-	if (!(ap->flags & ATA_FLAG_SKIP_D2H_BSY) && !ata_link_offline(link)) {
+	if (!(link->flags & ATA_LFLAG_SKIP_D2H_BSY) && !ata_link_offline(link)) {
 		rc = ata_wait_ready(ap, deadline);
 		if (rc && rc != -ENODEV) {
 			ata_link_printk(link, KERN_WARNING, "device not ready "
@@ -6247,6 +6247,7 @@ struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 		ap->mwdma_mask = pi->mwdma_mask;
 		ap->udma_mask = pi->udma_mask;
 		ap->flags |= pi->flags;
+		ap->link.flags |= pi->link_flags;
 		ap->ops = pi->port_ops;
 
 		if (!host->ops && (pi->port_ops != &ata_dummy_port_ops))
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 7b7d14c..1f71946 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -455,8 +455,8 @@ static const struct ata_port_info nv_port_info[] = {
 	/* generic */
 	{
 		.sht		= &nv_sht,
-		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_HRST_TO_RESUME,
+		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
+		.link_flags	= ATA_LFLAG_HRST_TO_RESUME,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
@@ -466,8 +466,8 @@ static const struct ata_port_info nv_port_info[] = {
 	/* nforce2/3 */
 	{
 		.sht		= &nv_sht,
-		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_HRST_TO_RESUME,
+		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
+		.link_flags	= ATA_LFLAG_HRST_TO_RESUME,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
@@ -477,8 +477,8 @@ static const struct ata_port_info nv_port_info[] = {
 	/* ck804 */
 	{
 		.sht		= &nv_sht,
-		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_HRST_TO_RESUME,
+		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
+		.link_flags	= ATA_LFLAG_HRST_TO_RESUME,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
@@ -489,8 +489,8 @@ static const struct ata_port_info nv_port_info[] = {
 	{
 		.sht		= &nv_adma_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_HRST_TO_RESUME |
 				  ATA_FLAG_MMIO | ATA_FLAG_NCQ,
+		.link_flags	= ATA_LFLAG_HRST_TO_RESUME,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 4b2ebc5..78f01aa 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -59,7 +59,8 @@ enum {
 	SIL_FLAG_MOD15WRITE	= (1 << 30),
 
 	SIL_DFL_PORT_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO | ATA_FLAG_HRST_TO_RESUME,
+				  ATA_FLAG_MMIO,
+	SIL_DFL_LINK_FLAGS	= ATA_LFLAG_HRST_TO_RESUME,
 
 	/*
 	 * Controller IDs
@@ -216,6 +217,7 @@ static const struct ata_port_info sil_port_info[] = {
 	/* sil_3112 */
 	{
 		.flags		= SIL_DFL_PORT_FLAGS | SIL_FLAG_MOD15WRITE,
+		.link_flags	= SIL_DFL_LINK_FLAGS,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= ATA_UDMA5,
@@ -225,6 +227,7 @@ static const struct ata_port_info sil_port_info[] = {
 	{
 		.flags		= SIL_DFL_PORT_FLAGS | SIL_FLAG_MOD15WRITE |
 				  SIL_FLAG_NO_SATA_IRQ,
+		.link_flags	= SIL_DFL_LINK_FLAGS,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= ATA_UDMA5,
@@ -233,6 +236,7 @@ static const struct ata_port_info sil_port_info[] = {
 	/* sil_3512 */
 	{
 		.flags		= SIL_DFL_PORT_FLAGS | SIL_FLAG_RERR_ON_DMA_ACT,
+		.link_flags	= SIL_DFL_LINK_FLAGS,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= ATA_UDMA5,
@@ -241,6 +245,7 @@ static const struct ata_port_info sil_port_info[] = {
 	/* sil_3114 */
 	{
 		.flags		= SIL_DFL_PORT_FLAGS | SIL_FLAG_RERR_ON_DMA_ACT,
+		.link_flags	= SIL_DFL_LINK_FLAGS,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= ATA_UDMA5,
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index a1f3b31..8d89053 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -237,8 +237,8 @@ enum {
 	/* host flags */
 	SIL24_COMMON_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  ATA_FLAG_NCQ | ATA_FLAG_SKIP_D2H_BSY |
-				  ATA_FLAG_ACPI_SATA,
+				  ATA_FLAG_NCQ | ATA_FLAG_ACPI_SATA,
+	SIL24_COMMON_LFLAGS	= ATA_LFLAG_SKIP_D2H_BSY,
 	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 24), /* IRQ loss errata on PCI-X */
 
 	IRQ_STAT_4PORTS		= 0xf,
@@ -424,6 +424,7 @@ static const struct ata_port_info sil24_port_info[] = {
 	{
 		.flags		= SIL24_COMMON_FLAGS | SIL24_NPORTS2FLAG(4) |
 				  SIL24_FLAG_PCIX_IRQ_WOC,
+		.link_flags	= SIL24_COMMON_LFLAGS,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= ATA_UDMA5,		/* udma0-5 */
@@ -432,6 +433,7 @@ static const struct ata_port_info sil24_port_info[] = {
 	/* sil_3132 */
 	{
 		.flags		= SIL24_COMMON_FLAGS | SIL24_NPORTS2FLAG(2),
+		.link_flags	= SIL24_COMMON_LFLAGS,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= ATA_UDMA5,		/* udma0-5 */
@@ -440,6 +442,7 @@ static const struct ata_port_info sil24_port_info[] = {
 	/* sil_3131/sil_3531 */
 	{
 		.flags		= SIL24_COMMON_FLAGS | SIL24_NPORTS2FLAG(1),
+		.link_flags	= SIL24_COMMON_LFLAGS,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= ATA_UDMA5,		/* udma0-5 */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9d6ef5b..b2de9ed 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -156,6 +156,11 @@ enum {
 	ATA_DEV_ATAPI_UNSUP	= 4,	/* ATAPI device (unsupported) */
 	ATA_DEV_NONE		= 5,	/* no device */
 
+	/* struct ata_link flags */
+	ATA_LFLAG_HRST_TO_RESUME = (1 << 0), /* hardreset to resume link */
+	ATA_LFLAG_SKIP_D2H_BSY	= (1 << 1), /* can't wait for the first D2H
+					     * Register FIS clearing BSY */
+
 	/* struct ata_port flags */
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
 					    /* (doesn't imply presence) */
@@ -170,9 +175,6 @@ enum {
 	ATA_FLAG_PIO_POLLING	= (1 << 9), /* use polling PIO if LLD
 					     * doesn't handle PIO interrupts */
 	ATA_FLAG_NCQ		= (1 << 10), /* host supports NCQ */
-	ATA_FLAG_HRST_TO_RESUME	= (1 << 11), /* hardreset to resume phy */
-	ATA_FLAG_SKIP_D2H_BSY	= (1 << 12), /* can't wait for the first D2H
-					      * Register FIS clearing BSY */
 	ATA_FLAG_DEBUGMSG	= (1 << 13),
 	ATA_FLAG_IGN_SIMPLEX	= (1 << 15), /* ignore SIMPLEX */
 	ATA_FLAG_NO_IORDY	= (1 << 16), /* controller lacks iordy */
@@ -513,6 +515,8 @@ struct ata_link {
 	unsigned int		active_tag;	/* active tag on this link */
 	u32			sactive;	/* active NCQ commands */
 
+	unsigned int		flags;		/* ATA_LFLAG_xxx */
+
 	unsigned int		hw_sata_spd_limit;
 	unsigned int		sata_spd_limit;
 	unsigned int		sata_spd;	/* current SATA PHY speed */
@@ -650,6 +654,7 @@ struct ata_port_operations {
 struct ata_port_info {
 	struct scsi_host_template	*sht;
 	unsigned long		flags;
+	unsigned long		link_flags;
 	unsigned long		pio_mask;
 	unsigned long		mwdma_mask;
 	unsigned long		udma_mask;
-- 
1.5.0.3


