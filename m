From: "Jason Pfingstmann" <jason@pfingstmann.com>
Subject: sata_sil - broke at some point
Date: Sun, 2 Jul 2006 21:58:05 -0700
Message-ID: <cec86d5f0607022158n713e0d73ue967ecb93eb3b1e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:62589 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751298AbWGCE6H (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Jul 2006 00:58:07 -0400
Received: by py-out-1112.google.com with SMTP id c39so1206782pyd
        for <linux-ide@vger.kernel.org>; Sun, 02 Jul 2006 21:58:06 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

I've got a SIL3112-based PCMCIA SATA controller which, I believe,
worked on my old system (~2.6.11 maybe?  Not sure, don't have it
anymore - sorry).  I have been trying to get it to work with 2.6.17.1
(don't see anything major that should effect up through 2.6.17.3, so
unless requested to, am sticking with this vers (dialup))).  Thanks in
advance.

Here's what I have:

lspci -v:
04:00.0 Mass storage controller: Silicon Image, Inc. SiI 3112
[SATALink/SATARaid] Serial ATA Controller (rev 01)
        Subsystem: Silicon Image, Inc. SiI 3112 SATALink Controller
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 177
        I/O ports at b410 [size=8]
        I/O ports at b420 [size=4]
        I/O ports at b418 [size=8]
        I/O ports at b424 [size=4]
        I/O ports at b400 [size=16]
        Memory at 52000000 (32-bit, non-prefetchable) [size=512]
        [virtual] Expansion ROM at 50000000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2

related dmesg:
pccard: CardBus card inserted into slot 0
yenta EnE: chaning testregister 0xC9, 04 -> 04
PCI: Enabling device 0000:04:00.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 22 (level, low) -> IRQ 177
sata_sil 0000:04:00.0: cache line size not set.  Driver may not function
PCI: Setting latency timer of device 0000:04:00.0 to 64
ata3: SATA max UDMA/100 cmd 0xFFFFC20000058080 ctl 0xFFFFC2000005808A
bmdma 0xFFFFC20000058000 irq 177
ata4: SATA max UDMA/100 cmd 0xFFFFC200000580C0 ctl 0xFFFFC200000580CA
bmdma 0xFFFFC20000058008 irq 177
ata3: SATA link down (SStatus 0)
scsi2 : sata_sil
ata4: SATA link up 1.5 Gbps (SStatus 113)
ata4: dev 0 cfg 49:2f00 82:346b 83:7f61 84:4003 85:3469 86:3c41 87:4003 88:007f
ata4: dev 0 ATA-6, max UDMA/133, 488397168 sectors: LBA48
ata4: qc timeout (cmd 0xef)
ata4: failed to set xfermode (err_mask=0x4)
scsi3 : sata_sil
pccard: card ejected from slot 0

I'm using a "gentoo-sources" Gentoo kernel, but have run diff against
a vanilla 2.6.17.1 sata_sil.c with no differences.  I have sata_sil
built into the kernel currently.

The drive connected to it is a WD2500.

Full lspci (without -v) (posting due to reading something about
sata_sil and IXP):
00:00.0 Host bridge: ATI Technologies Inc ATI Radeon Xpress 200
(RS480/RS482/RX480/RX482) Chipset - Host bridge (rev 01)
00:02.0 PCI bridge: ATI Technologies Inc RS480 PCI-X Root Port
00:06.0 PCI bridge: ATI Technologies Inc RS480 PCI Bridge
00:13.0 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
00:13.1 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
00:13.2 USB Controller: ATI Technologies Inc IXP SB400 USB2 Host Controller
00:14.0 SMBus: ATI Technologies Inc IXP SB400 SMBus Controller (rev 11)
00:14.1 IDE interface: ATI Technologies Inc Standard Dual Channel PCI
IDE Controller ATI
00:14.3 ISA bridge: ATI Technologies Inc IXP SB400 PCI-ISA Bridge
00:14.4 PCI bridge: ATI Technologies Inc IXP SB400 PCI-PCI Bridge
00:14.5 Multimedia audio controller: ATI Technologies Inc IXP SB400
AC'97 Audio Controller (rev 02)
00:14.6 Modem: ATI Technologies Inc ATI SB400 - AC'97 Modem Controller (rev 02)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
01:00.0 VGA compatible controller: ATI Technologies Inc M24 1P [Radeon
Mobility X600]
02:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8036
PCI-E Fast Ethernet Controller (rev 10)
03:05.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller (rev 01)
03:07.0 Network controller: Broadcom Corporation BCM4318 [AirForce One
54g] 802.11g Wireless LAN Controller (rev 02)
03:0e.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 80)
04:00.0 Mass storage controller: Silicon Image, Inc. SiI 3112
[SATALink/SATARaid] Serial ATA Controller (rev 01)

Other errors that *MAY* be related on my system:
dmesg reports this frequently, but I've read that I can safely ignore this:
APIC error on CPU0: 40(40)


-Jason Pfingstmann
