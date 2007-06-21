From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: ide/dma not working from 2.6.19 to 2.6.21
Date: Thu, 21 Jun 2007 17:29:41 +0200 (MEST)
Message-ID: <200706211529.l5LFTfav005957@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:38623 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752937AbXFUP3q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Jun 2007 11:29:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bahadir.balban@gmail.com, linux-ide@vger.kernel.org

On Thu, 21 Jun 2007 12:47:30 +0100, "Bahadir Balban" <bahadir.balban@gmail.com> wrote:
> I have a PCI Promise TX2 Ultra133 controller with a harddisk on an ARM
> platform (which is a barebone system with no BIOS). This setup used to
> work with the old linux-ide drivers on 2.6.19 but it does not work
> with 2.6.22-rc4, or 2.6.21. Here's the error output:
> 
> PDC20269: chipset revision 2
> <6>PDC20269: ROM enabled at 0xa0210000
> PDC20269: ROM enabled at 0xa0210000
> PDC20269: PLL input clock is 37736 kHz
> PDC20269: PLL input clock is 37736 kHz
> <6>PDC20269: 100% native mode on irq 84
> PDC20269: 100% native mode on irq 84
> <7>PCI: Enabling bus mastering for device 0000:07:01.0
> <6>    ide0: BM-DMA at 0x90050040-0x90050047    ide0: BM-DMA at
> 0x90050040-0x90050047, BIOS settings
> : hda:pio, hdb:pio, BIOS settings: hda:pio, hdb:pio
> 
> <6>    ide1: BM-DMA at 0x90050048-0x9005004f    ide1: BM-DMA at
> 0x90050048-0x9005004f, BIOS settings
> : hdc:pio, hdd:pio, BIOS settings: hdc:pio, hdd:pio
> 
> <7>Probing IDE interface ide0...
> hda: HDS728080PLAT20, hda: HDS728080PLAT20, ATA DISK drive
> ATA DISK drive
> <4>Warning: Primary channel requires an 80-pin cable for operation.
> Warning: Primary channel requires an 80-pin cable for operation.
> <4>hda reduced to Ultra33 mode.
> hda reduced to Ultra33 mode.
> ide0 at 0x90050050-0x90050057,0x90050062 on irq 84ide0 at
> 0x90050050-0x90050057,0x90050062 on irq 84
> 
> <7>Probing IDE interface ide1...
> <7>Probing IDE interface ide1...
> <6>hda: max request size: 512KiB
> hda: max request size: 512KiB
> <4>hda: lost interrupt
> hda: lost interrupt
> <4>hda: lost interrupt
> hda: lost interrupt
> <4>hda: lost interrupt
> hda: lost interrupt
> <6>hda: 160836480 sectors (82348 MB)hda: 160836480 sectors (82348 MB)
> w/1719KiB Cache w/1719KiB Cach
> e, CHS=16383/255/63, CHS=16383/255/63, UDMA(33), UDMA(33)
> 
> <4>hda: lost interrupt
> hda: lost interrupt
> <6>hda: cache flushes supported
> hda: cache flushes supported
> <6> hda: hda:<4>hda: dma_timer_expiry: dma status == 0x21
> <4>hda: dma_timer_expiry: dma status == 0x21
> <4>hda: DMA timeout error
> hda: DMA timeout error
> hda: dma timeout error: status=0x51 { hda: dma timeout error:
> status=0x51 { DriveReady DriveReady Se
> ekComplete SeekComplete Error Error }
> }
> hda: dma timeout error: error=0x84 { hda: dma timeout error:
> error=0x84 { DriveStatusError DriveStat
> usError BadCRC BadCRC }}
> 
> ide: failed opcode was: ide: failed opcode was: unknown
> unknown
> <4>hda: lost interrupt
> hda: lost interrupt
> 
> On 2.6.21 I have been using:
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_BLK_DEV_IDECD=y
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_BLK_DEV_PDC202XX_NEW=y
> CONFIG_IDE_GENERIC=y
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_OFFBOARD=y
> CONFIG_BLK_DEV_GENERIC=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> 
> On 2.6.19 I have exactly the same but also:
> 
> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_IDEDMA_AUTO=y
> 
> Could this have caused a problem?
> 
> Does IDE support in linux depend on certain BIOS settings or any other
> motherboard specific details? I am asking because neither the new ata
> nor the old ide layer worked for the cards I tried on ARM (JMB363,
> IT8212, Promise TX2 133 -> worked only with 2.6.19 old ide layer).

Try kernel 2.6.21 or newer and the libata driver for this card
instead (pata_pdc2027x). I'm using that in a PowerMac whose
firmware doesn't initialise the card at boot, and it works for me.

What kind of ARM board is this?

/Mikael
