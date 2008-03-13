From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: NCQ change  on 2007-12-07
Date: Wed, 12 Mar 2008 21:07:04 -0600
Message-ID: <47D89A58.6010301@shaw.ca>
References: <D8AE5DC69BFCA64989BE8E46BCF0047303B24F2E@MAPLE.conncoll.edu>
 <47D76B7D.8010808@gmail.com>
 <D8AE5DC69BFCA64989BE8E46BCF0047303B24F2F@MAPLE.conncoll.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:50289 "EHLO
	pd2mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbYCMDHO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Mar 2008 23:07:14 -0400
Received: from pd2mr6so.prod.shaw.ca (pd2mr6so-qfe3.prod.shaw.ca [10.0.141.9])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JXN00I04FC0ULB0@l-daemon> for linux-ide@vger.kernel.org; Wed,
 12 Mar 2008 21:07:12 -0600 (MDT)
Received: from pn2ml2so.prod.shaw.ca ([10.0.121.146])
 by pd2mr6so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JXN00H48FBZ0U80@pd2mr6so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Wed, 12 Mar 2008 21:07:13 -0600 (MDT)
Received: from [192.168.1.113] ([70.64.130.4])
 by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JXN001RUFBVL140@l-daemon> for linux-ide@vger.kernel.org; Wed,
 12 Mar 2008 21:07:10 -0600 (MDT)
