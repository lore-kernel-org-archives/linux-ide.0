From: Mark Lord <liml@rtr.ca>
Subject: Re: ahci problems with sata disk.
Date: Tue, 16 Jan 2007 13:32:26 -0500
Message-ID: <45AD1A3A.4000706@rtr.ca>
References: <1168785128.7865.13.camel@duo> <45AB45B2.2080602@gmail.com>	 <1168859112.6980.8.camel@duo> <f4527be0701160844r19fe5220i39a5834f1f4df570@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1489 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbXAPSc3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Jan 2007 13:32:29 -0500
In-Reply-To: <f4527be0701160844r19fe5220i39a5834f1f4df570@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lyon <andrew.lyon@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>, Tejun Heo <htejun@gmail.com>

..
>> I though that NCQ was intended to increase performance ??
..
> My Raptor drive  WDC WD740ADFD-00  Rev: 20.0 performs worse with NCQ
> than with NCQ, Alan Cox has added it to a blacklist but I dont think
> that is in the mainline kernel yet.
> 
> Search the list archives for my previous postings about it, including
> some hdparm -tT results.
> 
> Andy

Raptors have "server style" firmware in them.
When NCQ is turned on, they self-optimize for random seeks
rather than for sequential read-ahead.

My hdparm test is a sequential read-ahead test, so it will
naturally perform worse on a Raptor when NCQ is on.

That doesn't mean NCQ is bad on all Raptors; it just means
it's not good for large sequential reads.

Cheers
