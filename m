From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Subject: Re: Hotplug borked after suspend/resume in Linux-3.3 ?
Date: Wed, 18 Apr 2012 20:23:50 +0200
Message-ID: <4F8F06B6.9050306@fold.natur.cuni.cz>
References: <4F8DD4DC.4050503@teksavvy.com> <4F8DD708.8050502@teksavvy.com> <4F8DD834.5070000@teksavvy.com> <4F8DDA53.206@teksavvy.com> <CAE5mzvjsfX34fod0KURNQN8Rmn0xOPCdP2iY2xnSTnnRXPAaEQ@mail.gmail.com> <4F8EF57E.4070603@fold.natur.cuni.cz> <4F8EF9F7.5040202@pobox.com> <4F8EFD89.2080603@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:44621 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752523Ab2DRSXy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Apr 2012 14:23:54 -0400
In-Reply-To: <4F8EFD89.2080603@fold.natur.cuni.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: cwillu <cwillu@cwillu.com>, Mark Lord <kernel@teksavvy.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Martin Mokrejs wrote:
> 
> 
> Jeff Garzik wrote:
>> On 04/18/2012 01:10 PM, Martin Mokrejs wrote:
>>> Fix: I got my 3TB disk detected by this single command:
>>>
>>> # echo on>   /sys/devices/pci0000:00/0000:00:1f.2/ata6/power/control
>>> #
>>>
>>> This is a Dell Vostro 3550 with A09 BIOS. Same happend with 3.4-rc3 kernel.
>>>
>>> I can do some more testing if you want me to.
>>> Best,
>>> Martin
>>
>>
>> Can you test this one-line patch from Lin Ming?  Hopefully there is zero sysfs twiddling required with this one...
>>
>> --- a/drivers/ata/libata-transport.c
>> +++ b/drivers/ata/libata-transport.c
>> @@ -294,6 +294,7 @@ int ata_tport_add(struct device *parent,
>>      device_enable_async_suspend(dev);
>>      pm_runtime_set_active(dev);
>>      pm_runtime_enable(dev);
>> +    pm_runtime_forbid(dev);
>>
>>      transport_add_device(dev);
>>      transport_configure_device(dev);
> 
> Works! (the src tree has some pcieh patches so can re-test in a while on vanilla kernel
> sources if you want me to confirm that). Just too many patches to try. ;-)

Just confirming that it fixed even plain 3.4-rc3 as well.

Martin
