Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE191990B5;
	Mon, 23 Sep 2024 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727096846; cv=none; b=t/ezHYOauLju94uq/M6uwtwc5UIgwxvwp9INtJul+WkSQu0gQU8pQeJVqKIIjZqS74vu9f/KABIB/oO5zXcMl3bklXrtDxmA4WjirdE8SkwYqpNd7/CABFlNjyqMmkrHF9wLNFt5CsTbql8osvS10HthZpcPmNSs0VKcu3wHMvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727096846; c=relaxed/simple;
	bh=OGPHsMK7U0ARgmjaJNZV0oXO/2Ea4qxBjP9Qd28aTCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSWDtQOPXeWqvSK3NeBCvkRW+Q8fs1rNey5lTy7uKVb0EkGdPEleXKD85XHywq5f6174MfQmTxXvD20mlGcix3aHmXVfsDhS9p8qPdKTWgbwT/V2fpiN9JsE8JKWGED3yqINJz/A9cfn+N34tmReJWwPvWMExzXYis3xdiS5A1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7BR5Sq6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7BR5Sq6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB77C4CEC4;
	Mon, 23 Sep 2024 13:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727096846;
	bh=OGPHsMK7U0ARgmjaJNZV0oXO/2Ea4qxBjP9Qd28aTCE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S7BR5Sq60wnANYMm6pU3wWbfEIPqTlTzSw+eAljDhvZMaShOPkmyrvPs3xFka2g62
	 UII6Y0/IHPjmPdpXXub8NJzdNahT9hQGXDNC60YeHvrj1S1E+wiRV1tmL9G5R7ph8X
	 ZwtKtqGbs8KaUY9ZVEE/g9iFmWzVQKS1hB8bIdXVqisCz2o/4HatfcjxsFyc35GSxm
	 /FxAJZp3ZvGtp6bzmBRpQcIwhZ+83VLNL/qlycB7eppNP9vyUaghkrk+ky7h496ybX
	 adOOhUBFaa0++6S6qSa5Y6YOkA0rW1bL0ForTEzSayYi9kZEyIu0vZ7odErawNHB8o
	 CjFzwyr6U5vEg==
Message-ID: <7f297a66-6c82-498e-81da-85bbb74c8a8f@kernel.org>
Date: Mon, 23 Sep 2024 15:07:24 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata: fix ALL_SUB_MPAGES not to be performed when
 CDL is not supported
To: Jeongjun Park <aha310510@gmail.com>
Cc: cassel@kernel.org, syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240921124117.82156-1-aha310510@gmail.com>
 <f70ee386-d8eb-4d28-99fd-9d40e5d93ca8@kernel.org>
 <CAO9qdTGAgBux-M3GxZdBbBpsUm0V_E8fyWSjZuA7jA8bH-Qf4g@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAO9qdTGAgBux-M3GxZdBbBpsUm0V_E8fyWSjZuA7jA8bH-Qf4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/09/23 13:15, Jeongjun Park wrote:
> Damien Le Moal <dlemoal@kernel.org> wrote:
>>
>> On 2024/09/21 14:41, Jeongjun Park wrote:
>>> In the previous commit 602bcf212637 ("ata: libata: Improve CDL resource
>>> management"), the ata_cdl structure was added and the ata_cdl structure
>>> memory was allocated with kzalloc(). Because of this, if CDL is not
>>> supported, dev->cdl is a NULL pointer, so additional work should never
>>> be done.
>>>
>>> However, even if CDL is not supported now, if spg is ALL_SUB_MPAGES,
>>> dereferencing dev->cdl will result in a NULL pointer dereference.
>>>
>>> Therefore, I think it is appropriate to check dev->flags in
>>> ata_scsiop_mode_sense() if spg is ALL_SUB_MPAGES to see if CDL is supported.
>>>
>>> Reported-by: syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com
>>> Tested-by: syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com
>>> Fixes: 602bcf212637 ("ata: libata: Improve CDL resource management")
>>> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
>>> ---
>>>  drivers/ata/libata-scsi.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>>> index 3328a6febc13..6f5527f12b0e 100644
>>> --- a/drivers/ata/libata-scsi.c
>>> +++ b/drivers/ata/libata-scsi.c
>>> @@ -2442,7 +2442,9 @@ static unsigned int ata_scsiop_mode_sense(struct ata_scsi_args *args, u8 *rbuf)
>>>       if (spg) {
>>>               switch (spg) {
>>>               case ALL_SUB_MPAGES:
>>> -                     break;
>>> +                     if (dev->flags & ATA_DFLAG_CDL)
>>> +                             break;
>>> +                     fallthrough;
>>
>> I do not think this is correct at all. If the user request all sub mpages, we
>> need to give that list regardless of CDL support. What needs to be fixed is that
>> if CDL is NOT supported, we should not try to add the information for the T2A
>> and T2B sub pages. So the fix should be this:
> 
> Okay. But after looking into it further, I think it would be more appropriate to
> also check the ATA_DFLAG_CDL_ENABLED flag when checking if CDL is
> not supported. So it seems like it would be better to modify the condition as
> below.
> 
> What do you think?
> 
> if (!(dev->flags & ATA_DFLAG_CDL
>       dev->flags & ATA_DFLAG_CDL_ENABLED) || !dev->cdl)
>         return 0;

No, that would be wrong. The mode sense is to report if CDL is *supported*, not
if it is enabled or not. So we always must report the T2A and T2B pages for SATA
drives that support CDL, even if the CDL feature is disabled.

The flag ATA_DFLAG_CDL_ENABLED is not checked in ata_scsiop_mode_sense() for
this reason. Adding that check in ata_msense_control_spgt2() would be wrong.


-- 
Damien Le Moal
Western Digital Research
