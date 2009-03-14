From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 2/2 v2] libata: convert drivers to use ata.h mode mask
 defines
Date: Sat, 14 Mar 2009 21:38:24 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142137530.66298@anduin.net>
References: <alpine.BSF.1.00.0903142131010.65817@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:55991 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754798AbZCNUi2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 16:38:28 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1Liaci-000HGB-Ja
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 21:38:24 +0100
In-Reply-To: <alpine.BSF.1.00.0903142131010.65817@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/ahci.c              |   16 ++++----
 drivers/ata/ata_generic.c       |    4 +-
 drivers/ata/ata_piix.c          |   60 ++++++++++++++++---------------=
-
 drivers/ata/pata_acpi.c         |    6 ++--
 drivers/ata/pata_ali.c          |   28 ++++++++--------
 drivers/ata/pata_amd.c          |   70 +++++++++++++++++++------------=
-------
 drivers/ata/pata_artop.c        |   16 ++++----
 drivers/ata/pata_at32.c         |    4 ++-
 drivers/ata/pata_atiixp.c       |    6 ++--
 drivers/ata/pata_bf54x.c        |    2 +-
 drivers/ata/pata_cmd640.c       |    2 +-
 drivers/ata/pata_cmd64x.c       |   24 +++++++-------
 drivers/ata/pata_cs5520.c       |    2 +-
 drivers/ata/pata_cs5530.c       |    8 ++--
 drivers/ata/pata_cs5535.c       |    4 +-
 drivers/ata/pata_cs5536.c       |    4 +-
 drivers/ata/pata_cypress.c      |    4 +-
 drivers/ata/pata_efar.c         |    6 ++--
 drivers/ata/pata_hpt366.c       |    4 +-
 drivers/ata/pata_hpt37x.c       |   28 ++++++++--------
 drivers/ata/pata_hpt3x2n.c      |    4 +-
 drivers/ata/pata_hpt3x3.c       |    6 ++--
 drivers/ata/pata_icside.c       |    4 +-
 drivers/ata/pata_isapnp.c       |    2 +-
 drivers/ata/pata_it8213.c       |    4 +-
 drivers/ata/pata_it821x.c       |   16 ++++----
 drivers/ata/pata_ixp4xx_cf.c    |    2 +-
 drivers/ata/pata_jmicron.c      |    4 +-
 drivers/ata/pata_legacy.c       |    2 +-
 drivers/ata/pata_marvell.c      |    8 ++--
 drivers/ata/pata_mpc52xx.c      |    4 +-
 drivers/ata/pata_mpiix.c        |    2 +-
 drivers/ata/pata_netcell.c      |    4 +-
 drivers/ata/pata_ninja32.c      |    2 +-
 drivers/ata/pata_ns87410.c      |    2 +-
 drivers/ata/pata_ns87415.c      |    8 ++--
 drivers/ata/pata_octeon_cf.c    |    4 +-
 drivers/ata/pata_oldpiix.c      |    4 +-
 drivers/ata/pata_opti.c         |    2 +-
 drivers/ata/pata_optidma.c      |   10 +++---
 drivers/ata/pata_pcmcia.c       |    2 +-
 drivers/ata/pata_pdc2027x.c     |   12 +++---
 drivers/ata/pata_pdc202xx_old.c |   12 +++---
 drivers/ata/pata_qdi.c          |    4 +-
 drivers/ata/pata_radisys.c      |    6 ++--
 drivers/ata/pata_rb532_cf.c     |    2 +-
 drivers/ata/pata_rz1000.c       |    2 +-
 drivers/ata/pata_sc1200.c       |    6 ++--
 drivers/ata/pata_scc.c          |    4 +-
 drivers/ata/pata_sch.c          |    6 ++--
 drivers/ata/pata_serverworks.c  |   20 +++++-----
 drivers/ata/pata_sil680.c       |    8 ++--
 drivers/ata/pata_sis.c          |   32 ++++++++++-------
 drivers/ata/pata_sl82c105.c     |    6 ++--
 drivers/ata/pata_triflex.c      |    4 +-
 drivers/ata/pata_via.c          |   24 +++++++-------
 drivers/ata/pata_winbond.c      |    2 +-
 drivers/ata/pdc_adma.c          |    2 +-
 drivers/ata/sata_fsl.c          |    4 +-
 drivers/ata/sata_inic162x.c     |    4 +-
 drivers/ata/sata_mv.c           |   16 ++++----
 drivers/ata/sata_nv.c           |    6 ++--
 drivers/ata/sata_promise.c      |   28 ++++++++--------
 drivers/ata/sata_qstor.c        |    2 +-
 drivers/ata/sata_sil.c          |   16 ++++----
 drivers/ata/sata_sil24.c        |   18 +++++-----
 drivers/ata/sata_sis.c          |    4 +-
 drivers/ata/sata_svw.c          |   16 ++++----
 drivers/ata/sata_sx4.c          |    4 +-
 drivers/ata/sata_uli.c          |    2 +-
 drivers/ata/sata_via.c          |   16 ++++----
 drivers/ata/sata_vsc.c          |    4 +-
 72 files changed, 347 insertions(+), 339 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 66e012c..3e66734 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -404,7 +404,7 @@ static const struct ata_port_info ahci_port_info[] =
=3D {
 	/* board_ahci */
 	{
 		.flags		=3D AHCI_FLAG_COMMON,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &ahci_ops,
 	},
@@ -412,7 +412,7 @@ static const struct ata_port_info ahci_port_info[] =
=3D {
 	{
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_NCQ | AHCI_HFLAG_NO_PMP),
 		.flags		=3D AHCI_FLAG_COMMON,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &ahci_vt8251_ops,
 	},
@@ -420,7 +420,7 @@ static const struct ata_port_info ahci_port_info[] =
=3D {
 	{
 		AHCI_HFLAGS	(AHCI_HFLAG_IGN_IRQ_IF_ERR),
 		.flags		=3D AHCI_FLAG_COMMON,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &ahci_ops,
 	},
@@ -430,7 +430,7 @@ static const struct ata_port_info ahci_port_info[] =
=3D {
 				 AHCI_HFLAG_32BIT_ONLY | AHCI_HFLAG_NO_MSI |
 				 AHCI_HFLAG_SECT255),
 		.flags		=3D AHCI_FLAG_COMMON,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &ahci_sb600_ops,
 	},
@@ -440,7 +440,7 @@ static const struct ata_port_info ahci_port_info[] =
=3D {
 				 AHCI_HFLAG_MV_PATA | AHCI_HFLAG_NO_PMP),
 		.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &ahci_ops,
 	},
@@ -448,7 +448,7 @@ static const struct ata_port_info ahci_port_info[] =
=3D {
 	{
 		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL),
 		.flags		=3D AHCI_FLAG_COMMON,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &ahci_sb600_ops,
 	},
