From: "Winstel, Drew" <DWinstel@Miltope.com>
Subject: PDC20269: Limit on number of controllers?
Date: Mon, 21 Feb 2005 16:32:45 -0600
Message-ID: <66F9227F7417874C8DB3CEB057727417044F96@MILEX0.Miltope.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Received: from firewall.miltope.com ([208.12.184.221]:51845 "EHLO
	MILEX0.Miltope.local") by vger.kernel.org with ESMTP
	id S262161AbVBUWcq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Feb 2005 17:32:46 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Linux-Ide (E-mail)" <linux-ide@vger.kernel.org>

Is there a limit on the number of Promise Ultra133TX2 (PDC20269
 chip) PATA interface cards that can be present on a system?  

Judging from my efforts to get a test PC running with the
configuration below, it would appear that there is a maximum 
of two cards that can be installed.  After much trial and error, 
I have determined that the errors listed below occur only on 
UDMA(100) drives that are connected to ide6 and later (that 
is, the 3rd card).  Master/slave jumper settings have no 
visible effect.

I tried using three Highpoint Rocket 133 cards to see if they 
performed any better, and they were not vulnerable to the DMA 
limitation, but I must have gotten a bad card or two since they 
left the drives in an unstable condition (/var/log/messages 
grew to 343M!).  

Steps to reproduce:
1) Set up a system with at least 3 Promise Ultra133TX2 cards in 
addition to having on-board primary and secondary IDE enabled.
2) Populate the primary master of the third controller with a 
drive supporting UDMA 5 or better.  It appears to have no 
bearing whether or not the first two controllers are populated 
or not.  
3) Check dmesg for errors akin to the ones below.

This dmesg output is from 2.6.7, but the problem also exists 
in 2.6.11-rc4.  

Oh, and before anyone asks me why in the world I would have a 
need for a system capable of addressing 16 drives attached to 
one PC, the machine's entire purpose is stressing the IDE drives 
to the limit before they are declared safe for production use.  
Ordinarily, I would say this isn't much of a problem, but during 
one of the stress runs, these problems force the drives to drop 
to PIO mode, thereby killing any resemblance of speed.  

Thanks for any help!

Drew Winstel


P.S. dmesg output follows:
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100%% native mode: will probe irqs later
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: TOSHIBA MK4019GAX, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: DVD-ROM DDU1621, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20269: IDE controller at PCI slot 0000:01:07.0
PDC20269: chipset revision 2
PDC20269: 100%% native mode on irq 10
    ide2: BM-DMA at 0x5c00-0x5c07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x5c08-0x5c0f, BIOS settings: hdg:pio, hdh:pio
hde: TOSHIBA MK8025GAS, ATA DISK drive
ide2 at 0x4c00-0x4c07,0x5002 on irq 10
hdg: TOSHIBA MK8025GAS, ATA DISK drive
ide3 at 0x5400-0x5407,0x5802 on irq 10
PDC20269: IDE controller at PCI slot 0000:01:08.0
PDC20269: chipset revision 2
PDC20269: 100%% native mode on irq 11
    ide4: BM-DMA at 0x7000-0x7007, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0x7008-0x700f, BIOS settings: hdk:pio, hdl:pio
hdi: TOSHIBA MK8025GAS, ATA DISK drive
ide4 at 0x6000-0x6007,0x6402 on irq 11
hdk: TOSHIBA MK8025GAS, ATA DISK drive
ide5 at 0x6800-0x6807,0x6c02 on irq 11
PDC20269: IDE controller at PCI slot 0000:01:09.0
PDC20269: chipset revision 2
PDC20269: 100%% native mode on irq 5
    ide6: BM-DMA at 0x8400-0x8407, BIOS settings: hdm:pio, hdn:pio
    ide7: BM-DMA at 0x8408-0x840f, BIOS settings: hdo:pio, hdp:pio
hdm: TOSHIBA MK8025GAS, ATA DISK drive
ide6 at 0x7400-0x7407,0x7802 on irq 5
hdo: TOSHIBA MK8025GAS, ATA DISK drive
ide7 at 0x7c00-0x7c07,0x8002 on irq 5
PDC20269: IDE controller at PCI slot 0000:01:0a.0
PDC20269: chipset revision 2
PDC20269: 100%% native mode on irq 12
    ide8: BM-DMA at 0x9800-0x9807, BIOS settings: hdq:pio, hdr:pio
    ide9: BM-DMA at 0x9808-0x980f, BIOS settings: hds:pio, hdt:pio
hdq: TOSHIBA MK8025GAS, ATA DISK drive
ide8 at 0x8800-0x8807,0x8c02 on irq 12
hds: TOSHIBA MK8025GAS, ATA DISK drive
ide9 at 0x9000-0x9007,0x9402 on irq 12
hda: max request size: 128KiB
hda: Host Protected Area detected.
hda: 78138047 sectors (40006 MB), CHS=65535/16/63, UDMA(33)
 hda: hda1 hda2 hda3
hde: max request size: 128KiB
hde: 156301488 sectors (80026 MB), CHS=65535/16/63, UDMA(100)
 hde: unknown partition table
hdg: max request size: 128KiB
hdg: 156301488 sectors (80026 MB), CHS=65535/16/63, UDMA(100)
 hdg: unknown partition table
hdi: max request size: 128KiB
hdi: 156301488 sectors (80026 MB), CHS=65535/16/63, UDMA(100)
 hdi: unknown partition table
hdk: max request size: 128KiB
hdk: 156301488 sectors (80026 MB), CHS=65535/16/63, UDMA(100)
 hdk: unknown partition table
hdm: max request size: 128KiB
hdm: 156301488 sectors (80026 MB), CHS=65535/16/63, UDMA(100)
 hdm:hdm: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdm: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdm: dma_timer_expiry: dma status == 0x21
hdm: DMA timeout error
hdm: dma timeout error: status=0x51 { DriveReady SeekComplete Error }
hdm: dma timeout error: error=0x84 { DriveStatusError BadCRC }
 unknown partition table
hdo: max request size: 128KiB
hdo: 156301488 sectors (80026 MB), CHS=65535/16/63, UDMA(100)
 hdo:hdo: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdo: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdo: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdo: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdo: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdo: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdo: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdo: dma_intr: error=0x84 { DriveStatusError BadCRC }
PDC202XX: Secondary channel reset.
ide7: reset: success
 unknown partition table
hdq: max request size: 128KiB
hdq: 156301488 sectors (80026 MB), CHS=65535/16/63, UDMA(100)
 hdq:hdq: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdq: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdq: dma_timer_expiry: dma status == 0x21
hdq: DMA timeout error
hdq: dma timeout error: status=0x51 { DriveReady SeekComplete Error }
hdq: dma timeout error: error=0x84 { DriveStatusError BadCRC }
 unknown partition table
hds: max request size: 128KiB
hds: 156301488 sectors (80026 MB), CHS=65535/16/63, UDMA(100)
 hds:hds: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hds: dma_intr: error=0x84 { DriveStatusError BadCRC }
hds: dma_timer_expiry: dma status == 0x21
hds: DMA timeout error
hds: dma timeout error: status=0x51 { DriveReady SeekComplete Error }
hds: dma timeout error: error=0x84 { DriveStatusError BadCRC }
 unknown partition table
