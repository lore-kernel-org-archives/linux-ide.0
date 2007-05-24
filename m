From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH pata-2.6 fix queue] hpt366: don't check enablebits for
 HPT36x
Date: Fri, 25 May 2007 00:53:19 +0400
Message-ID: <4655FB3F.2070605@ru.mvista.com>
References: <200705042318.37367.sshtylyov@ru.mvista.com> <4655F43D.2090402@ru.mvista.com> <20070524203414.GO5921@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:3117 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750909AbXEXUvs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 May 2007 16:51:48 -0400
In-Reply-To: <20070524203414.GO5921@austin.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linas Vepstas <linas@austin.ibm.com>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries.Brouwer@cwi.nl, michal.kepien@poczta.onet.pl

Linas Vepstas wrote:

>>>HPT36x chip don't seem to have the channel enable bits, so prevent the IDE 
>>>core from checking them...

>>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>>	d->channels = 1;
>>>+	d->enablebits[0].reg = 0;

> The original patch worked for me.

>>   Linas, Andries, Michal, cound you try this instead:
>>
>>	d->enablebits[0].mask = d->enablebits[0].val = 0x10;

> Based on the printk's from my system, this should work fine.
> The config register had 0x33 in it, so 0x33 & mask == val for me.
> I'll reply tommorrow if this doesn't work.

    It probably won't work the way it should anyway -- the secondary channel 
(and controller in this case) uses another bit in this register and the 
controllers get registered with IDE core "in pair". Highpoint knows how to 
make broken hardware. :-)

> --linas

MBR, Sergei
