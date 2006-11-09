From: snatcher snatcher <snatcher93@rocketmail.com>
Subject: Re : sata_sil problems with SIL3512 controler on a ppc target
Date: Thu, 9 Nov 2006 02:33:13 -0800 (PST)
Message-ID: <20061109103313.95820.qmail@web51414.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web51414.mail.yahoo.com ([206.190.39.155]:17529 "HELO
	web51414.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1754796AbWKIKdO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Nov 2006 05:33:14 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

By checking the old 2.4.20 driver used for this device, I've found the =
following lines :
#ifdef CONFIG_BUFFALO_PLATFORM=20
writel(0x10401554, mmio_base + 0x14c);=20
writel(0x10401554, mmio_base + 0x1cc);=20
#endif in the sil_init_one function (in sata_sil.c)... After some googl=
e searching, I've found this message from this mailing list : http://ww=
w.spinics.net/lists/linux-ide/msg00047.html
=3D> It says that for SiI 3114 contoler, we need to force write 0x10401=
554 instead of 0x10401555 in sfis_cfg (SATA FIS reception config regist=
er). By looking in the source code of the latest version, it looks like=
 my controler (Sil 3512) is set to apply this workaround too, but accor=
ding to my boot log, it's not applying it (It should write "Applying R_=
ERR on DMA / activate FIS errata fix" just after the error about the PC=
I cache). I'll add some traces to understand what's happening and I'll =
tell you ...
Sylver


----- Message d'origine ----
De : snatcher snatcher <snatcher93@rocketmail.com>
=C0 : linux-ide@vger.kernel.org
Envoy=E9 le : Jeudi, 9 Novembre 2006, 1h01mn 42s
Objet : sata_sil problems with SIL3512 controler on a ppc target

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




   =20

   =20
       =20
_______________________________________________________________________=
____=20
Yahoo! Mail r=E9invente le mail ! D=E9couvrez le nouveau Yahoo! Mail et=
 son interface r=E9volutionnaire.
http://fr.mail.yahoo.com
-
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html





=09

=09
	=09
_______________________________________________________________________=
____=20
D=E9couvrez une nouvelle fa=E7on d'obtenir des r=E9ponses =E0 toutes vo=
s questions !=20
Profitez des connaissances, des opinions et des exp=E9riences des inter=
nautes sur Yahoo! Questions/R=E9ponses=20
http://fr.answers.yahoo.com
