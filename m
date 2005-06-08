From: Sergio Navarro i Fajardo <sergio.navarro@uv.es>
Subject: Re: Re: sata_sil: Fix FIFO PCI Bus Arbitration KERNEL OOPS!
Date: Wed, 8 Jun 2005 17:26:03 +0200
Message-ID: <200506081726.03818.sergio.navarro@uv.es>
References: <200506081332.58717.navarro_ser@gva.es>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_L4wpCajFT5ujYcE"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 252.Red-81-37-175.pooles.rima-tde.net ([81.37.175.252]:45440
	"EHLO navax.aroigui.com") by vger.kernel.org with ESMTP
	id S261277AbVFHPa0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Jun 2005 11:30:26 -0400
In-Reply-To: <200506081332.58717.navarro_ser@gva.es>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

--Boundary-00=_L4wpCajFT5ujYcE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

El Wednesday 08 June 2005 13:32, escribi=F3:
> > But, this patch produces an oops on load modules sata_sil on my system:
> > sata_sil version 0.9
> Please try with attached patch.
>=20
> diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
> --- a/drivers/scsi/sata_sil.c
> +++ b/drivers/scsi/sata_sil.c
> @@ -432,7 +432,13 @@ static int sil_init_one (struct pci_dev

OK! Jens,
This patch corrects kernel oops.  Now, when I load sata_sil module no oops =
is=20
produced.
Now, kernel 2.6.12-rc6+patch reports this error:
Jun  8 17:18:08 localhost kernel: ata4: status=3D0x51 { DriveReady SeekComp=
lete=20
Error }
Jun  8 17:18:08 localhost kernel: ata4: error=3D0x04 { DriveStatusError }
[ .... ]
Jun  8 17:25:04 localhost kernel: ata3: command 0x25 timeout, stat 0x58=20
host_stat0x0
Jun  8 17:25:04 localhost kernel: ata3: status=3D0x58 { DriveReady SeekComp=
lete=20
DataRequest }
Jun  8 17:25:04 localhost kernel: SCSI error : <2 0 0 0> return code =3D=20
0x8000002
Jun  8 17:25:04 localhost kernel: sdc: Current: sense key=3D0xb
Jun  8 17:25:04 localhost kernel:     ASC=3D0x47 ASCQ=3D0x0
Jun  8 17:25:04 localhost kernel: end_request: I/O error, dev sdc, sector=20
1588672
Jun  8 17:25:04 localhost kernel: Buffer I/O error on device sdc, logical=20
block 198584
Jun  8 17:25:04 localhost kernel: ATA: abnormal status 0x58 on port 0xD0902=
E87

And system hangs!!

I attach the dmesg and the lspci output.

Bye!
=2D-=20
____________________________________________________________________

 Sergio Navarro i Fajardo

  sergio.navarro@uv.es  --  sernafa@gmail.com
  GnuPG-Public-Key: 0x24E340FF
  Alginet / Valencia / Spain

--Boundary-00=_L4wpCajFT5ujYcE
Content-Type: text/plain;
  charset="iso-8859-1";
  name="lspci.2.6.12-rc6"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci.2.6.12-rc6"

0000:00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0258
	Subsystem: VIA Technologies, Inc.: Unknown device 0258
	Flags: bus master, 66MHz, medium devsel, latency 8
	Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [80] AGP version 3.5
	Capabilities: [50] Power Management version 2
00: 06 11 58 02 06 00 30 22 00 00 00 06 00 08 80 00
10: 08 00 00 f8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 58 02
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00
40: 7f aa 11 aa 00 00 00 00 00 00 1f c4 00 04 00 01
50: 01 00 02 00 00 00 00 00 08 00 01 80 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 02 50 35 00 07 02 00 1f 00 00 00 00 28 00 00 00
90: 80 01 00 00 30 0f 01 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 25 d2 80 80
c0: 04 02 40 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:00.1 Host bridge: VIA Technologies, Inc.: Unknown device 1258
	Flags: bus master, medium devsel, latency 0
00: 06 11 58 12 06 00 00 02 00 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:00.2 Host bridge: VIA Technologies, Inc.: Unknown device 2258
	Flags: bus master, medium devsel, latency 0
00: 06 11 58 22 06 00 00 02 00 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: a8 fe ef 88 38 28 00 00 00 00 00 00 00 b2 88 c7
60: 44 ff 0f 44 ff 0f f5 30 01 00 00 00 00 00 00 00
70: 22 11 22 11 70 08 44 00 54 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:00.3 Host bridge: VIA Technologies, Inc.: Unknown device 3258
	Flags: bus master, medium devsel, latency 0
00: 06 11 58 32 06 00 00 02 00 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 01 01 01 01 01 01 01 45 00 00 00 00 00 00 00
50: e0 00 00 00 0d 82 b5 1a 10 00 00 00 00 00 00 00
60: 00 00 00 00 00 99 80 50 85 8f 65 10 00 00 84 00
70: 7c 77 3b 3e 88 00 01 00 13 01 63 63 00 00 00 00
80: aa 0a a0 00 00 ff 29 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: aa 00 78 00 99 00 00 00 aa 00 00 00 10 11 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:00.4 Host bridge: VIA Technologies, Inc.: Unknown device 4258
	Flags: bus master, medium devsel, latency 0
00: 06 11 58 42 06 00 00 02 00 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 80 20 c3 80 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 04 00 00 00 00 00 82 00 05 60 09 00 00 00 00 00

0000:00:00.7 Host bridge: VIA Technologies, Inc.: Unknown device 7258
	Flags: bus master, medium devsel, latency 0
00: 06 11 58 72 06 00 00 02 00 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 44 39 88 80 82 44 00 00 13 39 88 80 82 44 00 00
50: 00 00 00 00 00 00 01 10 08 00 01 80 00 00 00 00
60: 00 aa 0a 80 00 00 00 00 00 00 00 00 00 00 00 00
70: 82 c8 e8 01 20 0f 50 28 01 00 00 00 00 00 00 02
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 30 0f 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 01 00 00 00 63 46 68 02 6b 84 6a 01 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 29 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00006000-00006fff
	Memory behind bridge: ff900000-ff9fffff
	Prefetchable memory behind bridge: e7f00000-f7efffff
	Capabilities: [70] Power Management version 2
00: 06 11 98 b1 07 01 30 02 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 60 60 20 22
20: 90 ff 90 ff f0 e7 e0 f7 00 00 00 00 00 00 00 00
30: 00 00 00 00 70 00 00 00 00 00 00 00 00 00 0f 00
40: 83 c7 02 44 34 72 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 01 00 02 02 00 00 00 00 00 00 00 00 00 00 00 00
80: 0e 00 35 00 07 02 00 1f 00 00 00 00 28 00 00 00
90: 80 00 00 00 00 0f 01 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: bf 63 08 00 00 00 00 00 00 00 1f c4 00 04 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet (rev 10)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 702c
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 169
	I/O ports at d800 [size=256]
	Memory at ffeffd00 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at ffec0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
00: ec 10 69 81 17 00 b0 02 10 00 00 02 20 20 00 00
10: 01 d8 00 00 00 fd ef ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 2c 70
30: 00 00 ec ff dc 00 00 00 00 00 00 00 0a 01 20 40
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 c2 f7
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:09.0 RAID bus controller: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3112 [SATALink/SATARaid] Serial ATA Controller (rev 02)
	Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) Asus A7N8X
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 185
	I/O ports at ec00 [size=8]
	I/O ports at e800 [size=4]
	I/O ports at e400 [size=8]
	I/O ports at e000 [size=4]
	I/O ports at dc00 [size=16]
	Memory at ffeffe00 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at ffe00000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
