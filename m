From: Artem Bokhan <aptem@ngs.ru>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands
 concurrently
Date: Wed, 13 Aug 2008 18:47:08 +0700
Message-ID: <48A2C9BC.2010209@ngs.ru>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca> <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca> <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru> <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru> <48A2C460.6040504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpout1.ngs.ru ([195.93.186.195]:47264 "EHLO smtpout1.ngs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751848AbYHMLrC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Aug 2008 07:47:02 -0400
In-Reply-To: <48A2C460.6040504@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Tejun Heo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Unfortunately, libata core layer isn't ready for
> this yet and spews ugly warning message and malfunctions on this.
>  =20
Does this affect performance/functionality of controller/hdd someway?
> Don't allow concurrent DMA commands for now.
>
>  =20



