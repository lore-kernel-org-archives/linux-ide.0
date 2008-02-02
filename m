From: "Anantha Subramanyam" <ananth@broadcom.com>
Subject: RE: [PATCH 2.6.23.11]: [sata_svw]: Add ATAPI DMA support for
 HT1x00 SATA controller
Date: Fri, 1 Feb 2008 19:11:31 -0800
Message-ID: <03235919BBDE634289BB6A0758A20B360352AC8D@NT-SJCA-0751.brcm.ad.broadcom.com>
References: <03235919BBDE634289BB6A0758A20B3602F39355@NT-SJCA-0751.brcm.ad.broadcom.com>
 <47A3B9C0.4000309@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mms1.broadcom.com ([216.31.210.17]:1454 "EHLO mms1.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755975AbYBBFMi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Feb 2008 00:12:38 -0500
Content-class: urn:content-classes:message
In-Reply-To: <47A3B9C0.4000309@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

 

> 
> Thanks much for your patience.  Feedback:
> 
. 
. 
. 
> > -	static int printed_version;
> > +	static int printed_version = 0;
>
Thanks for the detailed feedback, will take care of points raised above.
 
> 
> 3) we try _very_ hard to avoid all dependencies on the state 
> produced by 
> BIOS.  The three main reasons:
> 
> 	a) the driver may be used on non-x86 platforms, where
> 	   x86 BIOS code simply cannot be executed
> 
> 	b) during suspend/resume, the driver must be able to
> 	   initialize the controller fully after transition
> 	   from PCI D3 to PCI D0
> 
> 	c) PCI controller hotplug
> 
> Thus, I would like to avoid the need for the 'skip_init' module 
> parameter.  Users and automated Linux install tools will be 
> completely 
> unaware of skip_init, and will not have enough knowledge to 
> use it.  It 
> is best to simply Do The Right Thing in all cases.
> 
Can be left out, but the reasoning behind this was :
1. For our embedded customers who spin their own kernels, this code was
meant to be a placeholder to optimize the pre-emphasis etc values as
needed.
2. Default was left as BIOS controlled for the customers who use
standard linux distributions but will always have BIOS to optimize these
values.

Good point about the hotplus, but this controller is part of the
motherboard chipset so hotplug should not be an issue.


> 
> 4) don't use udelay/mdelay when you can sleep:
> 
> > +inline void k2_lnx_sleep( u32 usec_delay)
> > +{
> > +    (usec_delay > 1000) ? mdelay(usec_delay/1000 + 1):
> > udelay(usec_delay);
> > +}
> 
> 
> 5) is it reasonable to use QDMA for ATA also?
> 
Yes QDMA could be used for ATA also. Due to time considerations plan to
do this at a later stage, currently the brunt of the patch is aimed at
providing DMA support for ATAPI devices by working around a busmaster
issue with ATAPI. 

> 
> 6) use spin_lock() rather than spin_lock_irqsave() in 
> k2_ht1x_interrupt().  You're not competing with other 
> interrupts AFAICS.
> 
Interrupt could come from other ports before completing processing for
the currently interrupting ports, or am I missing something. Based this
function on the current generic handler ata_interrupt.

> 
> 7) in k2_ht1x_qdma_intr(), ap->hsm_task_state generally refers to PIO 
> state.  ditto for the use of ata_hsm_move() in 
> k2_ht1x_handle_qdma_error().
> 
> Can you explain the need, there?
> 
Maybe I misunderstood the code, but k2_ht1x_qdma_intr was based on
ata_host_intr.

> It is more likely that you should override ->qc_issue and 
> handle things 
> at a top level, rather than overriding specific pieces of the 
> ATAPI host 
> state machine.  The HSM was not really designed to be 
> overridden piecemeal.
> 
> 
Related to #5 above. Had considered it, but could not see a way to
override qc_issue without affecting the ATA interface. Suggestions ?
 

Thanks again.

-Ananth

