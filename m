From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Pata support for SIS180
Date: Sun, 12 Jun 2005 23:34:37 -0400
Message-ID: <42ACFECD.7060909@pobox.com>
References: <42AAE8B1.8080607@verizon.net> <42AC9BB9.2030304@gmx.net> <42ACAE15.4030001@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:58337 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261345AbVFMDeo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Jun 2005 23:34:44 -0400
In-Reply-To: <42ACAE15.4030001@verizon.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wes Newell <w.newell@verizon.net>
Cc: Uwe Koziolek <uwe.koziolek@gmx.net>, "linux.ide" <linux-ide@vger.kernel.org>

Wes Newell wrote:
> Uwe Koziolek wrote:
> 
>> Wes Newell schrieb:
>>
>>  
>>
>>> Can anyone tell me if/how one could add device support for the sis180
>>> chipset pata ports to the sis5513 module? I've tried adding this as
>>> others have said it works for the 965 southbridge,
>>>
>>> if ((trueid == 0x5518) || (trueid == 0x0180)) {
>>>
>>> but it stll doesn't see a real sis180 on a Jetway S755MAX MB.
>>>   
>>
>>
>>
>> you must include the chip into the pci_device_id table
>>
>> static *struct* pci_device_id sis5513_pci_tbl[] = {
>>     { PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5513, PCI_ANY_ID, PCI_ANY_ID, 
>> 0, 0, 0},
>>     { PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5518, PCI_ANY_ID, PCI_ANY_ID, 
>> 0, 0, 0},
>> +    { PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_180, PCI_ANY_ID, PCI_ANY_ID, 
>> 0, 0, 0},
>>     { 0, },
>> };
>>
>>
>> regards
>> Uwe Koziolek
>>
>>  
>>
> Won't compile. I copied the sis180 line above into the code (- the + 
> sign of course). I tried both 0x180 and 0x0180 as a trueid. Didn't 
> matter. Keep in mind I'm not a C programmer.:-)
> 
> This is the error I get;
> 
>  CC      drivers/ide/pci/sis5513.o
> drivers/ide/pci/sis5513.c:955: error: `PCI_DEVICE_ID_SI_180' undeclared 
> here (not in a function)

You need to add this #define to include/linux/pci_ids.h.

	Jeff



