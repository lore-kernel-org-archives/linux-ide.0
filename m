From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_mv: Properly initialize main irq mask
Date: Mon, 26 Jan 2009 06:39:50 -0500
Message-ID: <497DA106.7080909@garzik.org>
References: <1232825098.13899.52.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55151 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751383AbZAZLjz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 06:39:55 -0500
In-Reply-To: <1232825098.13899.52.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Reitmayr <treitmayr@devbase.at>
Cc: linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Lennert Buytenhek <buytenh@marvell.com>, Martin Michlmayr <tbm@cyrius.com>

Thomas Reitmayr wrote:
> Hi,
> I noticed that during initialization sata_mv.c assumes that the main
> interrupt mask has its default value of 0. The function
> mv_platform_probe(..) initializes a shadow irq mask with 0 assuming
> that's the value of the controller's register. Now
> mv_set_main_irq_mask(..) only writes the controller's register if the
> new value differs from the "shadowed" value. This is fatal when trying
> to disable all interrupts in mv_init_host(..), i.e. the following
> function call does not write anything to the main irq mask register:
>   mv_set_main_irq_mask(host, ~0, 0);
> 
> The effect I see on my machine (QNAP TS-109 II) with booting via kexec
> (with Linux as a 2nd-stage boot loader) is that if the sata_mv module
> was still loaded when performing kexec, then the new kernel's sata_mv
> module starts up with interrupts enabled. This results in an unhandled
> IRQ and breaks the boot process.
> 
> The unhandled interrupt itself might also be fixed by Lennert's patch
> proposed at http://markmail.org/message/kwvzxstnlsa3s26w which I did not
> try yet.
> However I still propose to additionally initialize the shadow variable
> with the current contents of the main irq mask register to get both in
> sync and allow proper disabling the main irq mask. This fixes the
> unhandled irq on my machine.
> 
> 
> Signed-off-by: Thomas Reitmayr <treitmayr@devbase.at>

applied


