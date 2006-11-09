From: snatcher snatcher <snatcher93@rocketmail.com>
Subject: sata_sil problems with SIL3512 controler on a ppc target
Date: Wed, 8 Nov 2006 16:01:42 -0800 (PST)
Message-ID: <20061109000142.54547.qmail@web51411.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web51411.mail.yahoo.com ([206.190.39.152]:45502 "HELO
	web51411.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1161764AbWKIABn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Nov 2006 19:01:43 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,
I'm working on making a "Buffalo Terastation Pro" Hardware runs a 2.6 k=
ernel (the stock kernel is a 2.4 one).
This hardware includes a powerpc 603e (running @ 266MHz) and two SATA S=
IL3512 controllers (as the device runs 4 drives) ...
At startup it's getting some problems with the controler, but i'm not a=
ble to understand what can be wrong ... I tried with a 2.6.18.2 kernel =
and a 2.6.19-rc5 kernel, and I have the same problem with both versions=
 ...
Here is the "interesting" part of the kernel log (2.6.19-rc5 log):

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2=20
ide: Assuming 33MHz system bus speed for PIO modes; override with idebu=
s=3Dxx=20
sata_sil 0000:00:0c.0: cache line size not set.  Driver may not functio=
n=20
ata1: SATA max UDMA/100 cmd 0xC9002C80 ctl 0xC9002C8A bmdma 0xC9002C00 =
irq 17=20
ata2: SATA max UDMA/100 cmd 0xC9002CC0 ctl 0xC9002CCA bmdma 0xC9002C08 =
irq 17=20
scsi0 : sata_sil=20
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)=20
ata1.00: ATA-7, max UDMA7, 488397168 sectors: LBA48 NCQ (depth 0/32)=20
ata1.00: configured for UDMA/100=20
scsi1 : sata_sil=20
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)=20
ata2.00: ATA-7, max UDMA7, 488397168 sectors: LBA48 NCQ (depth 0/32)=20
ata2.00: configured for UDMA/100=20
scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG SP2504C  VT10 PQ: 0 AN=
SI: 5=20
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)=20
sda: Write Protect is off=20
SCSI device sda: drive cache: write back=20
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)=20
sda: Write Protect is off=20
SCSI device sda: drive cache: write back=20
sda:<3>ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen=
=20
ata1.00: (BMDMA stat 0x0)=20
ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)=20
ata1: soft resetting port=20
ata1: port is slow to respond, please be patient (Status 0xd8)=20
ata1: port failed to respond (30 secs, Status 0xd8)=20
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)=20
ATA: abnormal status 0xD8 on port 0xC9002C87=20
ATA: abnormal status 0xD8 on port 0xC9002C87=20
ATA: abnormal status 0xD8 on port 0xC9002C87=20
ATA: abnormal status 0xD8 on port 0xC9002C87=20
ATA: abnormal status 0xD8 on port 0xC9002C87=20
ata1.00: zero err_mask for failed internal command, assuming AC_ERR_OTH=
ERAbout the "cache line size not set.  Driver may not function", I was =
able to force PCI cache function but it doesn't change anything ... I'v=
e also tried to compile the kernel with a gcc v4.1.2 with no change !
I really hope someone could help ... You can find complete boot logs fo=
r 2.6.18.2 & 2.6.19-rc5 here : http://forum.linkstationwiki.net/index.p=
hp?action=3Dvthread&forum=3D15&topic=3D1302&page=3D1#msg17099

Thanks,
Sylver




=09

=09
	=09
_______________________________________________________________________=
____=20
Yahoo! Mail r=E9invente le mail ! D=E9couvrez le nouveau Yahoo! Mail et=
 son interface r=E9volutionnaire.
http://fr.mail.yahoo.com
