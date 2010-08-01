From: Tomas Lund <tlund@nxs.se>
Subject: Re: sata_sil24 failed command: READ FPDMA QUEUED
Date: Sun, 1 Aug 2010 16:27:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.1008011625490.24693@envy.nxs.se>
References: <Pine.LNX.4.61.1007132245000.24693@envy.nxs.se> <4C3D134B.2090604@gmail.com>
 <Pine.LNX.4.61.1007140955080.24693@envy.nxs.se> <Pine.LNX.4.61.1007152103081.24693@envy.nxs.se>
 <Pine.LNX.4.61.1007171422530.24693@envy.nxs.se> <Pine.LNX.4.61.1007211404480.24693@envy.nxs.se>
 <Pine.LNX.4.61.1007211433360.24693@envy.nxs.se> <4C531A40.6080804@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from envy.nxs.se ([212.247.200.182]:39101 "EHLO envy.nxs.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754504Ab0HAO1X (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 Aug 2010 10:27:23 -0400
In-Reply-To: <4C531A40.6080804@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

On Fri, 30 Jul 2010, Robert Hancock wrote:

> On 07/21/2010 06:38 AM, Tomas Lund wrote:
>> On Wed, 21 Jul 2010, Tomas Lund wrote:
>> 
>>> Put the "LYCOM SATA PE-103 2-CH" back in the server with the Gigabyte 
>>> 965P-DS4 motherboard and installed the debian backports kernel 
>>> 2.6.32-bpo.5-amd64.
>>> 
>>> Problem persists and a dmesg and console output (since dmesg buffer is 
>>> too small to fit everything) is available at:
>>> 
>>> http://tlund.pp.se/sil24/console_2.6.32-bpo.5-amd64.txt
>>> http://tlund.pp.se/sil24/dmesg_2.6.32-bpo.5-amd64.txt
>> 
>> Tested Debian 2.6.26-2-amd64, files at the same place.
>
> What does "hdparm -I" show when run on the drive attached to that controller?

# hdparm -I /dev/sdb

/dev/sdb:

ATA device, with non-removable media
         Model Number:       SAMSUNG HD103SJ
         Serial Number:      S246J90Z321275
         Firmware Revision:  1AJ10001
         Transport:          Serial, ATA8-AST, SATA 1.0a, SATA II Extensions, SATA Rev 2.5
Standards:
         Used: unknown (minor revision code 0x0028)
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
         LBA48  user addressable sectors: 1953525168
         device size with M = 1024*1024:      953869 MBytes
         device size with M = 1000*1000:     1000204 MBytes (1000 GB)
Capabilities:
         LBA, IORDY(can be disabled)
         Queue depth: 32
         Standby timer values: spec'd by Standard, no device specific minimum
         R/W multiple sector transfer: Max = 16  Current = 16
         Advanced power management level: disabled
         Recommended acoustic management value: 254, current value: 254
         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 udma6
              Cycle time: min=120ns recommended=120ns
         PIO: pio0 pio1 pio2 pio3 pio4
              Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
         Enabled Supported:
            *    SMART feature set
            *    Security Mode feature set
            *    Power Management feature set
            *    Write cache
            *    Look-ahead
            *    Host Protected Area feature set
            *    WRITE_BUFFER command
            *    READ_BUFFER command
            *    NOP cmd
            *    DOWNLOAD_MICROCODE
                 Advanced Power Management feature set
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
            *    64-bit World wide name
            *    WRITE_UNCORRECTABLE_EXT command
            *    {READ,WRITE}_DMA_EXT_GPL commands
            *    Segmented DOWNLOAD_MICROCODE
            *    SATA-I signaling speed (1.5Gb/s)
            *    SATA-II signaling speed (3.0Gb/s)
            *    Native Command Queueing (NCQ)
            *    Host-initiated interface power management
            *    Phy event counters
            *    unknown 76[12]
                 DMA Setup Auto-Activate optimization
                 Device-initiated interface power management
            *    Software settings preservation
            *    SMART Command Transport (SCT) feature set
            *    SCT Long Sector Access (AC1)
            *    SCT LBA Segment Access (AC2)
            *    SCT Error Recovery Control (AC3)
            *    SCT Features Control (AC4)
            *    SCT Data Tables (AC5)
Security:
         Master password revision code = 65534
                 supported
                 enabled
                 locked
         not     frozen
         not     expired: security count
                 supported: enhanced erase
         Security level high
         150min for SECURITY ERASE UNIT. 150min for ENHANCED SECURITY ERASE UNIT.
Logical Unit WWN Device Identifier: 50024e9221d12b7
         NAA             : 5
         IEEE OUI        : 24e9
         Unique ID       : 221d12b7
Checksum: correct

> Is it possible there's some security locking enabled on it? If the BIOS is 
> doing some kind of security unlock then it probably does it only on drives 
> attached to the motherboard controller, not on any add-in cards. It certainly 
> seems like the drive is returning command aborted on all reads when connected 
> to that controller for whatever reason.

No, nothing like that :(

//tlund
