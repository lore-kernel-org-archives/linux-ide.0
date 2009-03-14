From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 57/73] pata_via: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:21:19 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142021140.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:59787 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755787AbZCNTVV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:21:21 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZQ7-000Fiq-Fw
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:21:19 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_via.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

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
--=20
1.5.6.3

