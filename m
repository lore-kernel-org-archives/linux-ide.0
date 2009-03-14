From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 38/73] pata_ns87415: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:18:27 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142018190.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:62098 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755131AbZCNTS3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:18:29 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZNL-000Fed-1t
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:18:27 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_ns87415.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_ns87415.c b/drivers/ata/pata_ns87415.c
index 89bf5f8..773b159 100644
--- a/drivers/ata/pata_ns87415.c
+++ b/drivers/ata/pata_ns87415.c
@@ -346,8 +346,8 @@ static int ns87415_init_one (struct pci_dev *pdev, =
const struct pci_device_id *e
 	static int printed_version;
 	static const struct ata_port_info info =3D {
 		.flags		=3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.port_ops	=3D &ns87415_pata_ops,
 	};
 	const struct ata_port_info *ppi[] =3D { &info, NULL };
@@ -355,8 +355,8 @@ static int ns87415_init_one (struct pci_dev *pdev, =
const struct pci_device_id *e
 #if defined(CONFIG_SUPERIO)
 	static const struct ata_port_info info87560 =3D {
 		.flags		=3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask	=3D 0x1f,	/* pio0-4 */
-		.mwdma_mask	=3D 0x07, /* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.port_ops	=3D &ns87560_pata_ops,
 	};
=20
--=20
1.5.6.3

