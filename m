From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: SATL support for hdparm?
Date: Sun, 15 Feb 2009 01:19:11 +0100
Message-ID: <20090215001911.GN17914@xi.wantstofly.org>
References: <20090214222114.GI17914@xi.wantstofly.org> <49975A6D.4010608@pobox.com> <20090215000603.GK17914@xi.wantstofly.org> <49975D28.4050101@pobox.com> <20090215001355.GL17914@xi.wantstofly.org> <49975F1F.8090900@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xi.wantstofly.org ([80.101.37.227]:53539 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbZBOATN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Feb 2009 19:19:13 -0500
Content-Disposition: inline
In-Reply-To: <49975F1F.8090900@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: linux-ide@vger.kernel.org, dgilbert@interlog.com

On Sat, Feb 14, 2009 at 07:17:35PM -0500, Mark Lord wrote:

> >>>	[root@heth hdparm-9.10]# ./hdparm -B 254 /dev/sdb
> ..
> >	ioctl(3, SG_IO, {'S', SG_DXFER_NONE, cmd[12]=[a1, 06, 20, 05, fd, 
> >	00, 00, 00, 40, ef, 00, 00], mx_sb_len=32, iovec_count=0, 
> >	dxfer_len=0, timeout=5000, flags=0, status=02, masked_status=01, 
> >	sb[22]=[72, 0b, 00, 00, 00, 00, 00, 0e, 09, 0c, 00, 04, 00, fd, 00, 
> >	00, 00, 00, 00, 00, 40, 51], host_status=0, driver_status=0x8, 
> >	resid=0, duration=1, info=0x1}) = 0
> >
> >Does that mean the drive doesn't support SET_FEATURES/{05,85} (weird)?
> ..
> 
> The -I (IDENTIFY) flag will tell whether the drive supports Advanced Power 
> Management, so try that.
> 
> Also, not all drives like 254.  To turn it off, use -B 255 instead.

-B 255 gives the same thing.  -I gives:

/dev/sdb:

ATA device, with non-removable media
        Model Number:       WDC WD10EACS-00C7B0                     
        Serial Number:      WD-WCASJ2076861
        Firmware Revision:  01.01B01
        Transport:          Serial, SATA 1.0a, SATA II Extensions, SATA Rev 2.5
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
        LBA48  user addressable sectors: 1953525168
        device size with M = 1024*1024:      953869 MBytes
        device size with M = 1000*1000:     1000204 MBytes (1000 GB)
        cache/buffer size  = 16384 KBytes
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 32
        Standby timer values: spec'd by Standard, with device specific minimum
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
           *    WRITE_{DMA|MULTIPLE}_FUA_EXT
           *    64-bit World wide name
           *    WRITE_UNCORRECTABLE_EXT command
           *    {READ,WRITE}_DMA_EXT_GPL commands
           *    Segmented DOWNLOAD_MICROCODE
           *    SATA-I signaling speed (1.5Gb/s)
           *    SATA-II signaling speed (3.0Gb/s)
           *    Native Command Queueing (NCQ)
           *    Phy event counters
                DMA Setup Auto-Activate optimization
           *    Software settings preservation
           *    SMART Command Transport (SCT) feature set
           *    SCT Long Sector Access (AC1)
           *    SCT LBA Segment Access (AC2)
           *    SCT Error Recovery Control (AC3)
           *    SCT Features Control (AC4)
           *    SCT Data Tables (AC5)
                unknown 206[12] (vendor specific)
                unknown 206[13] (vendor specific)
Security: 
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
                supported: enhanced erase
        276min for SECURITY ERASE UNIT. 276min for ENHANCED SECURITY ERASE UNIT.
Logical Unit WWN Device Identifier: 50014ee2576dc3c6
        NAA             : 5
        IEEE OUI        : 0014ee
        Unique ID       : 2576dc3c6
Checksum: correct


cheers,
Lennert
