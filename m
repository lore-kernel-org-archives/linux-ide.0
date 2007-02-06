From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: fix drive side 80c cable check, take 2
Date: Wed, 07 Feb 2007 00:09:48 +0100
Message-ID: <45C90ABC.9060205@gmail.com>
References: <20070205074713.GF1625@htj.dyndns.org>	 <20070205111837.1981bda2@localhost.localdomain>	 <20070205124713.GL1625@htj.dyndns.org>	 <20070205132849.484e97a1@localhost.localdomain> <58cb370e0702061454j1dfe2492w240ca06c028043b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:22953 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030513AbXBFXEt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Feb 2007 18:04:49 -0500
Received: by ug-out-1314.google.com with SMTP id 44so28398uga
        for <linux-ide@vger.kernel.org>; Tue, 06 Feb 2007 15:04:48 -0800 (PST)
In-Reply-To: <58cb370e0702061454j1dfe2492w240ca06c028043b7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, stable@kernel.org, linux-ide@vger.kernel.org


Alan wrote:
> On Mon, 5 Feb 2007 21:47:13 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> eighty_ninty_three() had word 93 validitity check but not the 80c bit
>> test itself (bit 12).  This increases the chance of incorrect wire
>> detection especially because host side cable detection is often
>> unreliable and we sometimes soley depend on drive side cable
>> detection.  Fix it.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> ---
>> Ah... thanks.  That explains the code much better.  Fixed accordingly.
>>
>> diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
>> index badde63..6558055 100644
>> --- a/drivers/ide/ide-iops.c
>> +++ b/drivers/ide/ide-iops.c
>> @@ -607,6 +607,8 @@ u8 eighty_ninty_three (ide_drive_t *drive)
>>       if(!(drive->id->hw_config & 0x4000))
>>               return 0;
>>  #endif /* CONFIG_IDEDMA_IVB */
>> +     if (!(drive->id->hw_config & 0x2000))
>> +             return 0;
>>       return 1;
> 
> Acked-by: Alan Cox <alan@redhat.com>

applied
