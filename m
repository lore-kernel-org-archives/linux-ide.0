From: Michael Bueker <m.bueker@berlin.de>
Subject: DMA errors with HTP370 IDE in <= 2.6.18.2
Date: Mon, 08 Jan 2007 20:51:08 +0100
Message-ID: <45A2A0AC.1050203@berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sour.ops.eusc.inter.net ([84.23.254.154]:58059 "EHLO
	sour.ops.eusc.inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067AbXAHUQK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Jan 2007 15:16:10 -0500
Received: from sour.ops.eusc.inter.net ([10.154.10.14] helo=localhost)
	by sour.ops.eusc.inter.net with esmtpa (Exim 4.63 id 1H40Wz-000Lc7-0L)
	for linux-ide@vger.kernel.org; Mon, 08 Jan 2007 20:51:41 +0100
Received: from [192.168.6.3] (terra.bueker.lan [192.168.6.3])
	by mtu.homelinux.net (Postfix) with ESMTP id BCA321567F
	for <linux-ide@vger.kernel.org>; Mon,  8 Jan 2007 20:51:08 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

[please CC me upon replying - thank you]

I have a Highpoint 370 PCI IDE controller, and both my 2.6.18.2 and
Knoppix 5's 2.6.17 display the following messages:

> HPT370: IDE controller at PCI slot 0000:01:09.0
> HPT370: chipset revision 3
> HPT370: 100% native mode on irq 11
> HPT37X: using 33MHz PCI clock
>     ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:DMA, hdf:DMA
> HPT37X: using 33MHz PCI clock
>     ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:pio, hdh:pio
> Probing IDE interface ide2...
> hde: ST340823A, ATA DISK drive
> hdf: ExcelStor Technology J840, ATA DISK drive
> ide2 at 0x9000-0x9007,0x9402 on irq 11
> Probing IDE interface ide3...
> hdg: LITE-ON LTR-52246S, ATAPI CD/DVD-ROM drive
> ide3 at 0x9800-0x9807,0x9c02 on irq 11
> hde: max request size: 128KiB
> hde: 78165360 sectors (40020 MB) w/1024KiB Cache, CHS=65535/16/63, UDMA(100)
> hde: cache flushes not supported
>  hde:<4>hde: dma_timer_expiry: dma status == 0x61
> hde: DMA timeout error
> hde: 0 bytes in FIFO
> hde: timeout waiting for DMA
> hde: dma timeout error: status=0x80 { Busy }
> ide: failed opcode was: unknown
> hde: DMA disabled
> hdf: DMA disabled
> ide2: reset: success
>  hde1 hde2 <<4>hde: dma_timer_expiry: dma status == 0x21
> hde: DMA timeout error
> hde: 0 bytes in FIFO
> hde: timeout waiting for DMA
> hde: dma timeout error: status=0x80 { Busy }
> ide: failed opcode was: unknown
> hde: DMA disabled
> ide2: reset: success
>  hde5<4>hde: dma_timer_expiry: dma status == 0x21
> hde: DMA timeout error
> hde: 0 bytes in FIFO
> hde: timeout waiting for DMA
> hde: dma timeout error: status=0x80 { Busy }
> ide: failed opcode was: unknown
> hde: DMA disabled
> ide2: reset: success
>  hde6 >
> hdf: max request size: 512KiB
> hdf: 80418240 sectors (41174 MB) w/1719KiB Cache, CHS=16383/255/63
> hdf: cache flushes supported
>  hdf: unknown partition table
> hde: dma_timer_expiry: dma status == 0x21
> hde: DMA timeout error
> hde: 0 bytes in FIFO
> hde: timeout waiting for DMA
> hde: dma timeout error: status=0x80 { Busy }
> ide: failed opcode was: unknown
> hde: DMA disabled
> ide2: reset: success

(hdf is naked, there's no error in partition detection)

The same messages appear when manually trying to enable DMA with hdparm.
The hdparm reading of hde is:

> /dev/hde:
>  multcount    = 16 (on)
>  IO_support   =  0 (default 16-bit)
>  unmaskirq    =  0 (off)
>  using_dma    =  0 (off)
>  keepsettings =  0 (off)
>  readonly     =  0 (off)
>  readahead    = 256 (on)
>  geometry     = 65535/16/63, sectors = 78165360, start = 0

hda, which is on the mainboard controller and works as hde used to as
well, reads:

> /dev/hda:
>  multcount    = 16 (on)
>  IO_support   =  1 (32-bit)
>  unmaskirq    =  1 (on)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  readonly     =  0 (off)
>  readahead    = 256 (on)
>  geometry     = 65535/16/63, sectors = 117231408, start = 0

In the controller's setup utility, I can choose access modes. If i
switch it from UDMA5 to PIO0, the only difference during boot is:

> ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:pio, hdf:pio

instead of

> ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:DMA, hdf:DMA

Please help me getting DMA to work with this controller.

Thanks in advance,
~Mik

-- 
So, how can you tell me you're lonely?
And say that you don't have no life?
Let me take you by the hand and show you all the geeks of London
I'll show you something to make you change your mind!

