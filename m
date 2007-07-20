From: =?ISO-8859-1?Q?D=E2niel?= Fraga <fragabr@gmail.com>
Subject: Re: pata_via with software raid1: "attempt to access beyond end of
 device"
Date: Thu, 19 Jul 2007 21:25:24 -0300
Message-ID: <k0c5n4-dl4.ln1@tux.abusar.org>
References: <ohu2n4-lcf.ln1@tux.abusar.org>
	<20070720001714.7b6aaf95@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:46979 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757261AbXGTA0B (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Jul 2007 20:26:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBgJa-0002SM-KO
	for linux-ide@vger.kernel.org; Fri, 20 Jul 2007 02:25:50 +0200
Received: from 200-207-206-233.dsl.telesp.net.br ([200.207.206.233])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Fri, 20 Jul 2007 02:25:50 +0200
Received: from fragabr by 200-207-206-233.dsl.telesp.net.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Fri, 20 Jul 2007 02:25:50 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Fri, 20 Jul 2007 00:17:14 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Are their host protected areas on the two disks ?

	I don't know, but hdparm returns this:

/dev/sda:

ATA device, with non-removable media
        Model Number:       ST3802110A                              
        Serial Number:      5LR2DA69
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
        LBA    user addressable sectors:  156301488
        LBA48  user addressable sectors:  156301488
        device size with M = 1024*1024:       76319 MBytes
        device size with M = 1000*1000:       80026 MBytes (80 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 1
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 1
        Recommended acoustic management value: 208, current value: 0
        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
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
                SET MAX security extension
           *    DOWNLOAD MICROCODE cmd
           *    General Purpose Logging feature set
           *    SMART self-test 
           *    SMART error logging 
Security: 
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper
Checksum: correct

	***

/dev/sdb:

ATA device, with non-removable media
        Model Number:       ST3802110A                              
        Serial Number:      5LR3ZQ6A
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
        LBA    user addressable sectors:  156301488
        LBA48  user addressable sectors:  156301488
        device size with M = 1024*1024:       76319 MBytes
        device size with M = 1000*1000:       80026 MBytes (80 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 1
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 1
        Recommended acoustic management value: 208, current value: 0
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
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
                SET MAX security extension
           *    DOWNLOAD MICROCODE cmd
           *    General Purpose Logging feature set
           *    SMART self-test 
           *    SMART error logging 
Security: 
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper
Checksum: correct

	***

	Both HDs are identical. How can I determine if it's a Host
Protected Area?

	SMART information, if needed:

fraga@abusar ~$ sudo ide-smart /dev/sda
Id=  1  Status=15  {Prefailure  Online }  Value=100  Threshold=  6  Passed
Id=  3  Status= 3  {Prefailure  Online }  Value= 99  Threshold=  0  Passed
Id=  4  Status=50  {Advisory    Online }  Value=100  Threshold= 20  Passed
Id=  5  Status=51  {Prefailure  Online }  Value=100  Threshold= 36  Passed
Id=  7  Status=15  {Prefailure  Online }  Value= 85  Threshold= 30  Passed
Id=  9  Status=50  {Advisory    Online }  Value= 93  Threshold=  0  Passed
Id= 10  Status=19  {Prefailure  Online }  Value=100  Threshold= 97  Passed
Id= 12  Status=50  {Advisory    Online }  Value=100  Threshold= 20  Passed
Id=187  Status=50  {Advisory    Online }  Value=  1  Threshold=  0  Passed
Id=189  Status=58  {Advisory    Online }  Value=100  Threshold=  0  Passed
Id=190  Status=34  {Advisory    Online }  Value= 66  Threshold= 45  Passed
Id=194  Status=34  {Advisory    Online }  Value= 34  Threshold=  0  Passed
Id=195  Status=26  {Advisory    Online }  Value= 69  Threshold=  0  Passed
Id=197  Status=18  {Advisory    Online }  Value=100  Threshold=  0  Passed
Id=198  Status=16  {Advisory    OffLine}  Value=100  Threshold=  0  Passed
Id=199  Status=62  {Advisory    Online }  Value=200  Threshold=  0  Passed
Id=200  Status= 0  {Advisory    OffLine}  Value=100  Threshold=  0  Passed
Id=202  Status=50  {Advisory    Online }  Value=100  Threshold=  0  Passed
OffLineStatus=130 {Completed}, AutoOffLine=Yes, OffLineTimeout=7 minutes
OffLineCapability=91 {Immediate Auto SuspendOnCmd}
SmartRevision=10, CheckSum=177, SmartCapability=3 {SaveOnStandBy AutoSave}

fraga@abusar ~$ sudo ide-smart /dev/sdb
Id=  1  Status=15  {Prefailure  Online }  Value=104  Threshold=  6  Passed
Id=  3  Status= 3  {Prefailure  Online }  Value= 99  Threshold=  0  Passed
Id=  4  Status=50  {Advisory    Online }  Value=100  Threshold= 20  Passed
Id=  5  Status=51  {Prefailure  Online }  Value=100  Threshold= 36  Passed
Id=  7  Status=15  {Prefailure  Online }  Value= 84  Threshold= 30  Passed
Id=  9  Status=50  {Advisory    Online }  Value= 94  Threshold=  0  Passed
Id= 10  Status=19  {Prefailure  Online }  Value=100  Threshold= 97  Passed
Id= 12  Status=50  {Advisory    Online }  Value=100  Threshold= 20  Passed
Id=187  Status=50  {Advisory    Online }  Value=100  Threshold=  0  Passed
Id=189  Status=58  {Advisory    Online }  Value=100  Threshold=  0  Passed
Id=190  Status=34  {Advisory    Online }  Value= 66  Threshold= 45  Passed
Id=194  Status=34  {Advisory    Online }  Value= 34  Threshold=  0  Passed
Id=195  Status=26  {Advisory    Online }  Value= 66  Threshold=  0  Passed
Id=197  Status=18  {Advisory    Online }  Value=100  Threshold=  0  Passed
Id=198  Status=16  {Advisory    OffLine}  Value=100  Threshold=  0  Passed
Id=199  Status=62  {Advisory    Online }  Value=200  Threshold=  0  Passed
Id=200  Status= 0  {Advisory    OffLine}  Value=100  Threshold=  0  Passed
Id=202  Status=50  {Advisory    Online }  Value=100  Threshold=  0  Passed
OffLineStatus=130 {Completed}, AutoOffLine=Yes, OffLineTimeout=7 minutes
OffLineCapability=91 {Immediate Auto SuspendOnCmd}
SmartRevision=10, CheckSum=193, SmartCapability=3 {SaveOnStandBy AutoSave}

	Thank you very much.

-- 
Linux 2.6.22: Holy Dancing Manatees, Batman!
http://www.lastfm.pt/user/danielfraga
http://u-br.net
Dave Matthews Band - "When the World Ends" (Everyday)

