From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 37/73] pata_ns87410: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:18:16 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142018090.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:62085 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755265AbZCNTSS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:18:18 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZNA-000FeH-5I
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:18:16 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_ns87410.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_ns87410.c b/drivers/ata/pata_ns87410.c
index 40d411c..ca53fac 100644
--- a/drivers/ata/pata_ns87410.c
+++ b/drivers/ata/pata_ns87410.c
@@ -144,7 +144,7 @@ static int ns87410_init_one(struct pci_dev *dev, co=
nst struct pci_device_id *id)
 {
 	static const struct ata_port_info info =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x0F,
+		.pio_mask =3D ATA_PIO3,
 		.port_ops =3D &ns87410_port_ops
 	};
 	const struct ata_port_info *ppi[] =3D { &info, NULL };
--=20
1.5.6.3

