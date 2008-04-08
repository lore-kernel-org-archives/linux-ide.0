From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10425] New: Problem with pata_marvell kernel module : kernel 2.6.24.4 in Mandriva 2008.1 RC2 don't detect my IDE harddisk connected to a Marvell 88SE6111 IDE Controller
Date: Tue,  8 Apr 2008 08:53:26 -0700 (PDT)
Message-ID: <bug-10425-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33239 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751181AbYDHPyA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 Apr 2008 11:54:00 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m38FrQ54011751
	for <linux-ide@vger.kernel.org>; Tue, 8 Apr 2008 08:53:27 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=3D10425

           Summary: Problem with pata_marvell kernel module : kernel
                    2.6.24.4 in Mandriva 2008.1 RC2 don't detect my IDE
                    harddisk connected to a Marvell 88SE6111 IDE Contro=
ller
           Product: IO/Storage
           Version: 2.5
     KernelVersion: kernel 2.6.24.4
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: blocking
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: y.le.ny@ifrance.com


Latest working kernel version:=20
kernel 2.6.24.4

++++

Distribution:=20
Mandriva 2008.1 RC2

++++++

Hardware Environment:

I have a MSI P35 NEO Combo mainboard with an Intel Core 2 duo CPU (E460=
0) and
Nvidia 8600GT graphic card.
(http://global.msi.com.tw/index.php?func=3Dproddesc&prod_no=3D1216&main=
cat_no=3D1&cat2_no=3D170)
This mainboard have these chipsets:

=E2=80=A2 Intel=C2=AE P35 Chipset
- Supports FSB 800/1066/1333MHz.

=E2=80=A2 Intel=C2=AE ICH9 Chipset
- Hi-Speed USB (USB2.0) controller, 480Mb/sec, up to 12 ports.
- 4 SATAII ports (ICH9) with transfer rate up to 3Gb/s.
- PCI Master v2.3, I/O APIC.
- ACPI 2.0 compliant.

On-Board IDE/SATA

=E2=80=A2 One Ultra DMA 66/100/133 IDE controller integrated in Marvell=
=C2=AE 88SE6111.
- Supports PIO, Bus Master operation modes.
- Can connect up to two Ultra ATA drives.

=E2=80=A2 SATAII controller integrated in ICH9 and Marvell=C2=AE 88SE61=
11 chipset
- Up to 3Gb/s transfer speed.
- Supports four SATAII ports by ICH9.
- Supports one SATAII port by 88SE6111.

Harddisk : IDE Hitachi Deskstar 7K80 80 Go 2 Mo (HDS728080PLAT20)
DVD-ROM Reader/Writer : LG GSA-H22N =20

+++++


Problem Description:

My main harddisk where I want to create my root(/) and home (/home) par=
titions
is=20
an IDE Hitachi Deskstar 7K80 80 Go 2 Mo (HDS728080PLAT20) harddisk that=
 is
connected to an IDE controller integrated in Marvell 88SE6111 chipset.
My LG GSA-H22N DVD-Rom reader is connected to the same IDE connector  t=
han my
IDE harddisk.
I use this DVD-Rom reader for installing Mandriva 2008.1 RC2.

I have an other Hitachi harddisk that is connected to an SATAII port by=
 ICH9
chipset.

When I want to create my root linux partition, the mandriva installer s=
how me
only one harddisk that is connected to sata port. The installer don't s=
how my
main harddisk that is connnected to ide port with Marvell chipset.

Because I unplug my sata harddisk, the mandriva installer said me that =
it don't
find any harddisk on my PC computer. It propose to show me the harddisk
controller informations avaible on my computer :

The mandriva 2008.1 RC2 installer found these harddisk chipset on my co=
mputer :

pata_marvell : "Marvell Technology Group Ltd. | 88SE6121 SATA II Contro=
ller"
[Storage_IDE]

ata_piix : "Intel corporation (82801 | (ICH9 Family ) 2 port SATA IDE
Controller [storage_ide] (subv: 1462 subd : 7365)

ata_piix : "Intel corporation (82801 | (ICH9 Family ) 2 port SATA IDE
Controller [storage_ide] (subv: 1462 subd : 7365)

