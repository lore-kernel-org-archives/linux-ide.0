From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH pata-2.6] cmd64x: procfs code fixes/cleanups (take 2)
Date: Tue, 17 Apr 2007 13:59:15 -0400
Message-ID: <46250AF3.6090105@rtr.ca>
References: <200704142011.l3EKBBhf025590@harpo.it.uu.se> <462136AF.9060505@ru.mvista.com> <46215347.2000403@rtr.ca> <462368D9.8060407@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:1949 "EHLO
	mail.rtr.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031256AbXDQR7R (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Apr 2007 13:59:17 -0400
In-Reply-To: <462368D9.8060407@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, bzolnier@gmail.com, linux-ide@vger.kernel.org

Sergei Shtylyov wrote:
> Mark Lord wrote:
> 
>>>>> - correct the chipset names (from CMDxxx to PCI-xxx)
>>>> Please explain why this rename is a correction.
> 
>>>   Because the chips are officially named PCI064[036] and PCI-64[89].
> 
>> We normally name things with a combination of brand and chip number.
>> Lots of companies could have chips with PCI in the name,
>> but the CMD64x designator makes it quite clear what we're dealing with here.
> 
>   Note that I'm only changing designator in the procfs output, i.e. not 
> something important to end user.

Err.. in this case, the procfs output *is* there for the end-user.
Using the name printed on the chip, which matches the cmdxxx.c driver name,
is by far the least confusing way to do it here.

>> In the machines I have here with these chips,
>> they are clearly labelled as "CMD" and then "PCI646.."
> 
>   Although I've never seen the chip, I guess that should be logo, not 
> the name.

Then perhaps you should test the scheme against the real hardware
before patching it.

Cheers