@@ -456,7 +456,7 @@ static const struct ata_port_info ahci_port_info[] =
=3D {
 	{
 		AHCI_HFLAGS	(AHCI_HFLAG_YES_NCQ),
 		.flags		=3D AHCI_FLAG_COMMON,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &ahci_ops,
 	},
@@ -464,7 +464,7 @@ static const struct ata_port_info ahci_port_info[] =
=3D {
 	{
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_PMP),
 		.flags		=3D AHCI_FLAG_COMMON,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &ahci_ops,
 	},
diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index dc48a63..ecfd22b 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -118,8 +118,8 @@ static int ata_generic_init_one(struct pci_dev *dev=
, const struct pci_device_id
 	u16 command;
 	static const struct ata_port_info info =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA5,
 		.port_ops =3D &generic_port_ops
 	};
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 54961c0..b3f7e60 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -446,34 +446,34 @@ static struct ata_port_info piix_port_info[] =3D =
{
 	[piix_pata_mwdma] =3D 	/* PIIX3 MWDMA only */
 	{
 		.flags		=3D PIIX_PATA_FLAGS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x06, /* mwdma1-2 ?? CHECK 0 should be ok but slow *=
/
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA12_ONLY, /* mwdma1-2 ?? CHECK 0 should be o=
k but slow */
 		.port_ops	=3D &piix_pata_ops,
 	},
=20
 	[piix_pata_33] =3D	/* PIIX4 at 33MHz */
 	{
 		.flags		=3D PIIX_PATA_FLAGS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x06, /* mwdma1-2 ?? CHECK 0 should be ok but slow *=
/
-		.udma_mask	=3D ATA_UDMA_MASK_40C,
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA12_ONLY, /* mwdma1-2 ?? CHECK 0 should be o=
k but slow */
+		.udma_mask	=3D ATA_UDMA2,
 		.port_ops	=3D &piix_pata_ops,
 	},
=20
 	[ich_pata_33] =3D 	/* ICH0 - ICH at 33Mhz*/
 	{
 		.flags		=3D PIIX_PATA_FLAGS,
-		.pio_mask 	=3D 0x1f,	/* pio 0-4 */
-		.mwdma_mask	=3D 0x06, /* Check: maybe 0x07  */
-		.udma_mask	=3D ATA_UDMA2, /* UDMA33 */
+		.pio_mask 	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA12_ONLY, /* Check: maybe MWDMA0 is ok  */
+		.udma_mask	=3D ATA_UDMA2,
 		.port_ops	=3D &ich_pata_ops,
 	},
=20
 	[ich_pata_66] =3D 	/* ICH controllers up to 66MHz */
 	{
 		.flags		=3D PIIX_PATA_FLAGS,
-		.pio_mask 	=3D 0x1f,	/* pio 0-4 */
-		.mwdma_mask	=3D 0x06, /* MWDMA0 is broken on chip */
+		.pio_mask 	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA12_ONLY, /* MWDMA0 is broken on chip */
 		.udma_mask	=3D ATA_UDMA4,
 		.port_ops	=3D &ich_pata_ops,
 	},
@@ -481,17 +481,17 @@ static struct ata_port_info piix_port_info[] =3D =
{
 	[ich_pata_100] =3D
 	{
 		.flags		=3D PIIX_PATA_FLAGS | PIIX_FLAG_CHECKINTR,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x06, /* mwdma1-2 */
-		.udma_mask	=3D ATA_UDMA5, /* udma0-5 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA12_ONLY,
+		.udma_mask	=3D ATA_UDMA5,
 		.port_ops	=3D &ich_pata_ops,
 	},
=20
 	[ich5_sata] =3D
 	{
 		.flags		=3D PIIX_SATA_FLAGS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &piix_sata_ops,
 	},
@@ -499,8 +499,8 @@ static struct ata_port_info piix_port_info[] =3D {
 	[ich6_sata] =3D
 	{
 		.flags		=3D PIIX_SATA_FLAGS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &piix_sata_ops,
 	},
@@ -508,8 +508,8 @@ static struct ata_port_info piix_port_info[] =3D {
 	[ich6m_sata] =3D
 	{
 		.flags		=3D PIIX_SATA_FLAGS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &piix_sata_ops,
 	},
@@ -517,8 +517,8 @@ static struct ata_port_info piix_port_info[] =3D {
 	[ich8_sata] =3D
 	{
 		.flags		=3D PIIX_SATA_FLAGS | PIIX_FLAG_SIDPR,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &piix_sata_ops,
 	},
@@ -526,8 +526,8 @@ static struct ata_port_info piix_port_info[] =3D {
 	[ich8_2port_sata] =3D
 	{
 		.flags		=3D PIIX_SATA_FLAGS | PIIX_FLAG_SIDPR,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &piix_sata_ops,
 	},
@@ -535,8 +535,8 @@ static struct ata_port_info piix_port_info[] =3D {
 	[tolapai_sata] =3D
 	{
 		.flags		=3D PIIX_SATA_FLAGS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &piix_sata_ops,
 	},
@@ -544,8 +544,8 @@ static struct ata_port_info piix_port_info[] =3D {
 	[ich8m_apple_sata] =3D
 	{
 		.flags		=3D PIIX_SATA_FLAGS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &piix_sata_ops,
 	},
@@ -553,9 +553,9 @@ static struct ata_port_info piix_port_info[] =3D {
 	[piix_pata_vmw] =3D
 	{
 		.flags		=3D PIIX_PATA_FLAGS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x06, /* mwdma1-2 ?? CHECK 0 should be ok but slow *=
/
-		.udma_mask	=3D ATA_UDMA_MASK_40C,
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA12_ONLY, /* mwdma1-2 ?? CHECK 0 should be o=
k but slow */
+		.udma_mask	=3D ATA_UDMA2,
 		.port_ops	=3D &piix_vmw_ops,
 	},
=20
diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
index 8b77a98..d8f35fe 100644
--- a/drivers/ata/pata_acpi.c
+++ b/drivers/ata/pata_acpi.c
@@ -246,9 +246,9 @@ static int pacpi_init_one (struct pci_dev *pdev, co=
nst struct pci_device_id *id)
 	static const struct ata_port_info info =3D {
 		.flags		=3D ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
=20
-		.pio_mask	=3D 0x1f,
-		.mwdma_mask	=3D 0x07,
-		.udma_mask 	=3D 0x7f,
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
+		.udma_mask 	=3D ATA_UDMA6,
=20
 		.port_ops	=3D &pacpi_ops,
 	};
diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index eb99dbe..751b7ea 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -492,53 +492,53 @@ static int ali_init_one(struct pci_dev *pdev, con=
st struct pci_device_id *id)
 {
 	static const struct ata_port_info info_early =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
+		.pio_mask =3D ATA_PIO4,
 		.port_ops =3D &ali_early_port_ops
 	};
 	/* Revision 0x20 added DMA */
 	static const struct ata_port_info info_20 =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.port_ops =3D &ali_20_port_ops
 	};
 	/* Revision 0x20 with support logic added UDMA */
 	static const struct ata_port_info info_20_udma =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
-		.udma_mask =3D 0x07,	/* UDMA33 */
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
+		.udma_mask =3D ATA_UDMA2,
 		.port_ops =3D &ali_20_port_ops
 	};
 	/* Revision 0xC2 adds UDMA66 */
 	static const struct ata_port_info info_c2 =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA4,
 		.port_ops =3D &ali_c2_port_ops
 	};
 	/* Revision 0xC3 is UDMA66 for now */
 	static const struct ata_port_info info_c3 =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA4,
 		.port_ops =3D &ali_c2_port_ops
 	};
 	/* Revision 0xC4 is UDMA100 */
 	static const struct ata_port_info info_c4 =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA5,
 		.port_ops =3D &ali_c4_port_ops
 	};
 	/* Revision 0xC5 is UDMA133 with LBA48 DMA */
 	static const struct ata_port_info info_c5 =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA6,
 		.port_ops =3D &ali_c5_port_ops
 	};
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 115b1cd..33a74f1 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -455,74 +455,74 @@ static void amd_clear_fifo(struct pci_dev *pdev)
 static int amd_init_one(struct pci_dev *pdev, const struct pci_device_=
id *id)
 {
 	static const struct ata_port_info info[10] =3D {
-		{	/* 0: AMD 7401 */
+		{	/* 0: AMD 7401 - no swdma */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,	/* No SWDMA */
-			.udma_mask =3D 0x07,	/* UDMA 33 */
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
+			.udma_mask =3D ATA_UDMA2,
 			.port_ops =3D &amd33_port_ops
 		},
 		{	/* 1: Early AMD7409 - no swdma */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
-			.udma_mask =3D ATA_UDMA4,	/* UDMA 66 */
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
+			.udma_mask =3D ATA_UDMA4,
 			.port_ops =3D &amd66_port_ops
 		},
-		{	/* 2: AMD 7409, no swdma errata */
+		{	/* 2: AMD 7409 */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
-			.udma_mask =3D ATA_UDMA4,	/* UDMA 66 */
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
+			.udma_mask =3D ATA_UDMA4,
 			.port_ops =3D &amd66_port_ops
 		},
 		{	/* 3: AMD 7411 */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
-			.udma_mask =3D ATA_UDMA5,	/* UDMA 100 */
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
+			.udma_mask =3D ATA_UDMA5,
 			.port_ops =3D &amd100_port_ops
 		},
 		{	/* 4: AMD 7441 */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
-			.udma_mask =3D ATA_UDMA5,	/* UDMA 100 */
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
+			.udma_mask =3D ATA_UDMA5,
 			.port_ops =3D &amd100_port_ops
 		},
-		{	/* 5: AMD 8111*/
+		{	/* 5: AMD 8111 - no swdma */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
-			.udma_mask =3D ATA_UDMA6,	/* UDMA 133, no swdma */
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
+			.udma_mask =3D ATA_UDMA6,
 			.port_ops =3D &amd133_port_ops
 		},
-		{	/* 6: AMD 8111 UDMA 100 (Serenade) */
+		{	/* 6: AMD 8111 UDMA 100 (Serenade) - no swdma */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
-			.udma_mask =3D ATA_UDMA5,	/* UDMA 100, no swdma */
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
+			.udma_mask =3D ATA_UDMA5,
 			.port_ops =3D &amd133_port_ops
 		},
 		{	/* 7: Nvidia Nforce */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
-			.udma_mask =3D ATA_UDMA5,	/* UDMA 100 */
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
+			.udma_mask =3D ATA_UDMA5,
 			.port_ops =3D &nv100_port_ops
 		},
-		{	/* 8: Nvidia Nforce2 and later */
+		{	/* 8: Nvidia Nforce2 and later - no swdma */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
-			.udma_mask =3D ATA_UDMA6,	/* UDMA 133, no swdma */
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
+			.udma_mask =3D ATA_UDMA6,
 			.port_ops =3D &nv133_port_ops
 		},
 		{	/* 9: AMD CS5536 (Geode companion) */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
-			.udma_mask =3D ATA_UDMA5,	/* UDMA 100 */
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
+			.udma_mask =3D ATA_UDMA5,
 			.port_ops =3D &amd100_port_ops
 		}
 	};
diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index 6b3092c..07c7fae 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -323,29 +323,29 @@ static int artop_init_one (struct pci_dev *pdev, =
const struct pci_device_id *id)
 	static int printed_version;
 	static const struct ata_port_info info_6210 =3D {
 		.flags		=3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask 	=3D ATA_UDMA2,
 		.port_ops	=3D &artop6210_ops,
 	};
 	static const struct ata_port_info info_626x =3D {
 		.flags		=3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask 	=3D ATA_UDMA4,
 		.port_ops	=3D &artop6260_ops,
 	};
 	static const struct ata_port_info info_628x =3D {
 		.flags		=3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask 	=3D ATA_UDMA5,
 		.port_ops	=3D &artop6260_ops,
 	};
 	static const struct ata_port_info info_628x_fast =3D {
 		.flags		=3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask 	=3D ATA_UDMA6,
 		.port_ops	=3D &artop6260_ops,
 	};
diff --git a/drivers/ata/pata_at32.c b/drivers/ata/pata_at32.c
index ab61095..5c129f9 100644
--- a/drivers/ata/pata_at32.c
+++ b/drivers/ata/pata_at32.c
@@ -67,7 +67,9 @@
  *
  * Alter PIO_MASK below according to table to set maximal PIO mode.
  */
-#define PIO_MASK (0x1f)
+enum {
+  PIO_MASK =3D ATA_PIO4,
+};
=20
 /*
  * Struct containing private information about device.
diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 506adde..bec0b8a 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -220,9 +220,9 @@ static int atiixp_init_one(struct pci_dev *pdev, co=
nst struct pci_device_id *id)
 {
 	static const struct ata_port_info info =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x06,	/* No MWDMA0 support */
-		.udma_mask =3D 0x3F,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA12_ONLY,
+		.udma_mask =3D ATA_UDMA5,
 		.port_ops =3D &atiixp_port_ops
 	};
 	static const struct pci_bits atiixp_enable_bits[] =3D {
diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index 1050fed..c4b47a3 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -1502,7 +1502,7 @@ static struct ata_port_info bfin_port_info[] =3D =
{
 		.flags		=3D ATA_FLAG_SLAVE_POSS
 				| ATA_FLAG_MMIO
 				| ATA_FLAG_NO_LEGACY,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D 0,
 		.udma_mask	=3D 0,
 		.port_ops	=3D &bfin_pata_ops,
diff --git a/drivers/ata/pata_cmd640.c b/drivers/ata/pata_cmd640.c
index 34a3942..5acf9fa 100644
--- a/drivers/ata/pata_cmd640.c
+++ b/drivers/ata/pata_cmd640.c
@@ -211,7 +211,7 @@ static int cmd640_init_one(struct pci_dev *pdev, co=
nst struct pci_device_id *id)
 {
 	static const struct ata_port_info info =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
+		.pio_mask =3D ATA_PIO4,
 		.port_ops =3D &cmd640_port_ops
 	};
 	const struct ata_port_info *ppi[] =3D { &info, NULL };
diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index 3167d8f..f98dffe 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -299,40 +299,40 @@ static int cmd64x_init_one(struct pci_dev *pdev, =
const struct pci_device_id *id)
 	static const struct ata_port_info cmd_info[6] =3D {
 		{	/* CMD 643 - no UDMA */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
 			.port_ops =3D &cmd64x_port_ops
 		},
 		{	/* CMD 646 with broken UDMA */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
 			.port_ops =3D &cmd64x_port_ops
 		},
 		{	/* CMD 646 with working UDMA */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
 			.udma_mask =3D ATA_UDMA2,
 			.port_ops =3D &cmd64x_port_ops
 		},
 		{	/* CMD 646 rev 1  */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
 			.port_ops =3D &cmd646r1_port_ops
 		},
 		{	/* CMD 648 */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
 			.udma_mask =3D ATA_UDMA4,
 			.port_ops =3D &cmd648_port_ops
 		},
 		{	/* CMD 649 */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
 			.udma_mask =3D ATA_UDMA5,
 			.port_ops =3D &cmd648_port_ops
 		}
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 1186bcd..db6a969 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -158,7 +158,7 @@ static int __devinit cs5520_init_one(struct pci_dev=
 *pdev, const struct pci_devi
 	static const unsigned int ctl_port[] =3D { 0x3F6, 0x376 };
 	struct ata_port_info pi =3D {
 		.flags		=3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask	=3D 0x1f,
+		.pio_mask	=3D ATA_PIO4,
 		.port_ops	=3D &cs5520_port_ops,
 	};
 	const struct ata_port_info *ppi[2];
diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index bba4533..c974b05 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -298,15 +298,15 @@ static int cs5530_init_one(struct pci_dev *pdev, =
const struct pci_device_id *id)
 {
 	static const struct ata_port_info info =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
-		.udma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
+		.udma_mask =3D ATA_UDMA2,
 		.port_ops =3D &cs5530_port_ops
 	};
 	/* The docking connector doesn't do UDMA, and it seems not MWDMA */
 	static const struct ata_port_info info_palmax_secondary =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
+		.pio_mask =3D ATA_PIO4,
 		.port_ops =3D &cs5530_port_ops
 	};
 	const struct ata_port_info *ppi[] =3D { &info, NULL };
diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
index 8b236af..d33aa28 100644
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -181,8 +181,8 @@ static int cs5535_init_one(struct pci_dev *dev, con=
st struct pci_device_id *id)
 {
 	static const struct ata_port_info info =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA4,
 		.port_ops =3D &cs5535_port_ops
 	};
diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
index afed929..6da4cb4 100644
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -241,8 +241,8 @@ static int cs5536_init_one(struct pci_dev *dev, con=
st struct pci_device_id *id)
 {
 	static const struct ata_port_info info =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA5,
 		.port_ops =3D &cs5536_port_ops,
 	};
diff --git a/drivers/ata/pata_cypress.c b/drivers/ata/pata_cypress.c
index d546425..8fb040b 100644
--- a/drivers/ata/pata_cypress.c
+++ b/drivers/ata/pata_cypress.c
@@ -124,8 +124,8 @@ static int cy82c693_init_one(struct pci_dev *pdev, =
const struct pci_device_id *i
 {
 	static const struct ata_port_info info =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.port_ops =3D &cy82c693_port_ops
 	};
 	const struct ata_port_info *ppi[] =3D { &info, &ata_dummy_port_info }=
;
diff --git a/drivers/ata/pata_efar.c b/drivers/ata/pata_efar.c
index ac6392e..bd498cc 100644
--- a/drivers/ata/pata_efar.c
+++ b/drivers/ata/pata_efar.c
@@ -251,9 +251,9 @@ static int efar_init_one (struct pci_dev *pdev, con=
st struct pci_device_id *ent)
 	static int printed_version;
 	static const struct ata_port_info info =3D {
 		.flags		=3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma1-2 */
-		.udma_mask 	=3D 0x0f, /* UDMA 66 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2, /* mwdma1-2 */
+		.udma_mask 	=3D ATA_UDMA3, /* UDMA 66 */
 		.port_ops	=3D &efar_ops,
 	};
 	const struct ata_port_info *ppi[] =3D { &info, NULL };
diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 65c28e5..d7f2da1 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -336,8 +336,8 @@ static int hpt36x_init_one(struct pci_dev *dev, con=
st struct pci_device_id *id)
 {
 	static const struct ata_port_info info_hpt366 =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA4,
 		.port_ops =3D &hpt366_port_ops
 	};
diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index 4216399..81ab570 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -753,55 +753,55 @@ static int hpt37x_init_one(struct pci_dev *dev, c=
onst struct pci_device_id *id)
 	/* HPT370 - UDMA100 */
 	static const struct ata_port_info info_hpt370 =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA5,
 		.port_ops =3D &hpt370_port_ops
 	};
 	/* HPT370A - UDMA100 */
 	static const struct ata_port_info info_hpt370a =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA5,
 		.port_ops =3D &hpt370a_port_ops
 	};
 	/* HPT370 - UDMA100 */
 	static const struct ata_port_info info_hpt370_33 =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA5,
 		.port_ops =3D &hpt370_port_ops
 	};
 	/* HPT370A - UDMA100 */
 	static const struct ata_port_info info_hpt370a_33 =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA5,
 		.port_ops =3D &hpt370a_port_ops
 	};
 	/* HPT371, 372 and friends - UDMA133 */
 	static const struct ata_port_info info_hpt372 =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA6,
 		.port_ops =3D &hpt372_port_ops
 	};
 	/* HPT374 - UDMA100, function 1 uses different prereset method */
 	static const struct ata_port_info info_hpt374_fn0 =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA5,
 		.port_ops =3D &hpt372_port_ops
 	};
 	static const struct ata_port_info info_hpt374_fn1 =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA5,
 		.port_ops =3D &hpt374_fn1_port_ops
 	};
diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index d5c9fd7..3d59fe0 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -441,8 +441,8 @@ static int hpt3x2n_init_one(struct pci_dev *dev, co=
nst struct pci_device_id *id)
 	/* HPT372N and friends - UDMA133 */
 	static const struct ata_port_info info =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA6,
 		.port_ops =3D &hpt3x2n_port_ops
 	};
diff --git a/drivers/ata/pata_hpt3x3.c b/drivers/ata/pata_hpt3x3.c
index f19cc64..7e31025 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -188,11 +188,11 @@ static int hpt3x3_init_one(struct pci_dev *pdev, =
const struct pci_device_id *id)
 	static int printed_version;
 	static const struct ata_port_info info =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
+		.pio_mask =3D ATA_PIO4,
 #if defined(CONFIG_PATA_HPT3X3_DMA)
 		/* Further debug needed */
-		.mwdma_mask =3D 0x07,
-		.udma_mask =3D 0x07,
+		.mwdma_mask =3D ATA_MWDMA2,
+		.udma_mask =3D ATA_UDMA2,
 #endif
 		.port_ops =3D &hpt3x3_port_ops
 	};
