From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 62/73] sata_mv: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:22:03 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142021560.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:59952 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753248AbZCNTWG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:22:06 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZQp-000FmQ-S2
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:22:03 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/sata_mv.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

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
--=20
1.5.6.3

