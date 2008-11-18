From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Assistance with error
Date: Tue, 18 Nov 2008 11:41:33 -0600
Message-ID: <4922FE4D.30700@shaw.ca>
References: <C907368E-3242-4D88-B879-AF621A17A93A@infogears.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:50134 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752318AbYKRRlx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Nov 2008 12:41:53 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L2UaD-0007sO-KD
	for linux-ide@vger.kernel.org; Tue, 18 Nov 2008 17:41:49 +0000
Received: from s0106000c41bb86e1.ss.shawcable.net ([70.76.47.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 18 Nov 2008 17:41:49 +0000
Received: from hancockr by s0106000c41bb86e1.ss.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 18 Nov 2008 17:41:49 +0000
In-Reply-To: <C907368E-3242-4D88-B879-AF621A17A93A@infogears.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Rusty Conover wrote:
> Hello Linux IDE Guys,
> 
> I'm encountering this error after a few days of decent load on the disks:
> 
> ata4.00: exception Emask 0x40 SAct 0x1 SErr 0x80800 action 0x6 frozen
> ata4: SError: { HostInt 10B8B }
> ata4.00: cmd 61/58:00:8d:40:08/00:00:01:00:00/40 tag 0 ncq 45056 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x44 (timeout)
> ata4.00: status: { DRDY }
> ata4: hard resetting link
> ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata4.00: configured for UDMA/133
> ata4: EH complete
> sd 3:0:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
> sd 3:0:0:0: [sdd] Write Protect is off
> sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
> sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't 
> support DPO or FUA
> ata4.00: exception Emask 0x50 SAct 0x1 SErr 0x480900 action 0x6 frozen
> ata4.00: irq_stat 0x08000000, interface fatal error
> ata4: SError: { UnrecovData HostInt 10B8B Handshk }
> ata4.00: cmd 61/08:00:fd:41:08/00:00:01:00:00/40 tag 0 ncq 4096 out
>          res 40/00:00:fd:41:08/00:00:01:00:00/40 Emask 0x50 (ATA bus error)
> ata4.00: status: { DRDY }
> ata4: hard resetting link

..

> Its always on the same device sdd, I've swapped out the physical disks 
> and the error persists.  Do you have any ideas what the cause could be?  
> I've checked connections, could it be a bad SATA cable?

Quite possibly. The errors indicate a bunch of problems on the SATA link 
between the disk and the controller.

> 
> The full dmesg output is available at:
> 
> http://www.infogears.com/disk-failure.log
> 
> Kernel is:
> 
> Linux version 2.6.26.6-79.fc9.i686.PAE (mockbuild@) (gcc version 4.3.0 
> 20080428 (Red Hat 4.3.0-8) (GCC) ) #1 SMP Fri Oct 17 1
> 4:38:28 EDT 2008
> 
> The FAQ mentions power issues being a possibility but I'm not sure if 
> there is a way to tell if that is the cause since it it always the same 
> device in a 6 device array.

If it's always the same device that seems a bit less likely, but I 
wouldn't rule that out either (maybe that drive is more sensitive, or 
it's on the end of the chain from the power supply, etc.)

