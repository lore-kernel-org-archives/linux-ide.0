From: "kern.petr@seznam.cz" <kern.petr@seznam.cz>
Subject: Re: via 6420 pata/sata controller
Date: Mon, 28 Feb 2005 23:29:54 +0100
Message-ID: <42239B62.6090704@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Received: from mail.upce.cz ([195.113.124.33]:49575 "EHLO mail.upce.cz")
	by vger.kernel.org with ESMTP id S261797AbVB1WaE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Feb 2005 17:30:04 -0500
Received: from mail.upce.cz (root@localhost)
	by mail.upce.cz (8.12.11/8.12.11) with SMTP id j1SMY1bN015656
	for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2005 23:34:01 +0100
Received: from [10.53.5.5] ([10.53.5.5])
	by mail.upce.cz (8.12.11/8.12.11) with ESMTP id j1SMY0CE015648
	for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2005 23:34:00 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

 >>Bartlomiej Zolnierkiewicz wrote:
 >>> On Tuesday 30 of March 2004 15:24, Zdenek Tlusty wrote:
 >>>
 >>>>Hello,
 >>>>
 >>>>I have problem with via 6420 controller under linux (I have=20
mandrake 9.1
 >>>>with kernel 2.4.25 with libata patch version 16).
 >>>>This controller has two sata and one pata channels. Sata channel=20
works fine
 >>>>with libata. My problem is with pata channel. I have pata hard dis=
k=20
on this
 >>>>controller. Bios of the controller detected this disk but linux di=
d=20
not.
 >>>>What is the current status of the driver for this controller?
 >>>>Thank you for your time.
 >>>
 >>>
 >>> There are some patches floating around adding support for VT6410
 >>> (not VT6420) to generic IDE PCI driver. This controller may also w=
ork
 >>> with generic IDE PCI driver (PCI VendorID/ProductID needs to be ad=
ded
 >>> to drivers/ide/pci/generic.h and drivers/ide/pci/generic.c).
 >>
 >>VT 6420 should be added to via82cxxx.c, since it does the necessary =
bus
 >>setup and such. AFAICS it is programmed just like all the other VIA
 >>PATA controllers.
 >>
 >> BTW Does anybody has contacts in VIA?
 >>
 >>Sure... I'll check my VT 6420 cards as well. It should just be anoth=
er
 >>PCI id added to via82cxxx.c.
 >>
 >> Jeff
 >>
 >
 >Hello,
 >
 >I tried to modify via82cxxx.c and .h, but was unsuccessful. Has anyon=
e=20
got it to work properly?
 >
 >Kamil Okac

* Per my message (last quoted line), the user should add the PCI ID to =
*=20
drivers/ide/via82cxxx.[ch] and see what happens.
*
*     Jeff



Hello,
i trying resurrect this discussion again for solve this problem=20
successfuly.

My experiments:
I changed two files:

usr/src/linux-2.6.11-rc5/include/linux/pci_ids.h
--- cut here ---
#define PCI_DEVICE_ID_VIA_8703_51_0 0x3148
#define PCI_DEVICE_ID_VIA_8237_SATA 0x3149
#define PCI_DEVICE_ID_VIA_6420 0x4149                    ; <=3D this i =
was=20
add
#define PCI_DEVICE_ID_VIA_XN266 0x3156
#define PCI_DEVICE_ID_VIA_8754C_0 0x3168
--- cut here ---

/use/src/linux-2.6.11-rc5/drivers/ide/pci/via82cxxx.c
--- cut here ---
{ "vt8233c", PCI_DEVICE_ID_VIA_8233C_0, 0x00, 0x2f, VIA_UDMA_100 },
{ "vt8233", PCI_DEVICE_ID_VIA_8233_0, 0x00, 0x2f, VIA_UDMA_100 },
{ "vt8231", PCI_DEVICE_ID_VIA_8231, 0x00, 0x2f, VIA_UDMA_100 },
{ "vt6420", PCI_DEVICE_ID_VIA_6420, 0x00, 0x2f, VIA_UDMA_100 },        =
 =20
         ; <=3D this i was add
{ "vt82c686b", PCI_DEVICE_ID_VIA_82C686, 0x40, 0x4f, VIA_UDMA_100 },
{ "vt82c686a", PCI_DEVICE_ID_VIA_82C686, 0x10, 0x2f, VIA_UDMA_66 },
--- cut here ---

But i was not successful :'-(



Informations from my computer:
dmesg
--- cut here ---
Linux version 2.6.11-rc5 (root@linux) (gcc version 2.95.4 20011002=20
(Debian prerelease)) #1 Sat Feb 26 02:18:02 CET 2005
=2E
=2E
=2E
SCSI subsystem initialized
libata version 1.10 loaded.
sata_via version 1.1
sata_via(0000:00:0f.0): routed to hard irq line 10
ata1: SATA max UDMA/133 cmd 0x6200 ctl 0x6302 bmdma 0x6600 irq 10
ata2: SATA max UDMA/133 cmd 0x6400 ctl 0x6502 bmdma 0x6608 irq 10
ata1: no device found (phy stat 00000000)
scsi0 : sata_via
ata2: no device found (phy stat 00000000)
scsi1 : sata_via
--- cut here ---

