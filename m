From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands
 concurrently
Date: Wed, 13 Aug 2008 19:36:05 -0400
Message-ID: <48A36FE5.5000706@rtr.ca>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca> <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca> <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru> <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru> <48A2C460.6040504@gmail.com> <48A2C770.2040200@ngs.ru> <48A2CB1B.4000200@gmail.com> <48A2CE09.9090806@ngs.ru> <48A30920.5030803@rtr.ca> <48A33CDC.3000809@ngs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:50073 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752600AbYHMXgI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Aug 2008 19:36:08 -0400
In-Reply-To: <48A33CDC.3000809@ngs.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bokhan Artem <APTEM@ngs.ru>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Bokhan Artem wrote:
> As it named RETRY, I set it to 0, "define SD_MAX_RETRIES        0"
> But still got two retries. Any suggestions?
..

I only see two failures (eg. one retry) in the log you showed.
But it probably was not a retry, but rather a second I/O after
the first one.  The filesystem layer often does that.

Cheers
