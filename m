From: Artem Bokhan <aptem@ngs.ru>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands
 concurrently
Date: Thu, 14 Aug 2008 19:58:47 +0700
Message-ID: <48A42C07.1050208@ngs.ru>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca> <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca> <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru> <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru> <48A2C460.6040504@gmail.com> <48A2C770.2040200@ngs.ru> <48A2CB1B.4000200@gmail.com> <48A2CE09.9090806@ngs.ru> <48A30920.5030803@rtr.ca> <48A33CDC.3000809@ngs.ru> <48A36FE5.5000706@rtr.ca> <48A3E1FF.4030502@ngs.ru> <48A427C0.1070500@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpout1.ngs.ru ([195.93.186.195]:38021 "EHLO smtpout1.ngs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbYHNM6k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Aug 2008 08:58:40 -0400
In-Reply-To: <48A427C0.1070500@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

That work, thanks, no retries at all now. But is behavior with readahea=
d=20
on and double reads correct?

Mark Lord =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Artem Bokhan wrote:
> ..
>> IMHO, looks like cavity somewhere... Any ideas?
> ..
>
> Have you tried to disable fs read-ahead?
>
> Something like "hdparm -a0 /dev/sd*" ?
>
> -ml

