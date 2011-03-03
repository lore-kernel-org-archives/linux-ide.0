From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: XT-PIC interrupts blocked by usbserial ? [Was Re: Intel ICH9M
 bug : sata unusable with usbserial]
Date: Thu, 3 Mar 2011 16:56:00 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1103031651300.1669-100000@iolanthe.rowland.org>
References: <4D700CB3.10101@teksavvy.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:35197 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758618Ab1CCV4A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Mar 2011 16:56:00 -0500
In-Reply-To: <4D700CB3.10101@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Philippe De Muyter <phdm@macqel.be>, Greg KH <greg@kroah.com>, Tejun Heo <tj@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org

On Thu, 3 Mar 2011, Mark Lord wrote:

> On 11-03-03 03:11 PM, Alan Stern wrote:
> > On Thu, 3 Mar 2011, Mark Lord wrote:
> > 
> >> Okay, dug out a UHCI 1.1 spec, and the indication from there
> >> is that uhci_irq() can return IRQ_HANDLED in some cases where IRQ_NONE
> >> is more appropriate.
> > 
> > What cases are those?
> > 
> >> Also, it is not masking the "Reserved" bits from the status register.
> >> Presumably most implementations "read zero" for those bits,
> >> but perhaps not all do.
> > 
> > Perhaps not, but I've never come across one that does.  This
> > essentially amounts to saying that the only reasons a UHCI controller
> > generates an interrupt request are the documented ones.
> > 
> > Suppose the driver did mask out the reserved bits and return IRQ_NONE 
> > when none of the defined bits were set.  An implementation that did set 
> > one of the reserved bits would then create an interrupt storm.
> 
> You mean, like, the "error -71" storms that I *still* get from time
> to time, ever since the early 2.6.2x kernels?

No, that's not what I mean.  I mean like getting a million IRQs in a 
fraction of a second, causing the IRQ line to be disabled.

Those error -71 storms are more or less normal; they happen when a USB
transfer can't be completed because the target device has been
disconnected or is not responding.  The driver usually resubmits the 
failed transfer, which then fails again in exactly the same way a 
millisecond later (or less).

Alan Stern

