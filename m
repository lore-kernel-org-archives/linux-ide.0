From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sata_vsc with iq3124h regression in 2.6.20
Date: Fri, 09 Feb 2007 17:33:33 -0500
Message-ID: <45CCF6BD.9020404@garzik.org>
References: <0C7297FA1D2D244A9C7F6959C0BF1E52015235BE@azsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60907 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752461AbXBIWdi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Feb 2007 17:33:38 -0500
In-Reply-To: <0C7297FA1D2D244A9C7F6959C0BF1E52015235BE@azsmsx413.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Williams, Dan J" <dan.j.williams@intel.com>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org, jeremy@sgi.com, Mark Lord <liml@rtr.ca>

Williams, Dan J wrote:
> When I fire up 2.6.20 with an iq3124h I get:
> 
> ata1: SATA max UDMA/133 cmd 0xC8822200 ctl 0xC8822229 bmdma 0xC8822270
> irq 25
> ata2: SATA max UDMA/133 cmd 0xC8822400 ctl 0xC8822429 bmdma 0xC8822470
> irq 25
> ata3: SATA max UDMA/133 cmd 0xC8822600 ctl 0xC8822629 bmdma 0xC8822670
> irq 25
> ata4: SATA max UDMA/133 cmd 0xC8822800 ctl 0xC8822829 bmdma 0xC8822870
> irq 25
> scsi0 : sata_vsc
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> irq 25: nobody cared (try booting with the "irqpoll" option)
> handlers:
> [<c01796e0>] (vsc_sata_interrupt+0x0/0x194)
> Disabling IRQ #25
> 
> I did a git bisect and came up with: [PATCH] libata: always use polling
> IDENTIFY (800b399669ad495ad4361d134df87401ae36f44f)
> 
> I could probably cobble together a workaround to use irq-driven IDENTIFY
> for this card but wanted to see if there was a better way.

As I recall, the 31244 and VSC-7174 always send an interrupt, so the 
driver should account for this.  I thought we had code already in the 
driver to handle this, but perhaps recent changes stomped that.

It would be good to standardize the way we handle these sorts of 
controllers, because (I think) Mark Lord has the same problem on 
sata_qstor (or pdc_adma?).

	Jeff