ata_piix : "Intel corporation (82801 | B (ICH9 Family ) 2 port SATA IDE
Controller [storage_ide] (subv: 1462 subd : 7365)

ata_piix : "Intel corporation (82801 | B (ICH9 Family ) 2 port SATA IDE
Controller [storage_ide] (subv: 1462 subd : 7365)

Version-Release number of selected component (if applicable):
Installer in MandrivaLinux 2008.1 RC2

How reproducible:
use an IDE harddisk connected to an IDE port with IDE 88SE6111 chipset =
on a
motherboard and a ICH9 chipset too on this same mainboard

+++++

VERY IMPORTANT INFORMATION :
I think that my IDE harddisk don't work with the latest kernel and Marv=
ell
88SE6111 chipset because there is no support for it in the pata_marvell=
 kernel
module.

When I browse kernel 2.6.25-rc8 sources by Web Git, I found the file :
[linux/kernel/git/torvalds/linux-2.6.git] / drivers / ata / pata_marvel=
l.c
source :
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
blob;f=3Ddrivers/ata/pata_marvell.c;h=3Da81f25d872355df8dad4d52b04103bd=
de9ad640c;hb=3D6fdf5e67fe8d3c83500dad9acae985132c2459a3

pata_marvell.c is the file for ide support in Marvell Chipset.
In this file, there is only support for :
Marvell 88SE6101
Marvell 88SE6121
Marvell 88SE6123
Marvell 88SE6145

This is support is with these lines 191 to 197 :
static const struct pci_device_id marvell_pci_tbl[] =3D {
192         { PCI_DEVICE(0x11AB, 0x6101), },
193         { PCI_DEVICE(0x11AB, 0x6121), },
194         { PCI_DEVICE(0x11AB, 0x6123), },
195         { PCI_DEVICE(0x11AB, 0x6145), },
196         { }     /* terminate list */
197 };=20

I found too that Alan Cox=20
date [Thu, 23 Aug 2007 19:19:55 +0000 (20:19 +0100)]
do : pata_marvell: Add more identifiers

modification=20
diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index 87594c0..ae206f3 100644 (file)
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -192,6 +192,8 @@ static int marvell_init_one (struct pci_dev *pdev, =
const
struct pci_device_id *i

 static const struct pci_device_id marvell_pci_tbl[] =3D {
        { PCI_DEVICE(0x11AB, 0x6101), },
+       { PCI_DEVICE(0x11AB, 0x6121), },
+       { PCI_DEVICE(0x11AB, 0x6123), },
        { PCI_DEVICE(0x11AB, 0x6145), },
        { }     /* terminate list */
 };
source
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff;h=3Dd36ee189f392ea89de85124a0b58477bb0f2e0a6

Can you patch the pata_marvell.c file and replace=20

static const struct pci_device_id marvell_pci_tbl[] =3D {
192         { PCI_DEVICE(0x11AB, 0x6101), },
193         { PCI_DEVICE(0x11AB, 0x6121), },
194         { PCI_DEVICE(0x11AB, 0x6123), },
195         { PCI_DEVICE(0x11AB, 0x6145), },
196         { }     /* terminate list */
197 };=20

by

static const struct pci_device_id marvell_pci_tbl[] =3D {
         { PCI_DEVICE(0x11AB, 0x6101), },
         { PCI_DEVICE(0x11AB, 0x6102), },
         { PCI_DEVICE(0x11AB, 0x6111), },
         { PCI_DEVICE(0x11AB, 0x6121), },
         { PCI_DEVICE(0x11AB, 0x6122), },
         { PCI_DEVICE(0x11AB, 0x6123), },
         { PCI_DEVICE(0x11AB, 0x6141), },
         { PCI_DEVICE(0x11AB, 0x6145), },
         { }     /* terminate list */
};=20


++++

Helpful Information :

A lot of information on Marvell 88SE61xx IDE/SATA chipsets
http://en.wikipedia.org/wiki/List_of_Marvell_Technology_Group_chipsets#=
Linux_IDE.28PATA.29_driver

My bug report at Mandriva team :
https://qa.mandriva.com/show_bug.cgi?id=3D39842

Thanks in advance.

Yannick


--=20
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=3Demail
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
