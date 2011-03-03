From: Mark Lord <kernel-R6A+fiHC8nRWk0Htik3J/w@public.gmane.org>
Subject: Re: XT-PIC interrupts blocked by usbserial ? [Was Re: Intel ICH9M
 bug : sata unusable with usbserial]
Date: Thu, 03 Mar 2011 14:51:03 -0500
Message-ID: <4D6FF127.6050209@teksavvy.com>
References: <Pine.LNX.4.44L0.1103031405110.1669-100000@iolanthe.rowland.org> <4D6FEE56.4080006@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D6FEE56.4080006-R6A+fiHC8nRWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Philippe De Muyter <phdm-vQo90/bmh3WzQB+pC5nmwQ@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On 11-03-03 02:39 PM, Mark Lord wrote:
> On 11-03-03 02:06 PM, Alan Stern wrote:
>> On Thu, 3 Mar 2011, Mark Lord wrote:
>>
>>> Mmm.. I missed that part.  Very curious, that.
>>> I wonder if it could be some issue with how the interrupt controller is set up.
>>>
>>> Oh the other hand, this USB-GPS is probably a "full-speed" (slow) device,
>>> using the UHCI interface rather than EHCI.
>>>
>>> The uhci_irq() handler (in uhci-hcd.c) appears to always return IRQ_HANDLED,
>>> even when it didn't actually handle an IRQ.  If I'm reading the code correctly,
>>> then that's a bug, and could cause this issue given the "right" peripheral
>>> (eg. your USB-GPS).
>>>
>>> I wonder if uhci_irq() can be a bit more clever and only set IRQ_HANDLED
>>> for interrupts that it actually had to handle?  Or am I reading it wrong?
>>
>> Evidently you didn't see these lines near the start of the routine:
>>
>> 	status = inw(uhci->io_addr + USBSTS);
>> 	if (!(status & ~USBSTS_HCH))	/* shared interrupt, not mine */
>> 		return IRQ_NONE;
> 
> No, I saw those.  But I don't blindly trust comments.  :)
> 
> To me, those lines say, "if nothing is active on our bus, then return IRQ_NONE".
> With the USB-GPS, the bus probably always as "something active",
> even if no URBs have been received at that instant in time.
> 
> But I don't have the UHCI spec handy to check right now.

Okay, dug out a UHCI 1.1 spec, and the indication from there
is that uhci_irq() can return IRQ_HANDLED in some cases where IRQ_NONE
is more appropriate.

Also, it is not masking the "Reserved" bits from the status register.
Presumably most implementations "read zero" for those bits,
but perhaps not all do.

Dunno if this is the cause the XT-PIC errors from earlier in this thread though.

Cheers
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