00: 95 10 12 31 07 00 b0 02 02 00 04 01 08 20 00 00
10: 01 ec 00 00 01 e8 00 00 01 e4 00 00 01 e0 00 00
20: 01 dc 00 00 00 fe ef ff 00 00 00 00 95 10 12 61
30: 00 00 e0 ff 60 00 00 00 00 00 00 00 0b 01 00 00
40: 02 00 00 00 00 00 50 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 22 06 00 40 00 64 00 00 00 00 00 00 00 00
70: 08 00 00 00 00 e0 be 0f 08 00 00 00 00 10 8b 0e
80: 03 00 00 00 03 00 00 00 00 00 00 00 f5 57 13 ba
90: 00 00 01 0d ff ff ff 46 00 00 00 18 00 00 00 00
a0: 01 21 15 65 dd 62 dd 62 92 43 92 43 09 40 09 40
b0: 01 21 15 65 dd 62 dd 62 92 43 92 43 09 40 09 40
c0: 84 01 00 00 13 01 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:0a.0 RAID bus controller: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3112 [SATALink/SATARaid] Serial ATA Controller (rev 02)
	Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) Asus A7N8X
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 169
	I/O ports at d400 [size=8]
	I/O ports at d000 [size=4]
	I/O ports at cc00 [size=8]
	I/O ports at c800 [size=4]
	I/O ports at c400 [size=16]
	Memory at ffeffa00 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at ffd80000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
