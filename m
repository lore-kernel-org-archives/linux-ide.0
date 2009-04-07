From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ata_check_status_mmio exception kernel panic
Date: Mon, 06 Apr 2009 23:02:59 -0400
Message-ID: <49DAC263.2060107@pobox.com>
References: <3fb94e50903312006y12717b8dh7dd7769f3f5b1dda@mail.gmail.com> <49D64DE0.8060400@sutus.com> <20090404170036.7d4d33a2@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36089 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754583AbZDGDDV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Apr 2009 23:03:21 -0400
In-Reply-To: <20090404170036.7d4d33a2@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dustin Harrison <d.harrison@sutus.com>, Sagar Borikar <sagar.borikar@gmail.com>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>

Alan Cox wrote:
>> port freeze during an interrupt while DMA is active causes a bus error 
>> to be thrown when the ata_check_status call fires.  I cannot reproduce 
>> this on x86.  I assume it handles the taskfile read error differently.
> 
> I hit this problem with the HPT343 (which locks the bus if you do this).
> For other devices where you get a PCI abort it is usually the case that
> x86 platforms ignore them while on many other platforms they produce
> exceptions.
> 
> In general I think we need to be sure all the core code paths stop DMA
> before poking in the taskfile (other than the basic IRQ check which we
> can't avoid)

I really think we are currently getting the ordering wrong, by calling 
ata_qc_complete() before we call the ->freeze() hook.

You can see sata_promise had problems with this, which led us to add DMA 
disabling in pdc_freeze()

But I think more generally, we seem to be missing a DMA-disable upon 
freeze, across a wide variety of controllers.

	Jeff



