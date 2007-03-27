From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA SB600
Date: Tue, 27 Mar 2007 11:31:41 +0900
Message-ID: <4608820D.2000203@gmail.com>
References: <4608807F.6040202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.238]:57710 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933956AbXC0Cbr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Mar 2007 22:31:47 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1765301wra
        for <linux-ide@vger.kernel.org>; Mon, 26 Mar 2007 19:31:46 -0700 (PDT)
In-Reply-To: <4608807F.6040202@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Mat=ED=ADas_Alejandro_Torres?= <torresmat@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello,

Mat=ED=ADas Alejandro Torres wrote:
> Ubuntu 6.10  with kernel version 2.6.21-rc5 compiled with ahci suppor=
t
>=20
> I have a MSI K9AGM motherboard that ships with four SB600 SATA ports =
but
> when the kernel is booting some errors are showed and the SATA disk i=
s
> not detected.
>=20
> Here is what dmesg throws:
>=20
> [    1.332000] ide: Assuming 33MHz system bus speed for PIO modes;
> override with idebus=3Dxx
> [    1.332000] ahci 0000:00:12.0: version 2.1
> [    1.332000] ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level,
> low) -> IRQ 16
> [    2.336000] ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 G=
bps
> 0xf impl SATA mode
> [    2.336000] ahci 0000:00:12.0: flags: 64bit ncq ilck pm led clo pm=
p
> pio slum part
> [    2.336000] ata1: SATA max UDMA/133 cmd 0xf8824d00 ctl 0x00000000
> bmdma 0x00000000 irq 222
> [    2.336000] ata2: SATA max UDMA/133 cmd 0xf8824d80 ctl 0x00000000
> bmdma 0x00000000 irq 222
> [    2.336000] ata3: SATA max UDMA/133 cmd 0xf8824e00 ctl 0x00000000
> bmdma 0x00000000 irq 222
> [    2.336000] ata4: SATA max UDMA/133 cmd 0xf8824e80 ctl 0x00000000
> bmdma 0x00000000 irq 222
> [    2.336000] scsi0 : ahci
> [    2.648000] ata1: SATA link down (SStatus 0 SControl 300)
> [    2.648000] scsi1 : ahci
> [    3.132000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [   33.132000] ata2.00: qc timeout (cmd 0xec)
> [   33.132000] ata2.00: failed to IDENTIFY (I/O error, err_mask=3D0x1=
04)
> [   34.112000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [   64.112000] ata2.00: qc timeout (cmd 0xec)
> [   64.112000] ata2.00: failed to IDENTIFY (I/O error, err_mask=3D0x1=
04)
> [   64.112000] ata2.00: limiting speed to UDMA7:PIO5
> [   65.092000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [   95.092000] ata2.00: qc timeout (cmd 0xec)
> [   95.092000] ata2.00: failed to IDENTIFY (I/O error, err_mask=3D0x1=
04)
> [   96.072000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [   96.072000] scsi2 : ahci
> [   96.384000] ata3: SATA link down (SStatus 0 SControl 300)
> [   96.384000] scsi3 : ahci
> [   96.696000] ata4: SATA link down (SStatus 0 SControl 300)

Does 2.6.20 work?  Has any version ever worked?

--=20
tejun
