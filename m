From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands
 concurrently
Date: Tue, 26 Aug 2008 09:04:31 +0200
Message-ID: <48B3AAFF.5010704@gmail.com>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca>	 <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca>	 <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru>	 <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru>	 <48A2C460.6040504@gmail.com> <e7510f760808251824m2da1331eq514e864209654028@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.190]:51122 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbYHZHFk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Aug 2008 03:05:40 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1196681tic.23
        for <linux-ide@vger.kernel.org>; Tue, 26 Aug 2008 00:05:38 -0700 (PDT)
In-Reply-To: <e7510f760808251824m2da1331eq514e864209654028@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: Artem Bokhan <aptem@ngs.ru>, Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Gwendal Grignou wrote:
> What happen if there is a SATA port multiplier behing the marvell
> controller and NCQ is disabled?
> 
> I have the impression that with this patch we are able to only send
> one DMA command at a time to all the drives behind the PM, which has
> an impact on performance.

Yeah, right. :-( The simplest way to implement this would be just
calling ata_std_qc_defer() which computes per-link restrictions after
ruling out all non-standard restrictions.  I wasn't really sure how
EDMA/NCQ_EN flags are supposed to work so just sticked to the original
condition tests.  Mark, can you please help us out here?  :-)

Thanks.

-- 
tejun
