From: Tejun Heo <htejun@gmail.com>
Subject: Re: [git patches] libata fixes
Date: Mon, 12 Mar 2007 15:30:45 +0900
Message-ID: <45F4F395.1050708@gmail.com>
References: <019c01c7642c$1ca4f5e0$2101a8c0@donald> <Pine.LNX.4.64.0703111750010.9690@woody.linux-foundation.org> <45F4F30F.9010603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:27219 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965172AbXCLGas (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Mar 2007 02:30:48 -0400
Received: by nz-out-0506.google.com with SMTP id s1so1290695nze
        for <linux-ide@vger.kernel.org>; Sun, 11 Mar 2007 23:30:47 -0700 (PDT)
In-Reply-To: <45F4F30F.9010603@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: justin@jmicron.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Paul Rolland <rol@as2917.net>, 'Jeff Garzik' <jeff@garzik.org>, Alan Cox <alan@redhat.com>, 'Andrew Morton' <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>, "'Eric D. Mudama'" <edmudama@gmail.com>

Of course I forgot to CC.  :-)  Quoting whole message for Justin.

Tejun Heo wrote:
> Hello, Linus.
> 
> Linus Torvalds wrote:
>> On Sun, 11 Mar 2007, Paul Rolland wrote:
>>> My machine is having two problems : the one you are describing above,
>>> which is due to a SIL controler being connected to one port of the ICH7
>>> (at least, it seems to), and probing it goes  timeout, but nothing is
>>> connected on it.
>> Ok, so that's just a message irritation, not actually bothersome 
>> otherwise?
> 
> It involves a long timeout, so it's bothersome.  This is caused by
> Silicon Image 4726/3726 storage processor (SATA Port Multiplier with
> extra features) attached to one of the ICH ports.
> 
> If the first  downstream port in the PMP is empty and it gets reset in
> non-PMP way, it identifies itself as "Config Disk" of quite small size.
>  It's probably used to configure the extra features using standard ATA
> RW commands.  Anyways, this "Config Disk" is a bit peculiar and doesn't
> work very well with the current ATA reset sequence and gets identified
> only after a few failures thus causing long timeout.
> 
> I keep forgetting about this.  I'll ask SIMG how to deal with this.  For
> the time being, connecting a device to the PMP port should remove the
> timeouts.
> 
>>> The second problem is a Jmicron363 controler that is failing to detect
>>> the DVD-RW that is connected, unless I use the irqpoll option as Tejun has
>>> suggested.
>> .. and this one has never worked without irqpoll?
>>
>>> But, as you suggest it, I'm adding pci=nomsi to the command line....
>>> rebooting... no change for this part of the problem.
>>>
>>> OK, the /proc/interrupt for this config, and the dmesg attached.
>>>
>>> 3 [23:22] rol@riri:~> cat /proc/interrupts 
>>>            CPU0       CPU1       
>>>   0:     297549          0   IO-APIC-edge      timer
>>>   1:          7          0   IO-APIC-edge      i8042
>>>   4:         13          0   IO-APIC-edge      serial
>>>   6:          5          0   IO-APIC-edge      floppy
>>>   8:          1          0   IO-APIC-edge      rtc
>>>   9:          0          0   IO-APIC-fasteoi   acpi
>>>  12:        126          0   IO-APIC-edge      i8042
>>>  14:       8313          0   IO-APIC-edge      libata
>>>  15:          0          0   IO-APIC-edge      libata
>>>  16:          0          0   IO-APIC-fasteoi   eth1, libata
>> So it's the irq16 one that is the Jmicron controller and just isn't 
>> getting any interrupts?
>>
>> Since all the other interrupts work (and MSI worked for other 
>> controllers), I don't think it's interrupt-routing related. Especially as 
>> MSI shouldn't even care about things like that.
>>
>> And since it all works when "irqpoll" is used, that implies that the 
>> *only* thing that is broken is literally irq delivery.
>>
>> Is there possibly some jmicron-specific "enable interrupts" bit? 
> 
> (cc'ing Justin of JMicron.  Hello, please correct me if I'm wrong.)
> 
> Not that I know of.  The PATA portion of JMB controllers is bog standard
> PCI BMDMA ATA device where ATA_NIEN is the way to turn IRQ on and off.
> 
> Thanks.
> 


-- 
tejun
