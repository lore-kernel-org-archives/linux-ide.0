From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands
 concurrently
Date: Fri, 22 Aug 2008 02:11:24 -0400
Message-ID: <48AE588C.6080605@garzik.org>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca> <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca> <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru> <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru> <48A2C460.6040504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50852 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752888AbYHVGL3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Aug 2008 02:11:29 -0400
In-Reply-To: <48A2C460.6040504@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Artem Bokhan <aptem@ngs.ru>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> sata_mv allowed issuing two DMA commands concurrently which the
> hardware allows.  Unfortunately, libata core layer isn't ready for
> this yet and spews ugly warning message and malfunctions on this.
> Don't allow concurrent DMA commands for now.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

applied


