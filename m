From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: SATA_SIL: Add a work-around for IXP4xx CPU.
Date: Wed, 11 Nov 2009 01:04:14 +0100
Message-ID: <m3fx8m0vwh.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from khc.piap.pl ([195.187.100.11]:52458 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758724AbZKKAEL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Nov 2009 19:04:11 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

IXP4xx CPUs can't read from 8 and 16-bit PCI MMIO registers, we have to=
 read
from normal IO regions instead.

Tested on SIL3512, and specifically not tested on 4-port SIL3114.

Signed-off-by: Krzysztof Ha=C5=82asa <khc@pm.waw.pl>

--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -757,7 +757,22 @@ static int sil_init_one(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)
 	if (rc)
 		return rc;
=20
+#ifdef CONFIG_ARCH_IXP4XX
+	/* IXP4xx CPUs can't perform 8 and 16-bit MMIO reads,
+	   use normal IO from/to regions 0-5 instead.
+	   region 0: channel 0 (and 2) task file regs
+	   region 1: channel 0 (and 2) auxiliary status
+	   region 2: channel 1 (and 3) task file regs
+	   region 3: channel 1 (and 3) auxiliary status
+	   region 4: bus master DMA command and status for all channels
+	   region 5: the normal MMIO
+
+	   Channels 2 and 3 are present only on SIL3114, device selection
+	   is done with ATA_DEV1 bit in ATA_REG_DEVICE. FIXME - untested */
+	rc =3D pcim_iomap_regions(pdev, 0x3F, DRV_NAME);
+#else
 	rc =3D pcim_iomap_regions(pdev, 1 << SIL_MMIO_BAR, DRV_NAME);
+#endif
 	if (rc =3D=3D -EBUSY)
 		pcim_pin_device(pdev);
 	if (rc)
@@ -777,10 +792,16 @@ static int sil_init_one(struct pci_dev *pdev, con=
st struct pci_device_id *ent)
 		struct ata_port *ap =3D host->ports[i];
 		struct ata_ioports *ioaddr =3D &ap->ioaddr;
=20
+#ifdef CONFIG_ARCH_IXP4XX
+		ioaddr->cmd_addr =3D host->iomap[(i % 2) * 2];
+		ioaddr->altstatus_addr =3D host->iomap[1 + (i % 2) * 2] + 2;
+		ioaddr->bmdma_addr =3D host->iomap[4] + sil_port[i % 2].bmdma;
+#else
 		ioaddr->cmd_addr =3D mmio_base + sil_port[i].tf;
-		ioaddr->altstatus_addr =3D
-		ioaddr->ctl_addr =3D mmio_base + sil_port[i].ctl;
+		ioaddr->altstatus_addr =3D mmio_base + sil_port[i].ctl;
 		ioaddr->bmdma_addr =3D mmio_base + sil_port[i].bmdma;
+#endif
+		ioaddr->ctl_addr =3D mmio_base + sil_port[i].ctl;
 		ioaddr->scr_addr =3D mmio_base + sil_port[i].scr;
 		ata_sff_std_ports(ioaddr);
=20

--=20
Krzysztof Halasa
