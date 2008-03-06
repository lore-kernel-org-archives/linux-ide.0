From: Denys Dmytriyenko <denis@denix.org>
Subject: Re: sata_sil24 stability and performance
Date: Wed, 05 Mar 2008 23:14:54 -0500
Message-ID: <20080306041454.GA7242@denix.org>
References: <20080219020916.GA29902@denix.org> <20080219043659.GA11936@jim.sh>
 <47BAF677.5000602@rtr.ca> <20080302061453.GA7291@denix.org>
 <005d01c87c4c$0d01f550$4d0fa8c0@M2007> <47CC9197.9050609@gmail.com>
 <20080304002215.GA13317@denix.org> <47CCC1C6.5010600@gmail.com>
 <20080304062942.GA14335@denix.org> <47CE55B3.6070701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms048pub.verizon.net ([206.46.252.48]:49262 "EHLO
	vms048pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162AbYCFEPP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Mar 2008 23:15:15 -0500
Received: from gandalf.denix.org ([71.126.188.25])
 by vms048.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JXA0081AJSUP6Q1@vms048.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Wed, 05 Mar 2008 22:14:55 -0600 (CST)
In-reply-to: <47CE55B3.6070701@gmail.com>
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Gabor FUNK <FUNK.Gabor@hunetkft.hu>, linux-ide@vger.kernel.org, Jim Paris <jim@jtan.com>, Mark Lord <liml@rtr.ca>

On Wed, Mar 05, 2008 at 05:11:31PM +0900, Tejun Heo wrote:
> That's the drive rejecting acoustic setting command probably because the
> drive doesn't support it.  Nothing to worry about.  More recent kernels
> won't whine about those anymore.

Oh, thanks. I forgot that I tried to change acoustic setting.

> > # dd if=/dev/zero of=file bs=100M count=20
> > 20+0 records in
> > 20+0 records out
> > 2097152000 bytes (2.1 GB) copied, 117.053 s, 17.9 MB/s
> > 
> > # dd if=file of=file1 bs=100M count=20
> > 20+0 records in
> > 20+0 records out
> > 2097152000 bytes (2.1 GB) copied, 161.721 s, 13.0 MB/s
> 
> Write seems awfully sluggish.  Does turning off NCQ help?  You can turn
> off NCQ by echoing 1 to /sys/block/sdX/device/queue_depth.  Also, which
> kernel is this test result from?

Turning off NCQ does not help. I am currently on 2.6.23.9, but I just tried
2.6.25-rc4 and it is the same.

> > A similar drive in an ICH7 box shows more consistent results:
> > 
> > # hdparm -t /dev/sda
> > 
> > /dev/sda:
> >  Timing buffered disk reads:  182 MB in  3.01 seconds =  60.48 MB/sec
> > 
> > # dd if=/dev/zero of=file bs=100M count=100
> > 100+0 records in
> > 100+0 records out
> > 10485760000 bytes (10 GB) copied, 242.908 s, 43.2 MB/s
> > 
> > # dd if=file of=/dev/null bs=100M count=100
> > 100+0 records in
> > 100+0 records out
> > 10485760000 bytes (10 GB) copied, 211.132 s, 49.7 MB/s
> 
> Hmmm... indeed.  Same kernel version?  Can you post "hdparm -I" results
> of both drives?

The kernel on the second box is also 2.6.23.9. Here are hdparm results for
identical drives:

1. Connected to SiI 3124/sata_sil24 w/ slow write:

# hdparm -I /dev/sda

/dev/sda:

ATA device, with non-removable media
        Model Number:       WDC WD1600JS-75NCB1
        Serial Number:      WD-WCANM1344866
        Firmware Revision:  10.02E01
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
        LBA    user addressable sectors:  268435455
        LBA48  user addressable sectors:  312500000
        device size with M = 1024*1024:      152587 MBytes
        device size with M = 1000*1000:      160000 MBytes (160 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 32
        Standby timer values: spec'd by Standard, with device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Recommended acoustic management value: 128, current value: 128
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 udma6
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
           *    SATA-II signaling speed (3.0Gb/s)
           *    Native Command Queueing (NCQ)
           *    Host-initiated interface power management
           *    Phy event counters
                DMA Setup Auto-Activate optimization
                Device-initiated interface power management
           *    Software settings preservation
           *    SMART Command Transport (SCT) feature set
           *    SCT Long Sector Access (AC1)
           *    SCT LBA Segment Access (AC2)
           *    SCT Error Recovery Control (AC3)
           *    SCT Features Control (AC4)
           *    SCT Data Tables (AC5)
                unknown 206[12]
Security:
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
Checksum: correct


2. Connected to ICH7/ata_piix w/ normal write:

# hdparm -I /dev/sda

/dev/sda:

ATA device, with non-removable media
        Model Number:       WDC WD1600JS-75NCB1
        Serial Number:      WD-WCANM1356774
        Firmware Revision:  10.02E01
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
        LBA    user addressable sectors:  268435455
        LBA48  user addressable sectors:  312500000
        device size with M = 1024*1024:      152587 MBytes
        device size with M = 1000*1000:      160000 MBytes (160 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 32
        Standby timer values: spec'd by Standard, with device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Recommended acoustic management value: 128, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
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
           *    SATA-II signaling speed (3.0Gb/s)
           *    Native Command Queueing (NCQ)
           *    Host-initiated interface power management
           *    Phy event counters
                DMA Setup Auto-Activate optimization
                Device-initiated interface power management
           *    Software settings preservation
           *    SMART Command Transport (SCT) feature set
           *    SCT Long Sector Access (AC1)
           *    SCT LBA Segment Access (AC2)
           *    SCT Error Recovery Control (AC3)
           *    SCT Features Control (AC4)
           *    SCT Data Tables (AC5)
                unknown 206[12]
Security:
                supported
        not     enabled
        not     locked
                frozen
        not     expired: security count
        not     supported: enhanced erase
Checksum: correct

Also, few months ago instead of sata_sil24 I had my drives connected to
sata_mv (Supermicro 8-port) and performance was normal...

Thank you for your time. Please let me know what else to try.

Regards,
Denys
