From: Jonathan Bastien-Filiatrault <joe@dastyle.net>
Subject: Re: Enabling AHCI on ICH7 without BIOS support
Date: Thu, 16 Aug 2007 08:58:45 -0400
Message-ID: <46C44A05.9040302@dastyle.net>
References: <46C1A999.5070109@dastyle.net> <46C441CB.8020805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:49342 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754259AbXHPM6q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Aug 2007 08:58:46 -0400
Received: from [172.16.1.150] ([74.59.112.80]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JMV00I4GAPXF890@VL-MH-MR002.ip.videotron.ca> for
 linux-ide@vger.kernel.org; Thu, 16 Aug 2007 08:58:46 -0400 (EDT)
In-reply-to: <46C441CB.8020805@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Tejun Heo wrote:

> Hello,
>
> Jonathan Bastien-Filiatrault wrote:
>   
>> Hello,
>>
>> I am the owner of a Dell Latitude D620 notebook with an ICH7 SATA
>> controller, unfortunately, the BIOS does not offer the option of using
>> "native mode" instead of "compatibility mode" when it comes to SATA. For
>> now, the ata_piix runs happily in compatibility mode. Looking at the
>> ICH7 docs, I found that poking register 0x90 in PCI configuration space
>> with value 0x40 should enable AHCI. However, there are some issues with
>> poking that register with setpci in an early initramfs:
>>
>>
>> - The kernel does not seem to update the device id from PCI config
>> space, which changes with the controller mode (it would seem the PCI
>> subsystem keeps a copy)
>>
>> - Poking PCI registers from userspace is far from ideal
>>
>>
>> It would be great if the AHCI driver (or otherwise) had a
>> "force_ich7_ahci" to properly setup and initialize this device in full
>> "native" AHCI mode. This option would be greatly welcome from users like
>> me who have a stupid bios (eh, who doesn't).
>>     
>
> Sorry but most BIOSen don't map ABAR unless it supports AHCI and there
> usually isn't a hole to fit in ABAR afterwards unless the kernel
> completely reallocates IO resources, which, again unfortunately, can't
> be done reliably cuz machines can be quirky and might puke if addresses
> aren't laid out as their BIOSen would do.
>
> So, you'll have to live with ata_piix.
>
>   
So far, I have managed to patch up the AHCI driver to initialize the 
ICH7 AHCI state machine as the BIOS would do (as per the AHCI spec 
instructions). This involves mapping ABAR and such. So far, I have 
gotten the AHCI driver to detect the chip properly, but it does not 
detect any drives. It looks like I will need to further initialize the 
chip. I think there might be a chance of success, but it will involve 
manually specifying which ports are present via a module parameter.


Thank you,
Jonathan
