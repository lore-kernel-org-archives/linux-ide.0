Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BEB218E96
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 07:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751009902; cv=none; b=B5ULFaq1mIM7W3nsGFycF98aUDYuSxFZ+oOrzy1qjRliJlnortFe4KWoj9Iz9pvoJSte7TQVmZL924d79A7ekS5Ee1MKc/R1W2bT3z/3/VUH3edddjgpcBwEggVAAyDww9RYS/MU8kztWR8t6cPtoHb4Bj9n+CRvWDSVuUDalCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751009902; c=relaxed/simple;
	bh=FKm0vIqrHyUGBOuOb9Tyc8pxH6nA2StRGwXqm0pjyOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ptiiY3lkQQmQaLkTvjm/eyAVHHJCX6tnHs/w/898mKVlEXM/b9iPtdewV646VDUhfOz/A3w0JATG5rlqmMWdL23GpyisYEr6nb896wqdH8UxPGUqQnK13dt+wrpZQowZjnVz5wAVT8GG25HkhNwT56gtzRAhVmVnVCWGVGUbDEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zct+5X0u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zct+5X0u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BB5C4CEE3;
	Fri, 27 Jun 2025 07:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751009901;
	bh=FKm0vIqrHyUGBOuOb9Tyc8pxH6nA2StRGwXqm0pjyOE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Zct+5X0uA42/N1mtOyxj5IE3sEweq4AlYaapJd46Gv2bQ1TBvEiLecy9JDW6dja4K
	 0ImwL+rrhY6ea2tuAxnorqvjoKVRJxdeclhu6g8Bz9YNZBXpbe0St3NFIwnA4wEISN
	 VOmHl07b/Q2Tup+FWp7IC681DbYvyVCajhiRUp/UFNQ38rrg2xAS+8bWq0ZmQpg/cM
	 cHbqqk9OnDo7kA7dQeMJa/GvXfIPLZhtfuXc29aVk1YmCY2f+2FOVitlRrNWV3kuWb
	 C878Rv8I9xGqsoqEsheXqmIoPOa/C6Ghz6Jw77kkrigd5fd5AzgpYLI3ZuvYUpTwYK
	 9ZunNLrrSLlKQ==
Message-ID: <5b510941-3015-48a8-9f56-3f0a8e6e8436@kernel.org>
Date: Fri, 27 Jun 2025 16:38:20 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] ata: libata: Improve LPM policies description
To: Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250627011155.701125-1-dlemoal@kernel.org>
 <20250627011155.701125-5-dlemoal@kernel.org>
 <5572ab0a-59f5-41f6-98f0-b88add978678@suse.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <5572ab0a-59f5-41f6-98f0-b88add978678@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 15:04, Hannes Reinecke wrote:
> On 6/27/25 03:11, Damien Le Moal wrote:
>> Improve the comments describing the different values of enum
>> ata_lpm_policy in include/linux/libata.h. The comments match the
>> description given for the CONFIG_SATA_MOBILE_LPM_POLICY config
>> parameter.
>>
>> No functional changes.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>   include/linux/libata.h | 17 ++++++++++++-----
>>   1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>> index 721f0805b6c9..f8bdf167bad9 100644
>> --- a/include/linux/libata.h
>> +++ b/include/linux/libata.h
>> @@ -499,16 +499,23 @@ enum ata_completion_errors {
>>   };
>>   
>>   /*
>> - * Link power management policy: If you alter this, you also need to
>> - * alter libata-sata.c (for the ascii descriptions)
>> + * Link power management policy: If you alter this, you also need to alter
>> + * the policy names used with the sysfs attribute link_power_management_policy
>> + * defined in libata-sata.c
>>    */
>>   enum ata_lpm_policy {
>> +	/* 0 => Keep firmware settings */
>>   	ATA_LPM_UNKNOWN,
>> +	/* 1 => No power savings (maximum performance) */
>>   	ATA_LPM_MAX_POWER,
>> +	/* 2 => HIPM (Partial) */
>>   	ATA_LPM_MED_POWER,
>> -	ATA_LPM_MED_POWER_WITH_DIPM, /* Med power + DIPM as win IRST does */
>> -	ATA_LPM_MIN_POWER_WITH_PARTIAL, /* Min Power + partial and slumber */
>> -	ATA_LPM_MIN_POWER, /* Min power + no partial (slumber only) */
>> +	/* 3 => HIPM (Partial) and DIPM (Partial and Slumber) */
>> +	ATA_LPM_MED_POWER_WITH_DIPM,
>> +	/* 4 => HIPM (Partial and DevSleep) and DIPM (Partial and Slumber) */
>> +	ATA_LPM_MIN_POWER_WITH_PARTIAL,
>> +	/* 5 => HIPM (Slumber and DevSleep) and DIPM (Partial and Slumber) */
>> +	ATA_LPM_MIN_POWER,
>>   };
>>   
>>   enum ata_lpm_hints {
> 
> It feels really weird to have the values for the enum in the _comment_.
> I'd rather drop them and just have the comments without values.

That is fair. The intent here was to link with CONFIG_SATA_MOBILE_LPM_POLICY
which defines the default LPM policy to use. The possible values of this enum
are what goes into that config option. But I can state that in the comment above
the enum.

> 
> Cheers,
> 
> Hannes


-- 
Damien Le Moal
Western Digital Research
