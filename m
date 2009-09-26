From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH #upstream-fixes] sata_promise: request follow-up SRST
Date: Fri, 25 Sep 2009 20:57:56 -0600
Message-ID: <4ABD8334.2090000@gmail.com>
References: <898aa1e70909242224n19c449b0s959f9f56f3ed63ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.211.174]:46408 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927AbZIZC5y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Sep 2009 22:57:54 -0400
Received: by ywh4 with SMTP id 4so3394339ywh.33
        for <linux-ide@vger.kernel.org>; Fri, 25 Sep 2009 19:57:58 -0700 (PDT)
In-Reply-To: <898aa1e70909242224n19c449b0s959f9f56f3ed63ff@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Walter Hutchins <hutchwa@gmail.com>
Cc: linux-ide@vger.kernel.org

On 09/24/2009 11:24 PM, Walter Hutchins wrote:
> I have tested this patch:
>
> http://user.it.uu.se/~mikpe/linux/patches/2.6/OLD/2.6.28/patch-sata_promise-reset-updates-v1-2.6.28
>
> on a 2.6.31 kernel.
>
> It continues with the same errors as:
> { DRDY ERR },
> { ICRC ABRT },
> exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t4,
> link is slow to respond,
> gradually reducing UDMA/133 to UDMA/33,
> etc.,
> with no apparent improvement.
>
> One thing of note is that it happens always on one drive, and not ever
> on the other.

Can you post the full dmesg output from bootup and the errors?

>
> It never happens on happens on ST3500641AS Seagate esata 500GB.
> It always happens on  WD My Book esata 500GB.
>
> I tried exchanging cables, and even reversing ports
> (including with fstab tweak from sda to sdb) to rule out the cable
> or the the controller port.
> I tried copying data the other way around and the WD still gave one
> group of errors, but writing triggers many more errors than reading.

Is the controller you are using designed to work with eSATA? Although a 
non-eSATA compliant controller will often work by connecting an eSATA 
adapter to the internal SATA ports, actually eSATA is supposed to use 
higher signalling voltage and it may not be reliable when used in this way.

>
> The problem follows the drive.
> The drive passes WD diagnostics and apparently functions fine except
> for the messages. The WD drive is a second RMA replacement for same model
> which gave same messages and I thought it was a problem.
>
> On kernel 2.6.18.8, the throughput to the WD drive is a little faster
> and the messages, which happen with the same frequency, are gentler.
>
> hdparm in case there is some clue:
>
> hdparm -I /dev/sda
>
> /dev/sda:
>
> ATA device, with non-removable media
>          Model Number:       ST3500641AS
>          Serial Number:      3PM1C9S5
>          Firmware Revision:  3.AAE
> Standards:
>          Supported: 7 6 5 4
>          Likely used: 7
> Configuration:
>          Logical         max     current
>          cylinders       16383   16383
>          heads           16      16
>          sectors/track   63      63
>          --
>          CHS current addressable sectors:   16514064
>          LBA    user addressable sectors:  268435455
>          LBA48  user addressable sectors:  976773168
>          device size with M = 1024*1024:      476940 MBytes
>          device size with M = 1000*1000:      500107 MBytes (500 GB)
> Capabilities:
>          LBA, IORDY(can be disabled)
>          Queue depth: 32
>          Standby timer values: spec'd by Standard, no device specific minimum
>          R/W multiple sector transfer: Max = 16  Current = ?
>          Recommended acoustic management value: 144, current value: 0
>          DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
>               Cycle time: min=120ns recommended=120ns
>          PIO: pio0 pio1 pio2 pio3 pio4
>               Cycle time: no flow control=240ns  IORDY flow control=120ns
> Commands/features:
>          Enabled Supported:
>             *    SMART feature set
>                  Security Mode feature set
>             *    Power Management feature set
>             *    Write cache
>             *    Look-ahead
>             *    Host Protected Area feature set
>             *    WRITE_BUFFER command
>             *    READ_BUFFER command
>             *    DOWNLOAD_MICROCODE
>                  SET_MAX security extension
>             *    48-bit Address feature set
>             *    Device Configuration Overlay feature set
>             *    Mandatory FLUSH_CACHE
>             *    FLUSH_CACHE_EXT
>             *    SMART error logging
>             *    SMART self-test
>             *    General Purpose Logging feature set
>             *    SATA-I signaling speed (1.5Gb/s)
>             *    SATA-II signaling speed (3.0Gb/s)
>             *    Native Command Queueing (NCQ)
>             *    Phy event counters
>             *    Software settings preservation
> Security:
>          Master password revision code = 65534
>                  supported
>          not     enabled
>          not     locked
>          not     frozen
>          not     expired: security count
>          not     supported: enhanced erase
> Checksum: correct
>
> hdparm -I /dev/sdb
>
> /dev/sdb:
>
> ATA device, with non-removable media
>          Model Number:       WD      My Book ESOxford OEMF@J
>          Serial Number:      WD-WCAPW0367705
>          Firmware Revision:  012
> Standards:
>          Used: ATA/ATAPI-6 T13 1410D revision 1
>          Supported: 6 5 4
> Configuration:
>          Logical         max     current
>          cylinders       16383   0
>          heads           16      0
>          sectors/track   63      0
>          --
>          LBA    user addressable sectors:  268435455
>          LBA48  user addressable sectors:  976773168
>          device size with M = 1024*1024:      476940 MBytes
>          device size with M = 1000*1000:      500107 MBytes (500 GB)
> Capabilities:
>          LBA, IORDY(cannot be disabled)
>          Standby timer values: spec'd by Vendor, with device specific minimum
>          R/W multiple sector transfer: Max = 1   Current = 0
>          DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
>               Cycle time: min=120ns recommended=120ns
>          PIO: pio0 pio1 pio2 pio3 pio4
>               Cycle time: no flow control=120ns  IORDY flow control=120ns
> Commands/features:
>          Enabled Supported:
>             *    SMART feature set
>             *    Power Management feature set
>             *    Write cache
>             *    48-bit Address feature set
>             *    Mandatory FLUSH_CACHE
>             *    FLUSH_CACHE_EXT
>             *    SMART self-test
>             *    WRITE_{DMA|MULTIPLE}_FUA_EXT
>             *    SATA-I signaling speed (1.5Gb/s)
>             *    SATA-II signaling speed (3.0Gb/s)
> Integrity word not set (found 0x0000, expected 0x51a5)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

