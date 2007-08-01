From: Laurent Riffard <laurent.riffard@free.fr>
Subject: Re: 2.6.23-rc1-mm2 (checks-for-80wire-cable-use-in-pata_via)
Date: Wed, 01 Aug 2007 22:13:41 +0200
Message-ID: <46B0E975.30404@free.fr>
References: <20070731230932.a9459617.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1-g19.free.fr ([212.27.42.27]:53484 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755609AbXHAUNo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Aug 2007 16:13:44 -0400
In-Reply-To: <20070731230932.a9459617.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Le 01.08.2007 08:09, Andrew Morton a =E9crit :
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.23-=
rc1/2.6.23-rc1-mm2/
=2E..
> +libata-acpi-checks-for-80wire-cable-use-in-pata_via.patch
=2E..
>  sata/pata things

Alan,

this does not work after a suspend-resume cycle, I get a " ACPI get
timing mode failed (AE 0x1001)" error.

$ dmesg | grep ata
=2E..
scsi0 : pata_via
scsi1 : pata_via
ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma
0x0001b800 irq 14
ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma
0x0001b808 irq 15
ata1.00: ATA-5: ST340016A, 3.75, max UDMA/100
ata1.00: 78165360 sectors, multi 16: LBA
ata1.01: ATA-7: Maxtor 6Y080L0, YAR41BW0, max UDMA/133
ata1.01: 160086528 sectors, multi 16: LBA
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/100
ata2.00: ATAPI: HL-DT-ST DVDRAM GSA-4165B, DL03, max UDMA/33
ata2.01: ATAPI: CD-950E/AKU, A4Q, max MWDMA2, CDB intr
ata2.00: configured for UDMA/33
ata2.01: configured for MWDMA2
ata1.00: Unable to set Link PM policy
ata1.01: Unable to set Link PM policy
ata2.00: Unable to set Link PM policy
ata2.01: Unable to set Link PM policy
=2E..
[ suspend-to-disk/resume cycle happens here ]
=2E..
ata1.00: Unable to set Link PM policy
ata1.01: Unable to set Link PM policy
ata2.00: Unable to set Link PM policy
ata2.01: Unable to set Link PM policy
ata1: ACPI get timing mode failed (AE 0x1001)   <=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
ata1.00: limited to UDMA/33 due to 40-wire cable
ata1.01: limited to UDMA/33 due to 40-wire cable
ata1.00: configured for UDMA/33
ata1.01: configured for UDMA/33
ata2: ACPI get timing mode failed (AE 0x1001)
ata2.00: configured for UDMA/33
ata2.01: configured for MWDMA2


Anyway, long before 2.6.23-rc1-mm2, 80-wire cable detection was
already wrong after a suspend-resume cycle. So I cooked the
following patch 2 days ago.

It may be the wrong approach but it works for me.

--=20
pata_via: preserve cable detection bits in via_do_set_mode

via_cable_detect performs cable detection by checking bits in PCI
layer. But via_do_set_mode overwrites these bits. This behaviour
breaks cable detection after suspend/resume cycle.

So let's teach via_do_set_mode to preserve cable detection bits.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
---

 drivers/ata/pata_via.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-2.6-mm/drivers/ata/pata_via.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6-mm.orig/drivers/ata/pata_via.c
+++ linux-2.6-mm/drivers/ata/pata_via.c
@@ -238,6 +238,7 @@ static void via_do_set_mode(struct ata_p
 	unsigned long T =3D  1000000000 / via_clock;
 	unsigned long UT =3D T/tdiv;
 	int ut;
+	u8 cable80_status;
 	int offset =3D 3 - (2*ap->port_no) - adev->devno;


@@ -287,6 +288,12 @@ static void via_do_set_mode(struct ata_p
 			ut =3D t.udma ? (0xe0 | (FIT(t.udma, 2, 9) - 2)) : 0x07;
 			break;
 	}
+
+	/* Preserve cable detection bit */
+	pci_read_config_byte(pdev, 0x50 + offset, &cable80_status);
+	cable80_status &=3D 0x10;
+	ut |=3D cable80_status;
+
 	/* Set UDMA unless device is not UDMA capable */
 	if (udma_type)
 		pci_write_config_byte(pdev, 0x50 + offset, ut);



