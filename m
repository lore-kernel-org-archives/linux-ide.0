From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: XT-PIC interrupts blocked by usbserial ? [Was Re: Intel ICH9M
 bug : sata unusable with usbserial]
Date: Thu, 3 Mar 2011 14:06:55 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1103031405110.1669-100000@iolanthe.rowland.org>
References: <4D6FDBD0.5010401@teksavvy.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:45041 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758207Ab1CCTG5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Mar 2011 14:06:57 -0500
In-Reply-To: <4D6FDBD0.5010401@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Philippe De Muyter <phdm@macqel.be>, Greg KH <greg@kroah.com>, Tejun Heo <tj@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org

On Thu, 3 Mar 2011, Mark Lord wrote:

> Mmm.. I missed that part.  Very curious, that.
> I wonder if it could be some issue with how the interrupt controller is set up.
> 
> Oh the other hand, this USB-GPS is probably a "full-speed" (slow) device,
> using the UHCI interface rather than EHCI.
> 
> The uhci_irq() handler (in uhci-hcd.c) appears to always return IRQ_HANDLED,
> even when it didn't actually handle an IRQ.  If I'm reading the code correctly,
> then that's a bug, and could cause this issue given the "right" peripheral
> (eg. your USB-GPS).
> 
> I wonder if uhci_irq() can be a bit more clever and only set IRQ_HANDLED
> for interrupts that it actually had to handle?  Or am I reading it wrong?

Evidently you didn't see these lines near the start of the routine:

	status = inw(uhci->io_addr + USBSTS);
	if (!(status & ~USBSTS_HCH))	/* shared interrupt, not mine */
		return IRQ_NONE;

Alan Stern