In-reply-to: <D8AE5DC69BFCA64989BE8E46BCF0047303B24F2F@MAPLE.conncoll.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Lanstein, Alex C" <aclan@conncoll.edu>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Lanstein, Alex C wrote:
> Hello,
> 
> I was asked to CC this list regarding an NCQ issue I'm having with many WD400YR-01PLB0 drives.
> 
> I have ~400 WD400YR-01PLB0 drives and some have NCQ errors that temporarily lock drive (and system) until the operation times out.  They look exactly the same in hdparm (same model, firmware version, etc), but there is a sticker on the back of the drive that we believe is a WDC internal version number.  100% of the drives that have AD on the end of the sticker have the problem and 100% of the ones that have AJ (or later) do not.  They all came from different batches and manufacturing locations so we're assuming it was some sort of silent revision.  This does not appear to be the same problem as the spurious NCQ issue thta Tejun fixed in December.
> 
> The sticker for a few drives that have the errors:
> 2061-701310-C00 AD	XS 2R19 2Q3v 1 0006340 6346
> 2061-701310-C00 AD	XS 2R19 2H28 4 0005330 6335
> 2061-701310-C00 AD	XS 2R19 1YSS 1 0002330 6332
> 2061-701310-C00 AD	XW 2R19 5JMQ 1 0005290 6295
> 
> The sticker for those that work correctly:
> 2061-701310-C00 AJ	XS 2R26 12JP 5 0007510 6517
> 2061-701310-C00 AJ	XS 2R26 0JPY 1 000145R 6451
> 2061-701310-C00 AJ	XS 2R26 12HQ 5 0007510 6517
> 2061-701310-C00 AK	XS 2R27 0FM6 4 0001140 7141
> 
> This sticker is on the underside of the drive on the plastic on the side of the drive with the legacy power connector
> 
> 
> 
> This is the output from hdparm -I, as well as uname -a.  All the drives look exactly the same in hdparm -I, so I'm not going to post more than one.  
> 
> [admin@hostname db]# hdparm -I /dev/sda
> 
> /dev/sda:
> 
> ATA device, with non-removable media
>         Model Number:       WDC WD4000YR-01PLB0
>         Serial Number:      WD-WMAMY1509516
>         Firmware Revision:  01.06A01
> Standards:
>         Supported: 7 6 5 4
>         Likely used: 7
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
>         Queue depth: 32
>         Standby timer values: spec'd by Standard, with device specific minimum
>         R/W multiple sector transfer: Max = 16  Current = 16
>         Recommended acoustic management value: 128, current value: 254
>         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
>              Cycle time: min=120ns recommended=120ns
>         PIO: pio0 pio1 pio2 pio3 pio4
>              Cycle time: no flow control=120ns  IORDY flow control=120ns
> Commands/features:
>         Enabled Supported:
>            *    NOP cmd
>            *    READ BUFFER cmd
>            *    WRITE BUFFER cmd
>            *    Host Protected Area feature set
>            *    Look-ahead
>            *    Write cache
>            *    Power Management feature set
>                 Security Mode feature set
>            *    SMART feature set
>            *    FLUSH CACHE EXT command
>            *    Mandatory FLUSH CACHE command
>            *    Device Configuration Overlay feature set
>            *    48-bit Address feature set
>                 Automatic Acoustic Management feature set
>                 SET MAX security extension
>            *    SET FEATURES subcommand required to spinup after power up
>                 Power-Up In Standby feature set
>            *    DOWNLOAD MICROCODE cmd
>            *    General Purpose Logging feature set
>            *    SMART self-test
>            *    SMART error logging
> Security:
>                 supported
>         not     enabled
>         not     locked
>         not     frozen
>         not     expired: security count
>         not     supported: enhanced erase
> Checksum: correct
> [admin@host db]# uname -a
> Linux Phi 2.6.22.6 #1 SMP PREEMPT Thu Feb 7 11:58:42 PST 2008 x86_64 x86_64 x86_64 GNU/Linux
> 
> These are a sample of the NCQ issues in dmesg and /var/log/messages.  It appears to be a blocking call so the system locks up for sometimes up to an hour.  To get the errors to occur I need to be doing heavy drive writing for a period of more than a few minutes.
> 
> 
> [admin@loki-idp-01 ~]# cat /var/log/messages | grep kernel
> Mar 11 06:11:08 loki-idp-01 kernel: ata1: EH in ADMA mode, notifier 0x0 notifier_error 0x0 gen_ctl 0x1501000 status 0x400 next cpb count 0x0 next cpb idx 0x0
> Mar 11 06:11:08 loki-idp-01 kernel: ata1: CPB 1: ctl_flags 0x1f, resp_flags 0x2
> Mar 11 06:11:08 loki-idp-01 kernel: ata1: CPB 2: ctl_flags 0x1f, resp_flags 0x2
> Mar 11 06:11:08 loki-idp-01 kernel: ata1: CPB 3: ctl_flags 0x1f, resp_flags 0x2
> Mar 11 06:11:08 loki-idp-01 kernel: ata1: timeout waiting for ADMA IDLE, stat=0x400
> Mar 11 06:11:08 loki-idp-01 kernel: ata1.00: exception Emask 0x0 SAct 0xe SErr 0x0 action 0x2 frozen
> Mar 11 06:11:08 loki-idp-01 kernel: ata1.00: cmd 60/08:08:02:74:51/00:00:00:00:00/40 tag 1 cdb 0x0 data 4096 in
> Mar 11 06:11:08 loki-idp-01 kernel:          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Mar 11 06:11:08 loki-idp-01 kernel: ata1.00: cmd 60/10:10:3a:74:51/00:00:00:00:00/40 tag 2 cdb 0x0 data 8192 in
> Mar 11 06:11:08 loki-idp-01 kernel:          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Mar 11 06:11:08 loki-idp-01 kernel: ata1.00: cmd 60/08:18:52:74:51/00:00:00:00:00/40 tag 3 cdb 0x0 data 4096 in
> Mar 11 06:11:08 loki-idp-01 kernel:          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Mar 11 06:11:08 loki-idp-01 kernel: sd 0:0:0:0: [sda] 781422768 512-byte hardware sectors (400088 MB)
> Mar 11 06:11:08 loki-idp-01 kernel: sd 0:0:0:0: [sda] Write Protect is off
> Mar 11 06:11:08 loki-idp-01 kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> Mar 11 06:19:21 loki-idp-01 kernel: ata1: EH in ADMA mode, notifier 0x0 notifier_error 0x0 gen_ctl 0x1501000 status 0x400 next cpb count 0x0 next cpb idx 0x0
> Mar 11 06:19:21 loki-idp-01 kernel: ata1: CPB 2: ctl_flags 0x1f, resp_flags 0x2
> Mar 11 06:19:21 loki-idp-01 kernel: ata1: CPB 3: ctl_flags 0x1f, resp_flags 0x2
> Mar 11 06:19:21 loki-idp-01 kernel: ata1: CPB 4: ctl_flags 0x1f, resp_flags 0x2
> Mar 11 06:19:21 loki-idp-01 kernel: ata1: CPB 5: ctl_flags 0x1f, resp_flags 0x2
> Mar 11 06:19:21 loki-idp-01 kernel: ata1: CPB 6: ctl_flags 0x1f, resp_flags 0x2
> Mar 11 06:19:21 loki-idp-01 kernel: ata1: CPB 7: ctl_flags 0x1f, resp_flags 0x2
> Mar 11 06:19:21 loki-idp-01 kernel: ata1: timeout waiting for ADMA IDLE, stat=0x400
> Mar 11 06:19:21 loki-idp-01 kernel: ata1.00: exception Emask 0x0 SAct 0xfc SErr 0x0 action 0x2 frozen
> Mar 11 06:19:21 loki-idp-01 kernel: ata1.00: cmd 60/08:10:4b:d0:6c/00:00:2a:00:00/40 tag 2 cdb 0x0 data 4096 in
> Mar 11 06:19:21 loki-idp-01 kernel:          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Mar 11 06:19:21 loki-idp-01 kernel: ata1.00: cmd 60/08:18:5b:d0:6c/00:00:2a:00:00/40 tag 3 cdb 0x0 data 4096 in
> Mar 11 06:19:21 loki-idp-01 kernel:          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Mar 11 06:19:21 loki-idp-01 kernel: ata1.00: cmd 60/08:20:13:d1:6c/00:00:2a:00:00/40 tag 4 cdb 0x0 data 4096 in
> Mar 11 06:19:21 loki-idp-01 kernel:          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Mar 11 06:19:21 loki-idp-01 kernel: ata1.00: cmd 60/08:28:1b:d1:6c/00:00:2a:00:00/40 tag 5 cdb 0x0 data 4096 in
> Mar 11 06:19:21 loki-idp-01 kernel:          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Mar 11 06:19:21 loki-idp-01 kernel: ata1.00: cmd 60/08:30:2b:d1:6c/00:00:2a:00:00/40 tag 6 cdb 0x0 data 4096 in
> Mar 11 06:19:21 loki-idp-01 kernel:          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Mar 11 06:19:21 loki-idp-01 kernel: ata1.00: cmd 60/10:38:43:9f:6d/00:00:2a:00:00/40 tag 7 cdb 0x0 data 8192 in
> Mar 11 06:19:21 loki-idp-01 kernel:          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Mar 11 06:19:21 loki-idp-01 kernel: sd 0:0:0:0: [sda] 781422768 512-byte hardware sectors (400088 MB)
> Mar 11 06:19:21 loki-idp-01 kernel: sd 0:0:0:0: [sda] Write Protect is off
> Mar 11 06:19:21 loki-idp-01 kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> Mar 11 07:23:13 loki-idp-01 kernel: ip_tables: (C) 2000-2006 Netfilter Core Team
> Mar 11 07:28:33 loki-idp-01 kernel: ip_tables: (C) 2000-2006 Netfilter Core Team

I don't think the driver is to blame for this one. CPB resp_flags of 2 
indicates the controller says that tag is "released", i.e. drive has 
been given the command but not completed. If it's timing out in that 
state, either the NCQ implementation is bad enough that it allows 
certain queued commands to starve for over 30 seconds, or the drive is 
just forgetting about them entirely.

Unfortunately, if the firmware revision does indeed appear the same on 
both sets of drives, the only automated way we could likely address the 
problem would be to blacklist NCQ on all of those drives of that 
model/revision..
