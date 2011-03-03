From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: XT-PIC interrupts blocked by usbserial ? [Was Re: Intel ICH9M
 bug : sata unusable with usbserial]
Date: Thu, 3 Mar 2011 15:11:18 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1103031502100.1669-100000@iolanthe.rowland.org>
References: <4D6FF127.6050209@teksavvy.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:51105 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932248Ab1CCULT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Mar 2011 15:11:19 -0500
In-Reply-To: <4D6FF127.6050209@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Philippe De Muyter <phdm@macqel.be>, Greg KH <greg@kroah.com>, Tejun Heo <tj@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org

On Thu, 3 Mar 2011, Mark Lord wrote:

> Okay, dug out a UHCI 1.1 spec, and the indication from there
> is that uhci_irq() can return IRQ_HANDLED in some cases where IRQ_NONE
> is more appropriate.

What cases are those?

> Also, it is not masking the "Reserved" bits from the status register.
> Presumably most implementations "read zero" for those bits,
> but perhaps not all do.

Perhaps not, but I've never come across one that does.  This
essentially amounts to saying that the only reasons a UHCI controller
generates an interrupt request are the documented ones.

Suppose the driver did mask out the reserved bits and return IRQ_NONE 
when none of the defined bits were set.  An implementation that did set 
one of the reserved bits would then create an interrupt storm.

> Dunno if this is the cause the XT-PIC errors from earlier in this thread though.

It seems most unlikely.  If the driver had a bug like that, it would 
have shown up many years ago.

Alan Stern

