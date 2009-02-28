From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: ATAPI question
Date: Fri, 27 Feb 2009 21:08:54 -0600
Message-ID: <49A8AAC6.2090201@gmail.com>
References: <3EAC55E3B6CF7348B3E2CAB2774ADA0403F2FCE7C7@azsmsx504.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:51388 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752681AbZB1DJH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Feb 2009 22:09:07 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LdFZY-0000ap-2R
	for linux-ide@vger.kernel.org; Sat, 28 Feb 2009 03:09:04 +0000
Received: from s0106000c41bb86e1.ss.shawcable.net ([70.76.47.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 28 Feb 2009 03:09:04 +0000
Received: from hancockrwd by s0106000c41bb86e1.ss.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 28 Feb 2009 03:09:04 +0000
In-Reply-To: <3EAC55E3B6CF7348B3E2CAB2774ADA0403F2FCE7C7@azsmsx504.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>

Foster, Doug F wrote:
> I'm looking at the following Bugzilla sighting:  [Bug 429724] RHEL 5.4 periodic ATA error messages on Tolapai hardware.
> 
> I have reproduced the problem using these drives:  Plextor models PX-712 and PX-716 and Lite On model SHD-16S1S.
> It occurs in AHCI mode only, not legacy mode.
> Although I am working on an EP80579, it probably occurs on any AHCI controller.
> 
> This is a snippet from dmesg:
> Jan 27 13:02:52 localhost kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> Jan 27 13:02:52 localhost kernel: ata2.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 8 in
> Jan 27 13:02:52 localhost kernel:          cdb 25 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
> Jan 27 13:02:52 localhost kernel:          res 40/00:03:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
> Jan 27 13:02:52 localhost kernel: ata2.00: status: { DRDY }
> Jan 27 13:02:53 localhost kernel: ata2: soft resetting link
> Jan 27 13:02:53 localhost kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> Jan 27 13:02:53 localhost kernel: ata2.00: configured for UDMA/25
> Jan 27 13:02:53 localhost kernel: ata2: EH complete
> 
> Using a SATA analyzer, I find that on an INQUIRY (12h) ATAPI packet command, the device sets bit-6 (DRDY) and bit-4 (SERV) in the status register, and bits 0 (CoD) and 1 (IO) are set in the ATAPI Interrupt Reason Register (ATA Sector Count Register).  After SERVICE is flagged by the ATAPI device (and not serviced), it doesn't respond properly from then on.

Bit 4 isn't SERV in this context, it's DRQ. (It's only SERV when TCQ is 
in use, which it isn't.) It looks like this is a READ CAPACITY command 
that's being issued by PIO. DRQ means the device expects to transfer 
data - either to receive the CDB or send the response. Presumably that 
didn't happen for some reason. Are you sure about both the C/D and I/O 
bits being 1? That would mean command transfer to the host, which 
doesn't make any sense.

You're saying that DRQ never gets cleared after the INQUIRY command? 
It's possible the device wanted to transfer more data than the PRD table 
had room for. Not sure what AHCI ends up doing in this case. I'm CCing 
Tejun who might know more..

> 
> Sections 5.7, 5.7.1, and 5.17 (overlapped commands) in the ATA Packet Interface for CD-ROMs specification (ATAPI-SFF8020i.pdf) seem to apply.  This functionality seems to be missing.  I would like to get some guidance as to where this functionality should be added.  I could either work with the appropriate maintainer on the details or take a crack at the code changes myself.  It would be a good learning experience for me, but I would like to collaborate with the appropriate Linux expert.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

