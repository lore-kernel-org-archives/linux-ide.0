From: Artem Bokhan <aptem@ngs.ru>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands
 concurrently
Date: Wed, 13 Aug 2008 19:05:29 +0700
Message-ID: <48A2CE09.9090806@ngs.ru>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca> <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca> <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru> <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru> <48A2C460.6040504@gmail.com> <48A2C770.2040200@ngs.ru> <48A2CB1B.4000200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpout1.ngs.ru ([195.93.186.195]:57362 "EHLO smtpout1.ngs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517AbYHMMFX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Aug 2008 08:05:23 -0400
In-Reply-To: <48A2CB1B.4000200@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

When I run 'dd if=3D/dev/sda of=3D/dev/null skip=3D9700 bs=3D1M' and it=
 meets=20
bad block, it takes about=20
'/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:02.0/host4/t=
arget4:0:0/4:0:0:0/timeout=20
+ about 10 seconds' to determine I/O error. Until that IO to device is=20
locked, as I understand. I want to reduce the time of lock as  much as=20
possible.

dd: reading `/dev/sda': Input/output error
240+1 records in
240+1 records out
252575744 bytes (253 MB) copied, 13.7833 s, 18.3 MB/s



Tejun Heo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Artem Bokhan wrote:
>  =20
>> Now I have about 10 seconds of "disk restart" when hitting bad block
>> (with /sys/...../timeout=3D1).
>> Can somebody point me, if there any way to reduce it to 1/2/3 secs?
>>    =20
>
> I don't really follow what you're saying.  Can you please elaborate?
>
>  =20