lspci
--- cut here ---
0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SAT=
A=20
RAID Controller (rev 50)
0000:00:0f.1 RAID bus controller: VIA Technologies, Inc.: Unknown devic=
e=20
4149 (rev 80)
--- cut here ---

lspci -n
--- cut here ---
0000:00:0f.0 0104: 1106:3149 (rev 50)
0000:00:0f.1 0104: 1106:4149 (rev 80)
--- cut here ---

cat /proc/ioports
--- cut here ---
6200-6207 : 0000:00:0f.0
 6200-6207 : sata_via
6300-6303 : 0000:00:0f.0
 6300-6303 : sata_via
6400-6407 : 0000:00:0f.0
 6400-6407 : sata_via
6500-6503 : 0000:00:0f.0
 6500-6503 : sata_via
6600-660f : 0000:00:0f.0
 6600-660f : sata_via
6700-67ff : 0000:00:0f.0
 6700-67ff : sata_via
6800-6807 : 0000:00:0f.1
6900-6903 : 0000:00:0f.1
6a00-6a07 : 0000:00:0f.1
6b00-6b03 : 0000:00:0f.1
6c00-6c0f : 0000:00:0f.1
--- cut here ---

lsmod
--- cut here ---
Module                  Size  Used by
ipv6                  245568  10
uhci_hcd               30216  0
ohci_hcd               20736  0
ehci_hcd               32128  0
usbcore               113096  3 uhci_hcd,ohci_hcd,ehci_hcd
i2c_sis630              7688  0
i2c_sis5595             7424  0
i2c_core               22144  2 i2c_sis630,i2c_sis5595
sis_agp                 8576  0
agpgart                33612  1 sis_agp
parport_pc             34724  0
parport                35264  1 parport_pc
floppy                 58096  0
pcspkr                  3912  0
evdev                   9344  0
sata_via                8708  0
libata                 44804  1 sata_via
scsi_mod              129572  1 libata
via_rhine              22148  0
mii                     4992  1 via_rhine
ide_cd                 39296  0
cdrom                  37664  1 ide_cd
genrtc                 10008  0
ide_generic             1408  0 [permanent]
trm290                  4352  0 [permanent]
triflex                 3840  0 [permanent]
slc90e66                5760  0 [permanent]
sis5513                13960  0 [permanent]
siimage                11648  0 [permanent]
serverworks             7556  0 [permanent]
sc1200                  7168  0 [permanent]
rz1000                  2816  0 [permanent]
piix                   10244  0 [permanent]
pdc202xx_old           10496  0 [permanent]
pdc202xx_new            8704  0 [permanent]
opti621                 4484  0 [permanent]
ns87415                 3968  0 [permanent]
hpt366                 18176  0 [permanent]
ide_disk               16384  5 hpt366
hpt34x                  5120  0 [permanent]
generic                 4096  0 [permanent]
cy82c693                4480  0 [permanent]
cs5530                  4992  0 [permanent]
cs5520                  4736  0 [permanent]
cmd64x                 11288  0 [permanent]
atiixp                  6288  0 [permanent]
amd74xx                12700  0 [permanent]
alim15x3               10252  0 [permanent]
aec62xx                 7424  0 [permanent]
unix                   27916  10
via82cxxx              12184  0 [permanent]
ide_core              120368  28=20
ide_cd,ide_generic,trm290,triflex,slc90e66,sis5513,siimage,serverworks,=
sc1200,rz1000,piix,pdc202xx_old,pdc202xx_new,opti621,ns87415,hpt366,ide=
_disk,hpt34x,generic,cy82c693,cs5530,cs5520,cmd64x,atiixp,amd74xx,alim1=
5x3,aec62xx,via82cxxx
ext3                  126728  2
jbd                    56216  1 ext3
--- cut here ---


This controller talking about:
http://www.sunsway.com.hk/products/sata-ide.html
http://www.viatech.co.jp/en/Products/vt6420.jsp
http://www.via.com.tw/en/products/peripherals/serial-ata_raid/vt6420/

=46orum where they talked about - linux talking:
http://www.ussg.iu.edu/hypermail/linux/kernel/0403.3/1565.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0403.3/1814.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0403.3/1821.html
_http://www.ussg.iu.edu/hypermail/linux/kernel/0404.2/0573.html_

=46orum where they talked about - freebsd talking:
http://lists.freebsd.org/pipermail/freebsd-current/2004-January/017706.=
html
http://lists.freebsd.org/pipermail/freebsd-current/2004-January/017725.=
html


Your's Sincerely
Petr Nov=E1k
kern.petr@seznam.cz



