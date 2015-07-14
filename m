From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/2] libata: add ATA_HORKAGE_NOTRIM
Date: Tue, 14 Jul 2015 15:34:07 +0300
Message-ID: <55A501BF.1000507@cogentembedded.com>
References: <1436873314-22563-1-git-send-email-arne_f@ipfire.org>
 <1436873314-22563-2-git-send-email-arne_f@ipfire.org>
 <55A4F5C8.3010908@cogentembedded.com>
 <73557bea6ace15e6dc087ede89ee1982@mail01.ipfire.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:36503 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbbGNMeP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jul 2015 08:34:15 -0400
Received: by lagw2 with SMTP id w2so5128966lag.3
        for <linux-ide@vger.kernel.org>; Tue, 14 Jul 2015 05:34:14 -0700 (PDT)
In-Reply-To: <73557bea6ace15e6dc087ede89ee1982@mail01.ipfire.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: arne_f <arne_f@ipfire.org>
Cc: tj@kernel.org, linux-ide@vger.kernel.org

On 7/14/2015 3:16 PM, arne_f wrote:

>>> sone disks lose data at trim also with disabled ncq
>>> so this add a switch to force disable trim.

>>    You forgot to sign off on the patch, so it can't be applied.

> Ok. Next time i will not forget the "-s"

>> [...]
>>> diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
>>> index d6c37bc..3a13c7d 100644
>>> --- a/drivers/ata/libata-transport.c
>>> +++ b/drivers/ata/libata-transport.c
>>> @@ -569,6 +569,8 @@ show_ata_dev_trim(struct device *dev,
>>>
>>>       if (!ata_id_has_trim(ata_dev->id))
>>>           mode = "unsupported";
>>> +    else if (ata_dev->horkage & ATA_HORKAGE_NOTRIM)
>>> +            mode = "forced_unsupported";
>>
>>    Indented too much.

> Should i change this to "unsupported" or better to something else?

   I just meant the line started too far to the right, that's all.

> Greets,
> Arne

MBR, Sergei

