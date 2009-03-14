From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 25/73] pata_icside: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:15:22 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142015140.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:61572 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754214AbZCNTPZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:15:25 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZKM-000Fc8-Mu
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:15:22 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_icside.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

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
--=20
1.5.6.3

