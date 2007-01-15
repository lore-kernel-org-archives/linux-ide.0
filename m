From: kenneth johansson <ken@kenjo.org>
Subject: Re: ahci problems with sata disk.
Date: Mon, 15 Jan 2007 12:05:12 +0100
Message-ID: <1168859112.6980.8.camel@duo>
References: <1168785128.7865.13.camel@duo>  <45AB45B2.2080602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90]:2988 "EHLO
	garbo.kenjo.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932221AbXAOLFW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Jan 2007 06:05:22 -0500
In-Reply-To: <45AB45B2.2080602@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Mon, 2007-01-15 at 18:13 +0900, Tejun Heo wrote:
> kenneth johansson wrote:
> > I changed my bios setting for SATA from IDE to AHCI.
> > 
> > This resulted in some "interesting" read throughput. 
> > 
> > plots can be found at http://kenjo.org/~ken/sata/
> > The plots was done on a live disk so some noise is expected but in the
> > ahci mode the throughput get stuck at 17 MB way to much.
> 
> It's probably not an ahci problem but more of NCQ implementation problem
> in the drive firmware.  Please report the result of 'hdparm -I /dev/sdX'
> and try adjust queue depth and see what happens.
> 
> http://linux-ata.org/faq.html
> 

It was, when I turn of NCQ with "echo 1
> /sys/block/sda/device/queue_depth" I get the same performance as when
the BIOS is set to IDE.

I though that NCQ was intended to increase performance ??

also the disk is a Westen Digital raptor and it's probably the most
benchmarked drive one could get so I was not expecting a problem with
the drive. 

-------
ATA device, with non-removable media
        Model Number:       WDC WD1500ADFD-00NLR1                   
        Serial Number:      WD-WMAP41269747
        Firmware Revision:  20.07P20
Standards:
        Used: ATA/ATAPI-7 published, ANSI INCITS 397-2005 
        Supported: 7 6 5 4 
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  268435455
        LBA48  user addressable sectors:  293046768
        device size with M = 1024*1024:      143089 MBytes
        device size with M = 1000*1000:      150039 MBytes (150 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 32
        Standby timer values: spec'd by Standard, with device specific
minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Recommended acoustic management value: 128, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5
*udma6 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=120ns  IORDY flow control=120ns
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
           *    NOP cmd
           *    DOWNLOAD_MICROCODE
                Power-Up In Standby feature set
           *    SET_FEATURES required to spinup after power up
                SET_MAX security extension
           *    Automatic Acoustic Management feature set
           *    48-bit Address feature set
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT
           *    SMART error logging
           *    SMART self-test
           *    General Purpose Logging feature set
           *    SATA-I signaling speed (1.5Gb/s)
           *    Native Command Queueing (NCQ)
           *    Host-initiated interface power management
           *    Phy event counters
                DMA Setup Auto-Activate optimization
           *    Software settings preservation
           *    SMART Command Transport (SCT) feature set
           *    SCT Long Sector Access (AC1)
           *    SCT LBA Segment Access (AC2)
           *    SCT Error Recovery Control (AC3)
           *    SCT Features Control (AC4)
           *    SCT Data Tables (AC5)
                unknown 206[12]
Security: 
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
                frozen
        not     expired: security count
        not     supported: enhanced erase
Checksum: correct