diff --git a/drivers/ata/pata_icside.c b/drivers/ata/pata_icside.c
index cf9e984..e7347db 100644
--- a/drivers/ata/pata_icside.c
+++ b/drivers/ata/pata_icside.c
@@ -297,7 +297,7 @@ static int icside_dma_init(struct pata_icside_info =
*info)
=20
 	if (ec->dma !=3D NO_DMA && !request_dma(ec->dma, DRV_NAME)) {
 		state->dma =3D ec->dma;
-		info->mwdma_mask =3D 0x07;	/* MW0..2 */
+		info->mwdma_mask =3D ATA_MWDMA2;
 	}
=20
 	return 0;
@@ -473,7 +473,7 @@ static int __devinit pata_icside_add_ports(struct p=
ata_icside_info *info)
 	for (i =3D 0; i < info->nr_ports; i++) {
 		struct ata_port *ap =3D host->ports[i];
=20
-		ap->pio_mask =3D 0x1f;
+		ap->pio_mask =3D ATA_PIO4;
 		ap->mwdma_mask =3D info->mwdma_mask;
 		ap->flags |=3D ATA_FLAG_SLAVE_POSS;
 		ap->ops =3D &pata_icside_port_ops;
diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
index 15cdb91..afa8f70 100644
--- a/drivers/ata/pata_isapnp.c
+++ b/drivers/ata/pata_isapnp.c
@@ -66,7 +66,7 @@ static int isapnp_init_one(struct pnp_dev *idev, cons=
t struct pnp_device_id *dev
 	ap =3D host->ports[0];
=20
 	ap->ops =3D &isapnp_port_ops;
-	ap->pio_mask =3D 1;
+	ap->pio_mask =3D ATA_PIO0;
 	ap->flags |=3D ATA_FLAG_SLAVE_POSS;
=20
 	ap->ioaddr.cmd_addr =3D cmd_addr;
diff --git a/drivers/ata/pata_it8213.c b/drivers/ata/pata_it8213.c
index c113d7c..f156da8 100644
--- a/drivers/ata/pata_it8213.c
+++ b/drivers/ata/pata_it8213.c
@@ -262,8 +262,8 @@ static int it8213_init_one (struct pci_dev *pdev, c=
onst struct pci_device_id *en
 	static int printed_version;
 	static const struct ata_port_info info =3D {
 		.flags		=3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask 	=3D ATA_UDMA4, /* FIXME: want UDMA 100? */
 		.port_ops	=3D &it8213_ops,
 	};
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index b05b86a..188bc2f 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -875,29 +875,29 @@ static int it821x_init_one(struct pci_dev *pdev, =
const struct pci_device_id *id)
=20
 	static const struct ata_port_info info_smart =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA6,
 		.port_ops =3D &it821x_smart_port_ops
 	};
 	static const struct ata_port_info info_passthru =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA6,
 		.port_ops =3D &it821x_passthru_port_ops
 	};
 	static const struct ata_port_info info_rdc =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA6,
 		.port_ops =3D &it821x_rdc_port_ops
 	};
 	static const struct ata_port_info info_rdc_11 =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		/* No UDMA */
 		.port_ops =3D &it821x_rdc_port_ops
 	};
diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.=
c
index b173c15..19fdecf 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -176,7 +176,7 @@ static __devinit int ixp4xx_pata_probe(struct platf=
orm_device *pdev)
 	ap =3D host->ports[0];
=20
 	ap->ops	=3D &ixp4xx_port_ops;
-	ap->pio_mask =3D 0x1f; /* PIO4 */
+	ap->pio_mask =3D ATA_PIO4;
 	ap->flags |=3D ATA_FLAG_MMIO | ATA_FLAG_NO_LEGACY | ATA_FLAG_NO_ATAPI=
;
=20
 	ixp4xx_setup_port(ap, data, cs0->start, cs1->start);
diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index 38cf1ab..3a1474a 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -136,8 +136,8 @@ static int jmicron_init_one (struct pci_dev *pdev, =
const struct pci_device_id *i
 	static const struct ata_port_info info =3D {
 		.flags	=3D ATA_FLAG_SLAVE_POSS,
=20
-		.pio_mask	=3D 0x1f,
-		.mwdma_mask	=3D 0x07,
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask 	=3D ATA_UDMA5,
=20
 		.port_ops	=3D &jmicron_ops,
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index e3bc1b4..3f830f0 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -129,7 +129,7 @@ static int qdi;			/* Set to probe QDI controllers *=
/
 static int winbond;		/* Set to probe Winbond controllers,
 					give I/O port if non standard */
 static int autospeed;		/* Chip present which snoops speed changes */
-static int pio_mask =3D 0x1F;	/* PIO range for autospeed devices */
+static int pio_mask =3D ATA_PIO4;	/* PIO range for autospeed devices *=
/
 static int iordy_mask =3D 0xFFFFFFFF;	/* Use iordy if available */
=20
 /**
diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index 76e399b..2096fb7 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -126,8 +126,8 @@ static int marvell_init_one (struct pci_dev *pdev, =
const struct pci_device_id *i
 	static const struct ata_port_info info =3D {
 		.flags		=3D ATA_FLAG_SLAVE_POSS,
=20
-		.pio_mask	=3D 0x1f,
-		.mwdma_mask	=3D 0x07,
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask 	=3D ATA_UDMA5,
=20
 		.port_ops	=3D &marvell_ops,
@@ -136,8 +136,8 @@ static int marvell_init_one (struct pci_dev *pdev, =
const struct pci_device_id *i
 		/* Slave possible as its magically mapped not real */
 		.flags		=3D ATA_FLAG_SLAVE_POSS,
=20
-		.pio_mask	=3D 0x1f,
-		.mwdma_mask	=3D 0x07,
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask 	=3D ATA_UDMA6,
=20
 		.port_ops	=3D &marvell_ops,
diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 50ae6d1..68d27bc 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -737,10 +737,10 @@ mpc52xx_ata_probe(struct of_device *op, const str=
uct of_device_id *match)
 	 */
 	prop =3D of_get_property(op->node, "mwdma-mode", &proplen);
 	if ((prop) && (proplen >=3D 4))
-		mwdma_mask =3D 0x7 & ((1 << (*prop + 1)) - 1);
+		mwdma_mask =3D ATA_MWDMA2 & ((1 << (*prop + 1)) - 1);
 	prop =3D of_get_property(op->node, "udma-mode", &proplen);
 	if ((prop) && (proplen >=3D 4))
-		udma_mask =3D 0x7 & ((1 << (*prop + 1)) - 1);
+		udma_mask =3D ATA_UDMA2 & ((1 << (*prop + 1)) - 1);
=20
 	ata_irq =3D irq_of_parse_and_map(op->node, 0);
 	if (ata_irq =3D=3D NO_IRQ) {
diff --git a/drivers/ata/pata_mpiix.c b/drivers/ata/pata_mpiix.c
index aa576ca..b21f002 100644
--- a/drivers/ata/pata_mpiix.c
+++ b/drivers/ata/pata_mpiix.c
@@ -200,7 +200,7 @@ static int mpiix_init_one(struct pci_dev *dev, cons=
t struct pci_device_id *id)
 	   the MPIIX your box goes castors up */
=20
 	ap->ops =3D &mpiix_port_ops;
-	ap->pio_mask =3D 0x1F;
+	ap->pio_mask =3D ATA_PIO4;
 	ap->flags |=3D ATA_FLAG_SLAVE_POSS;
=20
 	ap->ioaddr.cmd_addr =3D cmd_addr;
diff --git a/drivers/ata/pata_netcell.c b/drivers/ata/pata_netcell.c
index 9dc05e1..bdb2369 100644
--- a/drivers/ata/pata_netcell.c
+++ b/drivers/ata/pata_netcell.c
@@ -51,8 +51,8 @@ static int netcell_init_one (struct pci_dev *pdev, co=
nst struct pci_device_id *e
 		.flags		=3D ATA_FLAG_SLAVE_POSS,
 		/* Actually we don't really care about these as the
 		   firmware deals with it */
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask 	=3D ATA_UDMA5, /* UDMA 133 */
 		.port_ops	=3D &netcell_ops,
 	};
diff --git a/drivers/ata/pata_ninja32.c b/drivers/ata/pata_ninja32.c
index 4dd9a3b..0fb6b1b 100644
--- a/drivers/ata/pata_ninja32.c
+++ b/drivers/ata/pata_ninja32.c
@@ -136,7 +136,7 @@ static int ninja32_init_one(struct pci_dev *dev, co=
nst struct pci_device_id *id)
 	if (!base)
 		return -ENOMEM;
 	ap->ops =3D &ninja32_port_ops;
-	ap->pio_mask =3D 0x1F;
+	ap->pio_mask =3D ATA_PIO4;
 	ap->flags |=3D ATA_FLAG_SLAVE_POSS;
=20
 	ap->ioaddr.cmd_addr =3D base + 0x10;
diff --git a/drivers/ata/pata_ns87410.c b/drivers/ata/pata_ns87410.c
index 40d411c..ca53fac 100644
--- a/drivers/ata/pata_ns87410.c
+++ b/drivers/ata/pata_ns87410.c
@@ -144,7 +144,7 @@ static int ns87410_init_one(struct pci_dev *dev, co=
nst struct pci_device_id *id)
 {
 	static const struct ata_port_info info =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x0F,
+		.pio_mask =3D ATA_PIO3,
 		.port_ops =3D &ns87410_port_ops
 	};
 	const struct ata_port_info *ppi[] =3D { &info, NULL };
diff --git a/drivers/ata/pata_ns87415.c b/drivers/ata/pata_ns87415.c
index 89bf5f8..773b159 100644
--- a/drivers/ata/pata_ns87415.c
+++ b/drivers/ata/pata_ns87415.c
@@ -346,8 +346,8 @@ static int ns87415_init_one (struct pci_dev *pdev, =
const struct pci_device_id *e
 	static int printed_version;
 	static const struct ata_port_info info =3D {
 		.flags		=3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.port_ops	=3D &ns87415_pata_ops,
 	};
 	const struct ata_port_info *ppi[] =3D { &info, NULL };
@@ -355,8 +355,8 @@ static int ns87415_init_one (struct pci_dev *pdev, =
const struct pci_device_id *e
 #if defined(CONFIG_SUPERIO)
 	static const struct ata_port_info info87560 =3D {
 		.flags		=3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.port_ops	=3D &ns87560_pata_ops,
 	};
=20
diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.=
c
index 0fe4ef3..efe2c19 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -871,7 +871,7 @@ static int __devinit octeon_cf_probe(struct platfor=
m_device *pdev)
 	ap->private_data =3D cf_port;
 	cf_port->ap =3D ap;
 	ap->ops =3D &octeon_cf_ops;
-	ap->pio_mask =3D 0x7f; /* Support PIO 0-6 */
+	ap->pio_mask =3D ATA_PIO6;
 	ap->flags |=3D ATA_FLAG_MMIO | ATA_FLAG_NO_LEGACY
 		  | ATA_FLAG_NO_ATAPI | ATA_FLAG_PIO_POLLING;
=20
@@ -900,7 +900,7 @@ static int __devinit octeon_cf_probe(struct platfor=
m_device *pdev)
 		ap->ioaddr.ctl_addr	=3D cs1 + (6 << 1) + 1;
 		octeon_cf_ops.sff_data_xfer =3D octeon_cf_data_xfer16;
=20
-		ap->mwdma_mask	=3D 0x1f; /* Support MWDMA 0-4 */
+		ap->mwdma_mask	=3D ATA_MWDMA4;
 		irq =3D platform_get_irq(pdev, 0);
 		irq_handler =3D octeon_cf_interrupt;
=20
diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
index 2c1a91c..84ac503 100644
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -238,8 +238,8 @@ static int oldpiix_init_one (struct pci_dev *pdev, =
const struct pci_device_id *e
 	static int printed_version;
 	static const struct ata_port_info info =3D {
 		.flags		=3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma1-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.port_ops	=3D &oldpiix_pata_ops,
 	};
 	const struct ata_port_info *ppi[] =3D { &info, NULL };
diff --git a/drivers/ata/pata_opti.c b/drivers/ata/pata_opti.c
index e4fa4d5..99eddda 100644
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -163,7 +163,7 @@ static int opti_init_one(struct pci_dev *dev, const=
 struct pci_device_id *id)
 {
 	static const struct ata_port_info info =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
+		.pio_mask =3D ATA_PIO4,
 		.port_ops =3D &opti_port_ops
 	};
 	const struct ata_port_info *ppi[] =3D { &info, NULL };
diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index 93bb6e9..86885a4 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -399,15 +399,15 @@ static int optidma_init_one(struct pci_dev *dev, =
const struct pci_device_id *id)
 {
 	static const struct ata_port_info info_82c700 =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.port_ops =3D &optidma_port_ops
 	};
 	static const struct ata_port_info info_82c700_udma =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
-		.udma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
+		.udma_mask =3D ATA_UDMA2,
 		.port_ops =3D &optiplus_port_ops
 	};
 	const struct ata_port_info *ppi[] =3D { &info_82c700, NULL };
diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index 64b2e22..a5cbcc2 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -299,7 +299,7 @@ static int pcmcia_init_one(struct pcmcia_device *pd=
ev)
 		ap =3D host->ports[p];
=20
 		ap->ops =3D ops;
-		ap->pio_mask =3D 1;		/* ISA so PIO 0 cycles */
+		ap->pio_mask =3D ATA_PIO0;	/* ISA so PIO 0 cycles */
 		ap->flags |=3D ATA_FLAG_SLAVE_POSS;
 		ap->ioaddr.cmd_addr =3D io_addr + 0x10 * p;
 		ap->ioaddr.altstatus_addr =3D ctl_addr + 0x10 * p;
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index e94efcc..ca5cad0 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -152,18 +152,18 @@ static struct ata_port_info pdc2027x_port_info[] =
=3D {
 	{
 		.flags		=3D ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS |
 		                  ATA_FLAG_MMIO,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
-		.udma_mask	=3D ATA_UDMA5, /* udma0-5 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
+		.udma_mask	=3D ATA_UDMA5,
 		.port_ops	=3D &pdc2027x_pata100_ops,
 	},
 	/* PDC_UDMA_133 */
 	{
 		.flags		=3D ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS |
                         	  ATA_FLAG_MMIO,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
-		.udma_mask	=3D ATA_UDMA6, /* udma0-6 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
+		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &pdc2027x_pata133_ops,
 	},
 };
diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202x=
x_old.c
index 799a6a0..5fedb3d 100644
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -291,22 +291,22 @@ static int pdc202xx_init_one(struct pci_dev *dev,=
 const struct pci_device_id *id
 	static const struct ata_port_info info[3] =3D {
 		{
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
 			.udma_mask =3D ATA_UDMA2,
 			.port_ops =3D &pdc2024x_port_ops
 		},
 		{
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
 			.udma_mask =3D ATA_UDMA4,
 			.port_ops =3D &pdc2026x_port_ops
 		},
 		{
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
 			.udma_mask =3D ATA_UDMA5,
 			.port_ops =3D &pdc2026x_port_ops
 		}
diff --git a/drivers/ata/pata_qdi.c b/drivers/ata/pata_qdi.c
index f1b26f7..45879dc 100644
--- a/drivers/ata/pata_qdi.c
+++ b/drivers/ata/pata_qdi.c
@@ -212,11 +212,11 @@ static __init int qdi_init_one(unsigned long port=
, int type, unsigned long io, i
=20
 	if (type =3D=3D 6580) {
 		ap->ops =3D &qdi6580_port_ops;
-		ap->pio_mask =3D 0x1F;
+		ap->pio_mask =3D ATA_PIO4;
 		ap->flags |=3D ATA_FLAG_SLAVE_POSS;
 	} else {
 		ap->ops =3D &qdi6500_port_ops;
-		ap->pio_mask =3D 0x07;	/* Actually PIO3 !IORDY is possible */
+		ap->pio_mask =3D ATA_PIO2; /* Actually PIO3 !IORDY is possible */
 		ap->flags =3D ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
 	}
=20
diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
index 695d44a..1956d5c 100644
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -216,9 +216,9 @@ static int radisys_init_one (struct pci_dev *pdev, =
const struct pci_device_id *e
 	static int printed_version;
 	static const struct ata_port_info info =3D {
 		.flags		=3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma1-2 */
-		.udma_mask	=3D 0x14, /* UDMA33/66 only */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2, /* mwdma1-2 */
+		.udma_mask	=3D ATA_UDMA24_ONLY,
 		.port_ops	=3D &radisys_pata_ops,
 	};
 	const struct ata_port_info *ppi[] =3D { &info, NULL };
diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index ebfcda2..8acb5db 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -145,7 +145,7 @@ static void rb532_pata_setup_ports(struct ata_host =
*ah)
 	ap =3D ah->ports[0];
=20
 	ap->ops		=3D &rb532_pata_port_ops;
-	ap->pio_mask	=3D 0x1f; /* PIO4 */
+	ap->pio_mask	=3D ATA_PIO4;
 	ap->flags	=3D ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO;
=20
 	ap->ioaddr.cmd_addr	=3D info->iobase + RB500_CF_REG_BASE;
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index 46d6bc1..0c574c0 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -88,7 +88,7 @@ static int rz1000_init_one (struct pci_dev *pdev, con=
st struct pci_device_id *en
 	static int printed_version;
 	static const struct ata_port_info info =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
+		.pio_mask =3D ATA_PIO4,
 		.port_ops =3D &rz1000_port_ops
 	};
 	const struct ata_port_info *ppi[] =3D { &info, NULL };
diff --git a/drivers/ata/pata_sc1200.c b/drivers/ata/pata_sc1200.c
index 9a4bdca..36a0c35 100644
--- a/drivers/ata/pata_sc1200.c
+++ b/drivers/ata/pata_sc1200.c
@@ -205,9 +205,9 @@ static int sc1200_init_one(struct pci_dev *dev, con=
st struct pci_device_id *id)
 {
 	static const struct ata_port_info info =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
-		.udma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
+		.udma_mask =3D ATA_UDMA2,
 		.port_ops =3D &sc1200_port_ops
 	};
 	/* Can't enable port 2 yet, see top comments */
diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
index d447f1c..4257d6b 100644
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -1001,8 +1001,8 @@ static struct ata_port_operations scc_pata_ops =3D=
 {
 static struct ata_port_info scc_port_info[] =3D {
 	{
 		.flags		=3D ATA_FLAG_SLAVE_POSS | ATA_FLAG_MMIO | ATA_FLAG_NO_LEGACY=
,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x00,
+		.pio_mask	=3D ATA_PIO4,
+		/* No MWDMA */
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &scc_pata_ops,
 	},
diff --git a/drivers/ata/pata_sch.c b/drivers/ata/pata_sch.c
index 6aeeeeb..99cceb4 100644
--- a/drivers/ata/pata_sch.c
+++ b/drivers/ata/pata_sch.c
@@ -84,9 +84,9 @@ static struct ata_port_operations sch_pata_ops =3D {
=20
 static struct ata_port_info sch_port_info =3D {
 	.flags		=3D ATA_FLAG_SLAVE_POSS,
-	.pio_mask	=3D ATA_PIO4,   /* pio0-4 */
-	.mwdma_mask	=3D ATA_MWDMA2, /* mwdma0-2 */
-	.udma_mask	=3D ATA_UDMA5,  /* udma0-5 */
+	.pio_mask	=3D ATA_PIO4,
+	.mwdma_mask	=3D ATA_MWDMA2,
+	.udma_mask	=3D ATA_UDMA5,
 	.port_ops	=3D &sch_pata_ops,
 };
=20
diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverwo=
rks.c
index 8d2fd9d..beaed12 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -398,26 +398,26 @@ static int serverworks_init_one(struct pci_dev *p=
dev, const struct pci_device_id
 	static const struct ata_port_info info[4] =3D {
 		{ /* OSB4 */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
-			.udma_mask =3D 0x07,
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
+			.udma_mask =3D ATA_UDMA2,
 			.port_ops =3D &serverworks_osb4_port_ops
 		}, { /* OSB4 no UDMA */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
-			.udma_mask =3D 0x00,
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
+			/* No UDMA */
 			.port_ops =3D &serverworks_osb4_port_ops
 		}, { /* CSB5 */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
 			.udma_mask =3D ATA_UDMA4,
 			.port_ops =3D &serverworks_csb_port_ops
 		}, { /* CSB5 - later revisions*/
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
 			.udma_mask =3D ATA_UDMA5,
 			.port_ops =3D &serverworks_csb_port_ops
 		}
diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 9e764e5..4cb649d 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -282,15 +282,15 @@ static int __devinit sil680_init_one(struct pci_d=
ev *pdev,
 {
 	static const struct ata_port_info info =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA6,
 		.port_ops =3D &sil680_port_ops
 	};
 	static const struct ata_port_info info_slow =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA5,
 		.port_ops =3D &sil680_port_ops
 	};
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index 27ceb42..488e77b 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -552,51 +552,57 @@ static struct ata_port_operations sis_old_ops =3D=
 {
=20
 static const struct ata_port_info sis_info =3D {
 	.flags		=3D ATA_FLAG_SLAVE_POSS,
-	.pio_mask	=3D 0x1f,	/* pio0-4 */
-	.mwdma_mask	=3D 0x07,
-	.udma_mask	=3D 0,
+	.pio_mask	=3D ATA_PIO4,
+	.mwdma_mask	=3D ATA_MWDMA2,
+	/* No UDMA */
 	.port_ops	=3D &sis_old_ops,
 };
 static const struct ata_port_info sis_info33 =3D {
 	.flags		=3D ATA_FLAG_SLAVE_POSS,
-	.pio_mask	=3D 0x1f,	/* pio0-4 */
-	.mwdma_mask	=3D 0x07,
-	.udma_mask	=3D ATA_UDMA2,	/* UDMA 33 */
+	.pio_mask	=3D ATA_PIO4,
+	.mwdma_mask	=3D ATA_MWDMA2,
+	.udma_mask	=3D ATA_UDMA2,
 	.port_ops	=3D &sis_old_ops,
 };
 static const struct ata_port_info sis_info66 =3D {
 	.flags		=3D ATA_FLAG_SLAVE_POSS,
-	.pio_mask	=3D 0x1f,	/* pio0-4 */
-	.udma_mask	=3D ATA_UDMA4,	/* UDMA 66 */
+	.pio_mask	=3D ATA_PIO4,
+	/* No MWDMA */
+	.udma_mask	=3D ATA_UDMA4,
 	.port_ops	=3D &sis_66_ops,
 };
 static const struct ata_port_info sis_info100 =3D {
 	.flags		=3D ATA_FLAG_SLAVE_POSS,
-	.pio_mask	=3D 0x1f,	/* pio0-4 */
+	.pio_mask	=3D ATA_PIO4,
+	/* No MWDMA */
 	.udma_mask	=3D ATA_UDMA5,
 	.port_ops	=3D &sis_100_ops,
 };
 static const struct ata_port_info sis_info100_early =3D {
 	.flags		=3D ATA_FLAG_SLAVE_POSS,
+	.pio_mask	=3D ATA_PIO4,
+	/* No MWDMA */
 	.udma_mask	=3D ATA_UDMA5,
-	.pio_mask	=3D 0x1f,	/* pio0-4 */
 	.port_ops	=3D &sis_66_ops,
 };
 static const struct ata_port_info sis_info133 =3D {
 	.flags		=3D ATA_FLAG_SLAVE_POSS,
-	.pio_mask	=3D 0x1f,	/* pio0-4 */
+	.pio_mask	=3D ATA_PIO4,
+	/* No MWDMA */
 	.udma_mask	=3D ATA_UDMA6,
 	.port_ops	=3D &sis_133_ops,
 };
 const struct ata_port_info sis_info133_for_sata =3D {
 	.flags		=3D ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
-	.pio_mask	=3D 0x1f,	/* pio0-4 */
+	.pio_mask	=3D ATA_PIO4,
+	/* No MWDMA */
 	.udma_mask	=3D ATA_UDMA6,
 	.port_ops	=3D &sis_133_for_sata_ops,
 };
 static const struct ata_port_info sis_info133_early =3D {
 	.flags		=3D ATA_FLAG_SLAVE_POSS,
-	.pio_mask	=3D 0x1f,	/* pio0-4 */
+	.pio_mask	=3D ATA_PIO4,
+	/* No MWDMA */
 	.udma_mask	=3D ATA_UDMA6,
 	.port_ops	=3D &sis_133_early_ops,
 };
diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
index 1b0e7b6..29f733c 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -283,13 +283,13 @@ static int sl82c105_init_one(struct pci_dev *dev,=
 const struct pci_device_id *id
 {
 	static const struct ata_port_info info_dma =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.port_ops =3D &sl82c105_port_ops
 	};
 	static const struct ata_port_info info_early =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
+		.pio_mask =3D ATA_PIO4,
 		.port_ops =3D &sl82c105_port_ops
 	};
 	/* for now use only the first port */
diff --git a/drivers/ata/pata_triflex.c b/drivers/ata/pata_triflex.c
index ef95975..f1f13ff 100644
--- a/drivers/ata/pata_triflex.c
+++ b/drivers/ata/pata_triflex.c
@@ -191,8 +191,8 @@ static int triflex_init_one(struct pci_dev *dev, co=
nst struct pci_device_id *id)
 {
 	static const struct ata_port_info info =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.port_ops =3D &triflex_port_ops
 	};
 	const struct ata_port_info *ppi[] =3D { &info, NULL };
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index ba556d3..b08e6e0 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -422,46 +422,46 @@ static int via_init_one(struct pci_dev *pdev, con=
st struct pci_device_id *id)
 	/* Early VIA without UDMA support */
 	static const struct ata_port_info via_mwdma_info =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.port_ops =3D &via_port_ops
 	};
 	/* Ditto with IRQ masking required */
 	static const struct ata_port_info via_mwdma_info_borked =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.port_ops =3D &via_port_ops_noirq,
 	};
 	/* VIA UDMA 33 devices (and borked 66) */
 	static const struct ata_port_info via_udma33_info =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA2,
 		.port_ops =3D &via_port_ops
 	};
 	/* VIA UDMA 66 devices */
 	static const struct ata_port_info via_udma66_info =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA4,
 		.port_ops =3D &via_port_ops
 	};
 	/* VIA UDMA 100 devices */
 	static const struct ata_port_info via_udma100_info =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA5,
 		.port_ops =3D &via_port_ops
 	};
 	/* UDMA133 with bad AST (All current 133) */
 	static const struct ata_port_info via_udma133_info =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA6,	/* FIXME: should check north bridge */
 		.port_ops =3D &via_port_ops
 	};
diff --git a/drivers/ata/pata_winbond.c b/drivers/ata/pata_winbond.c
index 319e164..6d8619b 100644
--- a/drivers/ata/pata_winbond.c
+++ b/drivers/ata/pata_winbond.c
@@ -193,7 +193,7 @@ static __init int winbond_init_one(unsigned long po=
rt)
 		ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx", cmd_port, ctl_port);
=20
 		ap->ops =3D &winbond_port_ops;
-		ap->pio_mask =3D 0x1F;
+		ap->pio_mask =3D ATA_PIO4;
 		ap->flags |=3D ATA_FLAG_SLAVE_POSS;
 		ap->ioaddr.cmd_addr =3D cmd_addr;
 		ap->ioaddr.altstatus_addr =3D ctl_addr;
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index be53545..c509c20 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -166,7 +166,7 @@ static struct ata_port_info adma_port_info[] =3D {
 		.flags		=3D ATA_FLAG_SLAVE_POSS |
 				  ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO |
 				  ATA_FLAG_PIO_POLLING,
-		.pio_mask	=3D 0x10, /* pio4 */
+		.pio_mask	=3D ATA_PIO4_ONLY,
 		.udma_mask	=3D ATA_UDMA4,
 		.port_ops	=3D &adma_ata_ops,
 	},
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 55bc88c..c2e90e1 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1279,8 +1279,8 @@ static struct ata_port_operations sata_fsl_ops =3D=
 {
 static const struct ata_port_info sata_fsl_port_info[] =3D {
 	{
 	 .flags =3D SATA_FSL_HOST_FLAGS,
-	 .pio_mask =3D 0x1f,	/* pio 0-4 */
-	 .udma_mask =3D 0x7f,	/* udma 0-6 */
+	 .pio_mask =3D ATA_PIO4,
+	 .udma_mask =3D ATA_UDMA6,
 	 .port_ops =3D &sata_fsl_ops,
 	 },
 };
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index fbbd87c..305a4f8 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -744,8 +744,8 @@ static struct ata_port_operations inic_port_ops =3D=
 {
=20
 static struct ata_port_info inic_port_info =3D {
 	.flags			=3D ATA_FLAG_SATA | ATA_FLAG_PIO_DMA,
-	.pio_mask		=3D 0x1f,	/* pio0-4 */
-	.mwdma_mask		=3D 0x07, /* mwdma0-2 */
+	.pio_mask		=3D ATA_PIO4,
+	.mwdma_mask		=3D ATA_MWDMA2,
 	.udma_mask		=3D ATA_UDMA6,
 	.port_ops		=3D &inic_port_ops
 };
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 7007edd..ab5c95c 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -604,19 +604,19 @@ static struct ata_port_operations mv_iie_ops =3D =
{
 static const struct ata_port_info mv_port_info[] =3D {
 	{  /* chip_504x */
 		.flags		=3D MV_COMMON_FLAGS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &mv5_ops,
 	},
 	{  /* chip_508x */
 		.flags		=3D MV_COMMON_FLAGS | MV_FLAG_DUAL_HC,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &mv5_ops,
 	},
 	{  /* chip_5080 */
 		.flags		=3D MV_COMMON_FLAGS | MV_FLAG_DUAL_HC,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &mv5_ops,
 	},
@@ -624,7 +624,7 @@ static const struct ata_port_info mv_port_info[] =3D=
 {
 		.flags		=3D MV_COMMON_FLAGS | MV_6XXX_FLAGS |
 				  ATA_FLAG_PMP | ATA_FLAG_ACPI_SATA |
 				  ATA_FLAG_NCQ,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &mv6_ops,
 	},
@@ -632,25 +632,25 @@ static const struct ata_port_info mv_port_info[] =
=3D {
 		.flags		=3D MV_COMMON_FLAGS | MV_6XXX_FLAGS |
 				  ATA_FLAG_PMP | ATA_FLAG_ACPI_SATA |
 				  ATA_FLAG_NCQ | MV_FLAG_DUAL_HC,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &mv6_ops,
 	},
 	{  /* chip_6042 */
 		.flags		=3D MV_GENIIE_FLAGS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &mv_iie_ops,
 	},
 	{  /* chip_7042 */
 		.flags		=3D MV_GENIIE_FLAGS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &mv_iie_ops,
 	},
 	{  /* chip_soc */
 		.flags		=3D MV_GENIIE_FLAGS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &mv_iie_ops,
 	},
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index f65b537..2f523f8 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -57,9 +57,9 @@ enum {
 	NV_MMIO_BAR			=3D 5,
=20
 	NV_PORTS			=3D 2,
-	NV_PIO_MASK			=3D 0x1f,
-	NV_MWDMA_MASK			=3D 0x07,
-	NV_UDMA_MASK			=3D 0x7f,
+	NV_PIO_MASK			=3D ATA_PIO4,
+	NV_MWDMA_MASK			=3D ATA_MWDMA2,
+	NV_UDMA_MASK			=3D ATA_UDMA6,
 	NV_PORT0_SCR_REG_OFFSET		=3D 0x00,
 	NV_PORT1_SCR_REG_OFFSET		=3D 0x40,
=20
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index ba9a257..3ad2b88 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -213,8 +213,8 @@ static const struct ata_port_info pdc_port_info[] =3D=
 {
 	{
 		.flags		=3D PDC_COMMON_FLAGS | ATA_FLAG_SATA |
 				  PDC_FLAG_SATA_PATA,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &pdc_old_sata_ops,
 	},
@@ -222,8 +222,8 @@ static const struct ata_port_info pdc_port_info[] =3D=
 {
 	[board_2037x_pata] =3D
 	{
 		.flags		=3D PDC_COMMON_FLAGS | ATA_FLAG_SLAVE_POSS,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &pdc_pata_ops,
 	},
@@ -232,8 +232,8 @@ static const struct ata_port_info pdc_port_info[] =3D=
 {
 	{
 		.flags		=3D PDC_COMMON_FLAGS | ATA_FLAG_SATA |
 				  PDC_FLAG_4_PORTS,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &pdc_old_sata_ops,
 	},
@@ -242,8 +242,8 @@ static const struct ata_port_info pdc_port_info[] =3D=
 {
 	{
 		.flags		=3D PDC_COMMON_FLAGS | ATA_FLAG_SLAVE_POSS |
 				  PDC_FLAG_4_PORTS,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &pdc_pata_ops,
 	},
@@ -252,8 +252,8 @@ static const struct ata_port_info pdc_port_info[] =3D=
 {
 	{
 		.flags		=3D PDC_COMMON_FLAGS | ATA_FLAG_SATA |
 				  PDC_FLAG_GEN_II | PDC_FLAG_SATA_PATA,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &pdc_sata_ops,
 	},
@@ -262,8 +262,8 @@ static const struct ata_port_info pdc_port_info[] =3D=
 {
 	{
 		.flags		=3D PDC_COMMON_FLAGS | ATA_FLAG_SLAVE_POSS |
 				  PDC_FLAG_GEN_II,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &pdc_pata_ops,
 	},
@@ -272,8 +272,8 @@ static const struct ata_port_info pdc_port_info[] =3D=
 {
 	{
 		.flags		=3D PDC_COMMON_FLAGS | ATA_FLAG_SATA |
 				  PDC_FLAG_GEN_II | PDC_FLAG_4_PORTS,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &pdc_sata_ops,
 	},
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index a000c86..7112d89 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -160,7 +160,7 @@ static const struct ata_port_info qs_port_info[] =3D=
 {
 	{
 		.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_POLLING,
-		.pio_mask	=3D 0x10, /* pio4 */
+		.pio_mask	=3D ATA_PIO4_ONLY,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &qs_ata_ops,
 	},
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index d009160..e67ce8e 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -200,8 +200,8 @@ static const struct ata_port_info sil_port_info[] =3D=
 {
 	/* sil_3112 */
 	{
 		.flags		=3D SIL_DFL_PORT_FLAGS | SIL_FLAG_MOD15WRITE,
-		.pio_mask	=3D 0x1f,			/* pio0-4 */
-		.mwdma_mask	=3D 0x07,			/* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA5,
 		.port_ops	=3D &sil_ops,
 	},
@@ -209,24 +209,24 @@ static const struct ata_port_info sil_port_info[]=
 =3D {
 	{
 		.flags		=3D SIL_DFL_PORT_FLAGS | SIL_FLAG_MOD15WRITE |
 				  SIL_FLAG_NO_SATA_IRQ,
-		.pio_mask	=3D 0x1f,			/* pio0-4 */
-		.mwdma_mask	=3D 0x07,			/* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA5,
 		.port_ops	=3D &sil_ops,
 	},
 	/* sil_3512 */
 	{
 		.flags		=3D SIL_DFL_PORT_FLAGS | SIL_FLAG_RERR_ON_DMA_ACT,
-		.pio_mask	=3D 0x1f,			/* pio0-4 */
-		.mwdma_mask	=3D 0x07,			/* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA5,
 		.port_ops	=3D &sil_ops,
 	},
 	/* sil_3114 */
 	{
 		.flags		=3D SIL_DFL_PORT_FLAGS | SIL_FLAG_RERR_ON_DMA_ACT,
-		.pio_mask	=3D 0x1f,			/* pio0-4 */
-		.mwdma_mask	=3D 0x07,			/* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA5,
 		.port_ops	=3D &sil_ops,
 	},
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 2590c22..0d8990d 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -429,25 +429,25 @@ static const struct ata_port_info sil24_port_info=
[] =3D {
 	{
 		.flags		=3D SIL24_COMMON_FLAGS | SIL24_NPORTS2FLAG(4) |
 				  SIL24_FLAG_PCIX_IRQ_WOC,
-		.pio_mask	=3D 0x1f,			/* pio0-4 */
-		.mwdma_mask	=3D 0x07,			/* mwdma0-2 */
-		.udma_mask	=3D ATA_UDMA5,		/* udma0-5 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
+		.udma_mask	=3D ATA_UDMA5,
 		.port_ops	=3D &sil24_ops,
 	},
 	/* sil_3132 */
 	{
 		.flags		=3D SIL24_COMMON_FLAGS | SIL24_NPORTS2FLAG(2),
-		.pio_mask	=3D 0x1f,			/* pio0-4 */
-		.mwdma_mask	=3D 0x07,			/* mwdma0-2 */
-		.udma_mask	=3D ATA_UDMA5,		/* udma0-5 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
+		.udma_mask	=3D ATA_UDMA5,
 		.port_ops	=3D &sil24_ops,
 	},
 	/* sil_3131/sil_3531 */
 	{
 		.flags		=3D SIL24_COMMON_FLAGS | SIL24_NPORTS2FLAG(1),
-		.pio_mask	=3D 0x1f,			/* pio0-4 */
-		.mwdma_mask	=3D 0x07,			/* mwdma0-2 */
-		.udma_mask	=3D ATA_UDMA5,		/* udma0-5 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
+		.udma_mask	=3D ATA_UDMA5,
 		.port_ops	=3D &sil24_ops,
 	},
 };
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index 9c43b4e..8f98332 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -97,8 +97,8 @@ static struct ata_port_operations sis_ops =3D {
=20
 static const struct ata_port_info sis_port_info =3D {
 	.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
-	.pio_mask	=3D 0x1f,
-	.mwdma_mask	=3D 0x7,
+	.pio_mask	=3D ATA_PIO4,
+	.mwdma_mask	=3D ATA_MWDMA2,
 	.udma_mask	=3D ATA_UDMA6,
 	.port_ops	=3D &sis_ops,
 };
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index 609d147..7257f2d 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -361,8 +361,8 @@ static const struct ata_port_info k2_port_info[] =3D=
 {
 	{
 		.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | K2_FLAG_NO_ATAPI_DMA,
-		.pio_mask	=3D 0x1f,
-		.mwdma_mask	=3D 0x07,
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &k2_sata_ops,
 	},
@@ -371,8 +371,8 @@ static const struct ata_port_info k2_port_info[] =3D=
 {
 		.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | K2_FLAG_NO_ATAPI_DMA |
 				  K2_FLAG_SATA_8_PORTS,
-		.pio_mask	=3D 0x1f,
-		.mwdma_mask	=3D 0x07,
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &k2_sata_ops,
 	},
@@ -380,8 +380,8 @@ static const struct ata_port_info k2_port_info[] =3D=
 {
 	{
 		.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | K2_FLAG_BAR_POS_3,
-		.pio_mask	=3D 0x1f,
-		.mwdma_mask	=3D 0x07,
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &k2_sata_ops,
 	},
@@ -389,8 +389,8 @@ static const struct ata_port_info k2_port_info[] =3D=
 {
 	{
 		.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO,
-		.pio_mask	=3D 0x1f,
-		.mwdma_mask	=3D 0x07,
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &k2_sata_ops,
 	},
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index ec04b8d..dce3dcc 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -265,8 +265,8 @@ static const struct ata_port_info pdc_port_info[] =3D=
 {
 		.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
 				  ATA_FLAG_NO_ATAPI | ATA_FLAG_PIO_POLLING,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &pdc_20621_ops,
 	},
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index 019575b..e5bff47 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -89,7 +89,7 @@ static struct ata_port_operations uli_ops =3D {
 static const struct ata_port_info uli_port_info =3D {
 	.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 			  ATA_FLAG_IGN_SIMPLEX,
-	.pio_mask       =3D 0x1f,		/* pio0-4 */
+	.pio_mask       =3D ATA_PIO4,
 	.udma_mask      =3D ATA_UDMA6,
 	.port_ops       =3D &uli_ops,
 };
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 5c62da9..98e8c50 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -146,24 +146,24 @@ static struct ata_port_operations vt8251_ops =3D =
{
=20
 static const struct ata_port_info vt6420_port_info =3D {
 	.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
-	.pio_mask	=3D 0x1f,
-	.mwdma_mask	=3D 0x07,
+	.pio_mask	=3D ATA_PIO4,
+	.mwdma_mask	=3D ATA_MWDMA2,
 	.udma_mask	=3D ATA_UDMA6,
 	.port_ops	=3D &vt6420_sata_ops,
 };
=20
 static struct ata_port_info vt6421_sport_info =3D {
 	.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
-	.pio_mask	=3D 0x1f,
-	.mwdma_mask	=3D 0x07,
+	.pio_mask	=3D ATA_PIO4,
+	.mwdma_mask	=3D ATA_MWDMA2,
 	.udma_mask	=3D ATA_UDMA6,
 	.port_ops	=3D &vt6421_sata_ops,
 };
=20
 static struct ata_port_info vt6421_pport_info =3D {
 	.flags		=3D ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_LEGACY,
-	.pio_mask	=3D 0x1f,
-	.mwdma_mask	=3D 0,
+	.pio_mask	=3D ATA_PIO4,
+	/* No MWDMA */
 	.udma_mask	=3D ATA_UDMA6,
 	.port_ops	=3D &vt6421_pata_ops,
 };
@@ -171,8 +171,8 @@ static struct ata_port_info vt6421_pport_info =3D {
 static struct ata_port_info vt8251_port_info =3D {
 	.flags		=3D ATA_FLAG_SATA | ATA_FLAG_SLAVE_POSS |
 			  ATA_FLAG_NO_LEGACY,
-	.pio_mask	=3D 0x1f,
-	.mwdma_mask	=3D 0x07,
+	.pio_mask	=3D ATA_PIO4,
+	.mwdma_mask	=3D ATA_MWDMA2,
 	.udma_mask	=3D ATA_UDMA6,
 	.port_ops	=3D &vt8251_ops,
 };
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index c57cdff..ef211f3 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -345,8 +345,8 @@ static int __devinit vsc_sata_init_one(struct pci_d=
ev *pdev,
 	static const struct ata_port_info pi =3D {
 		.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO,
-		.pio_mask	=3D 0x1f,
-		.mwdma_mask	=3D 0x07,
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &vsc_sata_ops,
 	};
--=20
1.5.6.3
