From: Mark Lord <kernel@teksavvy.com>
Subject: Re: XT-PIC interrupts blocked by usbserial ? [Was Re: Intel ICH9M
 bug	: sata unusable with usbserial]
Date: Thu, 03 Mar 2011 13:20:00 -0500
Message-ID: <4D6FDBD0.5010401@teksavvy.com>
References: <20110228140149.GA18189@frolo.macqel> <20110228150553.66d02bc7@lxorguk.ukuu.org.uk> <20110228151618.GA16322@htj.dyndns.org> <20110228170556.GA29545@frolo.macqel> <20110228173634.GA23008@htj.dyndns.org> <20110228192700.GA3305@kroah.com> <20110301123452.GA1954@frolo.macqel> <20110301141627.GB12881@kroah.com> <20110301150018.GA17827@frolo.macqel> <4D6E477A.9020401@teksavvy.com> <20110303145812.GA3489@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:59789 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758598Ab1CCSUD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Mar 2011 13:20:03 -0500
In-Reply-To: <20110303145812.GA3489@frolo.macqel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Philippe De Muyter <phdm@macqel.be>
Cc: Greg KH <greg@kroah.com>, Tejun Heo <tj@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org

On 11-03-03 09:58 AM, Philippe De Muyter wrote:
> Summary :
> 
> When I started to listen to a USB serial GPS receiver, the interrupts
> of my sata disk were blocked until reboot :(
> 
> Switching in the BIOS from 'APIC disabled' to 'APIC enabled' made the problem
> disappear.
> 
> On Wed, Mar 02, 2011 at 08:34:50AM -0500, Mark Lord wrote:
>> On 11-03-01 10:00 AM, Philippe De Muyter wrote:
>>> On Tue, Mar 01, 2011 at 09:16:27AM -0500, Greg KH wrote:
>>>> On Tue, Mar 01, 2011 at 01:34:52PM +0100, Philippe De Muyter wrote:
>>>>> previously we had all but one usb interrupts on the same line as ata_piix :
>>>>>   5:      17183    XT-PIC-XT-PIC    ata_piix, ata_piix, ehci_hcd:usb1, ehci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb5, uhci_hcd:usb6, uhci_hcd:usb7, uhci_hcd:usb8
..

And now with APIC enabled:
>>>
>>>    19:     996143     995511   IO-APIC-fasteoi   ata_piix, ata_piix, uhci_hcd:usb5, uhci_hcd:usb7
>>>   tmp199:~ #
>>>
>>> my USB GPS receiver and my sata disk still share the same interrupt, I assume ?
>>>
>>> What's changed now is that this interrupt line is now IO-APIC-fasteoi instead
>>> of XT-PIC-XT-PIC.  Maybe there's something to look at there ?

Mmm.. I missed that part.  Very curious, that.
I wonder if it could be some issue with how the interrupt controller is set up.

Oh the other hand, this USB-GPS is probably a "full-speed" (slow) device,
using the UHCI interface rather than EHCI.

The uhci_irq() handler (in uhci-hcd.c) appears to always return IRQ_HANDLED,
even when it didn't actually handle an IRQ.  If I'm reading the code correctly,
then that's a bug, and could cause this issue given the "right" peripheral
(eg. your USB-GPS).

I wonder if uhci_irq() can be a bit more clever and only set IRQ_HANDLED
for interrupts that it actually had to handle?  Or am I reading it wrong?

Greg?
