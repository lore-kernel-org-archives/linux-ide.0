From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 12/12] sata_mv NCQ-EH for FIS-based switching
Date: Fri, 02 May 2008 13:46:50 -0400
Message-ID: <481B538A.3030804@rtr.ca>
References: <481AAF84.40501@rtr.ca> <481AB0A1.3040009@rtr.ca>	 <481AB0D2.3070103@rtr.ca> <481AB107.701@rtr.ca>	 <481AB12A.3030102@rtr.ca> <481AB15D.5020201@rtr.ca>	 <481AB189.3070705@rtr.ca> <481AB1B4.7050508@rtr.ca>	 <481B0C9E.80008@rtr.ca>	 <da824cf30805020952g73ce5eabqdd5cd769286a90a6@mail.gmail.com> <da824cf30805020954md3c3450qe22edff7f037994a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1285 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757876AbYEBRqv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 May 2008 13:46:51 -0400
In-Reply-To: <da824cf30805020954md3c3450qe22edff7f037994a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>

Grant Grundler wrote:
> On Fri, May 2, 2008 at 9:52 AM, Grant Grundler <grundler@google.com> wrote:
> ...
>>  >  I grepped for one, but didn't find one.
>>
>>  include/asm-ia64/bitops.h:hweight64()
..

"hweight" ??  That's a nice "obvious" name for "count number of set bits".  :)

I'll post a follow-up patch to convert sata_mv to use hweight16() .

Thanks
