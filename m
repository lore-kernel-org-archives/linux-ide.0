From: Patrick Nagelschmidt <dto@gmx.net>
Subject: DMA timeout error with 2.6.9 and PIIX4
Date: Fri, 19 Nov 2004 21:28:19 +0100
Message-ID: <6.2.0.14.2.20041119205628.03f8eb28@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop.gmx.de ([213.165.64.20]:43420 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261295AbUKSU2w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Nov 2004 15:28:52 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

hello,

i just tried to switch from my old 2.4.24 kernel to v2.6. i tried the
fedora core 2 v2.6.7, the fedora core 2 v2.6.9 and the v2.6.9 from
kernel.org with alan's patches (-ac10) but with all of them i get the
same problem. after a short time (some minutes) the system just
freezes with the following message:

hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete
DataRequest }

ide: failed opcode was: unknown

i had those dma problems with the early versions of the v2.4 kernel,
but they have been fixed a long time ago (first in some ac-patches,
later in the stock kernel as well) and i didn't have this problem with
any recent v2.4. is there anything known about the
problem/incompatibilities with v2.6 and the PIIX4 controller?

i have disabled APM completely on my box since i read somewhere that
it might cause problems like that but it didn't help (neither did noapic).

here's some information about my system, if anything else is needed
just tell me what you want to know:

-----------------
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:04.1
PIIX4: chipset revision 1
PIIX4: not 100%% native mode: will probe irqs later
     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
hda: SAMSUNG SV0643D, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SAMSUNG SP1604N, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 12594960 sectors (6448 MB) w/480KiB Cache, CHS=13328/15/63,
UDMA(33)
  hda: hda1 hda2 hda3
hdc: max request size: 1024KiB
hdc: 312581808 sectors (160041 MB) w/2048KiB Cache, CHS=19457/255/63,
UDMA(33)

-----------------
hdparm -I /dev/hda (executed under my working v2.4 kernel)

/dev/hda:

ATA device, with non-removable media
         Model Number:       SAMSUNG SV0643D
         Serial Number:      0137J1CK707639
         Firmware Revision:  KT100
Standards:
         Supported: 3 2 1
         Likely used: 4
Configuration:
         Logical         max     current
         cylinders       13328   13328
         heads           15      15
         sectors/track   63      63
         --
         bytes/track: 32256      bytes/sector: 512
         CHS current addressable sectors:   12594960
         LBA    user addressable sectors:   12594960
         device size with M = 1024*1024:        6149 MBytes
         device size with M = 1000*1000:        6448 MBytes (6 GB)
Capabilities:
         LBA, IORDY(can be disabled)
         Buffer size: 480.0kB    bytes avail on r/w long: 4      Queue
depth: 1
         Standby timer values: spec'd by Vendor
         R/W multiple sector transfer: Max = 16  Current = 16
         DMA: sdma0 sdma1 sdma2 *mdma0 mdma1 mdma2 udma0 udma1 *udma2
(?)
              Cycle time: min=120ns recommended=120ns
         PIO: pio0 pio1 pio2 pio3 pio4
              Cycle time: no flow control=120ns  IORDY flow
control=120ns
Commands/features:
         Enabled Supported:
                 Host Protected Area feature set
                 Power Management feature set
                 SMART feature set
                 DOWNLOAD MICROCODE cmd
-----------------

it would be nice if you could CC the comments posted to this topic to me.

thanks for your help,

Patrick 

