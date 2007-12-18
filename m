From: "Shane Huang" <Shane.Huang@amd.com>
Subject: RE: Questions about SATA hotplug in linux 2.6
Date: Tue, 18 Dec 2007 15:29:19 +0800
Message-ID: <B90463BC30D2E446BA423D888DC85E500677BF@sshaexmb1.amd.com>
References: <20071025.011445.80152909.davem@davemloft.net>
 <472052C1.2050302@garzik.org>
 <5CAB7B5D6F8AB84AA868A46B47A50705622EAB@sshaexmb1.amd.com>
 <472153D3.2020102@garzik.org> <4721575B.70706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-sin.frontbridge.com ([207.46.51.80]:15478 "EHLO
	outbound8-sin-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750954AbXLRHeX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Dec 2007 02:34:23 -0500
Content-class: urn:content-classes:message
In-Reply-To: <4721575B.70706@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Shane Huang <Shane.Huang@amd.com>

Hi Jeff  and  Tejun:


I want to continue this discussion with some questions:

> From: Tejun Heo wrote:
> Jeff Garzik wrote:
> > Shane Huang wrote:
> >> 1. If users unplug one SATA HDD(no-root partition) or SATA ODD when
> >> the system is running, then plug it back to the same SATA port,
> >> Should the system and SATA HDD/ODD still work well?
> >
> > Yes.
> 
> To add a bit, libata hotplug has grace time of at least 15secs.  If
the
> same device is plugged out and then plugged in in that time, libata
> considers that the device and/or connection has suffered transient
> failure and assumes it's the same device and there's no modification
to
> its content.
> 
> This means that if you disconnect a harddrive, write to it and then
> connect it back in the grace period corruption will occur.  It will be
> fun to have some sort of competition to actually do this.  :-)
> 
> >> These questions come up when our QA test our SB700 SATA drivers,
> >> but I don't know the SATA hotplug support in linux 2.6.
> >> Is there any guy who can give some official confirmation? :-)
> >
> > The main thing of note with regards to hotplug is that the
associated
> > device (/dev/sdb, /dev/scd0, etc.) may change between plug and
unplug.
> > For example, if you unplug a SATA HDD then plug it back in, the user
> > might see /dev/sdb disappear, and /dev/sdd appear -- even if it is
the
> > exact same HDD, on the exact same port.
> 
> Yeah, using LABEL and/or UUID is a good idea.  In the future, it will
be
> nice to have persistent block device name as netdevices do.


When I disconnect SATA ODD and plug it back to the same SATA port after
several seconds, it can still work well. But if I plug it to a different
SATA port, it will NOT able to work any more. I will attach the log
messages at the end of this mail, please check them.

My Env:
SB700 + RS780, openSUSE10.3 i386.

I also find the same symptom on Intel E210882 (ICH5) under RedHat
RHEL4U5.
That's to say failure of SATA hotplug to different ports also exist on
some Intel platforms.

Do you guys think it's normal? It not, how to make SATA hotplug work on
different SATA port? Should it be supported by BIOS or hardware?


====== plug SATA ODD to the original port, still can work =========
Dec 18 15:06:29 linux-i276 kernel: ata3: exception Emask 0x10 SAct 0x0
SErr 0x90200 action 0xe frozen
Dec 18 15:06:29 linux-i276 kernel: ata3: irq_stat 0x00400000 , <PHY RDY
changed> 
Dec 18 15:06:29 linux-i276 kernel: ata3: hard resetting link
Dec 18 15:06:30 linux-i276 kernel: ata3: SATA link down (SStatus 0
SControl 300)
Dec 18 15:06:30 linux-i276 kernel: ata3: failed to recover some devices,
retrying in 5 secs
Dec 18 15:06:35 linux-i276 kernel: ata3: hard resetting link
Dec 18 15:06:35 linux-i276 kernel: ata3: SATA link down (SStatus 0
SControl 300)
Dec 18 15:06:35 linux-i276 kernel: ata3: limiting SATA link speed to 1.5
Gbps
Dec 18 15:06:35 linux-i276 kernel: ata3.00: limiting speed to
UDMA/33:PIO3
Dec 18 15:06:35 linux-i276 kernel: ata3: failed to recover some devices,
retrying in 5 secs
Dec 18 15:06:40 linux-i276 kernel: ata3: hard resetting link
Dec 18 15:06:41 linux-i276 kernel: ata3: SATA link up 1.5 Gbps (SStatus
113 SControl 310)
Dec 18 15:06:41 linux-i276 kernel: ata3.00: configured for UDMA/33
Dec 18 15:06:41 linux-i276 kernel: ata3: EH pending after completion,
repeating EH (cnt=4)
Dec 18 15:06:41 linux-i276 kernel: ata3: exception Emask 0x10 SAct 0x0
SErr 0x40c0000 action 0xb
Dec 18 15:06:41 linux-i276 kernel: ata3: irq_stat 0x00000040 ,
<connection status changed> 
Dec 18 15:06:42 linux-i276 kernel: ata3: soft resetting link
Dec 18 15:06:42 linux-i276 kernel: ata3: SATA link up 1.5 Gbps (SStatus
113 SControl 310)
Dec 18 15:06:42 linux-i276 kernel: ata3.00: configured for UDMA/33
Dec 18 15:06:42 linux-i276 kernel: ata3: EH complete

====== plug SATA ODD to a different SATA port, can NOT work =========
Dec 18 15:09:10 linux-i276 kernel: ata3: exception Emask 0x10 SAct 0x0
SErr 0x90200 action 0xe frozen
Dec 18 15:09:10 linux-i276 kernel: ata3: irq_stat 0x00400000 , <PHY RDY
changed> 
Dec 18 15:09:10 linux-i276 kernel: ata3: hard resetting link
Dec 18 15:09:10 linux-i276 kernel: ata3: SATA link down (SStatus 0
SControl 310)
Dec 18 15:09:10 linux-i276 kernel: ata3: failed to recover some devices,
retrying in 5 secs
Dec 18 15:09:15 linux-i276 kernel: ata3: hard resetting link
Dec 18 15:09:16 linux-i276 kernel: ata3: SATA link down (SStatus 0
SControl 310)
Dec 18 15:09:16 linux-i276 kernel: ata3.00: limiting speed to
UDMA/33:PIO2
Dec 18 15:09:16 linux-i276 kernel: ata3: failed to recover some devices,
retrying in 5 secs
Dec 18 15:09:21 linux-i276 kernel: ata3: hard resetting link
Dec 18 15:09:21 linux-i276 kernel: ata3: SATA link down (SStatus 0
SControl 310)
Dec 18 15:09:21 linux-i276 kernel: ata3.00: disabled
Dec 18 15:09:21 linux-i276 kernel: ata3: EH complete
Dec 18 15:09:21 linux-i276 kernel: ata3.00: detaching (SCSI 2:0:0:0)
Dec 18 15:09:22 linux-i276 kernel: scsi 2:0:0:0: rejecting I/O to dead
device





Thanks
Shane



