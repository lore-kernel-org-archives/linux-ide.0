From: Russell Sloan <russell.sloan@lingua-data.com>
Subject: Re: SATA timeout value
Date: Mon, 23 Apr 2007 12:46:58 -0400
Message-ID: <32623559.31421177346818776.JavaMail.servlet@perfora>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_490_3799500.1177346818417"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.perfora.net ([74.208.4.195]:54981 "EHLO mout.perfora.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754044AbXDWQq7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Apr 2007 12:46:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

------=_Part_490_3799500.1177346818417
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Russell Sloan wrote:
> I'm using SG_IO and I'm curently passing in:
>   sg_io_hdr_t.timeout = 5;
> 
> This should be a 5 ms timeout, correct?  I've tried a few different values, 
from 5 to 1000 and it still takes 90+ seconds for it to timeout and return to 
my program.
> 
> I will try HDIO and see if that behaves any differently.

It might be retrying.  Can you post dmesg after the command?

-- 
tejun


Yes, it looks like it's trying very hard to talk to the drive (which is a good thing under normal circumstances), but the drive isn't there anymore.  It's SATA hardware is powered down at this point.  It doesn't sound like the right way of doing things, but it's the behavior of the drive I'm working with.  

I actually have a 5-disk RAID that I'm working with, 3 connected directly to a SiI 3124 and two behind a 4726 PMP.  The messages for the 3 direct connects are the same.  I see similar activity for the 3 PMP drives.  

Attached is a text file with a complete listing of the activity for each of the 5 drives after the command is issued to each.

Thanks!
-Russell
------=_Part_490_3799500.1177346818417
Content-Type: application/octet-stream; name=sata.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=sata.txt

md: md0 stopped.
md: unbind<sde>
md: export_rdev(sde)
md: unbind<sdd>
md: export_rdev(sdd)
md: unbind<sdc>
md: export_rdev(sdc)
md: unbind<sdb>
md: export_rdev(sdb)
md: unbind<sda>
md: export_rdev(sda)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: tag 0 cmd 0x82 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: soft resetting port
ata1: softreset failed (timeout)
ata1: softreset failed, retrying in 5 secs
ata1: hard resetting port
ata1: softreset failed (timeout)
ata1: follow-up softreset failed, retrying in 5 secs
ata1: hard resetting port
ata1: softreset failed (timeout)
ata1: reset failed, giving up
ata1.00: disabled
ata1: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x82 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (timeout)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: softreset failed (timeout)
ata2: follow-up softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: softreset failed (timeout)
ata2: reset failed, giving up
ata2.00: disabled
ata2: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0x82 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3: soft resetting port
ata3: softreset failed (timeout)
ata3: softreset failed, retrying in 5 secs
ata3: hard resetting port
ata3: softreset failed (timeout)
ata3: follow-up softreset failed, retrying in 5 secs
ata3: hard resetting port
ata3: softreset failed (timeout)
ata3: reset failed, giving up
ata3.00: disabled
ata3: EH complete
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata4.00: tag 0 cmd 0x82 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata4.15: hard resetting port
ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: hard resetting port
ata4.00: softreset failed (timeout)
ata4.00: follow-up softreset failed, retrying in 5 secs
ata4.00: hard resetting port
ata4.00: COMRESET failed (errno=-16)
ata4.00: reset failed, giving up
ata4.15: hard resetting port
ata4.15: softreset failed (timeout)
ata4.15: follow-up softreset failed, retrying in 5 secs
ata4.15: hard resetting port
ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: hard resetting port
ata4.00: softreset failed (timeout)
ata4.00: follow-up softreset failed, retrying in 5 secs
ata4.00: hard resetting port
ata4.00: COMRESET failed (errno=-16)
ata4.00: reset failed, giving up
ata4.00: failed to recover link after 2 tries, disabling
ata4.00: disabled
ata4: failed to recover PMP, retrying in 5 secs
ata4.15: hard resetting port
ata4.15: softreset failed (timeout)
ata4.15: follow-up softreset failed, retrying in 5 secs
ata4.15: hard resetting port
ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.01: hard resetting port
ata4.01: SATA link down (SStatus 0 SControl 300)
ata4.02: hard resetting port
ata4.02: SATA link down (SStatus 0 SControl 300)
ata4.03: hard resetting port
ata4.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.04: hard resetting port
ata4.04: SATA link down (SStatus 0 SControl 300)
ata4.03: configured for UDMA/100
ata4: EH complete
SCSI device sde: 257634304 512-byte hdwr sectors (131909 MB)
sde: Write Protect is off
sde: Mode Sense: 00 3a 00 00
ata4.03: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata4.03: tag 0 cmd 0x82 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata4.15: hard resetting port
ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.01: hard resetting port
ata4.01: SATA link down (SStatus 0 SControl 300)
ata4.02: hard resetting port
ata4.02: SATA link down (SStatus 0 SControl 300)
ata4.03: hard resetting port
ata4.03: softreset failed (timeout)
ata4.03: follow-up softreset failed, retrying in 5 secs
ata4.03: hard resetting port
ata4.03: COMRESET failed (errno=-16)
ata4.03: reset failed, giving up
ata4.15: hard resetting port
ata4.15: softreset failed (timeout)
ata4.15: follow-up softreset failed, retrying in 5 secs
ata4.15: hard resetting port
ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.01: hard resetting port
ata4.01: SATA link down (SStatus 0 SControl 300)
ata4.02: hard resetting port
ata4.02: SATA link down (SStatus 0 SControl 300)
ata4.03: hard resetting port
ata4.03: softreset failed (timeout)
ata4.03: follow-up softreset failed, retrying in 5 secs
ata4.03: hard resetting port
ata4.03: COMRESET failed (errno=-16)
ata4.03: reset failed, giving up
ata4.03: failed to recover link after 2 tries, disabling
ata4.03: disabled
ata4: failed to recover PMP, retrying in 5 secs
ata4.15: hard resetting port
ata4.15: softreset failed (timeout)
ata4.15: follow-up softreset failed, retrying in 5 secs
ata4.15: hard resetting port
ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.01: hard resetting port
ata4.01: SATA link down (SStatus 0 SControl 300)
ata4.02: hard resetting port
ata4.02: SATA link down (SStatus 0 SControl 300)
ata4.04: hard resetting port
ata4.04: SATA link down (SStatus 0 SControl 300)
ata4: EH pending after completion, repeating EH (cnt=4)
ata4.15: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x1
ata4.15: (irq_stat 0x08010800, SDB notify)
ata4: EH complete

------=_Part_490_3799500.1177346818417--