00: 95 10 12 31 07 00 b0 02 02 00 04 01 08 20 00 00
10: 01 d4 00 00 01 d0 00 00 01 cc 00 00 01 c8 00 00
20: 01 c4 00 00 00 fa ef ff 00 00 00 00 95 10 12 61
30: 00 00 d8 ff 60 00 00 00 00 00 00 00 0a 01 00 00
40: 02 00 00 00 11 00 1d b2 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 22 06 00 40 00 64 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 22 00 00 00 22 00 00 00 00 00 00 00 dd 31 52 de
90: 00 00 01 0d ff ff ff 46 00 00 00 18 00 00 00 00
a0: 01 21 15 65 dd 62 dd 62 92 43 92 43 09 40 09 40
b0: 01 21 15 65 dd 62 dd 62 92 43 92 43 09 40 09 40
c0: 84 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:0b.0 RAID bus controller: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3112 [SATALink/SATARaid] Serial ATA Controller (rev 02)
	Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) Asus A7N8X
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 193
	I/O ports at c000 [size=8]
	I/O ports at bc00 [size=4]
	I/O ports at b800 [size=8]
	I/O ports at b400 [size=4]
	I/O ports at b000 [size=16]
	Memory at ffeff800 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at ffd00000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
00: 95 10 12 31 07 00 b0 02 02 00 04 01 08 20 00 00
10: 01 c0 00 00 01 bc 00 00 01 b8 00 00 01 b4 00 00
20: 01 b0 00 00 00 f8 ef ff 00 00 00 00 95 10 12 61
30: 00 00 d0 ff 60 00 00 00 00 00 00 00 0c 01 00 00
40: 02 00 00 00 00 28 08 b2 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 22 06 00 40 00 64 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 22 00 00 00 22 00 00 00 00 00 00 00 de 29 d1 ce
90: 00 00 01 0d ff ff ff 46 00 00 00 18 00 00 00 00
a0: 01 21 15 65 dd 62 dd 62 92 43 92 43 09 40 09 40
b0: 01 21 15 65 dd 62 dd 62 92 43 92 43 09 40 09 40
c0: 84 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:0c.0 RAID bus controller: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3112 [SATALink/SATARaid] Serial ATA Controller (rev 02)
	Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) Asus A7N8X
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 201
	I/O ports at ac00 [size=8]
	I/O ports at a800 [size=4]
	I/O ports at a400 [size=8]
	I/O ports at a000 [size=4]
	I/O ports at 9c00 [size=16]
	Memory at ffeff600 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at ffc80000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
00: 95 10 12 31 07 00 b0 02 02 00 04 01 08 20 00 00
10: 01 ac 00 00 01 a8 00 00 01 a4 00 00 01 a0 00 00
20: 01 9c 00 00 00 f6 ef ff 00 00 00 00 95 10 12 61
30: 00 00 c8 ff 60 00 00 00 00 00 00 00 05 01 00 00
40: 02 00 00 00 00 00 80 a2 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 22 06 00 40 00 64 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 22 00 00 00 22 00 00 00 00 00 00 00 29 7c 5b bf
90: 00 00 01 0d ff ff ff 46 00 00 00 18 00 00 00 00
a0: 01 21 15 65 dd 62 dd 62 92 43 92 43 09 40 09 40
b0: 01 21 15 65 dd 62 dd 62 92 43 92 43 09 40 09 40
c0: 84 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0080
	Flags: bus master, medium devsel, latency 32, IRQ 177
	I/O ports at 9800 [size=8]
	I/O ports at 9400 [size=4]
	I/O ports at 9000 [size=8]
	I/O ports at 8c00 [size=4]
	I/O ports at 8800 [size=16]
	I/O ports at 8400 [size=256]
	Capabilities: [c0] Power Management version 2
