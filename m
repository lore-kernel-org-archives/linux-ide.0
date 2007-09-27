From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: T61 SATA error in log
Date: Fri, 28 Sep 2007 09:36:01 +1000
Message-ID: <1190936161.6158.42.camel@pasglop>
References: <1190877668.30275.3.camel@pasglop>  <46FC13FA.3090400@gmail.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:52329 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754854AbXI0XgY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Sep 2007 19:36:24 -0400
In-Reply-To: <46FC13FA.3090400@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>


On Thu, 2007-09-27 at 13:35 -0700, Tejun Heo wrote:
> Benjamin Herrenschmidt wrote:
> > Saw that popping up in my log today on a brand new T61 thinkpad:
> > 
> > [  427.712000] ata1.00: exception Emask 0x2 SAct 0x18 SErr 0x0 action 0x2 frozen
> > [  427.712000] ata1.00: (spurious completions during NCQ issue=0x0 SAct=0x18 FIS=004040a1:00000024)
> > [  427.712000] ata1.00: cmd 61/08:18:f4:74:54/00:00:04:00:00/40 tag 3 cdb 0x0 data 4096 out
> > [  427.712000]          res 40/00:28:64:e4:51/00:00:04:00:00/40 Emask 0x2 (HSM violation)
> > [  427.712000] ata1.00: cmd 61/08:20:84:10:81/00:00:04:00:00/40 tag 4 cdb 0x0 data 4096 out
> > [  427.712000]          res 40/00:28:64:e4:51/00:00:04:00:00/40 Emask 0x2 (HSM violation)
> > [  428.024000] ata1: soft resetting port
> > [  428.196000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > [  428.204000] ata1.00: configured for UDMA/100
> > [  428.204000] ata1: EH complete
> > [  428.204000] sd 0:0:0:0: [sda] 234441648 512-byte hardware sectors (120034 MB)
> > [  428.204000] sd 0:0:0:0: [sda] Write Protect is off
> > [  428.204000] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> > [  428.204000] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> > 
> > Kernel recovered just fine and things seem smooth so far. Is that something I need
> > to worry about ?
> 
> Please post the result of 'hdparm -I /dev/sda' and you don't need to
> worry about it too much.

Allright. What is happening exactly ? A fluke on the link ?

> benh@pasglop:~/kernels/linux-2.6$ sudo hdparm -I /dev/sda

/dev/sda:

ATA device, with non-removable media
        Model Number:       ST9120822AS
        Serial Number:      5LZ50702
        Firmware Revision:  3.CLF
Standards:
        Supported: 7 6 5 4
        Likely used: 7
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  234441648
        LBA48  user addressable sectors:  234441648
        device size with M = 1024*1024:      114473 MBytes
        device size with M = 1000*1000:      120034 MBytes (120 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 32
        Standby timer values: spec'd by Standard, no device specific
minimum
        R/W multiple sector transfer: Max = 16  Current = ?
        Advanced power management level: unknown setting (0x8080)
        Recommended acoustic management value: 254, current value: 0
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
           *    Host Protected Area feature set
           *    WRITE_BUFFER command
           *    READ_BUFFER command
           *    DOWNLOAD_MICROCODE
           *    Advanced Power Management feature set
                SET_MAX security extension
           *    48-bit Address feature set
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT
           *    SMART error logging
           *    SMART self-test
           *    General Purpose Logging feature set
           *    IDLE_IMMEDIATE with UNLOAD
           *    SATA-I signaling speed (1.5Gb/s)
           *    Native Command Queueing (NCQ)
           *    Phy event counters
           *    Device-initiated interface power management
           *    Software settings preservation
           *    SMART Command Transport (SCT) feature set
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
                frozen
        not     expired: security count
                supported: enhanced erase
        66min for SECURITY ERASE UNIT. 66min for ENHANCED SECURITY ERASE
UNIT.
Checksum: correct


