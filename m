From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 20/73] pata_efar: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:14:34 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142014190.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:61320 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754100AbZCNTOh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:14:37 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZJa-000FaO-O6
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:14:34 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.
(Looks like it could use one, though.)

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_efar.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

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
--=20
1.5.6.3

