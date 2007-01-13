From: Mike Accetta <maccetta@laurelnetworks.com>
Subject: Re: ICH6-M libata disk timeouts 2.6.18 -> 2.6.19
Date: Fri, 12 Jan 2007 22:09:47 -0500
Message-ID: <27103.1168657787@mdt.dhcp.pit.laurelnetworks.com>
References: <45A84297.3020408@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from staple.laurelnetworks.com ([63.94.127.68]:52590 "EHLO
	staple.laurelnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161202AbXAMDJs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jan 2007 22:09:48 -0500
Received: from postit.laurelnetworks.com (postit.laurelnetworks.com [63.94.127.21])
	by staple.laurelnetworks.com (ECI-DND/ECI-DND) with ESMTP id l0D39lAv004331
	for <linux-ide@vger.kernel.org>; Fri, 12 Jan 2007 22:09:47 -0500
Received: from mdt.dhcp.pit.laurelnetworks.com (mdt.dhcp.pit.laurelnetworks.com [10.0.21.56])
	by postit.laurelnetworks.com (ECI-DND/ECI-DND) with ESMTP id l0D39l36016820
	for <linux-ide@vger.kernel.org>; Fri, 12 Jan 2007 22:09:47 -0500
Received: from mdt.dhcp.pit.laurelnetworks.com (localhost.localdomain [127.0.0.1])
	by mdt.dhcp.pit.laurelnetworks.com (8.13.8/8.13.4) with ESMTP id l0D39lxw027104
	for <linux-ide@vger.kernel.org>; Fri, 12 Jan 2007 22:09:47 -0500
In-reply-to: Your message of "Sat, 13 Jan 2007 11:23:19 +0900."
             <45A84297.3020408@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Mike Accetta wrote:
> > Here's a bit more information on these timeouts.  I noticed a mention
> > of changing the command queue depth in a recent lkml post and decided
> > to give that a whirl.
> > 
> > This problem seems to be related to the depth of the queue.  When I
> > set the value for /sys/block/sdb/device/queue_depth to 4 the raid1
> > re-sync completes without incident.  When set to 5 it eventually gives
> > the timeout error message (although at well past 50% of the re-sync).
> > The problem was originally observed with the default setting (31).
> 
> Please post the result of 'hdparm -I /dev/sdb'.  Thanks.

The version of hdparm on this box gives
    dev/sdb:
     operation not supported on SCSI disks
against the SCSI disk name.  With the controller in compatible mode,
here is the 'hdparm -I /dev/hdb' output on the same disk:

ATA device, with non-removable media
        Model Number:       FUJITSU MHT2060BH
        Serial Number:      NR0YT53258G8
        Firmware Revision:  0000104A
Standards:
        Supported: 7 6 5 4
        Likely used: 7
Configuration:
        Logical         max     current
        cylinders       16383   65535
        heads           16      1
        sectors/track   63      63
        --
        CHS current addressable sectors:    4128705
        LBA    user addressable sectors:  117210240
        LBA48  user addressable sectors:  117210240
        device size with M = 1024*1024:       57231 MBytes
        device size with M = 1000*1000:       60011 MBytes (60 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 32
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: 128 (0x80)
        Recommended acoustic management value: 254, current value: 254
        DMA: mdma0 mdma1 *mdma2 udma0 udma1 udma2 udma3 udma4 udma5
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
           *    Automatic Acoustic Management feature set
                SET MAX security extension
           *    Advanced Power Management feature set
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
        60min for SECURITY ERASE UNIT.
Checksum: correct
--
Mike Accetta

ECI Telecom Ltd.
Data Networking Division (previously Laurel Networks)
