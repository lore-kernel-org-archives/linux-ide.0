From: Malcolm Gillies <malcolm@g7.org>
Subject: Re: CompactFlash and HD unhappy together on the same IDE channel
Date: Sun, 16 Sep 2007 09:54:08 +1000
Message-ID: <46EC70A0.1000800@g7.org>
References: <46C69913.1060505@g7.org>	<46C799E8.8080407@rtr.ca> <20070819175632.349d11c5@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from webmail.icp-qv1-irony-out1.iinet.net.au ([203.59.1.108]:10229
	"EHLO webmail.icp-qv1-irony-out1.iinet.net.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753145AbXIOXyN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Sep 2007 19:54:13 -0400
In-Reply-To: <20070819175632.349d11c5@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Alan Cox wrote:
> Sounds to me like the usual case of people putting CF convertors onto
> spec compliant cables and ending up with electrical problems. If you
> stick additional connectors, wires and plugs onto the cable it goes out
> of spec.

I've got reasonable evidence now that this is not the case.

I've acquired a new CF card that is capable of UDMA2, and with the same 
connectors, wiring and adaptor (i.e. I popped out the MWDMA card and 
inserted the UDMA one), I can now boot and read data on both devices 
without error at reasonable speeds.

Looks to me that there's a problem with either the specific MWDMA card 
(Sandisk Ultra II) or more generally with putting MWDMA and UDMA on the 
same cable.

cheers,

Malcolm
--
Here's the bootlog etc with the new CF card

ata_piix 0000:00:1f.1: version 2.11
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001ffa0 
irq 14
ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001ffa8 
irq 15
ata1.00: ATA-4: TRANSCEND, 20070319, max UDMA/66
ata1.00: 3980592 sectors, multi 0: LBA
ata1.01: ATA-7: SAMSUNG HD400LD, WQ100-14, max UDMA/100
ata1.01: 781422768 sectors, multi 16: LBA48
ata1.00: limited to UDMA/33 due to 40-wire cable
ata1.01: limited to UDMA/33 due to 40-wire cable
ata1.00: configured for UDMA/33
ata1.01: configured for UDMA/33
ata2.00: ATAPI: LG CD-ROM CRN-8245B, 1.18, max UDMA/33
ata2.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      TRANSCEND        2007 PQ: 0 ANSI: 5
scsi 0:0:1:0: Direct-Access     ATA      SAMSUNG HD400LD  WQ10 PQ: 0 ANSI: 5
scsi 1:0:0:0: CD-ROM            LG       CD-ROM CRN-8245B 1.18 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 3980592 512-byte hardware sectors (2038 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't 
support DP
O or FUA
sd 0:0:0:0: [sda] 3980592 512-byte hardware sectors (2038 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't 
support DP
O or FUA
  sda: sda1
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:1:0: [sdb] 781422768 512-byte hardware sectors (400088 MB)
sd 0:0:1:0: [sdb] Write Protect is off
sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't 
support DPO
  or FUA
sd 0:0:1:0: [sdb] 781422768 512-byte hardware sectors (400088 MB)
sd 0:0:1:0: [sdb] Write Protect is off
sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't 
support DPO
  or FUA
  sdb: sdb1
sd 0:0:1:0: [sdb] Attached SCSI disk

  # hdparm -I /dev/sda

/dev/sda:

ATA device, with non-removable media
         Model Number:       TRANSCEND
         Serial Number:      0           2000210E
         Firmware Revision:  20070319
Standards:
         Supported: 4
         Likely used: 5
Configuration:
         Logical         max     current
         cylinders       3949    3949
         heads           16      16
         sectors/track   63      63
         --
         CHS current addressable sectors:    3980592
         LBA    user addressable sectors:    3980592
         device size with M = 1024*1024:        1943 MBytes
         device size with M = 1000*1000:        2038 MBytes (2 GB)
Capabilities:
         LBA, IORDY(may be)(cannot be disabled)
         Standby timer values: spec'd by Vendor
         R/W multiple sector transfer: Max = 1   Current = 0
         Advanced power management level: unknown setting (0x0000)
         DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4
              Cycle time: min=120ns recommended=120ns
         PIO: pio0 pio1 pio2 pio3 pio4
              Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
         Enabled Supported:
                 Power Management feature set
                 WRITE_BUFFER command
                 READ_BUFFER command
                 NOP cmd
                 CFA feature set
                 Advanced Power Management feature set
HW reset results:
         CBLID- below Vih
         Device num = 0
         Integrity word not set (found 0x0000, expected 0x36a5)

  # hdparm --direct -Tt /dev/sdb

/dev/sdb:
  Timing O_DIRECT cached reads:    64 MB in  2.05 seconds =  31.15 MB/sec
  Timing O_DIRECT disk reads:   94 MB in  3.06 seconds =  30.71 MB/sec

  # hdparm --direct -Tt /dev/sda

/dev/sda:
  Timing O_DIRECT cached reads:    60 MB in  2.01 seconds =  29.84 MB/sec
  Timing O_DIRECT disk reads:   90 MB in  3.02 seconds =  29.80 MB/sec

And my original report:
> My PATA hard disk is crippled by CRC errors when it's on the same
> cable as a 1GB SanDisk Ultra II CompactFlash card in CF to IDE adaptor.
> Any ideas why?
> 
> By swapping around components, I've established that the problem is
> unlikely due to the cable (which is 50cm long 80-wire), hard disk or
> controller. When I swap to another, slower CF card (one that only
> supports PIO rather than MWDMA), the error goes away and the hard disk
> operates happily at UDMA/33.
> 
> No errors are reported for the CF card I/O.
> 
> The adaptor card is unbranded, model CF-IDE40 V.A1. It's a
> double-sided type, but I'm only using one of the two CF sockets.
> 
> The spec sheet says
> 
> * Accord with: CF spec Ver2.0 and IDE/ATA-33 spec.
> * Standard IDE interface: true-IDE mode, support DMA-33 transfer mode
> 
> I see the errors both with the old IDE code in 2.6.18 and with libata in 2.6.22
> 
> cheers,
> 
> Malcolm
> -- 
> Here are the relevant dmesg lines:
> 
> ata_piix 0000:00:1f.1: version 2.11
> PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
> ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ
>  11
> PCI: Setting latency timer of device 0000:00:1f.1 to 64
> scsi0 : ata_piix
> scsi1 : ata_piix
> ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001ffa0 irq 14
> ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001ffa8 irq 15
> ata1.00: CFA: SanDisk SDCFH-1024, HDX 4.07, max MWDMA2
> ata1.00: 2001888 sectors, multi 0: LBA
> ata1.01: ATA-7: SAMSUNG HD400LD, WQ100-14, max UDMA/100
> ata1.01: 781422768 sectors, multi 0: LBA48
> ata1.01: limited to UDMA/33 due to 40-wire cable
> ata1.00: configured for MWDMA2
> ata1.01: configured for UDMA/33
> ata2.00: ATAPI: LG CD-ROM CRN-8245B, 1.18, max UDMA/33
> ata2.00: configured for UDMA/33
> scsi 0:0:0:0: Direct-Access     ATA      SanDisk SDCFH-10 HDX  PQ: 0 ANSI: 5
> scsi 0:0:1:0: Direct-Access     ATA      SAMSUNG HD400LD  WQ10 PQ: 0 ANSI: 5
> scsi 1:0:0:0: CD-ROM            LG       CD-ROM CRN-8245B 1.18 PQ: 0 ANSI: 5
> sd 0:0:0:0: [sda] 2001888 512-byte hardware sectors (1025 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> sd 0:0:0:0: [sda] 2001888 512-byte hardware sectors (1025 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
>  sda: sda1
> sd 0:0:0:0: [sda] Attached SCSI removable disk
> sd 0:0:1:0: [sdb] 781422768 512-byte hardware sectors (400088 MB)
> sd 0:0:1:0: [sdb] Write Protect is off
> sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
> sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> sd 0:0:1:0: [sdb] 781422768 512-byte hardware sectors (400088 MB)
> sd 0:0:1:0: [sdb] Write Protect is off
> sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
> sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>  sdb:<3>ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
> ata1.01: (BMDMA stat 0x25)
> ata1.01: cmd c8/00:08:00:00:00/00:00:00:00:00/f0 tag 0 cdb 0x0 data 4096 in
>          res 51/84:00:07:00:00/00:00:00:00:00/f0 Emask 0x10 (ATA bus error)
> ata1: soft resetting port
> 
> [subsequently ata1.01 is downrated to UDMA/25 and finally PIO4]
> 
>  # hdparm -I /dev/sda
> 
> /dev/sda:
> 
> CompactFlash ATA device, with removable media
>         Model Number:       SanDisk SDCFH-1024
>         Serial Number:      004123D2804C2249
>         Firmware Revision:  HDX 4.07
> Standards:
>         Supported: 4
>         Likely used: 4
> Configuration:
>         Logical         max     current
>         cylinders       1986    1986
>         heads           16      16
>         sectors/track   63      63
>         --
>         CHS current addressable sectors:    2001888
>         LBA    user addressable sectors:    2001888
>         device size with M = 1024*1024:         977 MBytes
>         device size with M = 1000*1000:        1024 MBytes (1 GB)
> Capabilities:
>         LBA, IORDY(may be)(cannot be disabled)
>         Standby timer values: spec'd by Vendor
>         R/W multiple sector transfer: Max = 4   Current = 0
>         DMA: mdma0 mdma1 *mdma2
>              Cycle time: min=120ns recommended=120ns
>         PIO: pio0 pio1 pio2 pio3 pio4
>              Cycle time: no flow control=120ns  IORDY flow control=120ns
> Commands/features:
>         Enabled Supported:
>            *    CFA feature set
> 
>  # hdparm -I /dev/sdb
> 
> /dev/sdb:
> 
> ATA device, with non-removable media
>         Model Number:       SAMSUNG HD400LD
>         Serial Number:      S0AXJ1MP308674
>         Firmware Revision:  WQ100-14
> Standards:
>         Used: ATA/ATAPI-7 T13 1532D revision 4a
>         Supported: 7 6 5 4
> Configuration:
>         Logical         max     current
>         cylinders       16383   16383
>         heads           16      16
>         sectors/track   63      63
>         --
>         CHS current addressable sectors:   16514064
>         LBA    user addressable sectors:  268435455
>         LBA48  user addressable sectors:  781422768
>         device size with M = 1024*1024:      381554 MBytes
>         device size with M = 1000*1000:      400088 MBytes (400 GB)
> Capabilities:
>         LBA, IORDY(can be disabled)
>         Standby timer values: spec'd by Standard, no device specific minimum
>         R/W multiple sector transfer: Max = 16  Current = ?
>         Recommended acoustic management value: 254, current value: 254
>         DMA: mdma0 mdma1 mdma2 udma0 *udma1 udma2 udma3 udma4 udma5
>              Cycle time: min=120ns recommended=120ns
>         PIO: pio0 pio1 pio2 pio3 pio4
>              Cycle time: no flow control=240ns  IORDY flow control=120ns
> Commands/features:
>         Enabled Supported:
>            *    SMART feature set
>                 Security Mode feature set
>            *    Power Management feature set
>            *    Write cache
>            *    Look-ahead
>            *    Host Protected Area feature set
>            *    WRITE_BUFFER command
>            *    READ_BUFFER command
>            *    NOP cmd
>            *    DOWNLOAD_MICROCODE
>                 Power-Up In Standby feature set
>                 SET_FEATURES required to spinup after power up
>                 SET_MAX security extension
>            *    Automatic Acoustic Management feature set
>            *    48-bit Address feature set
>            *    Device Configuration Overlay feature set
>            *    Mandatory FLUSH_CACHE
>            *    FLUSH_CACHE_EXT
>            *    SMART error logging
>            *    SMART self-test
>                 Media Card Pass-Through
>            *    General Purpose Logging feature set
>            *    SMART Command Transport (SCT) feature set
>            *    SCT Long Sector Access (AC1)
>            *    SCT LBA Segment Access (AC2)
>            *    SCT Error Recovery Control (AC3)
>            *    SCT Features Control (AC4)
>            *    SCT Data Tables (AC5)
> Security:
>         Master password revision code = 65534
>                 supported
>         not     enabled
>         not     locked
>         not     frozen
>         not     expired: security count
>                 supported: enhanced erase
>         228min for SECURITY ERASE UNIT. 228min for ENHANCED SECURITY ERASE UNIT.
> HW reset results:
>         CBLID- above Vih
>         Device num = 1 determined by CSEL
> Checksum: correct 

