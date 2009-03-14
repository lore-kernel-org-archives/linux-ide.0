From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 54/73] pata_sis: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:20:56 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142020520.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:59661 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755908AbZCNTU6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:20:58 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZPk-000Fic-Fc
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:20:56 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_sis.c |   32 +++++++++++++++++++-------------
 1 files changed, 19 insertions(+), 13 deletions(-)

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
--=20
1.5.6.3

