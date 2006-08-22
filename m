From: Kevin Hilman <khilman@mvista.com>
Subject: Re: PCI SATA controllers on embedded, no-BIOS targets
Date: Tue, 22 Aug 2006 10:37:30 -0700
Message-ID: <44EB40DA.3010904@mvista.com>
References: <44EB32E4.8080706@mvista.com> <44EB33BB.4090101@gmail.com> <44EB3650.1080404@mvista.com> <44EB3E2F.4040504@gmail.com> <44EB3F70.6000702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:65337 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751390AbWHVRhb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Aug 2006 13:37:31 -0400
In-Reply-To: <44EB3F70.6000702@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Deepak Saxena <dsaxena@mvista.com>

Tejun Heo wrote:
> Tejun Heo wrote:
>> Kevin Hilman wrote:
>>> Tejun Heo wrote:
>>>> Kevin Hilman wrote:
>>>>> I have a Silicon Images 3112 PCI card on an XScale IXP425 
>>>>> platform.  The card works well in a PC, but I haven't got it to 
>>>>> work in on the ARM platform.  On the PC, I see the cards BIOS 
>>>>> executed and am guessing that since this can't happen on the ARM, 
>>>>> that's why things aren't working.
>>>>>
>>>>> The card is at least detected on the ARM, and the driver tries to 
>>>>> probe for devices, but times out an moves on.
>>>>>
>>>>> Before I debug this too deeply, I want to make sure this should 
>>>>> work on embedded boards, even without the BIOS execution.
>>>>
>>>> sil3112 works fine w/o any BIOS initialization.
>>>>
>>>
>>> I'm curious what platforms this has been tested.  Any non-x86 
>>> platforms?  Any big endian platforms?
>>>
>>> Thanks for the quick response.
>>
>> I've personally seen it working on XScale and ATI's mips.

OK, that's good to know.

> For the record, for ATI's new mips platform, sata_sil needs some 
> modifications.  Their PCI bridge can't handle byte-aligned mmio and the 
> driver had to be modified to use IO address space.

I'm using 2.6.18-rc4 on this XScale IXP425 (big endian) and both the 
legacy driver (drivers/ide/pci/siimage.c) and the libata driver 
(drivers/scsi/sata_sil.c) cause crashes during probing due to bad memory 
accesses.

Switching the legacy driver into PIO mode makes the probing work well, 
but still can't figure out what's happening in the libata driver, AFICT, 
it can't do PIO.

Any chance you can share the changes to use IO address space?  Maybe the 
PCI on this XScale has similar limitations.

Kevin
