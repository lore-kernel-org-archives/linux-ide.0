From: "Ing. Hugo Mora" <h.mora@melix.com.mx>
Subject: libata (sil + seagate)
Date: Wed, 6 Oct 2004 12:49:12 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200410061249.13403.h.mora@melix.com.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dsl-200-67-111-248.prod-empresarial.com.mx ([200.67.111.248]:5568
	"EHLO bli.melix.com.mx") by vger.kernel.org with ESMTP
	id S269337AbUJFRt1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Oct 2004 13:49:27 -0400
Received: from [192.168.9.7] (hugo.local [192.168.9.7])
	by bli.melix.com.mx (Postfix) with ESMTP id 4E659716AE
	for <linux-ide@vger.kernel.org>; Wed,  6 Oct 2004 12:49:22 -0500 (CDT)
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi Jeff,

Hope not being bothering you, I have a gigabyte 7N400 Pro2 mobo, and I'=
m still=20
having problems, I tryied kernel 2.6.8.1 and i have this error:

Oct  5 01:15:04 linux kernel: ata1: command 0x35 timeout, stat 0x58 hos=
t_stat=20
0x1
Oct  5 01:15:04 linux kernel: ata1: status=3D0x58 { DriveReady SeekComp=
lete=20
DataRequest }
Oct  5 01:15:04 linux kernel: SCSI error : <0 0 0 0> return code =3D 0x=
8000002
Oct  5 01:15:04 linux kernel: EOM ILI Current sda: sense =3D 70 69
Oct  5 01:15:04 linux kernel: ASC=3D62 ASCQ=3D61
Oct  5 01:15:04 linux kernel: end_request: I/O error, dev sda, sector=20
164906075
Oct  5 01:15:04 linux kernel: Buffer I/O error on device sda6, logical =
block=20
3713
Oct  5 01:15:04 linux kernel: lost page write due to I/O error on sda6
Oct  5 01:15:04 linux kernel: ATA: abnormal status 0x58 on port 0xE0804=
087

the weird thing, is that I tryied Knoppix 3.6 whit 2.4.27 and the it wo=
rked,=20
mi chipset is sil3512 and discs are ST3120026AS     Barracuda 7200.7 SA=
TA=20
with firmware 3.56.

So, if you have some code that you want me to test it, feel free to sen=
d me, I=20
can help you to test in ths machine (and hope there can be a patch to a=
pply=20
to a SuSE kernel to keep using that distro, a vanilla kernel doesen't w=
ork)

Thanks in advance and greetings from Guadalajara Jalisco, M=E9xico.

boot.log of the libata
***********************************************************************=
***********************
<7>libata version 1.02 loaded.
<7>sata_sil version 0.54
<6>ACPI: PCI interrupt 0000:01:0d.0[A] -> GSI 11 (level, low) -> IRQ 11
<6>ata1: SATA max UDMA/100 cmd 0xE0804080 ctl 0xE080408A bmdma 0xE08040=
00 irq=20
11
<6>ata2: SATA max UDMA/100 cmd 0xE08040C0 ctl 0xE08040CA bmdma 0xE08040=
08 irq=20
11
<7>ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4=
003=20
88:207f
<6>ata1: dev 0 ATA, max UDMA/133, 234441648 sectors: lba48
<6>ata1: dev 0 configured for UDMA/100
<6>scsi0 : sata_sil
<7>ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4=
003=20
88:207f
<6>ata2: dev 0 ATA, max UDMA/133, 234441648 sectors: lba48
<6>ata2: dev 0 configured for UDMA/100
<6>scsi1 : sata_sil
<5>  Vendor: ATA       Model: ST3120026AS       Rev: 3.56
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<5>SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
<5>SCSI device sda: drive cache: write back
<6> sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
<5>Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
<5>  Vendor: ATA       Model: ST3120026AS       Rev: 3.56
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<5>SCSI device sdb: 234441648 512-byte hdwr sectors (120034 MB)
<5>SCSI device sdb: drive cache: write back
<6> sdb: sdb1
<5>Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
*******************************************************************
--=20
---------------------
Ing. Hugo Mora
Investigaci=F3n y desarrollo
M=E9lix - Especialistas en Software Libre, 45160 Zapopan, M=E9xico
tel. +52-33-3833 3289   fax +52-33-3636 0925   http://melix.com.mx  =20