00: 06 11 49 31 07 00 90 02 80 00 04 01 00 20 80 00
10: 01 98 00 00 01 94 00 00 01 90 00 00 01 8c 00 00
20: 01 88 00 00 01 84 00 00 00 00 00 00 62 14 80 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 05 02 00 00
40: 23 03 f1 44 06 af 00 00 10 82 65 03 00 00 00 00
50: 00 00 00 00 00 00 04 04 00 10 10 00 05 00 20 00
60: 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 01 00 01 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 30 38 01 00 50 38 01
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 80 02 49 31 62 14 80 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
	Flags: bus master, medium devsel, latency 32, IRQ 255
	I/O ports at fc00 [size=16]
	Capabilities: [c0] Power Management version 2
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 fc 00 00 00 00 00 00 00 00 00 00 06 11 71 05
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 01 00 00
40: 2b f2 09 05 18 8c c0 00 a8 a8 a8 a8 ff 00 b6 b6
50: 07 07 07 07 0c 00 00 00 a8 a8 a8 a8 00 00 00 00
60: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
70: 82 01 00 00 00 00 00 00 82 01 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 06 00 71 05 06 11 71 05 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 09 00 00 00 00 00 00 00 00 00

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at 7400 [size=32]
	Capabilities: [80] Power Management version 2
00: 06 11 38 30 17 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 74 00 00 00 00 00 00 00 00 00 00 06 11 38 30
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 01 00 00
40: 40 12 03 00 00 00 00 00 00 0b a0 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 c2 ff 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 a0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 00

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at 7800 [size=32]
	Capabilities: [80] Power Management version 2
00: 06 11 38 30 17 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 78 00 00 00 00 00 00 00 00 00 00 06 11 38 30
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 01 00 00
40: 40 12 03 00 00 00 00 00 00 0b a0 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 c2 ff 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 a0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 00

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at 7c00 [size=32]
	Capabilities: [80] Power Management version 2
00: 06 11 38 30 17 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 7c 00 00 00 00 00 00 00 00 00 00 06 11 38 30
30: 00 00 00 00 80 00 00 00 00 00 00 00 0b 02 00 00
40: 40 12 03 00 00 00 00 00 00 0b a0 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 c2 ff 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 a0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 00

0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at 8000 [size=32]
	Capabilities: [80] Power Management version 2
00: 06 11 38 30 17 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 80 00 00 00 00 00 00 00 00 00 00 06 11 38 30
30: 00 00 00 00 80 00 00 00 00 00 00 00 0b 02 00 00
40: 40 12 03 00 00 00 00 00 00 0b a0 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 c2 ff 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 a0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 00

0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20 [EHCI])
	Subsystem: VIA Technologies, Inc. USB 2.0
	Flags: bus master, medium devsel, latency 32, IRQ 10
	Memory at ffeff500 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
