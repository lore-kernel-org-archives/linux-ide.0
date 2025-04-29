Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319F5293B58;
	Tue, 29 Apr 2025 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745922899; cv=none; b=NtJ/iwaCJhCWpz+u3sxAzWDUp1w6XUWy6Tfe2MvHjOcJuUQRX2c7oHIKoJ/LdIgATcgqnbsAJl5fNqtyF6Wd7IrpWpCvK+HIT7TuJ4uZL34cs/9eSmBgHRPVGODDg5SNlVb/3221URioto1+ap0TlJmcLM3KCKLceqzwifh3Hjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745922899; c=relaxed/simple;
	bh=5Xaiv77pPqDR0JWNZbP97RXrrtQfNbUb/NQWJxnkVrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbFnK3WYqgsi0Y7z83jEulIIuv1mSFpsZ6zMxWkapeuka6OqqbWc+MzaMYjU9m6OeQuLlEeWdhkikeFGgKgW3tW2eowDIHYxfr6rJad/ykZvHSxbSKYtJf7oowdQ4IzB36K5kEX4FTWeSMH+iXRchpr25R9T6kaND5ll7pEvSLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xv3f3HPN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xv3f3HPN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED33C4CEE3;
	Tue, 29 Apr 2025 10:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745922898;
	bh=5Xaiv77pPqDR0JWNZbP97RXrrtQfNbUb/NQWJxnkVrw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xv3f3HPN22BsCFvLatg87iv2U79wZb0pZQDrvgBpyuPwsy334ZKBuqJh9I6Sks9CY
	 F5zAQPm6AtssjmFldHZmuntmkaPBwBF+dfeKVYaOYipu5H3FjgSGYU8G8yKDFfI0BV
	 QyrXFiDeVxJWRw2jKr8gC32ujSD6Chg2RTnpUpPynzjkinZX8x2xvX0A6DwqlGpxuf
	 kHxYGHUHVXHF/uyx5DWuty05gXF2FloTRr2AYJH4TBLzOSnqZLblYwbntY/j3jJoGm
	 rQxC1k9B8eR6NrppxePXzq3a40SH2ENjbQ00JI7SFHM+KXrZbobbKLLT+7h6YYwPGS
	 uU5SD4DoZ/1OA==
Message-ID: <4e882e59-149d-4d9e-9897-69dab2659608@kernel.org>
Date: Tue, 29 Apr 2025 19:34:56 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard
 drives
To: Niklas Cassel <cassel@kernel.org>,
 Mikko Juhani Korhonen <mjkorhon@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAAZ0mTfSFZoL_CS9s1L0JhfaoyMGJ6Up5Z9_YvU-pX05MOZ99w@mail.gmail.com>
 <aA8xCLulpVz6V8T0@ryzen>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <aA8xCLulpVz6V8T0@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/28/25 16:40, Niklas Cassel wrote:
> On Fri, Apr 25, 2025 at 10:33:17PM +0300, Mikko Juhani Korhonen wrote:
>> Make WDC WD20EFAX-68FB5N0 hard drives work again after regression in
>> 6.9.0 when LPM was enabled, so disable it for this model.
>>
>> Signed-off-by: Mikko Korhonen <mjkorhon@gmail.com>
>> ---
>> drivers/ata/libata-core.c | 5 +++++
>> 1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 773799cfd443..5c2f26945d61 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -4239,6 +4239,11 @@ static const struct ata_dev_quirks_entry
>> __ata_dev_quirks[] = {
>>        { "WDC WD3000JD-*",             NULL,   ATA_QUIRK_WD_BROKEN_LPM },
>>        { "WDC WD3200JD-*",             NULL,   ATA_QUIRK_WD_BROKEN_LPM },
>>
>> +       /*
>> +        * This specific WD SATA-3 model has problems with LPM.
>> +        */
>> +       { "WDC WD20EFAX-68FB5N0",       NULL,   ATA_QUIRK_NOLPM },
>> +
>>        /*
>>         * This sata dom device goes on a walkabout when the ATA_LOG_DIRECTORY
>>         * log page is accessed. Ensure we never ask for this log page with
>>
>> base-commit: 14a3cc755825ef7b34c986aa2786ea815023e9c5
>> --
>> 2.47.2
> 
> Hello Mikko,
> 
> I tried to apply this commit, but it fails with:
> 
> Applying: ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard drives
> Patch failed at 0001 ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard drives
> error: corrupt patch at line 10
> 
> 
> Please use:
> $ git format-patch -1
> You should then get a foo.patch.

And please do not copy-paste that into a mailer. Use "git send-email" to send
the patch.

> 
> You should then be able to do (locally):
> $ git checkout HEAD~
> $ git am foo.patch
> 
> to verify that the commit can be applied.
> 
> 
> Kind regards,
> Niklas


-- 
Damien Le Moal
Western Digital Research
