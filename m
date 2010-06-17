From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] ahci,ata_generic: let ata_generic handle
 new MBP w/ MCP89
Date: Thu, 17 Jun 2010 11:42:22 +0200
Message-ID: <4C19EDFE.8040202@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45710 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932827Ab0FQJnG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Jun 2010 05:43:06 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Cc: pchen@nvidia.com, grapz666@gmail.com, tixetsal@juno.com, damien.cassou@gmail.com, gschwind@gnu-log.net, andreas_graf@csgraf.de, stable <stable@kernel.org>

=46or yet unknown reason, MCP89 on MBP 7,1 doesn't work w/ ahci under
linux but the controller doesn't require explicit mode setting and
works fine with ata_generic.  Make ahci ignore the controller on MBP
7,1 and let ata_generic take it for now.

Reported in bko#15923.

  https://bugzilla.kernel.org/show_bug.cgi?id=3D15923

NVIDIA is investigating why ahci mode doesn't work.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Peer Chen <pchen@nvidia.com>
Cc: stable@kernel.org
Reported-by: Anders =D8sthus <grapz666@gmail.com>
Reported-by: Andreas Graf <andreas_graf@csgraf.de>
Reported-by: Benoit Gschwind <gschwind@gnu-log.net>
Reported-by: Damien Cassou <damien.cassou@gmail.com>
Reported-by: tixetsal@juno.com
---
 drivers/ata/ahci.c        |   10 ++++++++++
 drivers/ata/ata_generic.c |    6 ++++++
 include/linux/pci_ids.h   |    1 +
 3 files changed, 17 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 8ca16f5..f252253 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1053,6 +1053,16 @@ static int ahci_init_one(struct pci_dev *pdev, c=
onst struct pci_device_id *ent)
 	if (pdev->vendor =3D=3D PCI_VENDOR_ID_MARVELL && !marvell_enable)
 		return -ENODEV;

+	/*
+	 * For some reason, MCP89 on MacBook 7,1 doesn't work with
+	 * ahci, use ata_generic instead.
+	 */
+	if (pdev->vendor =3D=3D PCI_VENDOR_ID_NVIDIA &&
+	    pdev->device =3D=3D PCI_DEVICE_ID_NVIDIA_NFORCE_MCP89_SATA &&
+	    pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_APPLE &&
+	    pdev->subsystem_device =3D=3D 0xcb89)
+		return -ENODEV;
+
 	/* Promise's PDC42819 is a SAS/SATA controller that has an AHCI mode.
 	 * At the moment, we can only use the AHCI mode. Let the users know
 	 * that for SAS drives they're out of luck.
diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index 573158a..d4ccf74 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -168,6 +168,12 @@ static struct pci_device_id ata_generic[] =3D {
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA,    PCI_DEVICE_ID_VIA_82C561), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_OPTI,   PCI_DEVICE_ID_OPTI_82C558), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_CENATEK,PCI_DEVICE_ID_CENATEK_IDE), },
+	/*
+	 * For some reason, MCP89 on MacBook 7,1 doesn't work with
+	 * ahci, use ata_generic instead.
+	 */
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP89_SATA,
+	  PCI_VENDOR_ID_APPLE, 0xcb89, },
 #if !defined(CONFIG_PATA_TOSHIBA) && !defined(CONFIG_PATA_TOSHIBA_MODU=
LE)
 	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_1), =
},
 	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2), =
 },
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 4eb4679..3bedcc1 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1261,6 +1261,7 @@
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP77_IDE       0x0759
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP73_SMBUS     0x07D8
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP79_SMBUS     0x0AA2
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP89_SATA	    0x0D85

 #define PCI_VENDOR_ID_IMS		0x10e0
 #define PCI_DEVICE_ID_IMS_TT128		0x9128
