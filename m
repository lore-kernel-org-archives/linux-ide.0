From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 36/73] pata_ninja32: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:17:56 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142017510.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:62035 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755265AbZCNTR7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:17:59 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZMq-000FeE-Ti
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:17:57 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_ninja32.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_ninja32.c b/drivers/ata/pata_ninja32.c
index 4dd9a3b..0fb6b1b 100644
--- a/drivers/ata/pata_ninja32.c
+++ b/drivers/ata/pata_ninja32.c
@@ -136,7 +136,7 @@ static int ninja32_init_one(struct pci_dev *dev, co=
nst struct pci_device_id *id)
 	if (!base)
 		return -ENOMEM;
 	ap->ops =3D &ninja32_port_ops;
-	ap->pio_mask =3D 0x1F;
+	ap->pio_mask =3D ATA_PIO4;
 	ap->flags |=3D ATA_FLAG_SLAVE_POSS;
=20
 	ap->ioaddr.cmd_addr =3D base + 0x10;
--=20
1.5.6.3

