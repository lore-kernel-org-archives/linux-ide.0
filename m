From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] IDE: palm_bk3710: use ioremap instead of arch-specific
 IO_ADDRESS()
Date: Fri, 30 Jan 2009 14:43:26 +0300
Message-ID: <4982E7DE.2080800@ru.mvista.com>
References: <1233270357-604-1-git-send-email-khilman@deeprootsystems.com>	<498240EB.3090907@ru.mvista.com> <87d4e5ljqr.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:7598 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752412AbZA3Lnc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jan 2009 06:43:32 -0500
In-Reply-To: <87d4e5ljqr.fsf@deeprootsystems.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-ide@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com

Hello.

Kevin Hilman wrote:

>> Hello.
>>
>> Kevin Hilman wrote:
>>
>>     
>>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>>>   
>>>       
>>   Sorry, NAK.
>>
>>     
>>> diff --git a/drivers/ide/palm_bk3710.c b/drivers/ide/palm_bk3710.c
>>> index f38aac7..be9c904 100644
>>> --- a/drivers/ide/palm_bk3710.c
>>> +++ b/drivers/ide/palm_bk3710.c
>>> @@ -380,7 +380,11 @@ static int __init palm_bk3710_probe(struct platform_device *pdev)
>>>  		return -EBUSY;
>>>  	}
>>>  -	base = IO_ADDRESS(mem->start);
>>> +	base = ioremap(mem->start, mem->end);
>>> +	if (!base) {
>>> +		printk(KERN_ERR "failed to map IO memory\n");
>>> +		return -ENOMEM;
>>>   
>>>       
>>   Leaks requested memory region.
> Where would you suggest putting the iounmap?

   You misunderstood -- you don't call release_mem_region() on the error 
path.

> Which brings up a bigger question, why isn't there a remove hook.  I
> vaguely remember there being some problem way back in the 2.6.18 time
> frame that wouldn't allow this driver to be removed.

   The IDE drivers were generally undremovable back then.

> Is that still a problem in newer kernels?
>   

   No, shouldn't be -- they've been made removable since.

> Kevin

MBR, Sergei


