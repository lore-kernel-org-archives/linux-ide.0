From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 34/73] pata_mpiix: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:17:36 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142017270.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:61994 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752784AbZCNTRi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:17:38 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZMW-000Fdd-6s
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:17:36 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_mpiix.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_mpiix.c b/drivers/ata/pata_mpiix.c
index aa576ca..b21f002 100644
--- a/drivers/ata/pata_mpiix.c
+++ b/drivers/ata/pata_mpiix.c
@@ -200,7 +200,7 @@ static int mpiix_init_one(struct pci_dev *dev, cons=
t struct pci_device_id *id)
 	   the MPIIX your box goes castors up */
=20
 	ap->ops =3D &mpiix_port_ops;
-	ap->pio_mask =3D 0x1F;
+	ap->pio_mask =3D ATA_PIO4;
 	ap->flags |=3D ATA_FLAG_SLAVE_POSS;
=20
 	ap->ioaddr.cmd_addr =3D cmd_addr;
--=20
1.5.6.3

