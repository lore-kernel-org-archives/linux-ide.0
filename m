From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Subject: libata - 2.6.21-rc4-git5, ata channel still badly configured
Date: Wed, 21 Mar 2007 22:37:57 +0100
Message-ID: <20070321213757.GB3637@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752990AbXCUVgN@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>
List-Id: linux-ide@vger.kernel.org

Hello,

as of 2.6.21-rc4-git5 this issue is still present.

> Subject    : ata_piix: PATA UDMA/100 configured as UDMA/33
> References : http://lkml.org/lkml/2007/2/20/294
> Submitter  : Fabio Comolli <fabio.comolli@gmail.com>
> Status     : unknown

ata_piix 0000:00:1f.1: version 2.10ac1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001ffa0 =
irq 14
ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001ffa8 =
irq 15
scsi0 : ata_piix
Time: acpi_pm clocksource has been installed.
Switched to high resolution mode on CPU 0
ata1.00: ATA-6: ST9100824A, 3.04, max UDMA/100
ata1.00: 195371568 sectors, multi 16: LBA48
ata1.01: ATAPI, max UDMA/33
ata1.00: configured for UDMA/33
ata1.01: configured for UDMA/33
scsi1 : ata_piix
ATA: abnormal status 0x7F on port 0x00010177
scsi 0:0:0:0: Direct-Access     ATA      ST9100824A       3.04 PQ: 0 AN=
SI: 5
SCSI device sda: 195371568 512-byte hdwr sectors (100030 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't sup=
port DPO or FUA
SCSI device sda: 195371568 512-byte hdwr sectors (100030 MB)

lspci:
00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Fa=
mily) IDE Controller (rev 04) (prog-if 8a [Master SecP PriP])
        Subsystem: ASUSTeK Computer Inc. Unknown device 1967
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at 01f0 [size=3D8]
        I/O ports at 03f4 [size=3D1]
        I/O ports at 0170 [size=3D8]
        I/O ports at 0374 [size=3D1]
        I/O ports at ffa0 [size=3D16]


--=20
Luk=E1=B9 Hejtm=E1nek
