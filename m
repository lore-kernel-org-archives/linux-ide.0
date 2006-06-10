From: Brad Campbell <brad@wasp.net.au>
Subject: Power down DVD drive on Sony Vaio VGN-TX27GP
Date: Sat, 10 Jun 2006 12:19:55 +0400
Message-ID: <448A80AB.9020304@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:21927 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S1030359AbWFJIUJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Jun 2006 04:20:09 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

G'day all,

I've got a shiny new toy to play with..

After much fiddling I've figured out how to use ACPI disconnect the power to the optical drive (to 
buy me some more disconnected battery time).

Problem being once I power it down if anything tries to access it, it all goes bad and those process 
lock up in the "D" state. I then have to reboot the machine to recover (suspend/resume does not do 
the trick).

I'm wondering if there is a way to de-register/re-register the optical drive, or force a hardware 
rescan or similar to get the drive back up..

It's no biggie if it can't be done I guess (tho windows can do it), but from the measurements I've 
made it looks like it will buy me 15-20 minutes extra runtime on the standard 6 hour battery.

I can see an option in hdparm to register/de-register entire interfaces, but have not managed to 
spot a way to do it with a single drive on an interface..


brad@bklaptop2:~$ lspci
0000:00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express Processor to DRAM 
Controller (rev 03)
0000:00:02.0 VGA compatible controller: Intel Corporation Mobile 915GM/GMS/910GML Express Graphics 
Controller (rev 03)
0000:00:02.1 Display controller: Intel Corporation Mobile 915GM/GMS/910GML Express Graphics 
Controller (rev 03)
0000:00:1b.0 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio 
Controller (rev 03)
0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 03)
0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 03)
0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 03)
0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 03)
0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI 
Controller (rev 03)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d3)
0000:00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface Bridge (rev 03)
0000:00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller 
(rev 03)
0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 03)
0000:06:05.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Controller
0000:06:05.2 FireWire (IEEE 1394): Texas Instruments OHCI Compliant IEEE 1394 Host Controller
0000:06:05.3 Mass storage controller: Texas Instruments PCIxx21 Integrated FlashMedia Controller
0000:06:08.0 Ethernet controller: Intel Corporation 82562EM/EX/GX - PRO/100 VM (LOM) Ethernet 
Controller Mobile (rev 03)
0000:06:0b.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev 05)

brad@bklaptop2:~$ sudo hdparm -I /dev/hda /dev/hdb

/dev/hda:

ATA device, with non-removable media
         Model Number:       TOSHIBA MK6006GAH
         Serial Number:      367Q4970T
         Firmware Revision:  BZ002A
Standards:
         Supported: 6 5 4 3
         Likely used: 6
Configuration:
         Logical         max     current
         cylinders       16383   65535
         heads           16      1
         sectors/track   63      63
         --
         CHS current addressable sectors:    4128705
         LBA    user addressable sectors:  117210240
         LBA48  user addressable sectors:  117210240
         device size with M = 1024*1024:       57231 MBytes
         device size with M = 1000*1000:       60011 MBytes (60 GB)
Capabilities:
         LBA, IORDY(can be disabled)
         Queue depth: 1
         Standby timer values: spec'd by Standard, no device specific minimum
         R/W multiple sector transfer: Max = 16  Current = ?
         Advanced power management level: unknown setting (0x0080)
         DMA: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
              Cycle time: min=120ns recommended=120ns
         PIO: pio0 pio1 pio2 pio3 pio4
              Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
         Enabled Supported:
            *    NOP cmd
            *    READ BUFFER cmd
            *    WRITE BUFFER cmd
            *    Host Protected Area feature set
            *    Look-ahead
            *    Write cache
            *    Power Management feature set
                 Security Mode feature set
            *    SMART feature set
            *    FLUSH CACHE EXT command
            *    Mandatory FLUSH CACHE command
            *    Device Configuration Overlay feature set
            *    48-bit Address feature set
            *    SET MAX security extension
            *    Advanced Power Management feature set
            *    DOWNLOAD MICROCODE cmd
            *    General Purpose Logging feature set
            *    SMART self-test
            *    SMART error logging
Security:
         Master password revision code = 65534
                 supported
         not     enabled
         not     locked
                 frozen
         not     expired: security count
         not     supported: enhanced erase
         74min for SECURITY ERASE UNIT.
HW reset results:
         CBLID- above Vih
         Device num = 0 determined by the jumper
Checksum: correct

/dev/hdb:

ATAPI CD-ROM, with removable media
         Model Number:       MATSHITAUJ-832D
         Serial Number:
         Firmware Revision:  1.61
Standards:
         Likely used CD-ROM ATAPI-1
Configuration:
         DRQ response: 50us.
         Packet size: 12 bytes
Capabilities:
         LBA, IORDY(can be disabled)
         DMA: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2
              Cycle time: min=120ns recommended=120ns
         PIO: pio0 pio1 pio2 pio3 pio4
              Cycle time: no flow control=240ns  IORDY flow control=120ns
HW reset results:
         CBLID- below Vih
         Device num = 1


May 26 08:45:57 localhost kernel: [4294668.055000] ICH6: IDE controller at PCI slot 0000:00:1f.1
May 26 08:45:57 localhost kernel: [4294668.055000] ACPI: PCI Interrupt 0000:00:1f.1[B] -> GSI 18 
(level, low) -> IRQ 17
May 26 08:45:57 localhost kernel: [4294668.055000] ICH6: chipset revision 3
May 26 08:45:57 localhost kernel: [4294668.055000] ICH6: not 100%% native mode: will probe irqs later
May 26 08:45:57 localhost kernel: [4294668.055000]     ide0: BM-DMA at 0x1810-0x1817, BIOS settings: 
hda:DMA, hdb:DMA
May 26 08:45:57 localhost kernel: [4294668.055000] Probing IDE interface ide0...
May 26 08:45:57 localhost kernel: [4294668.319000] hda: TOSHIBA MK6006GAH, ATA DISK drive
May 26 08:45:57 localhost kernel: [4294669.033000] hdb: MATSHITAUJ-832D, ATAPI CD/DVD-ROM drive
May 26 08:45:57 localhost kernel: [4294669.084000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
May 26 08:45:57 localhost kernel: [4294669.084000] hda: max request size: 512KiB
May 26 08:45:57 localhost kernel: [4294669.109000] hda: 117210240 sectors (60011 MB), 
CHS=16383/255/63, UDMA(100)
May 26 08:45:57 localhost kernel: [4294669.109000] hda: cache flushes supported
May 26 08:45:57 localhost kernel: [4294669.109000]  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
May 26 08:45:57 localhost kernel: [4294669.175000] hdb: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 
2048kB Cache, UDMA(33)
May 26 08:45:57 localhost kernel: [4294669.175000] Uniform CD-ROM driver Revision: 3.20

Regards,
Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
