From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] IDE: palm_bk3710: use ioremap instead of arch-specific IO_ADDRESS()
Date: Fri, 30 Jan 2009 10:23:00 -0800
Message-ID: <8763jwk60r.fsf@deeprootsystems.com>
References: <1233270357-604-1-git-send-email-khilman@deeprootsystems.com>
	<498240EB.3090907@ru.mvista.com> <87d4e5ljqr.fsf@deeprootsystems.com>
	<4982E7DE.2080800@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:15697 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbZA3SXF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jan 2009 13:23:05 -0500
Received: by rv-out-0506.google.com with SMTP id k40so552827rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 30 Jan 2009 10:23:03 -0800 (PST)
In-Reply-To: <4982E7DE.2080800@ru.mvista.com> (Sergei Shtylyov's message of "Fri\, 30 Jan 2009 14\:43\:26 +0300")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com

Sergei Shtylyov <sshtylyov@ru.mvista.com> writes:

> Hello.
>
> Kevin Hilman wrote:
>
>>> Hello.
>>>
>>> Kevin Hilman wrote:
>>>
>>>     
>>>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>>>>         
>>>   Sorry, NAK.
>>>
>>>     
>>>> diff --git a/drivers/ide/palm_bk3710.c b/drivers/ide/palm_bk3710.c
>>>> index f38aac7..be9c904 100644
>>>> --- a/drivers/ide/palm_bk3710.c
>>>> +++ b/drivers/ide/palm_bk3710.c
>>>> @@ -380,7 +380,11 @@ static int __init palm_bk3710_probe(struct platform_device *pdev)
>>>>  		return -EBUSY;
>>>>  	}
>>>>  -	base = IO_ADDRESS(mem->start);
>>>> +	base = ioremap(mem->start, mem->end);
>>>> +	if (!base) {
>>>> +		printk(KERN_ERR "failed to map IO memory\n");
>>>> +		return -ENOMEM;
>>>>         
>>>   Leaks requested memory region.
>> Where would you suggest putting the iounmap?
>
>   You misunderstood -- you don't call release_mem_region() on the
> error path.

Ah, I see.  Good catch.  I also noticed ioremap() takes 'size' and not
'end' so that needs to be fixed too.  Will resend.

Kevin

>> Which brings up a bigger question, why isn't there a remove hook.  I
>> vaguely remember there being some problem way back in the 2.6.18 time
>> frame that wouldn't allow this driver to be removed.
>
>   The IDE drivers were generally undremovable back then.
>
>> Is that still a problem in newer kernels?
>>   
>
>   No, shouldn't be -- they've been made removable since.
>
>> Kevin
>
> MBR, Sergei
