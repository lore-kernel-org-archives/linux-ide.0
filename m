From: Jan Killius <jkillius@arcor.de>
Subject: Re: worst via_sata performance
Date: Thu, 1 Apr 2004 11:33:53 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404011133.53344.jkillius@arcor.de>
References: <200404010357.57111.jkillius@arcor.de> <406BB322.8060509@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:29382 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S262329AbUDAJd7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Apr 2004 04:33:59 -0500
In-Reply-To: <406BB322.8060509@pobox.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

with 2.6.5-rc3-mm3 I only getting 28.19 MB/sec with generic ide don't now why 
and I can only select a dma up to udma2 which is really slow. 
>
> Do things change if you back out the "speed up SATA" patch?
no not really.
>
> Also, device information from hdparm, when using the IDE generic driver,
> would be useful.

dmesg:
ide: Assuming 66MHz system bus speed for PIO modes
VIA8237SATA: IDE controller at PCI slot 0000:00:0f.0
VIA8237SATA: chipset revision 128
VIA8237SATA: 100% native mode on irq 20
    ide2: BM-DMA at 0xd400-0xd407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xd408-0xd40f, BIOS settings: hdg:pio, hdh:pio
hde: HDS722516VLSA80, ATA DISK drive
Using cfq io scheduler
ide2 at 0xe800-0xe807,0xe402 on irq 20
hdg: HDS722516VLSA80, ATA DISK drive
ide3 at 0xe000-0xe007,0xd802 on irq 20

hde: max request size: 1024KiB
hde: 321672960 sectors (164696 MB) w/7938KiB Cache, CHS=20023/255/63
 hde: hde1 < > hde2
hdg: max request size: 1024KiB
hdg: 321672960 sectors (164696 MB) w/7938KiB Cache, CHS=20023/255/63
 hdg: unknown partition table

hdparm:
/dev/hdg:
 multcount    = 16 (on)
 IO_support   =  3 (32-bit w/sync)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 20023/255/63, sectors = 321672960, start = 0

 Model=HDS722516VLSA80, FwRev=V34OA60A, SerialNo=VNRD9FC4C81WDM
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=7938kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 3a:

 * signifies the current active mode
>
> Is this in 32-bit or 64-bit mode?
yes it's a 64 bit system
>
> 	Jeff
