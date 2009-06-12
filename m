From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/9] cmd64x: implement clear_irq() method
Date: Sat, 13 Jun 2009 00:04:29 +0400
Message-ID: <4A32B4CD.5000104@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com> <200906122101.14520.bzolnier@gmail.com> <4A32A8E5.4070000@ru.mvista.com> <200906122138.02533.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:34784 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750767AbZFLUEe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Jun 2009 16:04:34 -0400
In-Reply-To: <200906122138.02533.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>>>> Convert the driver's two dma_end() methods into clear_irq() methods -- the
>>>>>> driver will now use the standard dma_end() method implementation, ide_dma_end().
>>>>>>
>>>>>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>>>>>>
>>>>>> ---
>>>>>> The patch is atop of ide-2.6.git 'for-next' branch.
>>>>>>
>>>>>>  drivers/ide/cmd64x.c |   31 +++++++++++++++++--------------
>>>>>>  1 files changed, 17 insertions(+), 14 deletions(-)
>>>>>>     
>>>>>>         
>>>>>>             
>>>>> [...]
>>>>>   
>>>>>       
>>>>>           
>>>>>> @@ -226,11 +226,10 @@ static void cmd64x_set_dma_mode(ide_driv
>>>>>>  		(void) pci_write_config_byte(dev, pciU, regU);
>>>>>>  }
>>>>>>  
>>>>>> -static int cmd648_dma_end(ide_drive_t *drive)
>>>>>> +static void cmd648_clear_irq(ide_drive_t *drive)
>>>>>>  {
>>>>>>  	ide_hwif_t *hwif	= drive->hwif;
>>>>>>  	unsigned long base	= hwif->dma_base - (hwif->channel * 8);
>>>>>>     
>>>>>>         
>>>>>>             
>>>>> Don't we need to check whether hwif->dma_base is valid now?
>>>>>   
>>>>>       
>>>>>           
>>>>    You're right, I have managed to overlook this. I'll change this to 
>>>> pci_resource_start() call instead...
>>>>     
>>>>         
>>> Currently this driver should operate fine without BAR4 set so even if
>>> this is pci_resource_start(), the return value still needs to be checked
>>> against 0 -- it is the reliability/maintainability issue.
>>>   
>>>       
>>    Nay, the PCI device just must not be enabled in this case: all BARs 
>> must be allocated, period -- that's what the PCI specs say, IIRC. 
>> Besides, 0 doesn't generally mean "unassigned" in the PCI world.
>> I know, I know, we consider it unallocated but that's not correct -- 
>> only PCI 2.2 (IIRC) used to have words about 0 meaning "unassigned". 
>>     
>
> What matters here is our Linux PCI stack implementation not the spec,
> and historically it allowed use of not fully setup (because of some
> weird/broken BIOSes) PCI devices -- though this may no longer be the
> case..
>   

  Ah, and I know one such PowerPC platform (doesn't set BAR5 of some 
chip I can't remember right now, perhaps it was SiI 680)...

>> Note that we don't check pci_resource_start() result for 0 in the 
>> drivers that do call it, like hpt366.c... I'm seeing the checks in 
>> pdc202xx_*.c but they seem pretty useless -- this just must not happen. 
>>     
>
> Care to remove them while we are at it?
>   

   No, my time is very limited now and they don't hurt. :-)

MBR, Sergei


