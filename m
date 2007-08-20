From: Malcolm Gillies <linux-ide@ouabain.org>
Subject: Re: CompactFlash and HD unhappy together on the same IDE channel
Date: Mon, 20 Aug 2007 17:34:12 +1000
Message-ID: <46C943F4.1050201@ouabain.org>
References: <46C69913.1060505@g7.org> <46C799E8.8080407@rtr.ca> <46C81EC4.9080407@ouabain.org> <46C85140.9050906@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from webmail.icp-qv1-irony2.iinet.net.au ([203.59.1.107]:12332 "EHLO
	webmail.icp-qv1-irony2.iinet.net.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752369AbXHTHoQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Aug 2007 03:44:16 -0400
In-Reply-To: <46C85140.9050906@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Mark Lord wrote:
> Malcolm Gillies wrote:
>> 2) the HD runs error-free at UDMA/33 when I use a different, PIO-only 
>> CF card but otherwise the same cabling, adaptor etc.
> 
> It would be useful to see the boot log for this scenario.
> In particular, I'm curious what timings get chosen for the two devices.
> But since that CF card cannot do DMA, it should not respond at all to
> any HD DMA cycles, even if the timing is too fast for it's decoders to
> work properly.

scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001ffa0 
irq 14
ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001ffa8 
irq 15
ata1.00: CFA: Renesas XX.V.3.5.0.0, Rev 0.00, max PIO4
ata1.00: 1000944 sectors, multi 1: LBA
ata1.01: ATA-7: SAMSUNG HD400LD, WQ100-14, max UDMA/100
ata1.01: 781422768 sectors, multi 0: LBA48
ata1.00: configured for PIO4
ata1.01: configured for UDMA/100
ata2.00: ATAPI: LG CD-ROM CRN-8245B, 1.18, max UDMA/33
ata2.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      Renesas XX.V.3.5 Rev  PQ: 0 ANSI: 5
scsi 0:0:1:0: Direct-Access     ATA      SAMSUNG HD400LD  WQ10 PQ: 0 ANSI: 5
scsi 1:0:0:0: CD-ROM            LG       CD-ROM CRN-8245B 1.18 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 1000944 512-byte hardware sectors (512 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't 
support DPO or FUA
sd 0:0:0:0: [sda] 1000944 512-byte hardware sectors (512 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't 
support DPO or FUA
  sda: sda1
sd 0:0:0:0: [sda] Attached SCSI removable disk
sd 0:0:1:0: [sdb] 781422768 512-byte hardware sectors (400088 MB)
sd 0:0:1:0: [sdb] Write Protect is off
sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 0:0:1:0: [sdb] 781422768 512-byte hardware sectors (400088 MB)
sd 0:0:1:0: [sdb] Write Protect is off
d 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdb: sdb1
sd 0:0:1:0: [sdb] Attached SCSI disk

  # hdparm -I /dev/sda

/dev/sda:

CompactFlash ATA device, with removable media
         Model Number:       Renesas XX.V.3.5.0.0
         Serial Number:      X0819 20050726050808
         Firmware Revision:  Rev 0.00
Standards:
         Likely used: 4
Configuration:
         Logical         max     current
         cylinders       993     993
         heads           16      16
         sectors/track   63      63
         --
         bytes/track: 0  bytes/sector: 512
         CHS current addressable sectors:    1000944
         LBA    user addressable sectors:    1000944
         device size with M = 1024*1024:         488 MBytes
         device size with M = 1000*1000:         512 MBytes
Capabilities:
         LBA, IORDY(may be)(cannot be disabled)
         Buffer size: 1.0kB      bytes avail on r/w long: 4
         Standby timer values: spec'd by Vendor
         R/W multiple sector transfer: Max = 1   Current = 1
         DMA: not supported
         PIO: pio0 pio1 pio2 pio3 pio4
              Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
         Enabled Supported:
            *    WRITE_BUFFER command
            *    READ_BUFFER command
            *    NOP cmd
            *    CFA feature set


# hdparm --direct -Tt /dev/sdb

/dev/sdb:
  Timing O_DIRECT cached reads:   180 MB in  2.02 seconds =  89.04 MB/sec
  Timing O_DIRECT disk reads:  224 MB in  3.03 seconds =  74.04 MB/sec

# hdparm --direct -Tt /dev/sda

/dev/sda:
  Timing O_DIRECT cached reads:     6 MB in  2.27 seconds =   2.64 MB/sec
  Timing O_DIRECT disk reads:    8 MB in  3.03 seconds =   2.64 MB/sec
