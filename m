From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands
 concurrently
Date: Wed, 13 Aug 2008 20:52:19 +0900
Message-ID: <48A2CAF3.2010009@gmail.com>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca> <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca> <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru> <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru> <48A2C460.6040504@gmail.com> <48A2C9BC.2010209@ngs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.191]:36713 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577AbYHMLxR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Aug 2008 07:53:17 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1524548tic.23
        for <linux-ide@vger.kernel.org>; Wed, 13 Aug 2008 04:53:16 -0700 (PDT)
In-Reply-To: <48A2C9BC.2010209@ngs.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Artem Bokhan <aptem@ngs.ru>
Cc: Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Artem Bokhan wrote:
> Tejun Heo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Unfortunately, libata core layer isn't ready for
>> this yet and spews ugly warning message and malfunctions on this.

When NCQ is disabled, it will probably add tiny bit to inter command
latency thus reducing performance a bit but I don't think it will stand
out in any way.  When you count in the seek time and all, the inter
command latency should be negligible in most cases.

--=20
tejun
