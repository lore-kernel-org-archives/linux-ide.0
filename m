From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 64/73] sata_promise: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:22:18 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142022130.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:59984 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756806AbZCNTWV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:22:21 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZR4-000Fmj-Sx
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:22:19 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/sata_promise.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

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
--=20
1.5.6.3

