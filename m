From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH] pata_radisys: fix mwdma_mask to exclude mwdma0
Date: Sat, 14 Mar 2009 23:07:33 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142306410.72961@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:57441 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754564AbZCNWHg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 18:07:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>

As noted by Alan:
>Your suspicions are correct here btw - the device can only do MWDMA1 a=
nd
>MWDMA2 (much like some PIIX devices)

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_radisys.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
index 1956d5c..4401b33 100644
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -217,7 +217,7 @@ static int radisys_init_one (struct pci_dev *pdev, =
const struct pci_device_id *e
 	static const struct ata_port_info info =3D {
 		.flags		=3D ATA_FLAG_SLAVE_POSS,
 		.pio_mask	=3D ATA_PIO4,
-		.mwdma_mask	=3D ATA_MWDMA2, /* mwdma1-2 */
+		.mwdma_mask	=3D ATA_MWDMA12_ONLY,
 		.udma_mask	=3D ATA_UDMA24_ONLY,
 		.port_ops	=3D &radisys_pata_ops,
 	};
--=20
1.5.6.3
