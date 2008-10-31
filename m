From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] fix pata-rb532-cf
Date: Fri, 31 Oct 2008 14:08:33 +0300
Message-ID: <490AE731.4010709@ru.mvista.com>
References: <1225403251-15705-1-git-send-email-n0-1@freewrt.org> <490A4156.5080302@ru.mvista.com> <20081031000912.GB10620@nuty> <490AE023.9040906@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:24980 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750735AbYJaLIo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Oct 2008 07:08:44 -0400
In-Reply-To: <490AE023.9040906@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: florian.fainelli@telecomint.eu, n0-1@freewrt.org

Hello, I wrote:

>>>> -#define RB500_CF_REG_CMD    0x0800
>>>> +#define RB500_CF_REG_BASE    0x0800
>>>> #define RB500_CF_REG_CTRL    0x080E
>>>> #define RB500_CF_REG_DATA    0x0C00

   This is actually not the IDE data register itself but some data 
buffer register and supporting 32-bit I/O (and presumably implementing 
read prefetch)...

>>>> -static void rb532_pata_data_xfer(struct ata_device *adev, unsigned 
>>>> char *buf,
>>>> +static unsigned int rb532_pata_data_xfer(struct ata_device *adev, 
>>>> unsigned char *buf,
>>>>                 unsigned int buflen, int write_data)
>>>> {
>>>>     struct ata_port *ap = adev->link->ap;
>>>>     void __iomem *ioaddr = ap->ioaddr.data_addr;
>>>> +    unsigned int ret = buflen;
>>>>
>>>>     if (write_data) {
>>>>         for (; buflen > 0; buflen--, buf++)
>>>> @@ -87,6 +94,8 @@ static void rb532_pata_data_xfer(struct 
>>>> ata_device *adev, unsigned char *buf,
>>>>     }
>>>>
>>>>     rb532_pata_finish_io(adev->link->ap);
>>>> +
>>>> +    return ret;
>>>>  
>>>>       
>>>   Totally unneeded variable.
>>>     
>>
>> I wanted to preserve the behaviour of ata_sff_data_xfer(), i.e.
>> returning the number of bytes written. The variable exists, because
>> buflen is being decremented in the loop and therefore zero afterwards.
>>   
>
>   Oops, sorry -- I've managed to miss that decrement... :-<
>
>> Returning a static value also should be no alternative, as it could lead
>> to unexpected behaviour on the caller side. So, do I miss something?
>>   
>
>   No. The alternatives would be to use local variable as a loop 
> counter or, better yet, using readsb()/writesb() instead of the loops...
> Wait! The original driver used 32-bit I/O to this register, not 8-bit 
> -- so it looks like you have artificially slowed it down... :-/

   Sorry again -- looks like it was Florian who was the author of the 
original driver...

MBR, Sergei


