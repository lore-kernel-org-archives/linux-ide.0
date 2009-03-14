From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 03/73] pata_octeon_cf: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:10:44 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142010370.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:60602 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752574AbZCNTKq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:10:46 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZFs-000FU7-FK
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:10:44 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_octeon_cf.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.=
c
index 0fe4ef3..efe2c19 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -871,7 +871,7 @@ static int __devinit octeon_cf_probe(struct platfor=
m_device *pdev)
 	ap->private_data =3D cf_port;
 	cf_port->ap =3D ap;
 	ap->ops =3D &octeon_cf_ops;
-	ap->pio_mask =3D 0x7f; /* Support PIO 0-6 */
+	ap->pio_mask =3D ATA_PIO6;
 	ap->flags |=3D ATA_FLAG_MMIO | ATA_FLAG_NO_LEGACY
 		  | ATA_FLAG_NO_ATAPI | ATA_FLAG_PIO_POLLING;
=20
@@ -900,7 +900,7 @@ static int __devinit octeon_cf_probe(struct platfor=
m_device *pdev)
 		ap->ioaddr.ctl_addr	=3D cs1 + (6 << 1) + 1;
 		octeon_cf_ops.sff_data_xfer =3D octeon_cf_data_xfer16;
=20
-		ap->mwdma_mask	=3D 0x1f; /* Support MWDMA 0-4 */
+		ap->mwdma_mask	=3D ATA_MWDMA4;
 		irq =3D platform_get_irq(pdev, 0);
 		irq_handler =3D octeon_cf_interrupt;
=20
--=20
1.5.6.3

