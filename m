From: Andries Brouwer <Andries.Brouwer@cwi.nl>
Subject: Re: [PATCH pata-2.6 fix queue] hpt366: don't check enablebits for HPT36x
Date: Mon, 28 May 2007 22:32:28 +0200
Message-ID: <20070528203228.GA9786@apps.cwi.nl>
References: <200705042318.37367.sshtylyov@ru.mvista.com> <4655F43D.2090402@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.cwi.nl ([192.16.191.8]:37633 "EHLO hera.cwi.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373AbXE1Uct (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 May 2007 16:32:49 -0400
Content-Disposition: inline
In-Reply-To: <4655F43D.2090402@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, linas@austin.ibm.com, Andries.Brouwer@cwi.nl, michal.kepien@poczta.onet.pl

On Fri, May 25, 2007 at 12:23:25AM +0400, Sergei Shtylyov wrote:

>> HPT36x chip don't seem to have the channel enable bits, so prevent the
>> IDE core from checking them...

>    Actually it does, but the bit is different. :-/
> 
>>  	d->channels = 1;
>> +	d->enablebits[0].reg = 0;
> 
>    Linas, Andries, Michal, cound you try this instead:
> 
> 	d->enablebits[0].mask = d->enablebits[0].val = 0x10;

OK, tried, works fine.

Andries
