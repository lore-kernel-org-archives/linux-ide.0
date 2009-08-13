From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Marvell 6121 AHCI: hotplug not reliable?
Date: Thu, 13 Aug 2009 09:19:13 -0400
Message-ID: <4A8412D1.2070506@garzik.org>
References: <4A8406EE.1040203@aquazul.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43103 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754391AbZHMNTP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Aug 2009 09:19:15 -0400
In-Reply-To: <4A8406EE.1040203@aquazul.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mourad De Clerck <mourad@aquazul.com>
Cc: linux-ide@vger.kernel.org

Mourad De Clerck wrote:
> Hello,
> 
> I've got a box with an Asus M2V motherboard and a Marvell 6121 SATA
> controller. Kernel version 2.6.30.
> 
> It works in general, but from time to time it stops detecting the disks
> when I hotplug them. So usually hotplug works, but sometimes it just
> stops working.
> 
> If I unload the ahci module, and reload it (with the marvell_enable=1
> parm), it detects the disks again and works without any further issues -
> until the next failed hotplug.
> 
> Is there anything that can be done about this?
> 
> In attachment, the kernel log with at the end (at [128508.539280]) a
> failed hotplug, after which I unload/reload the ahci module and things
> work again (starting at [147111.353555]).

> [128508.539280] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
> [128508.539306] ata1: irq_stat 0x02400000, PHY RDY changed
> [128508.539333] ata1: hard resetting link
> [128514.300013] ata1: link is slow to respond, please be patient (ready=0)
> [128518.556015] ata1: COMRESET failed (errno=-16)
> [128518.556040] ata1: hard resetting link
> [128524.320015] ata1: link is slow to respond, please be patient (ready=0)
> [128528.576014] ata1: COMRESET failed (errno=-16)
> [128528.576039] ata1: hard resetting link
> [128534.340014] ata1: link is slow to respond, please be patient (ready=0)
> [128563.628015] ata1: COMRESET failed (errno=-16)
> [128563.628041] ata1: limiting SATA link speed to 1.5 Gbps
> [128563.628062] ata1: hard resetting link
> [128568.664014] ata1: COMRESET failed (errno=-16)
> [128568.664038] ata1: reset failed, giving up
> [128568.664059] ata1: EH complete


hmmmm.  Since PHY_RDY-leads-to-failure is a very rare report for this 
chip, my initial guess would be indicative of either a power, SATA port, 
or SATA cable problem.

PHY_RDY is essentially an indication of whether or not the host-device 
SATA connection is alive and transmitting SATA packets (FIS's).  If 
PHY_RDY changes, it means the hardware -thinks- that the SATA connection 
changed.

	Jeff



