From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 55/73] pata_sl82c105: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:21:04 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142020590.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:59713 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755935AbZCNTVH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:21:07 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZPs-000Fif-Kz
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:21:04 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_sl82c105.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

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
--=20
1.5.6.3

