From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH pata-2.6 fix queue] hpt366: don't check enablebits for
 HPT36x
Date: Fri, 25 May 2007 01:47:04 +0400
Message-ID: <465607D8.3030207@ru.mvista.com>
References: <200705042318.37367.sshtylyov@ru.mvista.com> <4655F43D.2090402@ru.mvista.com> <20070524203414.GO5921@austin.ibm.com> <4655FB3F.2070605@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:3915 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751031AbXEXVpe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 May 2007 17:45:34 -0400
In-Reply-To: <4655FB3F.2070605@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Linas Vepstas <linas@austin.ibm.com>, bzolnier@gmail.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries.Brouwer@cwi.nl, michal.kepien@poczta.onet.pl

Hello, I wrote:

>>>> HPT36x chip don't seem to have the channel enable bits, so prevent 
>>>> the IDE core from checking them...

>>>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>>>     d->channels = 1;
>>>> +    d->enablebits[0].reg = 0;

>> The original patch worked for me.

>>>   Linas, Andries, Michal, cound you try this instead:
>>>
>>>     d->enablebits[0].mask = d->enablebits[0].val = 0x10;

>> Based on the printk's from my system, this should work fine.
>> The config register had 0x33 in it, so 0x33 & mask == val for me.
>> I'll reply tommorrow if this doesn't work.

>    It probably won't work the way it should anyway -- the secondary 
> channel (and controller in this case) uses another bit in this register 
> and the controllers get registered with IDE core "in pair".

    Maybe it will though, after reading some more "secret" stuff. :-)

> Highpoint 
> knows how to make broken hardware. :-)

   It's alos known for lousy documentation. And even that they're not readily 
giving out. :-)

>> --linas

MBR, Sergei

