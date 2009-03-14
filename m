From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 06/73] ata_piix: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:11:30 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142011220.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:60772 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753248AbZCNTLc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:11:32 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZGc-000FY2-6g
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:11:30 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/ata_piix.c |   60 ++++++++++++++++++++++++----------------=
--------
 1 files changed, 30 insertions(+), 30 deletions(-)

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
--=20
1.5.6.3

