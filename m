From: Mark Lord <kernel@teksavvy.com>
Subject: Re: XT-PIC interrupts blocked by usbserial ? [Was Re: Intel ICH9M
 bug : sata unusable with usbserial]
Date: Thu, 03 Mar 2011 14:39:02 -0500
Message-ID: <4D6FEE56.4080006@teksavvy.com>
References: <Pine.LNX.4.44L0.1103031405110.1669-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:12448 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754614Ab1CCTjG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Mar 2011 14:39:06 -0500
In-Reply-To: <Pine.LNX.4.44L0.1103031405110.1669-100000@iolanthe.rowland.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Philippe De Muyter <phdm@macqel.be>, Greg KH <greg@kroah.com>, Tejun Heo <tj@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org

On 11-03-03 02:06 PM, Alan Stern wrote:
> On Thu, 3 Mar 2011, Mark Lord wrote:
> 
>> Mmm.. I missed that part.  Very curious, that.
>> I wonder if it could be some issue with how the interrupt controller is set up.
>>
>> Oh the other hand, this USB-GPS is probably a "full-speed" (slow) device,
>> using the UHCI interface rather than EHCI.
>>
>> The uhci_irq() handler (in uhci-hcd.c) appears to always return IRQ_HANDLED,
>> even when it didn't actually handle an IRQ.  If I'm reading the code correctly,
>> then that's a bug, and could cause this issue given the "right" peripheral
>> (eg. your USB-GPS).
>>
>> I wonder if uhci_irq() can be a bit more clever and only set IRQ_HANDLED
>> for interrupts that it actually had to handle?  Or am I reading it wrong?
> 
> Evidently you didn't see these lines near the start of the routine:
> 
> 	status = inw(uhci->io_addr + USBSTS);
> 	if (!(status & ~USBSTS_HCH))	/* shared interrupt, not mine */
> 		return IRQ_NONE;

No, I saw those.  But I don't blindly trust comments.  :)

To me, those lines say, "if nothing is active on our bus, then return IRQ_NONE".
With the USB-GPS, the bus probably always as "something active",
even if no URBs have been received at that instant in time.

But I don't have the UHCI spec handy to check right now.

Remember.. there IS a bug here somewhere, so old assumptions
do need to be reexamined to find the darned thing.

Cheers

