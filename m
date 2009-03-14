From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH] pata_efar: fix *dma_mask
Date: Sat, 14 Mar 2009 23:08:20 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142307530.73010@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:57611 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917AbZCNWIX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 18:08:23 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>

According to Alan:
>and yes the EFAR does UDMA66.

mwdma:
>Yep - wrong comment. The EFAR is a sort of clone of the PIIX and I
>copied the comment while EFAR don't appear to have copied the
>limitation

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_efar.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_efar.c b/drivers/ata/pata_efar.c
index bd498cc..2085e0a 100644
--- a/drivers/ata/pata_efar.c
+++ b/drivers/ata/pata_efar.c
@@ -252,8 +252,8 @@ static int efar_init_one (struct pci_dev *pdev, con=
st struct pci_device_id *ent)
 	static const struct ata_port_info info =3D {
 		.flags		=3D ATA_FLAG_SLAVE_POSS,
 		.pio_mask	=3D ATA_PIO4,
-		.mwdma_mask	=3D ATA_MWDMA2, /* mwdma1-2 */
-		.udma_mask 	=3D ATA_UDMA3, /* UDMA 66 */
+		.mwdma_mask	=3D ATA_MWDMA2,
+		.udma_mask 	=3D ATA_UDMA4,
 		.port_ops	=3D &efar_ops,
 	};
 	const struct ata_port_info *ppi[] =3D { &info, NULL };
--=20
1.5.6.3
