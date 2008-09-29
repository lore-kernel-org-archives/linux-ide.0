From: Paul Rolland (=?UTF-8?B?44Od44O844Or44O744Ot44Op44Oz?=)
	<rol@witbe.net>
Subject: Re: regarding frequent head unload problem
Date: Mon, 29 Sep 2008 11:00:17 +0200
Message-ID: <20080929110017.341a5255@tux.DEF.witbe.net>
References: <48E08B99.1070508@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.witbe.net ([81.88.96.48]:42024 "EHLO smtp.witbe.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751943AbYI2JIK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Sep 2008 05:08:10 -0400
In-Reply-To: <48E08B99.1070508@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Ivan N. Zlatev" <contact@i-nz.net>, Robert Krawitz <rlk@alum.mit.edu>, Omar A <aliencoder@gmail.com>, Pascal Vandeputte <pascal@asmodeus.be>, Carlos Bessa <carlos.bessa@gmail.com>, Andy Vaselaar <andrew.vaselaar@trinity.edu>, webmaster@dragontower.de, Christian Wolf <wolfchri@gmail.com>, "A. Klitzing" <aklitzing@online.de>, Stefan Henriet <aladin7501-01@yahoo.de>, IDE/ATA development list <linux-ide@vger.kernel.org>, rol@witbe.net

Hello,

On Mon, 29 Sep 2008 17:02:33 +0900
Tejun Heo <tj@kernel.org> wrote:

> Hello,
> 
> I'm writing to everyone who reported to me or linux-ide about frequent
> head unload problem and the report is not yet committed to
> storage-fixup.conf.
> 
> I'm a bit worried about the explosion of reports because I really
> wanna avoid creating false entries as they will increase power
> consumption on Linux unnecessarily.  I've just updated the Known
> Issues wiki page.  Here are the update parts.
> 
>  Note that modern laptop drives are supposed to unload frequently to
>  save power. Unless the unloading is excessive, disabling powersaving
>  is not a good idea. It seems that most modern drives are rated for
>  600,000 load/unload cycles which translates to about two years of
>  uptime at 35 unloads per hour. Even when assuming continuous 12 hours
>  of usage everyday, this means the drive will only reach its rated
>  load/unload cycle limit after four years and shouldn't be considered
>  malfunctioning. Please only report cases where the expected uptime is
>  significantly lower than two years.
> 
>  ... Also, please include how many times the drive unloads the head
>  per-hour under nominal usage without any adjustment.

I also have the following :
[root@tux ~]# while : ; do smartctl --all /dev/sda | grep ^193; sleep 60; done
193 Load_Cycle_Count 0x0012 075 075 000  Old_age Always  - 257584 
193 Load_Cycle_Count 0x0012 075 075 000  Old_age Always  - 257590 
193 Load_Cycle_Count 0x0012 075 075 000  Old_age Always  - 257593

and counting up...
The machine is not an HP one, but a Dell Inspiron 6400. The disk is :

/dev/sda:

 Model=Hitachi HTS542525K9SA00                 , FwRev=BBFOC31P, SerialNo=071007BB0F00WDGA8U9C
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=7229kB, MaxMultSect=16, MultSect=?8?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 
 AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
 Drive conforms to: unknown:  ATA/ATAPI-2,3,4,5,6,7

 * signifies the current active mode

[root@tux ~]# hdparm -I /dev/sda

/dev/sda:

ATA device, with non-removable media
        Model Number:       Hitachi HTS542525K9SA00                 
        Serial Number:      071007BB0F00WDGA8U9C
        Firmware Revision:  BBFOC31P
        Transport:          Serial, ATA8-AST, SATA 1.0a, SATA II Extensions, SATA Rev 2.5; Revision: ATA8-AST T13 Project D1697 Revision 0b
Standards:
        Supported: 8 7 6 5 
        Likely used: 8
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
        Standby timer values: spec'd by Vendor, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 8
        Advanced power management level: 128 (0x80)
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
           *    Advanced Power Management feature set
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
           *    WRITE_{DMA|MULTIPLE}_FUA_EXT
           *    64-bit World wide name
           *    IDLE_IMMEDIATE with UNLOAD
           *    WRITE_UNCORRECTABLE command
           *    SATA-I signaling speed (1.5Gb/s)
           *    Native Command Queueing (NCQ)
           *    Host-initiated interface power management
           *    Phy event counters
           *    unknown 76[12]
                Non-Zero buffer offsets in DMA Setup FIS
                DMA Setup Auto-Activate optimization
                Device-initiated interface power management
                In-order data delivery
           *    Software settings preservation
           *    SMART Command Transport (SCT) feature set
           *    SCT LBA Segment Access (AC2)
           *    SCT Error Recovery Control (AC3)
           *    SCT Features Control (AC4)
           *    SCT Data Tables (AC5)
Security: 
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
                frozen
        not     expired: security count
                supported: enhanced erase
        106min for SECURITY ERASE UNIT. 108min for ENHANCED SECURITY ERASE UNIT.
Checksum: correct

The machine is running Linux 2.6.27-rc5.


> Machines currently on the storage.fixup list are (or at least supposed
> to be) the extreme cases where the drive unloads its head multiple
> times per minute decreasing its life expectancy to under a year.
> Please double check your machine falls into this category.

Seems that I do :(

Can I help in any way ?

Regards,
Paul

-- 
Paul Rolland                                E-Mail : rol(at)witbe.net
CTO - Witbe.net SA                          Tel. +33 (0)1 47 67 77 77
Les Collines de l'Arche                     Fax. +33 (0)1 47 67 77 99
F-92057 Paris La Defense                    RIPE : PR12-RIPE

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur 
"Some people dream of success... while others wake up and work hard at it" 

There's no heavier burden than a great potential.
