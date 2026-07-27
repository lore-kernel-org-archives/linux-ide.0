Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DBC1DF72C;
	Mon, 27 Jul 2026 02:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785117758; cv=none; b=O8pRl7eUE85+gu+XLFJBs7rrLeNUjehdLoNEU8HzUTjtrYzcS4gsaK0MDRivlKrxaJH8yKKQVA1ejZ3OwWJsmY4Ay7+yeFIylQOe8BVu1UJPzrXpFK8RIWoHKaA4wwXQHzAG0wv67AgPiryjBjvXy2A4Lt0P8HgqQTdFn0oAl+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785117758; c=relaxed/simple;
	bh=hSUuabqQE6RU9qgBwvTX5GT+4YqiGwyqVW41lYKfHV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p//7LWiDvnwO+SAPjnIlGXafZ+sn70BT4F+gpE4MoZ+tUfmO9HxuQ36KO7vlGErWMr+d3P8/EodAcMFPKAQXshEQ9B/9K1Sl5N39QHTAAeJYaO+5cgxUFF6n5beScxeCED8tJhifYrfnUGnOM7vssICU3cTXB2ldxukLiAV8vTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqbCfhWd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqbCfhWd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0BA1F000E9;
	Mon, 27 Jul 2026 02:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785117757;
	bh=Lk448lbuxj9x9GnP2rXdKXbiREd+nR0XrnkqV4A/Ijc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OqbCfhWdoAgOl5tPEzj2XmriRFl/dKqhQbrlJjUv/dSRJAw7gH7y9BrXcd3SczCrF
	 w3OHw86n0dsPC5UQbbUlYxXdVLwMvCfUTlP5+QlSv3+KU1n5erH9hRrglWJ87XJPvs
	 twYavktBLKskHf83/2afbDZU4DBN6FZ4ACsPJZNkknD7A3iVV0Rrx/BBQoCPgwktth
	 osmdFSWCA43KlHDghVHHgX8rYIm1P8d5SIOKF1K5GQZDHTfqlFFKauIJOBqLiof0/l
	 dXEtJaJLTgL26wrhHSb2mZTwX7N8U64veJ9mBNzIxxYOu0zlKgYNhqDczuBQi4xaLi
	 0PnV+yTaLXqAQ==
Message-ID: <f431a513-3b6a-4f17-a5d8-d6876e1f1bc9@kernel.org>
Date: Mon, 27 Jul 2026 11:02:25 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata: avoid kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org
References: <20260725015209.1207666-1-rdunlap@infradead.org>
 <343c7dd0-c16c-419b-97f6-379692266761@kernel.org>
 <85a068d0-8e37-49d2-93a5-3298b036726f@infradead.org>
 <4cdc57ad-39a7-42f2-89c2-fab8c06b5da1@kernel.org>
 <9eb721f9-ffaf-4bcf-a548-7dd7a8cedf8d@infradead.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <9eb721f9-ffaf-4bcf-a548-7dd7a8cedf8d@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/26/26 13:19, Randy Dunlap wrote:
> 
> 
> On 7/25/26 9:14 PM, Damien Le Moal wrote:
>> On 7/26/26 12:41, Randy Dunlap wrote:
>>>
>>>
>>> On 7/25/26 7:49 PM, Damien Le Moal wrote:
>>>> On 7/25/26 10:52, Randy Dunlap wrote:
>>>>> Modify comments to prevent kernel-doc warnings:
>>>>> - use "/*" for a non-kernel-doc comment
>>>>> - add a Returns: section for ata_id_major_version()
>>>>>
>>>>> Warning: include/linux/ata.h:770 Cannot find identifier on line:
>>>>>  *
>>>>> Warning: include/linux/ata.h:782 function parameter 'id' not described in 'ata_id_sct_data_tables'
>>>>> Warning: include/linux/ata.h:782 expecting prototype for Word(). Prototype was for ata_id_sct_data_tables() instead
>>>>> Warning: include/linux/ata.h:820 No description found for return value of 'ata_id_major_version'
>>>>>
>>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>>> ---
>>>>> Cc: Damien Le Moal <dlemoal@kernel.org>
>>>>> Cc: Niklas Cassel <cassel@kernel.org>
>>>>> Cc: linux-ide@vger.kernel.org
>>>>>
>>>>>  include/linux/ata.h |    5 +++--
>>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> --- linux-next-20260722.orig/include/linux/ata.h
>>>>> +++ linux-next-20260722/include/linux/ata.h
>>>>> @@ -767,8 +767,7 @@ static inline bool ata_id_sense_reportin
>>>>>  	return id[ATA_ID_COMMAND_SET_4] & BIT(6);
>>>>>  }
>>>>>  
>>>>> -/**
>>>>> - *
>>>>> +/*
>>>>>   * Word: 206 - SCT Command Transport
>>>>>   *    15:12 - Vendor Specific
>>>>>   *     11:6 - Reserved
>>>>> @@ -815,6 +814,8 @@ static inline bool ata_id_sct_supported(
>>>>>   *
>>>>>   *	The practical impact of this is that ata_id_major_version cannot
>>>>>   *	reliably report on drives below ATA3.
>>>>> + *
>>>>> + *	Returns: major version of ATA drive level or %0 if unknown
>>>>
>>>> Is the "%0% here intentional ? If yes, why ? Or is it a typo? If it is the
>>>> latter, I can fix when applying.
>>>
>>> It indicates to kernel-doc that it's a constant and should be printed
>>> in code/monospace style.
>>> But it's perfectly OK to drop it if you prefer that.
>>
>> Well, given that the patch is all about *not* having that comment as a kernel
>> doc, I would prefer staying consistent with this goals and not use kernel docs
>> markings. I will remove it if you agree.
>> Thanks!
> 
> Yes, I see now. Please drop the '%'.

I completely misread this patch: the %0 is fine since that is in the kdoc for
ata_id_major_version(), so all good. My apologies for the noise.



-- 
Damien Le Moal
Western Digital Research
