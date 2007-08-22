From: Rusty Conover <rconover@infogears.com>
Subject: Re: Resets on sil3124 & sil3726 PMP
Date: Wed, 22 Aug 2007 01:49:12 -0600
Message-ID: <7644C0A3-8AEF-4C00-837A-429F73DD616D@infogears.com>
References: <EA70552E-75C2-451D-BF58-A73482FBB14D@infogears.com> <46C5E3A6.9020907@gmail.com> <DFEB0E31-D017-4527-85A4-8D18D379CB0B@infogears.com> <98147300-A282-4909-A393-079365833BD8@infogears.com> <46CBA78D.2070405@gmail.com> <F3FDFA8B-A2EF-4EEE-ACE2-E67776650CF4@infogears.com> <46CBCD18.7070507@gmail.com> <B209C20A-580B-4AD6-A6A0-B4377499B8FC@infogears.com> <46CBDA17.6010009@gmail.com> <D2865984-EF5E-400F-9B71-1F95363D4C3F@infogears.com> <46CBDF82.6020206@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.infogears.com ([69.51.90.143]:51680 "EHLO
	mail.infogears.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754919AbXHVHtP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 03:49:15 -0400
In-Reply-To: <46CBDF82.6020206@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org


On Aug 22, 2007, at 1:02 AM, Tejun Heo wrote:

> Rusty Conover wrote:
>> After adding a semicolon to the added line, and recompiling there are
>> still timeouts like before on the PMP ports.
>
> Oops.
>
>> It did have the effect of setting the SATA speed to 1.5 rather  
>> then 3.0
>> on boot though.
>
> Yeah, that was the intention.  I'm running out of ideas.  Just some
> random suggestions...
>
> * if you have access to different types of disks, try them.
>
> * if you can open the storage box, take out the PMP and connect it and
> the harddrive to a different power supply and see whether that changes
> anything.

Hi Tejun,

I have some interesting results.

I had a pair of Seagate 250 GB SATA disks (models below) and tried  
those out rather then the WD's.    At the 1.5 gbps rather they appear  
to work just fine both being on the same PMP, at 3.0 gbps they  
timeout just like the other disks did.  Possibly, the code isn't  
detecting the max rate of the disks correctly since these drives only  
do 1.5 and it attempted to do 3.0 gbps?

Have you found that drives can be picky if they will work or not with  
PMP ports?

I'll be trying to get a bunch of different drives to replace the ones  
that don't work with PMP.

Thanks,

Rusty

[root@site-12 ~]# hdparm -I /dev/sdc

/dev/sdc:

ATA device, with non-removable media
         Model Number:       ST3250620AS
         Serial Number:      3QF0YRJF
         Firmware Revision:  3.AAE
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
         LBA48  user addressable sectors:  488397168
         device size with M = 1024*1024:      238475 MBytes
         device size with M = 1000*1000:      250059 MBytes (250 GB)
Capabilities:
         LBA, IORDY(can be disabled)
         Queue depth: 32
         Standby timer values: spec'd by Standard, no device specific  
minimum
         R/W multiple sector transfer: Max = 16  Current = ?
         Recommended acoustic management value: 254, current value: 0
         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5  
udma6
              Cycle time: min=120ns recommended=120ns
         PIO: pio0 pio1 pio2 pio3 pio4
              Cycle time: no flow control=120ns  IORDY flow  
control=120ns
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
                 SET_MAX security extension
            *    48-bit Address feature set
            *    Device Configuration Overlay feature set
            *    Mandatory FLUSH_CACHE
            *    FLUSH_CACHE_EXT
            *    SMART error logging
            *    SMART self-test
            *    General Purpose Logging feature set
            *    SATA-I signaling speed (1.5Gb/s)
            *    Native Command Queueing (NCQ)
            *    Phy event counters
                 Device-initiated interface power management
            *    Software settings preservation
Security:
         Master password revision code = 65534
                 supported
         not     enabled
         not     locked
         not     frozen
         not     expired: security count
         not     supported: enhanced erase
Checksum: correct

