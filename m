Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BF9352C51;
	Thu, 15 Oct 2026 07:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051198; cv=none; b=X4u7+vbVfj3AFb0NWpbdNH77ubioQY/hJe6mxlCWuouAEiTvVFu+7hYtDw6vU1kkLGKers0bjmQCry3sjrZQOh3mQzm1T7clkK7dET3857HN5KTveOmGVVVZudXG6Qy8uT4PpKFLZvUiu+2e2YQOOz/5Gvrm0THAmiQP8w3MNtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051198; c=relaxed/simple;
	bh=jxI6QxvXaIT6aWHXL86G5QrtdnzVp7YO5sKU25jyUR8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hCEIjK9nvCJ3mGXqbA8XwuvRb4+Qg0X3IsJ/U1+wW5Y9/Ojpcs9yzWNLQF4Lcg3FnZHn5taluuRsQJQvx1rKcComSDchFcw0qIgkOo9lq8Iejavoui+owFT4xY6Z91xfj3Z1Kjf7vQwJe8FH5ydPOq4qAJGWNeELr0M1U1gP7D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2T6JPI+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2T6JPI+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163E51F000C4;
	Thu, 15 Oct 2026 07:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792051196;
	bh=bziVElBgO+YjutTT4zmN77auD30OSZiSiTokpmhkB7U=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=n2T6JPI+D8qhrHR0Y/NUg/hrZeAFiwUWtzqmzc6Q8glAkZ6GyQ/QPmZF/vZhZiGo4
	 pgxqPlfCSCn8vtBsebs53hcUEhUYobUy2Oyb4Bh6LMUsCgYKHK5GUrPSMo3ETQUDEh
	 wpJsjAKV8C/YVAwm8eysw7IkwsO+UKuGaMAPIlWzdCp3kwCV+rjAHdelXfNfKTrJR/
	 il7B/DcOsRZmi9u+PxcaRVT38YavBZHZXii2NPeQ2qeFQ7Ox69OjAGaMKFFSTf2cbK
	 X5ZaUxz+0WY7vLzhM/s1/+X30Yu+TxVQptzZMnTxGiwbwGboZ2getMW3tIZ86qtOSP
	 ghFZ98QqnUoiw==
Message-ID: <4e87af7b-22e5-4dd4-8270-aa73e3539feb@kernel.org>
Date: Thu, 15 Oct 2026 09:59:54 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata: preserve sata_spd link cache across
 ata_dev_init
From: Damien Le Moal <dlemoal@kernel.org>
To: tongzhiwei <tongzhiwei@cmss.chinamobile.com>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261010075457.882-1-tongzhiwei@cmss.chinamobile.com>
 <9c6bafea-7eef-42c8-b514-bdb0777b9372@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <9c6bafea-7eef-42c8-b514-bdb0777b9372@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/15 7:30, Damien Le Moal wrote:
> On 2026/10/10 9:54, tongzhiwei wrote:
>> a hot-unplug goes through
>> ata_eh_schedule_probe() -> ata_dev_init() -> sata_spd = 0.
>> After commit 69f2c9346313 ("ata: libata: Fix sata_down_spd_limit() when no
>> link speed is reported"), when
>> the device is unplugged, every probe lowers sata_spd_limit, which breaks
>> commit 2dc0b46b5ea3 ("libata: sata_down_spd_limit should return if
>> driver has not recorded sstatus speed"). The harm is, when the device
>> is plugged back, it is limited to low speed which will never be recovered.
>>
>> This patch stops zeroing sata_spd in ata_dev_init (sata_spd was
>> introduced in commit 008a78961ec7 ("libata: improve SATA PHY speed down
>> logic")).  sata_spd is then written only on a successful reset.  At
>> struct ata_port's init time the sata_spd field is zeroed by kzalloc.
>>
>> Fixes: 69f2c9346313 ("ata: libata: Fix sata_down_spd_limit() when no link speed is reported")
>> Assisted-by: LLM
>> Signed-off-by: tongzhiwei <tongzhiwei@cmss.chinamobile.com>
>> ---
>>  drivers/ata/libata-core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index f482c0a6d7e9..2ddad2e6ebd2 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -5659,7 +5659,7 @@ void ata_dev_init(struct ata_device *dev)
>>  
>>  	/* SATA spd limit is bound to the attached device, reset together */
>>  	link->sata_spd_limit = link->hw_sata_spd_limit;
>> -	link->sata_spd = 0;
>> +	/* link->sata_spd caches last negotiated link speed; not zeroed here */
> 
> This contradicts the previous comment, so let's make this consistent. E.g.
> something like:
> 
> 	/*
> 	 * The SATA speed limit is bound to the attached device, so reset it
> 	 * but keep the last negotiated speed indicated by link->sata_spd.
> 	 */
> 
> to replace the previous comment.
> 
>>  
>>  	/* High bits of dev->flags are used to record warm plug
>>  	 * requests which occur asynchronously.  Synchronize using

Looking at the Sashiko comment on this patch, I think it is valid and should be
addressed as well.



-- 
Damien Le Moal
Western Digital Research
