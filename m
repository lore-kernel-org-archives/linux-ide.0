From: "Sumanth J.V" <sumanth@cse.unl.edu>
Subject: Re: Fw: Spurious completions during NCQ
Date: Mon, 17 Sep 2007 08:18:26 -0500
Message-ID: <46EE7EA2.3000608@cse.unl.edu>
References: <20070915005751.353d0c69.akpm@linux-foundation.org> <46EC7159.6000904@garzik.org> <46ED25DD.605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cse-mail.unl.edu ([129.93.165.11]:58146 "EHLO cse-mail.unl.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753937AbXIQNqa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Sep 2007 09:46:30 -0400
In-Reply-To: <46ED25DD.605@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>   
>> Andrew Morton wrote:
>>     
>>> Begin forwarded message:
>>>
>>> Date: Fri, 07 Sep 2007 12:57:14 -0500
>>> From: "Sumanth J.V" <sumanth@cse.unl.edu>
>>> To: linux-kernel@vger.kernel.org
>>> Subject: Spurious completions during NCQ
>>>
>>>
>>> I keep seeing this message a few times a day on my box.
>>>
>>> ata1.00: exception Emask 0x2 SAct 0x18 SErr 0x0 action 0x2 frozen
>>> ata1.00: (spurious completions during NCQ issue=0x0 SAct=0x18
>>> FIS=004040a1:00000004)
>>>       
>
> Please report the result of "hdparm -I /dev/sda".
>
>   
[root@localhost 3d]# hdparm -I /dev/sda

/dev/sda:

ATA device, with non-removable media
        Model Number:       WDC WD5000AAKS-22TMA0                  
        Serial Number:      WD-WCAPW2873034
        Firmware Revision:  12.01C01
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
        LBA48  user addressable sectors:  976773168
        device size with M = 1024*1024:      476940 MBytes
        device size with M = 1000*1000:      500107 MBytes (500 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 32
        Standby timer values: spec'd by Standard, with device specific 
minimum
        R/W multiple sector transfer: Max = 16  Current = 0
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
                Power-Up In Standby feature set
           *    SET_FEATURES required to spinup after power up
                SET_MAX security extension
                Automatic Acoustic Management feature set
           *    48-bit Address feature set
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT
           *    SMART error logging
           *    SMART self-test
           *    General Purpose Logging feature set
           *    64-bit World wide name
           *    Segmented DOWNLOAD_MICROCODE
           *    SATA-I signaling speed (1.5Gb/s)
           *    SATA-II signaling speed (3.0Gb/s)
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
                unknown 206[13]
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
        128min for SECURITY ERASE UNIT.
Checksum: correct

