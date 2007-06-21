From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: ide/dma not working from 2.6.19 to 2.6.21
Date: Thu, 21 Jun 2007 19:28:35 +0400
Message-ID: <467A9923.6010203@ru.mvista.com>
References: <7ac1e90c0706210447k7c1bdb26y43d62e930ce7728e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:63793 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752509AbXFUP0y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Jun 2007 11:26:54 -0400
In-Reply-To: <7ac1e90c0706210447k7c1bdb26y43d62e930ce7728e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bahadir Balban <bahadir.balban@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bahadir Balban wrote:

> I have a PCI Promise TX2 Ultra133 controller with a harddisk on an ARM
> platform (which is a barebone system with no BIOS). This setup used to
> work with the old linux-ide drivers on 2.6.19

    You were very lucky then bacause actually it usually failed on anything 
non-x86. ;-)

> but it does not work
> with 2.6.22-rc4, or 2.6.21. Here's the error output:

    I guess this might be related to the driver update in 2.6.20-rc1 then -- I 
made the driver calibrate the chip's PLL, so that it might work for non-x86 
case too (where Promise BIOS isn't available to do this). The code is 
basically the same as in the libata's pata_2027x driver...

> PDC20269: chipset revision 2
> <6>PDC20269: ROM enabled at 0xa0210000
> PDC20269: ROM enabled at 0xa0210000

    Hm, why all the messages are printed twice? :-O
    (I'll cut out the dupes to save bandwidth).

> PDC20269: PLL input clock is 37736 kHz

    37.736 MHz is a pretty strange PLL clock... Basically, it's the halved PCI 
clock, and that value signifies your PCI is probably running at 75 MHz -- 
which is serious overclocking... :-/
    That could explain why the driver managed to work before -- the default 
DPLL settings fit for 66 MHz PCI but made the UltraDMA fail with CRC errors on 
the plain 33 MHz PCI, IIRC...
    I may suggest replacing #undef DEBUG by #define DEBUG in this driver, 
rebuilding the kernel and posting the driver's output...

> <6>PDC20269: 100% native mode on irq 84
> <7>PCI: Enabling bus mastering for device 0000:07:01.0
> <6>    ide0: BM-DMA at 0x90050040-0x90050047, BIOS settings: hda:pio, hdb:pio
> <6>    ide1: BM-DMA at 0x90050048-0x9005004f, BIOS settings: hdc:pio, hdd:pio
> <7>Probing IDE interface ide0...
> hda: HDS728080PLAT20, ATA DISK drive
> <4>Warning: Primary channel requires an 80-pin cable for operation.
> <4>hda reduced to Ultra33 mode.
> hda reduced to Ultra33 mode.

    Oh, now I understand why it used to work for you before 2.6.20 -- UltraDMA 
only failed with 80-conductor cable on non-x86. :-)
    Have you been using the 40-conductor cable all the time?

> ide0 at 0x90050050-0x90050057,0x90050062 on irq 84
> <7>Probing IDE interface ide1...
> <6>hda: max request size: 512KiB
> <4>hda: lost interrupt
> <4>hda: lost interrupt
> <4>hda: lost interrupt

    Hm, that's interesting -- I'm not sure how the driver rewrite could have 
affected the interrupt delivery for PIO commands (there's no prior "DMA 
interrupt recovery" messages).  Might be some other issue here...

> <6>hda: 160836480 sectors (82348 MB) w/1719KiB Cache, CHS=16383/255/63, UDMA(33)
> <4>hda: lost interrupt
> <6>hda: cache flushes supported
> <6> hda: <4>hda: dma_timer_expiry: dma status == 0x21
> <4>hda: DMA timeout error
> hda: dma timeout error: status=0x51 { DriveReady SeekComplete Error }
> hda: dma timeout error: error=0x84 { DriveStatusError BadCRC }

    This is too familiar -- that's how the driver used to behave on

> ide: failed opcode was: unknown
> <4>hda: lost interrupt

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

> On 2.6.19 I have exactly the same but also:

> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_IDEDMA_AUTO=y

> Could this have caused a problem?

    No.

> Does IDE support in linux depend on certain BIOS settings or any other
> motherboard specific details? I am asking because neither the new ata
> nor the old ide layer worked for the cards I tried on ARM (JMB363,
> IT8212, Promise TX2 133 -> worked only with 2.6.19 old ide layer).

    As for the Promise -- it used to before 2.2.20-rc1, and it shouldn't since.

> Finally is there a simplest, known-to-work pci ide controller you can
> suggest? So that I can start looking from there.

    Your Promise card should actually be working...

> Thank you,
> Bahadir

MBR, Sergei
