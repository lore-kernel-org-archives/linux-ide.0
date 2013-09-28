From: Dimitar Boyn <dimitarboyn@cyclone-trading.com>
Subject: Fwd: AHCI driver does not discover PCIe Marvell based SSD device
Date: Sat, 28 Sep 2013 02:20:07 -0700
Message-ID: <CAH2BsKWNo1X=W2917xfGWt4K64HuhKk9=-2jRxACBF7VavNOkA@mail.gmail.com>
References: <CAH2BsKX7_qOE33ZZ27TgXpK74zQh6XUuFYgHjtsd5nURpwJ15w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ea0-f172.google.com ([209.85.215.172]:61955 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574Ab3I1JUI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Sep 2013 05:20:08 -0400
Received: by mail-ea0-f172.google.com with SMTP id r16so1652777ead.31
        for <linux-ide@vger.kernel.org>; Sat, 28 Sep 2013 02:20:07 -0700 (PDT)
In-Reply-To: <CAH2BsKX7_qOE33ZZ27TgXpK74zQh6XUuFYgHjtsd5nURpwJ15w@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org

Hi, Jeff! (and Team)

We still work with early engineering releases of M.2 SSD at this point
as PCIe compatible M.2 will not be available commercially for at least
a few weeks.
Current implementations use AHCI controllers by Marvell.
We are able to natively install RHEL 6.3 on it as boot device where it
is discovered as the device:

0a:00.0 SATA controller: Marvell Technology Group Ltd. Device 9183 (rev=
 14)

You can see that in BIOS the PCIe device is correctly discovered too:
<Missing picture>

My question is related to other Linux related platforms which do not
identify the device as SSD SATA at boot time - and in particular
Oracle vServer, XenServer 6.2.

I have gathered some information included bellow and noticed that
drivers included in the distributions were dependent on other modules
before.

Could you please explain the changes in the module included with RHEL
6.3 and advise how/what to modify in the other distributions to enable
correct recognition at install time?

-----------------------------------------------------------------------=
----------------

RHEL 6.3

#modinfo ahci

filename:       /lib/modules/2.6.32-279.el6.x86_64/kernel/drivers/ata/a=
hci.ko

version:        3.0

license:        GPL

description:    AHCI SATA low-level driver

author:         Jeff Garzik

srcversion:     C45EE190F3F2730DF6E95A0

depends:

vermagic:     2.6.32-279.el6.x86_64 SMP mod_unload modversions

parm:           skip_host_reset:skip global host reset (0=3Ddon't skip,
1=3Dskip) (int)

parm:           ignore_sss:Ignore staggered spinup flag (0=3Ddon't
ignore, 1=3Dignore) (int)

parm:           ahci_em_messages:AHCI Enclosure Management Message
control (0 =3D off, 1 =3D on) (int)

parm:           marvell_enable:Marvell SATA via AHCI (1 =3D enabled) (i=
nt)

#yum install smartmontools

#uname -u

2.6.32-279.el6.x86_64 #1 SMP Wed Jun 13 18:24:36 EDT 2012 x86_64
x86_64 x86_64 GNU/Linux

# lsmod | grep ahci

Module              Size  Used by

ahci                   40871  8

#cat /sys/module/ahci/parameters/ahci_em_messages  1

#cat /sys/module/ahci/parameters/ignore_sss 0

#cat /sys/module/ahci/parameters/marvell_enable

0

#cat /sys/module/ahci/parameters/skip_host_reset

0

from /var/log/messg

=85=85=85=85=85=85=85

kernel: ahci 0000:0a:00.0: PCI INT A -> GSI 30 (level, low) -> IRQ 30

kernel: ahci 0000:0a:00.0: AHCI 0001.0000 32 slots 1 ports 6 Gbps 0x1
impl SATA mode

kernel: ahci 0000:0a:00.0: flags: 64bit ncq sntf led pio slum part

kernel: scsi7 : ahci

kernel: ata7: SATA max UDMA/133 abar m512@0xb9b00000 port 0xb9b00100 ir=
q 65

kernel: ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)

kernel: ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 300)

kernel: ata7.00: ATA-8: LITEONIT LGT-128B1P, VG7RDTB, max UDMA/133

kernel: ata7.00: 250069680 sectors, multi 1: LBA48 NCQ (depth 31/32), A=
A

kernel: ata7.00: configured for UDMA/133
--------------------------------------
however:

Xen Server 6.2

#modinfo ahci

filename: /lib/modules/2.6.32.43-0.4.1.xs1.8.0.835.170778xen/kernel/dri=
vers/ata/ahci.ko

version: 3.0

description: AHCI SATA low-level driver

author: Jeff Garzik

srcversion: 2A18A052E06680917E65277

depends: libata

vermagic: 2.6.32.43-0.4.1.xs1.8.0.835.170778xen SMP mod_unload
modversions Xen 686

parm: skip_host_reset: skip global host reset (0=3Ddon=92t skip, 1=3Dsk=
ip) (int)

parm: ignore_sss: Ignore staggered spinup flag (0=3Ddon=92t ignore, 1=3D=
ignore) (int)

parm: ahci_em_messages: Set AHCI Enclosure Management Message type
(0=3Ddisabled, 1=3DLED) (int)

parm: marvell_enable: Marvell SATA via AHCI (1=3Denabled) (int)


Oracle vServer (v37306-01.iso)

#uname -u

2.6.39-300.29.1.el5uek #1 SMP THu Feb 14 03:32:54 PST 2013 x86_64 GNU/L=
inux


#lsmod | grep ahci

ahci 22884 0

libahci 24254 1 ahci


#lspci

0a:00.0 SATA Controller: Marvell Technology Group LTd. Device 9183 (rev=
 14)


#lspci -s 0a:00 -nn

a:00.0 SATA Controller [0106]: Marvell Technology Group LTd. Device
9183 [1b4b:9183] (rev 14)



Many Thanks!
Dimitar Boyn

--=20
-- LiveLoveDo
