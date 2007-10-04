From: Frans Pop <elendil@planet.nl>
Subject: Re: ata1.00: spurious completions during NCQ
Date: Thu, 4 Oct 2007 10:18:37 +0200
Message-ID: <200710041018.38140.elendil@planet.nl>
References: <200710011443.05629.elendil@planet.nl> <47044D36.4090708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hpsmtp-eml15.kpnxchange.com ([213.75.38.115]:36711 "EHLO
	hpsmtp-eml15.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753370AbXJDISk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 04:18:40 -0400
In-Reply-To: <47044D36.4090708@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

On Thursday 04 October 2007, Tejun Heo wrote:
> Frans Pop wrote:
> > On 15 August 2007 Tejun Heo wrote:
> >> You don't need to worry too much as long as errors are properly,
> >> recovered. All commands are retried and you won't lose any data.
> >> Please report if the spurious NCQ problem happens again.  Thanks.
> >
> > I've just received a logcheck mail with another one. I have not seen
> > any in the time between my initial mail [1] and now, so this is the
> > second occurrence in 1.5 months. The message is slightly different this
> > time.
> >
> > I'm currently running 2.6.23-rc8 + CFS patchset.
>
> Please post the result of "hdparm -I /dev/sda".  Thanks.

/dev/sda:

ATA device, with non-removable media
        Model Number:       HDT722516DLA380
        Serial Number:      VDKE1BTCDZ1KHR
        Firmware Revision:  V43OA96A
Standards:
        Used: ATA/ATAPI-7 T13 1532D revision 1
        Supported: 7 6 5 4
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  268435455
        LBA48  user addressable sectors:  321672960
        device size with M = 1024*1024:      157066 MBytes
        device size with M = 1000*1000:      164696 MBytes (164 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 32
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: unknown setting (0x0000)
        Recommended acoustic management value: 128, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=240ns  IORDY flow control=120ns
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
                Advanced Power Management feature set
                Power-Up In Standby feature set
                SET_FEATURES required to spinup after power up
                Address Offset Reserved Area Boot
                SET_MAX security extension
                Automatic Acoustic Management feature set
           *    48-bit Address feature set
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT
           *    SMART error logging
           *    SMART self-test
                Media Card Pass-Through
           *    General Purpose Logging feature set
           *    WRITE_{DMA|MULTIPLE}_FUA_EXT
           *    64-bit World wide name
           *    URG for READ_STREAM[_DMA]_EXT
           *    URG for WRITE_STREAM[_DMA]_EXT
           *    SATA-I signaling speed (1.5Gb/s)
           *    Native Command Queueing (NCQ)
           *    Host-initiated interface power management
                Non-Zero buffer offsets in DMA Setup FIS
                DMA Setup Auto-Activate optimization
                Device-initiated interface power management
                In-order data delivery
           *    Software settings preservation
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
                frozen
        not     expired: security count
        not     supported: enhanced erase
        78min for SECURITY ERASE UNIT.
Checksum: correct
