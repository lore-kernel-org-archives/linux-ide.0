From: Patrizio Bassi <patrizio.bassi@gmail.com>
Subject: Re: libata not working for sis5533
Date: Tue, 25 Sep 2007 22:44:46 +0200
Message-ID: <46F9733E.9080604@gmail.com>
References: <46D132C5.5000803@gmail.com> <6bffcb0e0708261627s12e5a9acqef92d0261264a40c@mail.gmail.com> <46D8921E.3010304@gmail.com> <46D89429.7080802@gmail.com> <46E85AA8.3080302@redhat.com>
Reply-To: patrizio.bassi@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:11894 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbXIYUoy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Sep 2007 16:44:54 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1786636nfb
        for <linux-ide@vger.kernel.org>; Tue, 25 Sep 2007 13:44:52 -0700 (PDT)
In-Reply-To: <46E85AA8.3080302@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, "Kernel," <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Chuck Ebbert ha scritto:
> On 08/31/2007 06:20 PM, Patrizio Bassi wrote:
>   
>> Patrizio Bassi ha scritto:
>>     
>>> Michal Piotrowski ha scritto:
>>>       
>>>> Hi,
>>>>
>>>> [Adding IDE wizards to CC]
>>>>
>>>> On 26/08/07, Patrizio Bassi <patrizio.bassi@gmail.com> wrote:
>>>>   
>>>>         
>>>>> My sis630 chipset shipped with Asus A1000
>>>>> doesn't work properly with suspend with ide drivers
>>>>> (http://bugzilla.kernel.org/show_bug.cgi?id=7077)
>>>>>
>>>>> i tried to switch to libata but i cannot boot.
>>>>> I've enabled generic ide and sis specific code, both in-kernel. of
>>>>> course scsi too.
>>>>>
>>>>> when i boot i get: irq #14 nobody cared and stop
>>>>>
>>>>> i have to remove battery to reboot pc.
>>>>> I'm using 2.6.22.5, but i never got any libata kernel working.
>>>>>
>>>>> Patrizio
>>>>>
>>>>> ps. i'm writing from my desktop as i'm doing hardware mainteinance on
>>>>> the laptop and could not boot it
>>>>>
>>>>> Please CC me.
>>>>>
>>>>> lspci:
>>>>> 00:00.0 Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 11)
>>>>> 00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
>>>>> 00:01.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513 (LPC
>>>>> Bridge)
>>>>> 00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900
>>>>> PCI Fast Ethernet (rev 80)
>>>>> 00:01.2 USB Controller: Silicon Integrated Systems [SiS] USB  1.0
>>>>> Controller (rev 07)
>>>>> 00:01.3 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
>>>>> Controller (rev 07)
>>>>> 00:01.4 Multimedia audio controller: Silicon Integrated Systems [SiS]
>>>>> SiS PCI Audio Accelerator (rev 01)
>>>>>  00:01.6 Modem: Silicon Integrated Systems [SiS] AC'97 Modem
>>>>> Controller (rev a0)
>>>>> 00:02.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual
>>>>> PCI-to-PCI bridge (AGP)
>>>>> 00:0a.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
>>>>> 00:0a.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
>>>>> 01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]
>>>>> 630/730 PCI/AGP VGA Display Adapter (rev 11)
>>>>>     
>>>>>           
>>>> Regards,
>>>> Michal
>>>>
>>>>   
>>>>         
>> i've been out for a week, but found no notice, did i lost any email or
>> no activity on this issue?
>>
>>     
>
> I assume you tried the standard workarounds, like
>
>   pci=nommconf,nomsi
>   pci=noacpi
>   pci=biosirq
>
> (one at at time, not all at once.)
>
>
>   
i just fineshed to try (had an hardware problem, could not be faster)
but got no results :(

libata is unusable on my system.
i'll wait 2.6.23 to be out to try again.


-- 

Patrizio Bassi
www.patriziobassi.it
