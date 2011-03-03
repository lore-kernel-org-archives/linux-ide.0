From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: XT-PIC interrupts blocked by usbserial ? [Was Re: Intel ICH9M
 bug	: sata unusable with usbserial]
Date: Thu, 03 Mar 2011 18:23:12 +0300
Message-ID: <4D6FB260.6010402@ru.mvista.com>
References: <20110228140149.GA18189@frolo.macqel> <20110228150553.66d02bc7@lxorguk.ukuu.org.uk> <20110228151618.GA16322@htj.dyndns.org> <20110228170556.GA29545@frolo.macqel> <20110228173634.GA23008@htj.dyndns.org> <20110228192700.GA3305@kroah.com> <20110301123452.GA1954@frolo.macqel> <20110301141627.GB12881@kroah.com> <20110301150018.GA17827@frolo.macqel> <4D6E477A.9020401@teksavvy.com> <20110303145812.GA3489@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59911 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758251Ab1CCPYp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Mar 2011 10:24:45 -0500
In-Reply-To: <20110303145812.GA3489@frolo.macqel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Philippe De Muyter <phdm@macqel.be>
Cc: Mark Lord <kernel@teksavvy.com>, Greg KH <greg@kroah.com>, Tejun Heo <tj@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org

Hello.

Philippe De Muyter wrote:

> Summary :

> When I started to listen to a USB serial GPS receiver, the interrupts
> of my sata disk were blocked until reboot :(

> Switching in the BIOS from 'APIC disabled' to 'APIC enabled' made the problem
> disappear.

>>>>> previously we had all but one usb interrupts on the same line as ata_piix :
>>>>>   5:      17183    XT-PIC-XT-PIC    ata_piix, ata_piix, ehci_hcd:usb1, ehci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb5, uhci_hcd:usb6, uhci_hcd:usb7, uhci_hcd:usb8
>>>>> while now they are spread on different lines : 16, 18, 19, 21 and 22

>>>>> So I wonder if there is still a bug, but that it is not triggered anymore.

>>>>> Is there a way to tell which interrupt line the USB GPS receiver is connected
>>>>> to ?
>>>> See which USB bus the device is on, using lsusb.  It should match up
>>>> with the usbX number in the above list.

>>> Given that I get :

>>>   tmp199:~ # lsusb
>>>   ...
>>>   Bus 007 Device 002: ID 067b:2303 Prolific Technology, Inc. PL2303 Serial Port
>>>   tmp199:~ # cat /proc/interrupts
>>> 	     CPU0       CPU1
>>>   ...
>>>    19:     996143     995511   IO-APIC-fasteoi   ata_piix, ata_piix, uhci_hcd:usb5, uhci_hcd:usb7
>>>   tmp199:~ #

>>> my USB GPS receiver and my sata disk still share the same interrupt, I assume ?

>>> What's changed now is that this interrupt line is now IO-APIC-fasteoi instead
>>> of XT-PIC-XT-PIC.  Maybe there's something to look at there ?

>>>> Glad enabling APIC in your BIOS fixed this.

>>> I am glad too :)

>> Nothing got "fixed" by doing that.
>> Swept under the rug, yes.

>> But the bug is still there.

> If it is a bug (what I also believe) it is not a new one :

> Before installing 2.6.37-20-desktop (opensuse 11.4) on this new hardware,
> I had the same problem with 2.6.31.14-0.6-desktop (opensuse 11.2) and
> with 2.6.22.18-0.2-default (opensuse 10.3)

> The only interesting file where I find the word 'XT-PIC' is
> 	arch/alpha/kernel/irq_i8259.c

    Why it's interesting if you're not really on Alpha? Because there is also 
arch/x86/kernel/i8259.c (and several others)...

> Best regards

> Philippe

WBR, Sergei
