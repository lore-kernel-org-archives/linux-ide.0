From: David Ahern <dsahern@gmail.com>
Subject: boot failure with 4.13.0-rc6 due to ATA errors
Date: Mon, 28 Aug 2017 12:40:39 -0600
Message-ID: <3117ae58-d432-101e-3f0b-68d72fdee28b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Not sure why mailing list to direct this bug report to, so starting with
libata based on the error messages.

Some where between v4.12 and 4.13.0-rc6 a Celestica redstone switch
fails to boot due to ATA errors:

[    9.185203] ata1.00: failed to set xfermode (err_mask=0x40)
[    9.500825] ata1.00: revalidation failed (errno=-5)
[   20.449205] ata1.00: failed to set xfermode (err_mask=0x40)

I just tried Linus' top of tree (cc4a41fe5541) and it still fails. With
v4.12 the same switch boots and 'dmesg | grep ata' shows:

[    0.129080] libata version 3.00 loaded.
[    1.016520] ata1: SATA max UDMA/133 abar m2048@0xdffce000 port
0xdffce100 irq 27
[    1.016524] ata2: SATA max UDMA/133 abar m2048@0xdffce000 port
0xdffce180 irq 27
[    1.016528] ata3: SATA max UDMA/133 abar m2048@0xdffce000 port
0xdffce200 irq 27
[    1.016531] ata4: SATA max UDMA/133 abar m2048@0xdffce000 port
0xdffce280 irq 27
[    1.028623] ata5: SATA max UDMA/133 abar m2048@0xdffcd000 port
0xdffcd100 irq 28
[    1.028627] ata6: SATA max UDMA/133 abar m2048@0xdffcd000 port
0xdffcd180 irq 28
[    1.326767] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.328646] ata2: SATA link down (SStatus 0 SControl 300)
[    1.330519] ata4: SATA link down (SStatus 0 SControl 300)
[    1.330554] ata3: SATA link down (SStatus 0 SControl 300)
[    1.330575] ata1.00: ATA-9: InnoDisk Corp. - mSATA 3ME, S130604, max
UDMA/133
[    1.330581] ata1.00: 31277232 sectors, multi 16: LBA48 NCQ (depth
31/32), AA
[    1.332433] ata1.00: failed to get Identify Device Data, Emask 0x1
[    1.332709] ata1.00: failed to get Identify Device Data, Emask 0x1
[    1.332717] ata1.00: configured for UDMA/133
[    1.335813] ata6: SATA link down (SStatus 0 SControl 300)
[    1.339829] ata5: SATA link down (SStatus 0 SControl 300)

Given the overhead of building, installing, booting and recovering from
a failed boot, 'git bisect' is not a realistic option for this switch
option unless some one can cut the span to a few iterations.

If it helps, lspci and lsscsi output from an older kernel:

# lspci
00:00.0 Host bridge: Intel Corporation Atom processor C2000 SoC
Transaction Router (rev 02)
00:01.0 PCI bridge: Intel Corporation Atom processor C2000 PCIe Root
Port 1 (rev 02)
00:02.0 PCI bridge: Intel Corporation Atom processor C2000 PCIe Root
Port 2 (rev 02)
00:03.0 PCI bridge: Intel Corporation Atom processor C2000 PCIe Root
Port 3 (rev 02)
00:0e.0 Host bridge: Intel Corporation Atom processor C2000 RAS (rev 02)
00:0f.0 IOMMU: Intel Corporation Atom processor C2000 RCEC (rev 02)
00:13.0 System peripheral: Intel Corporation Atom processor C2000 SMBus
2.0 (rev 02)
00:14.0 Ethernet controller: Intel Corporation Ethernet Connection I354
(rev 03)
00:14.1 Ethernet controller: Intel Corporation Ethernet Connection I354
(rev 03)
00:14.2 Ethernet controller: Intel Corporation Ethernet Connection I354
(rev 03)
00:16.0 USB controller: Intel Corporation Atom processor C2000 USB
Enhanced Host Controller (rev 02)
00:17.0 SATA controller: Intel Corporation Atom processor C2000 AHCI
SATA2 Controller (rev 02)
00:18.0 SATA controller: Intel Corporation Atom processor C2000 AHCI
SATA3 Controller (rev 02)
00:1f.0 ISA bridge: Intel Corporation Atom processor C2000 PCU (rev 02)
00:1f.3 SMBus: Intel Corporation Atom processor C2000 PCU SMBus (rev 02)
01:00.0 Ethernet controller: Broadcom Corporation Device b854 (rev 03)


# lsscsi
[0:0:0:0]    disk    ATA      InnoDisk Corp. - 604   /dev/sda
