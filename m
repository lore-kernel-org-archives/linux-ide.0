From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 45/73] pata_qdi: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:19:32 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142019220.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:62489 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755567AbZCNTTe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:19:34 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZOO-000FgR-CS
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:19:32 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_qdi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_qdi.c b/drivers/ata/pata_qdi.c
index f1b26f7..45879dc 100644
--- a/drivers/ata/pata_qdi.c
+++ b/drivers/ata/pata_qdi.c
@@ -212,11 +212,11 @@ static __init int qdi_init_one(unsigned long port=
, int type, unsigned long io, i
=20
 	if (type =3D=3D 6580) {
 		ap->ops =3D &qdi6580_port_ops;
-		ap->pio_mask =3D 0x1F;
+		ap->pio_mask =3D ATA_PIO4;
 		ap->flags |=3D ATA_FLAG_SLAVE_POSS;
 	} else {
 		ap->ops =3D &qdi6500_port_ops;
-		ap->pio_mask =3D 0x07;	/* Actually PIO3 !IORDY is possible */
+		ap->pio_mask =3D ATA_PIO2; /* Actually PIO3 !IORDY is possible */
 		ap->flags =3D ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
 	}
=20
--=20
1.5.6.3

