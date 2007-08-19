From: Tejun Heo <htejun@gmail.com>
Subject: Re: Enabling AHCI on ICH7 without BIOS support
Date: Sun, 19 Aug 2007 14:34:30 +0900
Message-ID: <46C7D666.8020700@gmail.com>
References: <46C1A999.5070109@dastyle.net>	<46C441CB.8020805@gmail.com>	<46C44A05.9040302@dastyle.net> <20070819014412.1378C5ED6F3@master.hanzubon.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:4176 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbXHSFfv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Aug 2007 01:35:51 -0400
Received: by wa-out-1112.google.com with SMTP id j4so403544wah
        for <linux-ide@vger.kernel.org>; Sat, 18 Aug 2007 22:35:50 -0700 (PDT)
In-Reply-To: <20070819014412.1378C5ED6F3@master.hanzubon.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ISHIKAWA Mutsumi <ishikawa@hanzubon.jp>
Cc: joe@dastyle.net, jgarzik@pobox.com, linux-ide@vger.kernel.org

ISHIKAWA Mutsumi wrote:
>>>>>> In <46C44A05.9040302@dastyle.net> 
>>>>>> 	Jonathan Bastien-Filiatrault <joe@dastyle.net> wrote:
>>> Tejun Heo wrote:
>>>
>>>> Hello,
>>>>
>>>> Jonathan Bastien-Filiatrault wrote:
>>>>   
>>>>> Hello,
>>>>>
>>>>> I am the owner of a Dell Latitude D620 notebook with an ICH7 SATA
>>>>> controller, unfortunately, the BIOS does not offer the option of using
>>>>> "native mode" instead of "compatibility mode" when it comes to SATA. For
>>>>> now, the ata_piix runs happily in compatibility mode. Looking at the
>>>>> ICH7 docs, I found that poking register 0x90 in PCI configuration space
>>>>> with value 0x40 should enable AHCI. However, there are some issues with
>>>>> poking that register with setpci in an early initramfs:
>>>>>
>>>>>
>>>>> - The kernel does not seem to update the device id from PCI config
>>>>> space, which changes with the controller mode (it would seem the PCI
>>>>> subsystem keeps a copy)
>>>>>
>>>>> - Poking PCI registers from userspace is far from ideal
>>>>>
>>>>>
>>>>> It would be great if the AHCI driver (or otherwise) had a
>>>>> "force_ich7_ahci" to properly setup and initialize this device in full
>>>>> "native" AHCI mode. This option would be greatly welcome from users like
>>>>> me who have a stupid bios (eh, who doesn't).
>>>>>     
>>>> Sorry but most BIOSen don't map ABAR unless it supports AHCI and there
>>>> usually isn't a hole to fit in ABAR afterwards unless the kernel
>>>> completely reallocates IO resources, which, again unfortunately, can't
>>>> be done reliably cuz machines can be quirky and might puke if addresses
>>>> aren't laid out as their BIOSen would do.
>>>>
>>>> So, you'll have to live with ata_piix.
>>>>
>>>>   
>>> So far, I have managed to patch up the AHCI driver to initialize the 
>>> ICH7 AHCI state machine as the BIOS would do (as per the AHCI spec 
>>> instructions). This involves mapping ABAR and such. So far, I have 
>>> gotten the AHCI driver to detect the chip properly, but it does not 
>>> detect any drives. It looks like I will need to further initialize the 
>>> chip. I think there might be a chance of success, but it will involve 
>>> manually specifying which ports are present via a module parameter.
> 
>  Do you know Edvin's patch?
> 
> http://www.bughost.org/pipermail/power/2007-June/000538.html
> 
>  I've tested it and works fine on my note
> (Sony VAIO type S VGN-SZ92PS, ICH7-M)

Yeah, I've seen it but I'm not sure whether it would worth the risk.
For one, there are BIOSen which won't assign IO memory region to ABAR at
all.  There also is a patch to reallocate IO memory regions and make
room for ABAR but that can break things.

Thanks.

-- 
tejun
