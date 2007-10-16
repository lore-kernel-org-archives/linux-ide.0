From: Mark Lord <liml@rtr.ca>
Subject: Re: Fwd: CMD 64x regression from 2.6.21 to 2.6.22 and 2.6.23?
Date: Tue, 16 Oct 2007 08:43:18 -0400
Message-ID: <4714B1E6.9070308@rtr.ca>
References: <200710142211.03382.marogge@onlinehome.de> <4713A010.3080504@ru.mvista.com> <200710152339.33718.marogge@onlinehome.de> <4714A625.8040306@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2729 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755190AbXJPMnU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Oct 2007 08:43:20 -0400
In-Reply-To: <4714A625.8040306@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Martin Rogge <marogge@onlinehome.de>, bzolnier@gmail.com, linux-ide@vger.kernel.org

Sergei Shtylyov wrote:
> Martin Rogge wrote:
> 
>>>    Could you git-bisect this?
>>>    Although I have a couple of patch suspects (dealing with interrupts),
>>> all worked fine with PCI-649 just fine. PCI-648 is not really much
>>> different from 649 according to specs...
> 
>> Yes, I found the same when I managed to send the CMD 648 into UDMA-100 
>> mode years ago (by treating it like a 649).
> 
>> Anyway, I found the git patches on kernel.org and bisected away. For 
>> completeness, this is the table containing all my results.
> 
>> Kernel         System reaction
>> ============================================================================ 
>>
>> 2.6.21         CMD 648 working fine
>> 2.6.21-git4    CMD 648 working fine
>> 2.6.21-git5    CMD 648 working fine
>> 2.6.21-git6    irg 15: nobody cared [...] Disabling IRQ #15 etc.
>> 2.6.21-git8    irg 15: nobody cared [...] Disabling IRQ #15 etc.
>> 2.6.22-rc1     irg 15: nobody cared [...] Disabling IRQ #15 etc.
>> 2.6.22         irg 15: nobody cared [...] Disabling IRQ #15 etc.
>> 2.6.23         irg 15: nobody cared [...] Disabling IRQ #15 etc.
> 
>> Well, most likely the CMD related patches in git6 are the culprit. 
> 
>    Erm... usually bisection leaves you with one patch startting from 
> which kernel was broken.  It seems you've done sort iof manual 
> bisecting. Thanks anyway. :-)

He's certainly provided way more than enough information here to find/fix
the bug.  The onus for hours of slaving away here is really on the person
who *broke* it, not the innocent reporter!

In this case, there are two very likely commits:

7670df73fba373d19471a2ebedb3302ea0607be0 ide: mode limiting fixes for user requested speed changes
26bcb879c03254545a19c6700fe5bcef6f21e7b1 ide: add ide_set{_max}_pio() (take 4)

Cheers
