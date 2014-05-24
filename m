From: Andreas =?UTF-8?B?U2NocsOkZ2xl?= <ajs124.ajs124@gmail.com>
Subject: [PATCH] ahci: add PCI ID for Marvell 88SE91A0 SATA Controller
Date: Sat, 24 May 2014 16:35:43 +0200
Message-ID: <20140524163543.11b65052@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f194.google.com ([74.125.82.194]:51500 "EHLO
	mail-we0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbaEXOfr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 May 2014 10:35:47 -0400
Received: by mail-we0-f194.google.com with SMTP id t61so1753780wes.9
        for <linux-ide@vger.kernel.org>; Sat, 24 May 2014 07:35:46 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

=46rom: Andreas Schr=C3=A4gle <ajs124.ajs124@gmail.com>

Add support for Marvell Technology Group Ltd. 88SE91A0 SATA 6Gb/s Contr=
oller by adding its PCI ID.
---
 drivers/ata/ahci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 6070781..ae672a3 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -445,6 +445,8 @@ static const struct pci_device_id ahci_pci_tbl[] =3D=
 {
 	  .driver_data =3D board_ahci_yes_fbs },			/* 88se9172 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9192),
 	  .driver_data =3D board_ahci_yes_fbs },			/* 88se9172 on some Gigaby=
te */
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x91a0),
+	  .driver_data =3D board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x91a3),
 	  .driver_data =3D board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
--=20
1.9.3

