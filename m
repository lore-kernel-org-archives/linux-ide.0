Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E530366DA3;
	Sun, 26 Jul 2026 04:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785039306; cv=none; b=BcO4BpeAVSzl/53XFR5AP5WyDvpJneE29IlFabGDX/xHdkhH4mMoKT/r6CzA2aBiH985edKvFN05s/LoVvvAU4QgRh6jLi0ozTnelXjZqNRPK4YvZc612vNz5yB42gz812IRDZJ/y4dY0yPYOyIAncuJ7ZWStV1IB+aF+E5Lac0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785039306; c=relaxed/simple;
	bh=yHLo3ksD4uvDz7hIWShxk8ZsKLJAQDQD5L5IGjya+5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmVcWsCJPR8vnsFPAF5O7q1U5sgQyjn4WFMzKXUHEzgrqIarU7A6JCKjY4DLN7qQUFH9lHumOXo1Zkteb2qVc0R4sObIf97UQHaTZ32NI4MpMrnnKx4+4eKH8yNp7H0XFW9EZBLUxS7IssW0DXGLXtYmJiBf8TTdooBthWOAYM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhghKuao; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhghKuao"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CB11F000E9;
	Sun, 26 Jul 2026 04:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785039301;
	bh=OwXMCqhZ/u07cjJs9lawhazg4wRIr1bIf/rZuQUhHBU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JhghKuaoNcU5VvIOZB1E0qS/UwfQD7VqGMl+fzEAH6mhEDOaxXowknTEczRgulGmu
	 PYkbzinX511e7cHrBw8/c+si2au1t/P4ugaNy+gKdFqeTOZlJlOFgml2MrBc/zusje
	 /saRmcJBoWWqJMivtnur2+4A2HaZ8A+/mTrWLrOc95oNuOnMmPWOeCaMDg4iQgGtFR
	 nCsGbDotB1J+RTS/yv89/HoFjcl4AtKzuoXTLBs+rHu7IWb+qQT33+9ZaF8DV60xzY
	 G+q+3iAiJ9X4RevHYwSuA61P5EfcNAP025B160+uCDYqWCZ5He6HJJl48pEXrwea9x
	 2OwkrocQHYxDA==
Message-ID: <4cdc57ad-39a7-42f2-89c2-fab8c06b5da1@kernel.org>
Date: Sun, 26 Jul 2026 13:14:59 +0900
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
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <85a068d0-8e37-49d2-93a5-3298b036726f@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/26/26 12:41, Randy Dunlap wrote:
> 
> 
> On 7/25/26 7:49 PM, Damien Le Moal wrote:
>> On 7/25/26 10:52, Randy Dunlap wrote:
>>> Modify comments to prevent kernel-doc warnings:
>>> - use "/*" for a non-kernel-doc comment
>>> - add a Returns: section for ata_id_major_version()
>>>
>>> Warning: include/linux/ata.h:770 Cannot find identifier on line:
>>>  *
>>> Warning: include/linux/ata.h:782 function parameter 'id' not described in 'ata_id_sct_data_tables'
>>> Warning: include/linux/ata.h:782 expecting prototype for Word(). Prototype was for ata_id_sct_data_tables() instead
>>> Warning: include/linux/ata.h:820 No description found for return value of 'ata_id_major_version'
>>>
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> ---
>>> Cc: Damien Le Moal <dlemoal@kernel.org>
>>> Cc: Niklas Cassel <cassel@kernel.org>
>>> Cc: linux-ide@vger.kernel.org
>>>
>>>  include/linux/ata.h |    5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> --- linux-next-20260722.orig/include/linux/ata.h
>>> +++ linux-next-20260722/include/linux/ata.h
>>> @@ -767,8 +767,7 @@ static inline bool ata_id_sense_reportin
>>>  	return id[ATA_ID_COMMAND_SET_4] & BIT(6);
>>>  }
>>>  
>>> -/**
>>> - *
>>> +/*
>>>   * Word: 206 - SCT Command Transport
>>>   *    15:12 - Vendor Specific
>>>   *     11:6 - Reserved
>>> @@ -815,6 +814,8 @@ static inline bool ata_id_sct_supported(
>>>   *
>>>   *	The practical impact of this is that ata_id_major_version cannot
>>>   *	reliably report on drives below ATA3.
>>> + *
>>> + *	Returns: major version of ATA drive level or %0 if unknown
>>
>> Is the "%0% here intentional ? If yes, why ? Or is it a typo? If it is the
>> latter, I can fix when applying.
> 
> It indicates to kernel-doc that it's a constant and should be printed
> in code/monospace style.
> But it's perfectly OK to drop it if you prefer that.

Well, given that the patch is all about *not* having that comment as a kernel
doc, I would prefer staying consistent with this goals and not use kernel docs
markings. I will remove it if you agree.
Thanks!

-- 
Damien Le Moal
Western Digital Research