00: 06 11 04 31 17 00 10 02 86 20 03 0c 08 20 80 00
10: 00 f5 ef ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 04 31
30: 00 00 00 00 80 00 00 00 00 00 00 00 0a 03 00 00
40: 00 00 03 00 00 00 00 00 80 20 00 09 00 00 00 00
50: 00 5a 00 80 00 00 00 00 04 0b 66 88 03 66 88 00
60: 20 20 01 00 00 00 00 00 01 00 00 00 00 00 00 80
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 c2 ff 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 87 00 00 00 00 00 00 00 00 00

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2
00: 06 11 27 32 87 00 10 02 00 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00
40: 44 00 f0 00 00 00 00 00 0c 20 00 00 44 00 08 08
50: c0 89 09 00 00 00 00 00 43 80 00 01 00 00 04 08
60: 00 00 00 00 10 00 02 04 00 00 00 00 00 00 00 00
70: 06 11 00 00 00 00 00 00 00 00 00 00 20 00 00 00
80: 20 84 59 00 9a 00 00 00 01 08 00 00 0a 18 00 00
90: 00 d7 ec 00 b0 c5 05 00 10 37 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 01 04 01 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 04 0b 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 03 00 00 00 00 00 00 00 00 00

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE] (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Radeon 7000/Radeon VE
	Flags: bus master, stepping, 66MHz, medium devsel, latency 32
	Memory at e8000000 (32-bit, prefetchable) [size=128M]
	I/O ports at 6800 [size=256]
	Memory at ff9f0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at ff9c0000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
	Capabilities: [50] Power Management version 2
00: 02 10 59 51 87 00 b0 02 00 00 00 03 08 20 00 00
10: 08 00 00 e8 01 68 00 00 00 00 9f ff 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 10 3a 01
30: 00 00 9c ff 58 00 00 00 00 00 00 00 ff 00 08 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 02 10 3a 01
50: 01 00 02 06 00 00 00 00 02 50 20 00 07 02 00 2f
60: 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--Boundary-00=_L4wpCajFT5ujYcE
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg.2.6.12-rc6"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg.2.6.12-rc6"

Linux version 2.6.12-rc6 (root@array) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #3 Wed Jun 8 12:05:57 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
found SMP MP-table at 000fc020
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                   ) @ 0x000fa670
ACPI: RSDT (v001 AMIINT VIA_P6   0x00000010 MSFT 0x00000097) @ 0x0fff0000
ACPI: FADT (v001 AMIINT VIA_P6   0x00000011 MSFT 0x00000097) @ 0x0fff0030
ACPI: MADT (v001 AMIINT VIA_P6   0x00000009 MSFT 0x00000097) @ 0x0fff00c0
ACPI: DSDT (v001    VIA APOLLO-P 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 10000000 (gap: 10000000:eec00000)
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=2612 ro root=900 console=ttyS0,115200n8 console=tty0
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 2411.599 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 255836k/262080k available (1948k kernel code, 5668k reserved, 852k data, 184k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4718.59 BogoMIPS (lpj=2359296)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 0000441d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 0000441d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 0000441d 00000000 00000000
CPU: Intel(R) Celeron(R) CPU 2.40GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb11, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
Real Time Clock Driver v1.12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
r8169 Gigabit Ethernet driver 2.2LK loaded
ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 18 (level, low) -> IRQ 169
r8169: NAPI enabled
eth0: Identified chip type is 'RTL8169s/8110s'.
eth0: RTL8169 at 0xd0802d00, 00:11:09:c6:89:23, IRQ 169
ipddp.c:v0.01 8/28/97 Bradford W. Johnson <johns393@maroon.tc.umn.edu>
ipddp0: Appletalk-IP Encap. mode by Bradford W. Johnson <johns393@maroon.tc.umn.edu>
libata version 1.11 loaded.
sata_via version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 177
sata_via(0000:00:0f.0): routed to hard irq line 5
ata1: SATA max UDMA/133 cmd 0x9800 ctl 0x9402 bmdma 0x8800 irq 177
ata2: SATA max UDMA/133 cmd 0x9000 ctl 0x8C02 bmdma 0x8808 irq 177
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:407f
ata1: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_via
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:407f
ata2: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_via
  Vendor: ATA       Model: ST3160827AS       Rev: 3.42
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3160023AS       Rev: 3.05
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
 /dev/scsi/host1/bus0/target0/lun0: p1 p2 p3
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
mice: PS/2 mouse device common for all mice
md: raid1 personality registered as nr 3
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
NET: Registered protocol family 5
devfs_mk_dev: could not append to parent for md/0
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb3 ...
md:  adding sdb3 ...
md: sdb2 has different UUID to sdb3
md: sdb1 has different UUID to sdb3
md:  adding sda3 ...
md: sda2 has different UUID to sdb3
md: sda1 has different UUID to sdb3
devfs_mk_dev: could not append to parent for md/2
md: created md2
md: bind<sda3>
md: bind<sdb3>
md: running: <sdb3><sda3>
raid1: raid set md2 active with 2 out of 2 mirrors
md: considering sdb2 ...
md:  adding sdb2 ...
md: sdb1 has different UUID to sdb2
md:  adding sda2 ...
md: sda1 has different UUID to sdb2
devfs_mk_dev: could not append to parent for md/1
md: created md1
md: bind<sda2>
md: bind<sdb2>
md: running: <sdb2><sda2>
raid1: raid set md1 active with 2 out of 2 mirrors
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: running: <sdb1><sda1>
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 184k freed
input: AT Translated Set 2 keyboard on isa0060/serio0
input: AT Translated Set 2 keyboard on isa0060/serio0
Adding 497912k swap on /dev/md1.  Priority:-1 extents:1
EXT3 FS on md0, internal journal
ReiserFS: md2: found reiserfs format "3.6" with standard journal
ReiserFS: md2: using ordered data mode
ReiserFS: md2: journal params: device md2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md2: checking transaction log (md2)
ReiserFS: md2: Using r5 hash to sort names
sata_sil version 0.9
ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 17 (level, low) -> IRQ 185
ata3: SATA max UDMA/100 cmd 0xD0902E80 ctl 0xD0902E8A bmdma 0xD0902E00 irq 185
ata4: SATA max UDMA/100 cmd 0xD0902EC0 ctl 0xD0902ECA bmdma 0xD0902E08 irq 185
ata3: dev 0 cfg 49:2f00 82:74eb 83:7fea 84:4023 85:74e9 86:3c02 87:4023 88:203f
ata3: dev 0 ATA, max UDMA/100, 488397168 sectors: lba48
ata3: dev 0 configured for UDMA/100
scsi2 : sata_sil
ata4: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata4: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
ata4: dev 0 configured for UDMA/100
scsi3 : sata_sil
  Vendor: ATA       Model: HDS722525VLSA80   Rev: V36O
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdc: drive cache: write back
 /dev/scsi/host2/bus0/target0/lun0: p1
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
  Vendor: ATA       Model: ST3160827AS       Rev: 3.42
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdd: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdd: drive cache: write back
 /dev/scsi/host3/bus0/target0/lun0: unknown partition table
Attached scsi disk sdd at scsi3, channel 0, id 0, lun 0
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 18 (level, low) -> IRQ 169
ata5: SATA max UDMA/100 cmd 0xD090AA80 ctl 0xD090AA8A bmdma 0xD090AA00 irq 169
ata6: SATA max UDMA/100 cmd 0xD090AAC0 ctl 0xD090AACA bmdma 0xD090AA08 irq 169
ata5: no device found (phy stat 00000000)
scsi4 : sata_sil
ata6: no device found (phy stat 00000000)
scsi5 : sata_sil
ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 193
ata7: SATA max UDMA/100 cmd 0xD090C880 ctl 0xD090C88A bmdma 0xD090C800 irq 193
ata8: SATA max UDMA/100 cmd 0xD090C8C0 ctl 0xD090C8CA bmdma 0xD090C808 irq 193
ata7: no device found (phy stat 00000000)
scsi6 : sata_sil
ata8: no device found (phy stat 00000000)
scsi7 : sata_sil
ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 16 (level, low) -> IRQ 201
ata9: SATA max UDMA/100 cmd 0xD090E680 ctl 0xD090E68A bmdma 0xD090E600 irq 201
ata10: SATA max UDMA/100 cmd 0xD090E6C0 ctl 0xD090E6CA bmdma 0xD090E608 irq 201
ata9: no device found (phy stat 00000000)
scsi8 : sata_sil
ata10: no device found (phy stat 00000000)
scsi9 : sata_sil
r8169: eth0: link up
ata4: status=0x51 { DriveReady SeekComplete Error }
ata4: error=0x04 { DriveStatusError }
ata4: status=0x51 { DriveReady SeekComplete Error }
ata4: error=0x04 { DriveStatusError }
ata4: status=0x51 { DriveReady SeekComplete Error }
ata4: error=0x04 { DriveStatusError }
ata4: status=0x51 { DriveReady SeekComplete Error }
ata4: error=0x04 { DriveStatusError }
ata4: status=0x51 { DriveReady SeekComplete Error }
ata4: error=0x04 { DriveStatusError }
ata4: status=0x51 { DriveReady SeekComplete Error }
ata4: error=0x04 { DriveStatusError }

--Boundary-00=_L4wpCajFT5ujYcE--
