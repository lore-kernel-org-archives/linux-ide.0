From: "kern.petr@seznam.cz" <kern.petr@seznam.cz>
Subject: Re: via 6420 pata/sata controller
Date: Fri, 04 Mar 2005 15:10:38 +0100
Message-ID: <42286C5E.2020106@seznam.cz>
References: <42213771.5060809@seznam.cz> <42255E5D.1030908@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Received: from mail.upce.cz ([195.113.124.33]:12714 "EHLO mail.upce.cz")
	by vger.kernel.org with ESMTP id S262890AbVCDOKp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Mar 2005 09:10:45 -0500
Received: from mail.upce.cz (root@localhost)
	by mail.upce.cz (8.12.11/8.12.11) with SMTP id j24EEklX007106
	for <linux-ide@vger.kernel.org>; Fri, 4 Mar 2005 15:14:46 +0100
In-Reply-To: <42255E5D.1030908@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com, B.Zolnierkiewicz@elka.pw.edu.pl, vojtech@suse.cz, giovanni@sudfr.com, andre@linux-ide.org, dake@staszic.waw.pl

I downloaded new kernel 2.6.11, applied your's via82cxxx.c patch and=20
compiled it (.config was derived "make oldconfig" from 2.6.8 kernel fro=
m=20
Debian Sarge 3.1).

I created initrd.img with this settings:
/etc/mkinitrd/mkinitrd.conf
--- cut here ---
MODULES=3Ddep
--- cut here ---

/etc/mkinitrd/modules
###
jbd
ext3
ide-core
via82cxxx

I boot PC with this settings:
/etc/modules
###
ide-cd
via82cxxx

Results:
Everything is the same, dmesg, lspci, lspci -n, cat /proc/ioports, lsmo=
d=20
as the last email.

Controller still don't working :'(.

PS: I don't add anything into pci_ids.h, I only applied your's=20
via82cxxx.c patch:
#define PCI_DEVICE_ID_VIA_6420 0x4149

Your's Sincerely
Petr Nov=E1k
kern.petr@seznam.cz

Jeff Garzik napsal(a):

> If I had to guess, I would try the attached patch.  The via82cxxx.c=20
> driver is a bit annoying in that, here we do not talk to the ISA=20
> bridge but to the PCI device 0x4149 itself.
>
> If this doesn't work, I could probably whip together a quick PATA=20
> driver for libata that works on this hardware.
>
>     Jeff =20
>
>----------------------------------------------------------------------=
--
>
>=3D=3D=3D=3D=3D drivers/ide/pci/via82cxxx.c 1.27 vs edited =3D=3D=3D=3D=
=3D
>--- 1.27/drivers/ide/pci/via82cxxx.c	2005-02-03 02:24:29 -05:00
>+++ edited/drivers/ide/pci/via82cxxx.c	2005-03-02 01:28:26 -05:00
>@@ -79,6 +79,7 @@
> 	u8 rev_max;
> 	u16 flags;
> } via_isa_bridges[] =3D {
>+	{ "vt6420",	0x4149,			    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
> 	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 | V=
IA_BAD_AST },
> 	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 | V=
IA_BAD_AST },
> 	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, VIA_UDMA_133 | =
VIA_BAD_AST },
>@@ -635,9 +636,10 @@
> }
>=20
> static struct pci_device_id via_pci_tbl[] =3D {
>-	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C576_1, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, 0},
>-	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, 0},
>-	{ 0, },
>+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C576_1) },
>+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1) },
>+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, 0x4149) },
>+	{ },	/* terminate list */
> };
> MODULE_DEVICE_TABLE(pci, via_pci_tbl);
>


