From: Bokhan Artem <APTEM@ngs.ru>
Subject: Re: bad sectors, suspicious behaviour
Date: Mon, 11 Aug 2008 18:12:25 +0700
Message-ID: <48A01E99.1080905@ngs.ru>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca> <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpout1.ngs.ru ([195.93.186.195]:36518 "EHLO smtpout1.ngs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751513AbYHKLMb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Aug 2008 07:12:31 -0400
Received: from [192.168.3.217] (unknown [192.168.3.217])
	(Authenticated sender: aptem@ngs.ru)
	by smtp.ngs.ru (smtp) with ESMTP id 610424254F1FF
	for <linux-ide@vger.kernel.org>; Mon, 11 Aug 2008 18:12:28 +0700 (NOVST)
In-Reply-To: <489C54D1.5080901@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

So, is there any chance to test patch from someone on this issue?

ps. I'm very far from kernel development.

Mark Lord =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Mark Lord wrote:
> ..
>>>> [75703.296100] WARNING: at drivers/ata/libata-core.c:4732=20
>>>> ata_qc_issue+0x1ca/0x230 [libata]()
>> ..
>> That line is this one (linux-2.6.26.2):
>>
>>        WARN_ON(ap->ops->error_handler &&=20
>> ata_tag_valid(link->active_tag));
>>
>> So this should trigger only when link->active_tag is valid, which=20
>> doesn't normally happen.
>> But the convoluted traceback shows that this code path came from the=
 EH,
>> so something in libata EH is likely neglecting to clear link->active=
_tag
>> before issuing a new command.
>> Tejun?
> ..
>
> Mmm.. since it happens only once in a while, and not on every EH acti=
on,
> one might assume that it's a race of some kind.
>
> One possibility, might be due to .qc_defer.
>
> The stock ata_qc_defer relies heavily on ata_tag_valid(),
> which matches what the above WARN_ON uses.
>
> But sata_mv doesn't use ata_tag_valid, because it wants to know
> about the entire port and not just a single individual link on the po=
rt.
> So instead, it uses ap->nr_active_links for the test.
>
> My guess is that these two items are not kept in sync during EH.
>
> Tejun?
> --=20
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

