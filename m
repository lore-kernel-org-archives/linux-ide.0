From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 1/1] libata-dev: ata_check_atapi_dma() fix for ATA_FLAG_PIO_POLLING
 LLDDs
Date: Wed, 15 Mar 2006 11:24:39 -0500
Message-ID: <44183FC7.3020401@rtr.ca>
References: <441525DB.40905@tw.ibm.com> <441528BD.8070708@pobox.com> <44164C25.10106@tw.ibm.com> <441838B6.8060900@rtr.ca> <44183CDA.5010407@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:15312 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1752127AbWCOQYo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Mar 2006 11:24:44 -0500
In-Reply-To: <44183CDA.5010407@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE Linux <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Mark Lord wrote:
> Albert Lee wrote:
>> Jeff Garzik wrote:
>>
>>> Applied, though I think its an open question what happens with
>>> CDB-interrupt ATAPI devices want to do DMA.  Perhaps we just get an
>>> interrupt event that we clear, then life proceeds as normal.

Oh yeah, from experience I know that the interrupt and DRQ bit
are *NOT* synchronized with these devices.. I believe that the IRQ
sometimes arrives early, and sometimes late.

Reading the ATA status reg after the IRQ always clears the IRQ,
and is usually necessary for the transfer to continue.

The last time I did a full ATAPI driver, it used both periodic polling
and an IRQ handler to wait for (DRQ && !BUSY).

Cheers
