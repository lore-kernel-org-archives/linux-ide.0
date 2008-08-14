From: Artem Bokhan <aptem@ngs.ru>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands
 concurrently
Date: Thu, 14 Aug 2008 14:42:55 +0700
Message-ID: <48A3E1FF.4030502@ngs.ru>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca> <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca> <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru> <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru> <48A2C460.6040504@gmail.com> <48A2C770.2040200@ngs.ru> <48A2CB1B.4000200@gmail.com> <48A2CE09.9090806@ngs.ru> <48A30920.5030803@rtr.ca> <48A33CDC.3000809@ngs.ru> <48A36FE5.5000706@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpout1.ngs.ru ([195.93.186.195]:55798 "EHLO smtpout1.ngs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752461AbYHNHmu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Aug 2008 03:42:50 -0400
In-Reply-To: <48A36FE5.5000706@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Mark Lord =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>
> I only see two failures (eg. one retry) in the log you showed.
Yes, I mean 2 tries, so 1 unnecessary rerty.

> But it probably was not a retry, but rather a second I/O after
> the first one.  The filesystem layer often does that.
>
If kernel tries to read the same sector more then one time, I call that=
=20
retry :)

I found that it depend on vm someway... First 'dd if=3D/dev/sdb=20
of=3D/dev/null skip=3D300000 count=3D1' causes 2 failures (1 retry), bu=
t next=20
'dd's only 1failure. After I drop vm cache 'sysctl vm.drop_caches=3D1',=
 I=20
get two failures again.

running 'dd if=3D/dev/sdb of=3D/dev/null skip=3D300000 count=3D1 iflag=3D=
direct'=20
always causes only 1 failure

IMHO, looks like cavity somewhere... Any ideas?


> Cheers

