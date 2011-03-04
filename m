From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: XT-PIC interrupts blocked by usbserial ? [Was Re: Intel ICH9M
 bug : sata unusable with usbserial]
Date: Thu, 03 Mar 2011 19:53:42 -0600
Message-ID: <4D704626.7070001__10977.0321324051$1299204759$gmane$org@gmail.com>
References: <Pine.LNX.4.44L0.1103031405110.1669-100000@iolanthe.rowland.org> <4D6FEE56.4080006@teksavvy.com> <4D6FF127.6050209@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:40977 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758917Ab1CDCM3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Mar 2011 21:12:29 -0500
Received: from public by plane.gmane.org with local (Exim 4.69)
	(envelope-from <public@plane.gmane.org>)
	id 1PvKDN-0004Y5-Pd
	for linux-ide@vger.kernel.org; Fri, 04 Mar 2011 02:53:57 +0100
In-Reply-To: <4D6FF127.6050209@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <public-kernel-R6A+fiHC8nRWk0Htik3J/w@plane.gmane.org>
Cc: Alan Stern <public-stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@plane.gmane.org>, Philippe De Muyter <public-phdm-vQo90/bmh3WzQB+pC5nmwQ@plane.gmane.org>, Greg KH <public-greg-U8xfFu+wG4EAvxtiuMwx3w@plane.gmane.org>, Tejun Heo <public-tj-DgEjT+Ai2ygdnm+yROfE0A@plane.gmane.org>, Alan Cox <public-alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@plane.gmane.org>, public-linux-ide-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org, Greg Kroah-Hartman <public-gregkh-l3A5Bk7waGM@plane.gmane.org>, public-linux-usb-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org



On 03/03/2011 01:51 PM, Mark Lord wrote:
> On 11-03-03 02:39 PM, Mark Lord wrote:
>> On 11-03-03 02:06 PM, Alan Stern wrote:
>>> On Thu, 3 Mar 2011, Mark Lord wrote:
>>>
>>>> Mmm.. I missed that part.  Very curious, that.
>>>> I wonder if it could be some issue with how the interrupt controller is set up.
>>>>
>>>> Oh the other hand, this USB-GPS is probably a "full-speed" (slow) device,
>>>> using the UHCI interface rather than EHCI.
>>>>
>>>> The uhci_irq() handler (in uhci-hcd.c) appears to always return IRQ_HANDLED,
>>>> even when it didn't actually handle an IRQ.  If I'm reading the code correctly,
>>>> then that's a bug, and could cause this issue given the "right" peripheral
>>>> (eg. your USB-GPS).
>>>>
>>>> I wonder if uhci_irq() can be a bit more clever and only set IRQ_HANDLED
>>>> for interrupts that it actually had to handle?  Or am I reading it wrong?
>>>
>>> Evidently you didn't see these lines near the start of the routine:
>>>
>>> 	status = inw(uhci->io_addr + USBSTS);
>>> 	if (!(status&  ~USBSTS_HCH))	/* shared interrupt, not mine */
>>> 		return IRQ_NONE;
>>
>> No, I saw those.  But I don't blindly trust comments.  :)
>>
>> To me, those lines say, "if nothing is active on our bus, then return IRQ_NONE".
>> With the USB-GPS, the bus probably always as "something active",
>> even if no URBs have been received at that instant in time.
>>
>> But I don't have the UHCI spec handy to check right now.
>
> Okay, dug out a UHCI 1.1 spec, and the indication from there
> is that uhci_irq() can return IRQ_HANDLED in some cases where IRQ_NONE
> is more appropriate.
>
> Also, it is not masking the "Reserved" bits from the status register.
> Presumably most implementations "read zero" for those bits,
> but perhaps not all do.
>
> Dunno if this is the cause the XT-PIC errors from earlier in this thread though.

I'm pretty sure the kernel always has to run all of the IRQ handlers for 
that interrupt even though one of them says "handled" so this wouldn't 
cause a lost interrupt. One some devices it's not even possible to tell 
for sure whether the device actually generated an interrupt or not, so 
the driver has to return IRQ_HANDLED always.

The required behavior is "if you know for sure you did not generate an 
interrupt, return IRQ_NONE, otherwise return IRQ_HANDLED".

The only thing falsely returning IRQ_HANDLED really hurts is the 
screaming-IRQ detection, since the kernel can't tell that the interrupt 
isn't actually being cleared.

