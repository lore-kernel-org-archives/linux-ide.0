From: Greg KH <greg@kroah.com>
Subject: Re: XT-PIC interrupts blocked by usbserial ? [Was Re: Intel ICH9M
 bug	: sata unusable with usbserial]
Date: Thu, 3 Mar 2011 10:20:47 -0800
Message-ID: <20110303182047.GA28936@kroah.com>
References: <20110228151618.GA16322@htj.dyndns.org>
 <20110228170556.GA29545@frolo.macqel>
 <20110228173634.GA23008@htj.dyndns.org>
 <20110228192700.GA3305@kroah.com>
 <20110301123452.GA1954@frolo.macqel>
 <20110301141627.GB12881@kroah.com>
 <20110301150018.GA17827@frolo.macqel>
 <4D6E477A.9020401@teksavvy.com>
 <20110303145812.GA3489@frolo.macqel>
 <4D6FD982.2050308@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:58575 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758636Ab1CCSYe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Mar 2011 13:24:34 -0500
Content-Disposition: inline
In-Reply-To: <4D6FD982.2050308@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Philippe De Muyter <phdm@macqel.be>, Tejun Heo <tj@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org

On Thu, Mar 03, 2011 at 01:10:10PM -0500, Mark Lord wrote:
> What is most likely happening here, is that the USB interrupt handler
> is returning IRQ_HANDLED under some condition where IRQ_NONE is required.
> 
> In other words, USB thought it got an interrupt, but didn't really,
> but since it returns IRQ_HANDLED regardless, then other
> device drivers sharing that IRQ don't necessarily get called.
> If this happens repeatedly, then it could disrupt the other devices.

I doubt this is the issue, as we would have seen it long before now.

> Now, that's not overly likely, but then again it's probably not
> well tested with everyone using APICs nowadays.
> 
> Or, perhaps the PL2303 driver leaves an interrupt active/pending
> without clearing it in hardware, so the interrupt keeps recurring
> over and over.  This (unlikely) is easy to check for, by watching
> the /proc/interrupts count for the USB on your APIC-enabled kernel.

A usb driver has no interrupt handling at all, so it just flat out can
not do this.  It's up to the usb host controller driver, that is what
handles interrupts.

> If the numbers increase at a phenomenal rate, then there might
> be an issue.  With an active GPS, one would expect the numbers to
> be incrementing steadily, say a few dozen or a hundred or so per second.

It all depends on the traffic to the USB device and how well behaved it
is, as to how many interrupts it generates.

thanks,

greg k-h
