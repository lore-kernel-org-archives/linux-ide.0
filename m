From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands
 concurrently
Date: Tue, 26 Aug 2008 09:54:24 -0400
Message-ID: <48B40B10.6060301@rtr.ca>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca> <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca> <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru> <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru> <48A2C460.6040504@gmail.com> <48AE588C.6080605@garzik.org> <20080822170119.GA18700@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:38805 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754603AbYHZNyZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Aug 2008 09:54:25 -0400
In-Reply-To: <20080822170119.GA18700@deprecation.cyrius.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Tejun Heo <htejun@gmail.com>, Artem Bokhan <aptem@ngs.ru>, linux-ide@vger.kernel.org

Martin Michlmayr wrote:
> * Jeff Garzik <jeff@garzik.org> [2008-08-22 02:11]:
>> Tejun Heo wrote:
>>> sata_mv allowed issuing two DMA commands concurrently which the
>>> hardware allows.  Unfortunately, libata core layer isn't ready for
>>> this yet and spews ugly warning message and malfunctions on this.
>>> Don't allow concurrent DMA commands for now.
>>>
>>> Signed-off-by: Tejun Heo <tj@kernel.org>
>> applied
> 
> Is this -stable material?

Absolutely yes.
