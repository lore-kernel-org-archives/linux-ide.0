From: Artem Bokhan <aptem@ngs.ru>
Subject: Re: bad sectors, suspicious behaviour
Date: Wed, 13 Aug 2008 18:19:56 +0700
Message-ID: <48A2C35C.7020400@ngs.ru>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca> <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca> <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru> <48A2BC5D.5060801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpout1.ngs.ru ([195.93.186.195]:45730 "EHLO smtpout1.ngs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155AbYHMLTv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Aug 2008 07:19:51 -0400
In-Reply-To: <48A2BC5D.5060801@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Tejun, I am very sorry, necessary initrd image was not updated. Now I=20
can not reproduce the problem, thx a lot.

Tejun Heo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Artem Bokhan wrote:
>  =20
>> patch did not help,  but I found additional necessary condition (I
>> didn't take it into account before system reboot):
>>
>> to reproduce the problem from scratch it is necessary to
>>
>> echo 1 >=20
>> /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:02.0/host4=
/target4:0:0/4:0:0:0/timeout
>>
>>
>> returning the value to 30 do not help.
>>
>> With default 30 secs the problem can not be reproduced
>>    =20
>
> Can you please post full kernel log?
>
>  =20

