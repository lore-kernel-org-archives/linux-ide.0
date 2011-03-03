From: Mark Lord <kernel@teksavvy.com>
Subject: Re: XT-PIC interrupts blocked by usbserial ? [Was Re: Intel ICH9M
 bug	: sata unusable with usbserial]
Date: Thu, 03 Mar 2011 13:10:10 -0500
Message-ID: <4D6FD982.2050308@teksavvy.com>
References: <20110228140149.GA18189@frolo.macqel> <20110228150553.66d02bc7@lxorguk.ukuu.org.uk> <20110228151618.GA16322@htj.dyndns.org> <20110228170556.GA29545@frolo.macqel> <20110228173634.GA23008@htj.dyndns.org> <20110228192700.GA3305@kroah.com> <20110301123452.GA1954@frolo.macqel> <20110301141627.GB12881@kroah.com> <20110301150018.GA17827@frolo.macqel> <4D6E477A.9020401@teksavvy.com> <20110303145812.GA3489@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:21513 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758559Ab1CCSKN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Mar 2011 13:10:13 -0500
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


Blocked until reboot, or until you unplug the GPS/serial thingie from the USB port?


> Switching in the BIOS from 'APIC disabled' to 'APIC enabled' made the problem
> disappear.
> 
> On Wed, Mar 02, 2011 at 08:34:50AM -0500, Mark Lord wrote:
>> On 11-03-01 10:00 AM, Philippe De Muyter wrote:
>>> On Tue, Mar 01, 2011 at 09:16:27AM -0500, Greg KH wrote:
>>>> On Tue, Mar 01, 2011 at 01:34:52PM +0100, Philippe De Muyter wrote:
>>>>> previously we had all but one usb interrupts on the same line as ata_piix :
>>>>>   5:      17183    XT-PIC-XT-PIC    ata_piix, ata_piix, ehci_hcd:usb1, ehci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb5, uhci_hcd:usb6, uhci_hcd:usb7, uhci_hcd:usb8
>>>>> while now they are spread on different lines : 16, 18, 19, 21 and 22
>>>>>
>>>>> So I wonder if there is still a bug, but that it is not triggered anymore.
>>>>>
>>>>> Is there a way to tell which interrupt line the USB GPS receiver is connected
>>>>> to ?
>>>>
>>>> See which USB bus the device is on, using lsusb.  It should match up
>>>> with the usbX number in the above list.
>>>
>>> Given that I get :
>>>
>>>   tmp199:~ # lsusb
>>>   ...
>>>   Bus 007 Device 002: ID 067b:2303 Prolific Technology, Inc. PL2303 Serial Port
>>>   tmp199:~ # cat /proc/interrupts
>>> 	     CPU0       CPU1
>>>   ...
>>>    19:     996143     995511   IO-APIC-fasteoi   ata_piix, ata_piix, uhci_hcd:usb5, uhci_hcd:usb7
>>>   tmp199:~ #
>>>
>>> my USB GPS receiver and my sata disk still share the same interrupt, I assume ?
>>>
>>> What's changed now is that this interrupt line is now IO-APIC-fasteoi instead
>>> of XT-PIC-XT-PIC.  Maybe there's something to look at there ?
>>>
>>>>
>>>> Glad enabling APIC in your BIOS fixed this.
>>>
>>> I am glad too :)
>>
>> Nothing got "fixed" by doing that.
>> Swept under the rug, yes.
>>
>> But the bug is still there.
> 
> If it is a bug (what I also believe) it is not a new one :
> 
> Before installing 2.6.37-20-desktop (opensuse 11.4) on this new hardware,
> I had the same problem with 2.6.31.14-0.6-desktop (opensuse 11.2) and
> with 2.6.22.18-0.2-default (opensuse 10.3)

Mmm.. so an old bug.  Nasty, those.  :)

What is most likely happening here, is that the USB interrupt handler
is returning IRQ_HANDLED under some condition where IRQ_NONE is required.

In other words, USB thought it got an interrupt, but didn't really,
but since it returns IRQ_HANDLED regardless, then other
device drivers sharing that IRQ don't necessarily get called.
If this happens repeatedly, then it could disrupt the other devices.

Now, that's not overly likely, but then again it's probably not
well tested with everyone using APICs nowadays.

Or, perhaps the PL2303 driver leaves an interrupt active/pending
without clearing it in hardware, so the interrupt keeps recurring
over and over.  This (unlikely) is easy to check for, by watching
the /proc/interrupts count for the USB on your APIC-enabled kernel.

If the numbers increase at a phenomenal rate, then there might
be an issue.  With an active GPS, one would expect the numbers to
be incrementing steadily, say a few dozen or a hundred or so per second.

Cheers

