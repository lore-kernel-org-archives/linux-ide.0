From: Martin Michlmayr <tbm@cyrius.com>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands
	concurrently
Date: Fri, 29 Aug 2008 10:12:01 +0300
Message-ID: <20080829071201.GB5284@deprecation.cyrius.com>
References: <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca> <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru> <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru> <48A2C460.6040504@gmail.com> <48AE588C.6080605@garzik.org> <20080822170119.GA18700@deprecation.cyrius.com> <48B40B10.6060301@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:3904 "EHLO sorrow.cyrius.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbYH2HMW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Aug 2008 03:12:22 -0400
Content-Disposition: inline
In-Reply-To: <48B40B10.6060301@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Artem Bokhan <aptem@ngs.ru>, linux-ide@vger.kernel.org, stable@kernel.org

* Mark Lord <liml@rtr.ca> [2008-08-26 09:54]:
>>>> sata_mv allowed issuing two DMA commands concurrently which the
>>>> hardware allows.  Unfortunately, libata core layer isn't ready for
>>>> this yet and spews ugly warning message and malfunctions on this.
>>>> Don't allow concurrent DMA commands for now.
>>>>
>>>> Signed-off-by: Tejun Heo <tj@kernel.org>
>>> applied
>>
>> Is this -stable material?
>
> Absolutely yes.

Adding stable@kernel.org.  This is commit 4bdee6c5103696a2729d3db2f235d202191788e4

-- 
Martin Michlmayr
http://www.cyrius.com/
