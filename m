From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 42/73] pata_pcmcia: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:19:03 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142018550.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:62394 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755553AbZCNTTG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:19:06 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZNv-000Ffg-CH
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:19:03 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_pcmcia.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index 64b2e22..a5cbcc2 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -299,7 +299,7 @@ static int pcmcia_init_one(struct pcmcia_device *pd=
ev)
 		ap =3D host->ports[p];
=20
 		ap->ops =3D ops;
-		ap->pio_mask =3D 1;		/* ISA so PIO 0 cycles */
+		ap->pio_mask =3D ATA_PIO0;	/* ISA so PIO 0 cycles */
 		ap->flags |=3D ATA_FLAG_SLAVE_POSS;
 		ap->ioaddr.cmd_addr =3D io_addr + 0x10 * p;
 		ap->ioaddr.altstatus_addr =3D ctl_addr + 0x10 * p;
--=20
1.5.6.3

