From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] Add hook for custom xfer function in PATA Platform driver
Date: Mon, 10 May 2010 14:03:30 +0400
Message-ID: <4BE7D9F2.4070006@ru.mvista.com>
References: <1273382493-5859-1-git-send-email-graeme.russ@gmail.com> <4BE6910D.9070504@ru.mvista.com> <4BE69C81.2070703@gmail.com> <4BE6BA74.10200@mvista.com> <4BE74EEE.5060307@gmail.com> <4BE7D714.9010006@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:50687 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755810Ab0EJKEQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 May 2010 06:04:16 -0400
Received: by ewy20 with SMTP id 20so841214ewy.1
        for <linux-ide@vger.kernel.org>; Mon, 10 May 2010 03:04:15 -0700 (PDT)
In-Reply-To: <4BE7D714.9010006@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Graeme Russ <graeme.russ@gmail.com>, linux-ide@vger.kernel.org

Hello.

Sergei Shtylyov wrote:

>>>> other devices on the bus). By overriding the data transfer function 
>>>> I can
>>>> arbitrate access to the bus and switch the bus timings based on the
>>>> peripheral being accessed. This cannot be done be a generic data 
>>>> transfer
>>>> function.
>>>>         
>>>   I disagree with your approach of overriding the libata methods at the
>>> board level, so I suggest to write a new driver. This is too 
>>> complicated
>>> stuff for poor old pata_platform. :-)
>>>     
>>
>> My custom function to date looks like:
>>
>> unsigned int ata_enet_data_xfer(struct ata_device *dev, unsigned char 
>> *buf,
>>                    unsigned int buflen, int rw)
>> {
>>     struct ata_port *ap = dev->link->ap;
>>     void __iomem *data_addr = ap->ioaddr.data_addr;
>>
>>     set_gp_bus_slow();
>>     /* Transfer bytes */
>>     if (rw == READ)
>>         ioread8_rep(data_addr, buf, buflen);
>>     else
>>         iowrite8_rep(data_addr, buf, buflen);
>>
>>     set_gp_bus_fast();
>>     return buflen;
>> }
>>
>> set_gp_bus_slow() and set_gp_bus_fast() (at the moment) simply set a few
>> config registers to set the GP bus timing (no arbitration yet, but these

   BTW, do you know that there are different ATA PIO transfer modes with 
different timings?

>> functions will also handle that using a mutex). I don't see the point in
>> re-writing the entire PATA Platform driver when the existing driver 
>> appears
>> to be perfectly capable with a very minor extension hook.
>>   
>
>   As I said, we *can't* implement the driver methods at the board 
> level. Especially if they involve messing with timings -- that's the 
> point where the ATA driver stops being generic, like pata_platform, 
> and there arises a need for the dedicated driver. Also, your patch 
> would bring in disparity with the ide-platfrom driver (which should be 
> interchangeable with pata_platfrom). For me, the need of a separate 
> driver is clear now, so I'll remain opposed to your patch. Of course, 
> the maintainer (Jeff Garzik) will decide but if I could veto this 
> patch I would.

   At the very least, you should remove 'struct ata_device *' parameter 
from your hook, so that it could be called from the IDE driver also. 
Without this change, the patch will remain totally unacceptable.

>> Graeme
> Regards,

WBR, Sergei

