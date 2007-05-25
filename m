From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH pata-2.6 fix queue] hpt366: don't check enablebits for
 HPT36x
Date: Fri, 25 May 2007 22:12:25 +0400
Message-ID: <46572709.5040900@ru.mvista.com>
References: <200705042318.37367.sshtylyov@ru.mvista.com> <4655F43D.2090402@ru.mvista.com> <20070524203414.GO5921@austin.ibm.com> <4655FB3F.2070605@ru.mvista.com> <465607D8.3030207@ru.mvista.com> <20070525175830.GA4323@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:10172 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752779AbXEYSKz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 May 2007 14:10:55 -0400
In-Reply-To: <20070525175830.GA4323@austin.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linas Vepstas <linas@austin.ibm.com>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries.Brouwer@cwi.nl, michal.kepien@poczta.onet.pl

Linas Vepstas wrote:

>>>>> Linas, Andries, Michal, cound you try this instead:

>>>>>   d->enablebits[0].mask = d->enablebits[0].val = 0x10;

>>>  It probably won't work the way it should anyway -- the secondary 
>>>channel (and controller in this case) uses another bit in this register 
>>>and the controllers get registered with IDE core "in pair".

> Setting d->enablebits[0].mask = d->enablebits[0].val = 0x10; makes
> my system bootable, and so this works well enough for me.  Without this
> patch, mainline 2.6.21.1 is broken, and so I'll say it again:
> 
> Please submit a patch to the stable branch so that this gets generically
> fixed!  I'll happily Ack it. 

    Already done. I hope it'll be in 2.6.21.3...

> --linas

WBR, Sergei
