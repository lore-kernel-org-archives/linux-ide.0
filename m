From: Martin Michlmayr <tbm@cyrius.com>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands
	concurrently
Date: Fri, 22 Aug 2008 20:01:19 +0300
Message-ID: <20080822170119.GA18700@deprecation.cyrius.com>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca> <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca> <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru> <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru> <48A2C460.6040504@gmail.com> <48AE588C.6080605@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:4869 "EHLO sorrow.cyrius.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752994AbYHVRqW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Aug 2008 13:46:22 -0400
Content-Disposition: inline
In-Reply-To: <48AE588C.6080605@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Artem Bokhan <aptem@ngs.ru>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

* Jeff Garzik <jeff@garzik.org> [2008-08-22 02:11]:
> Tejun Heo wrote:
>> sata_mv allowed issuing two DMA commands concurrently which the
>> hardware allows.  Unfortunately, libata core layer isn't ready for
>> this yet and spews ugly warning message and malfunctions on this.
>> Don't allow concurrent DMA commands for now.
>>
>> Signed-off-by: Tejun Heo <tj@kernel.org>
>
> applied

Is this -stable material?
-- 
Martin Michlmayr
http://www.cyrius.com/
