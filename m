From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 44/73] pata_pdc202xx_old: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:19:19 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142019130.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:62439 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755510AbZCNTTV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:19:21 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZOB-000Fft-BR
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:19:19 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_pdc202xx_old.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

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
--=20
1.5.6.3

