From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands
 concurrently
Date: Tue, 26 Aug 2008 09:58:24 -0400
Message-ID: <48B40C00.3030903@rtr.ca>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca>	 <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca>	 <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru>	 <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru>	 <48A2C460.6040504@gmail.com> <e7510f760808251824m2da1331eq514e864209654028@mail.gmail.com> <48B3AAFF.5010704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:38849 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753139AbYHZN60 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Aug 2008 09:58:26 -0400
In-Reply-To: <48B3AAFF.5010704@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Gwendal Grignou <gwendal@google.com>, Artem Bokhan <aptem@ngs.ru>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Gwendal Grignou wrote:
>> What happen if there is a SATA port multiplier behing the marvell
>> controller and NCQ is disabled?
>>
>> I have the impression that with this patch we are able to only send
>> one DMA command at a time to all the drives behind the PM, which has
>> an impact on performance.
> 
> Yeah, right. :-( The simplest way to implement this would be just
> calling ata_std_qc_defer() which computes per-link restrictions after
> ruling out all non-standard restrictions.  I wasn't really sure how
> EDMA/NCQ_EN flags are supposed to work so just sticked to the original
> condition tests.  Mark, can you please help us out here?  :-)
..

The hardware is both tricky and buggy, depending upon the version,
and my memory is fading -- I haven't looked at the code since early June,
when Marvell stopped paying invoices (administrative "issues").

The only 100% safe scenario is to issue only a single non-NCQ command at a time.
But there are many situations where it is safe to allow one command/port,
provided that there are no PIO commands anywhere in the mix.

Messy.  I'll have another walk through it whenever Marvell gets over
their "administrative issues" on this.

Cheers
