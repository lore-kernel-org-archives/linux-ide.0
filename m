From: =?UTF-8?B?SsOpcsO0bWU=?= Carretero <cJ-ko@zougloub.eu>
Subject: [PATCH] ahci: Add Device ID for HighPoint RocketRaid 642L
Date: Fri, 30 May 2014 02:18:33 -0400
Message-ID: <20140530021833.746efa6b@Vantage.cJ>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zougloub.eu ([198.27.83.45]:51847 "EHLO zougloub.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754730AbaE3GYL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 May 2014 02:24:11 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>

This device normally comes with a proprietary driver, using a web GUI
to configure RAID:
 http://www.highpoint-tech.com/USA_new/series_rr600-download.htm
But thankfully it also works out of the box with the AHCI driver,
being just a Marvell 88SE9235.

Devices 640L, 644L, 644LS should also be supported but not tested here.

Signed-off-by: J=C3=A9r=C3=B4me Carretero <cJ-ko@zougloub.eu>
---
 drivers/ata/ahci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 6070781..ff5543f 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -449,6 +449,8 @@ static const struct pci_device_id ahci_pci_tbl[] =3D=
 {
 	  .driver_data =3D board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
 	  .driver_data =3D board_ahci_yes_fbs },
+	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642,
+	  .driver_data =3D board_ahci_yes_fbs },
=20
 	/* Promise */
 	{ PCI_VDEVICE(PROMISE, 0x3f20), board_ahci },	/* PDC42819 */
--=20
1.9.3

