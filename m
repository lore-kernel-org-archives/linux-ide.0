From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Thu, 22 Jan 2009 15:06:16 +0300
Message-ID: <49786138.20809@ru.mvista.com>
References: <200901141345.42583.stf_xl@wp.pl> <4975B065.6030705@ru.mvista.com> <200901221212.55528.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:23871 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754172AbZAVMGX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Jan 2009 07:06:23 -0500
In-Reply-To: <200901221212.55528.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org

Hello.

Stanislaw Gruszka wrote:

>>>  arch/arm/mach-at91/at91sam9263_devices.c |   96 +++++++
>>>  arch/arm/mach-at91/board-sam9263ek.c     |   11 +
>>>  arch/arm/mach-at91/include/mach/board.h  |    9 +
>>>   
>>>       
>>    This should probably go thru the ARM tree... though the maintainer 
>> will decide.
>>     
> I will submit patches to linux-ide and ARM things separately (ARM when I 
> finally test with Atmel Evaluation Kit) . Against which tree IDE patches
> should be submitted, against Bart's kernel?
>
>   
>>> +/* Proper CS address space will be added */
>>> +#define AT91_IDE_TASK_FILE	0x00c00000
>>> +#define AT91_IDE_CTRL_REG	0x00e00000

   Besides, I'm not sure: these 2 address range are decoded via 1 SMC 
chip select or 2?

>>    Er, are you sure? Address lines should be 110 to address the device 
>> control and alternate status registers, do they get asserted properly?
>>     
> Hmm, you may have right, because I can see warning 
>
> hda: probing with STATUS(0x50) instead of ALTSTATUS(0x00)
>
> but I don't understand this issue, I'm going to investigate.
>   

   I think it's exactly due to the driver reading alternate status from 
0x00e00000 ISO 0x00e00006. Soft reset also won't work because of the 
wrong address.

>>> + * IDE host driver for AT91 Static Memory Controler  
>>>       
>>   I'm afraid you're being too generic here: e.g. AT91RM9200 has 
>> incompatible SMC.
>>     
> Well, we could add #ifdef with diffrent implementation of init_smc_mode(), 
> set_8bit_mode(), etc... 
>   

   No, #ifdef'ery is certainly not an option.

>>> +		if (t9 < t2i - t1)
>>> +			t9 = t2i - t1;
>>>   
>>>       
>>    It  more sense to calculate such things *after* quantizing the 
>> timings with calc_mck_cycles()...
>>     
> Why?
>   

   More precise result -- matching the clock being used.

>>> +	t9 = calc_mck_cycles(t9, mck_hz);
>>> +	pdbg("t0=%u t1=%u t2=%u t2i=%u t9=%u\n", t0, t1, t2, t2i, t9);
>>>   
>>>       
>>    Besides, we have ide_timing_compute() doing the same thing.
>>     
> I don't like results of ide_timing_compute(),

   Well, it seems worth fixing...

> I will use ide_timing_find_mode() and quantize
> by my own. This also is needed at startup when we need to program SMC and have no
> drive structure to pass to ide_timing_compute().
>   

   Looks like we need to export ide_timing_quantize() too...

>>> +	/* values are rounded up so we need to assure cycle is larger than pulse */
>>> +	if (t0 < t1 + t2 + t9)
>>> +		t0 = t1 + t2 + t9;
>>> +
>>> +	/* setup calculated timings */
>>> +	at91_sys_write(AT91_SMC_SETUP(chipselect), AT91_SMC_NWESETUP_(t1) |
>>> +						   AT91_SMC_NCS_WRSETUP_(0) |
>>> +						   AT91_SMC_NRDSETUP_(t1) |
>>> +						   AT91_SMC_NCS_RDSETUP_(0));
>>> +	at91_sys_write(AT91_SMC_PULSE(chipselect), AT91_SMC_NWEPULSE_(t2) |
>>> +						   AT91_SMC_NCS_WRPULSE_(t1 + t2 + t9) |
>>>   
>>>       
>>   With zero address to CS setup time it's the same as t0.
>>     
> Not true for slower PIO modes.

   Well, you're right probably...

> But CS pulse can be t0.

   Yes, it must be no less than t0.

> Write data is driver on
> NWR signal (WRITE_MODE = 1) in at91_ide,  in opposite to pata_at32 where 
> there is need to non zero CS setup or recovery time.
>   

   You're always setting CS setup to 0. Recovery time can't be 0, you 
probably mean nCS hold time?

>>> +	/* disable or enable waiting for IORDY signal */
>>> +	mode = at91_sys_read(AT91_SMC_MODE(chipselect));
>>> +	mode &= ~AT91_SMC_EXNWMODE;
>>> +	if (pio <= 4)
>>>   
>>>       
>>    The IORDY loigic is not as simple -- you'd better use 
>> ata_id_has_iordy() for PIO modes < 5.
>>     
> Hmm. Really IDE host should behave like this?
>   

   PIO modes 0 to 2 don't require IORDY and low end CF drives don't 
support IORDY modes.

> Must IDENTYFY DEVICE and then disable IORDY if device not use it.

   Not, the host must only disable drive's IORDY if it does't have this 
signal.

> Maybe this is simpler, host have to react on IORDY signal but device
> just not assert it. 
>
> I would like to remove this code and have allways NWAIT
> READY mode to make flipping 8/16 simpler.

   I don't understand how these are connected.

> But I don't think we 
> have guarantees that PIO5 and 6 devices not assert IORDY.
>   

   They must not assert IORDY according to the spec (unless it's 
improbable case of a hard drive with PIO5).

>>> +	else 
>>> +		mode |= AT91_SMC_EXNWMODE_DISABLE;
>>>   
>>>       
>>    This constant is 0, so else branch can be skipped.
>>     
> Do you think this make code more readable? Compiler optimize this.
>   

   Up to you.

>>    Why not pass it normally, via the platform device's resource?
>>     
> Irq pin is board specific. When use resource I will need in processor 
> code modify resource.

   So what? That's pretty normal and won't take much code.

BR, Sergei


