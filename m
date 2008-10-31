From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] fix pata-rb532-cf
Date: Fri, 31 Oct 2008 13:38:27 +0300
Message-ID: <490AE023.9040906@ru.mvista.com>
References: <1225403251-15705-1-git-send-email-n0-1@freewrt.org> <490A4156.5080302@ru.mvista.com> <20081031000912.GB10620@nuty>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:24671 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751135AbYJaKid (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Oct 2008 06:38:33 -0400
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP id 81FCF3ECA
	for <linux-ide@vger.kernel.org>; Fri, 31 Oct 2008 03:38:31 -0700 (PDT)
In-Reply-To: <20081031000912.GB10620@nuty>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello.

Phil Sutter wrote:

>>> -#define RB500_CF_REG_CMD	0x0800
>>> +#define RB500_CF_REG_BASE	0x0800
>>> #define RB500_CF_REG_CTRL	0x080E
>>> #define RB500_CF_REG_DATA	0x0C00
>>> +#define RB500_CF_REG_ERR	0x080D
>>>  
>>>       
>>   Hm...
>>     
>
> The original driver (see my patch) accesses 0x80D to read error codes,
> so I assumed this is correct. Indeed, the driver works also with the
> standard setting. Is there a way I can clearly verify which is the right
> offset?
>   

   I assume you don't have the documentation? I wodner why they needed 
to duplicate (or remap) this register...

>>> -static void rb532_pata_data_xfer(struct ata_device *adev, unsigned char 
>>> *buf,
>>> +static unsigned int rb532_pata_data_xfer(struct ata_device *adev, 
>>> unsigned char *buf,
>>> 				unsigned int buflen, int write_data)
>>> {
>>> 	struct ata_port *ap = adev->link->ap;
>>> 	void __iomem *ioaddr = ap->ioaddr.data_addr;
>>> +	unsigned int ret = buflen;
>>>
>>> 	if (write_data) {
>>> 		for (; buflen > 0; buflen--, buf++)
>>> @@ -87,6 +94,8 @@ static void rb532_pata_data_xfer(struct ata_device 
>>> *adev, unsigned char *buf,
>>> 	}
>>>
>>> 	rb532_pata_finish_io(adev->link->ap);
>>> +
>>> +	return ret;
>>>  
>>>       
>>   Totally unneeded variable.
>>     
>
> I wanted to preserve the behaviour of ata_sff_data_xfer(), i.e.
> returning the number of bytes written. The variable exists, because
> buflen is being decremented in the loop and therefore zero afterwards.
>   

   Oops, sorry -- I've managed to miss that decrement... :-<

> Returning a static value also should be no alternative, as it could lead
> to unexpected behaviour on the caller side. So, do I miss something?
>   

   No. The alternatives would be to use local variable as a loop counter 
or, better yet, using readsb()/writesb() instead of the loops...
Wait! The original driver used 32-bit I/O to this register, not 8-bit -- 
so it looks like you have artificially slowed it down... :-/

MBR, Sergei


