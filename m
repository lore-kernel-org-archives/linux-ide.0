From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/3] mg_disk: fix CONFIG_LBD=y warning
Date: Tue, 28 Apr 2009 14:09:54 -0400
Message-ID: <49F74672.2090407@garzik.org>
References: <1240890740-3462-1-git-send-email-tj@kernel.org> <1240890740-3462-3-git-send-email-tj@kernel.org> <49F71E86.7040300@rtr.ca> <200904281728.58209.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54188 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754039AbZD1SKE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Apr 2009 14:10:04 -0400
In-Reply-To: <200904281728.58209.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <tj@kernel.org>, axboe@kernel.dk, linux-kernel@vger.kernel.org, donari75@gmail.com, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 28 April 2009 17:19:34 Mark Lord wrote:
>> Tejun Heo wrote:
>>> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>>>
>>> drivers/block/mg_disk.c: In function =E2=80=98mg_dump_status=E2=80=99=
:
>>> drivers/block/mg_disk.c:265: warning: format =E2=80=98%ld=E2=80=99 =
expects type =E2=80=98long int=E2=80=99, but
>>> argument 2 has type =E2=80=98sector_t=E2=80=99
>>>
>>> [ Impact: kill build warning ]
>>>
>>> Cc: unsik Kim <donari75@gmail.com>
>>> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>>> Signed-off-by: Tejun Heo <tj@kernel.org>
>>> ---
>>>  drivers/block/mg_disk.c |    2 +-
>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/block/mg_disk.c b/drivers/block/mg_disk.c
>>> index d3e72ad..f389835 100644
>>> --- a/drivers/block/mg_disk.c
>>> +++ b/drivers/block/mg_disk.c
>>> @@ -79,7 +79,7 @@ static void mg_dump_status(const char *msg, unsig=
ned int stat,
>>>  			if (host->breq) {
>>>  				req =3D elv_next_request(host->breq);
>>>  				if (req)
>>> -					printk(", sector=3D%ld", req->sector);
>>> +					printk(", sector=3D%u", (u32)req->sector);
>> ..
>>
>> Eh?  Shouldn't that be fixed the other way around, like this:
>>
>>   +					printk(", sector=3D%llu", (u64)req->sector);
>>
>> This way, it will still give correct data when sector_t is a u64.
>=20
> shouldn't matter, req->sector is never > u32 for mg_disk

It never matters... until the code gets copied elsewhere.  IMO wrong=20
code should never be kept -- "impossible to hit" just means it is low=20
priority :)

	Jeff



