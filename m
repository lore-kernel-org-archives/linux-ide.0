From: Anders Widman <andewid@tnonline.net>
Subject: IDE
Date: Fri, 12 Jul 2002 13:23:18 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <495319109.20020712132318@tnonline.net>
References: <20020709102249.GA20870@suse.de>
 <20020709200711.GA13401@win.tue.nl> <20020710054356.GE3185@suse.de>
 <20020710111115.GJ3185@suse.de> <20020712110620.GA14338@win.tue.nl>
Reply-To: Anders Widman <andewid@tnonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20020712110620.GA14338@win.tue.nl>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

As there seem to be more activity now, maybe someone can help me get
UDMA 66/100 to work with Promise U100 cards.

I have tested on three different systems with 4 brands (Maxtor,
Seagate, Quantum, IBM) of harddrives. The highest mode I can set is
UDMA33. When I try to use anything higher I get an error in the kernel
log saying "kernel: ide2: Speed warnings UDMA 3/4/5 is not functional".

All drives support higher at least UDMA 100.

I have tested with most of the 2.4.17-19 kernels, including the Red
Hat kernels under Red Hat 7.2 and 7.3. I have also used the -AC
patches.  I have also compiled with and without "IGNORE word93
Validation BITS"

The current kernel is 2.4.19-rc1.


dmesg log says this om my current system:
---

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:DMA
PDC20268: IDE controller on PCI bus 00 dev 48
PCI: Found IRQ 4 for device 00:09.0
PCI: Sharing IRQ 4 with 00:04.2
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0x9800-0x9807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x9808-0x980f, BIOS settings: hdg:pio, hdh:pio
PDC20268: IDE controller on PCI bus 00 dev 58
PCI: Found IRQ 10 for device 00:0b.0 
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
    ide4: BM-DMA at 0x8000-0x8007, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0x8008-0x800f, BIOS settings: hdk:pio, hdl:pio

---
hde: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, UDMA(33)
hdf: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, UDMA(33)
hdg: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63, UDMA(33)
hdh: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(33)
hdi: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, UDMA(33)
hdj: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, UDMA(33)
hdk: 117266688 sectors (60041 MB) w/2000KiB Cache, CHS=116336/16/63, UDMA(33)
hdl: 117266688 sectors (60041 MB) w/2000KiB Cache, CHS=116336/16/63, UDMA(33)
---
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xb000-0xb007,0xa802 on irq 4
ide3 at 0xa400-0xa407,0xa002 on irq 4
ide4 at 0x9400-0x9407,0x9002 on irq 10
ide5 at 0x8800-0x8807,0x8402 on irq 10
---
hde: ST360021A, ATA DISK drive
hdf: IC35L060AVER07-0, ATA DISK drive
hdg: Maxtor 4G160J8, ATA DISK drive
hdh: Maxtor 4G120J6, ATA DISK drive
hdi: Maxtor 98196H8, ATA DISK drive
hdj: Maxtor 98196H8, ATA DISK drive
hdk: MAXTOR 4K060H3, ATA DISK drive
hdl: MAXTOR 4K060H3, ATA DISK driv



The Promise U100Tx2 BIOS does report UDMA100 for ALL drives.

