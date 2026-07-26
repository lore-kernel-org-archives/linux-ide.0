Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30923D76;
	Sun, 26 Jul 2026 04:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785039550; cv=none; b=nUFjkNtCgAZatXv3pjmUDfYTpYwpPLqiLe1onXXmQh8LXfhm0FAblxwmSNA3FrQpkfhqXO3n59GtVO0nzv3m12QU90uEfrhnvi6vwcgGfnLAZDxuDI9Of3dlXhNBSfxfPyMNiN8b/mOX4UlzMkwpnFxVXEJZUcl4pmw8/LdZebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785039550; c=relaxed/simple;
	bh=TdqSQmw9z/9xNME3VwtX6d2c3Adb093KqzLq8PGIYFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctyn6xjp81ktfBNNG0fzkR2TOMvM4OqB4ogFXAse1MCxH7/uqbPP+CnVkwIUE+lDFifE+zG6j28eyjyvWF5Z8R4MIDwDhJQ0xN+MsViqLH+obXaOwDzNwU1IeB2DNsUBv0boBeL2Ba0uSeCKMLXILSlt0GgJOZjWLVXlvN2/MpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pH1LEwJP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pH1LEwJP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=afLO+vz2AGrqoDHHBQgD5seFbuN3YQ2FXvHXJKJRnQg=; b=pH1LEwJPsAIfhfQPrOz4URxdT2
	JhNRQNn9kAX+C1SBmK//A3BY3PBm19DCKvQpQntJQnUuhZinDcLfw+Y2Wu4taJkp63zXYbT4HAUy9
	Vi2p5TU2PtHKM2IacKN5hZLKzUzLE5+wUWwRwWMssLGFgYhUrcTc90WCtjk0LumWkbNTZ3TvfgOio
	+Zi6FssWPv3cC1hIBZxTG9+j0aciq5A991m7GpoJ1/BJMZsk7ozZUqfBFHSle6DlUYsjXjF3fgH1B
	LdVywigWgSxSOVREqGO7WviLg7uPRISQtjbve36Kt31fXS5jKS+/urPohevvGYUygDspBr6ELaL4D
	Uau91wdw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnqKQ-00000000s5X-2igO;
	Sun, 26 Jul 2026 04:19:06 +0000
Message-ID: <9eb721f9-ffaf-4bcf-a548-7dd7a8cedf8d@infradead.org>
Date: Sat, 25 Jul 2026 21:19:04 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata: avoid kernel-doc warnings
To: Damien Le Moal <dlemoal@kernel.org>, linux-kernel@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org
References: <20260725015209.1207666-1-rdunlap@infradead.org>
 <343c7dd0-c16c-419b-97f6-379692266761@kernel.org>
 <85a068d0-8e37-49d2-93a5-3298b036726f@infradead.org>
 <4cdc57ad-39a7-42f2-89c2-fab8c06b5da1@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <4cdc57ad-39a7-42f2-89c2-fab8c06b5da1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/25/26 9:14 PM, Damien Le Moal wrote:
> On 7/26/26 12:41, Randy Dunlap wrote:
>>
>>
>> On 7/25/26 7:49 PM, Damien Le Moal wrote:
>>> On 7/25/26 10:52, Randy Dunlap wrote:
>>>> Modify comments to prevent kernel-doc warnings:
>>>> - use "/*" for a non-kernel-doc comment
>>>> - add a Returns: section for ata_id_major_version()
>>>>
>>>> Warning: include/linux/ata.h:770 Cannot find identifier on line:
>>>>  *
>>>> Warning: include/linux/ata.h:782 function parameter 'id' not described in 'ata_id_sct_data_tables'
>>>> Warning: include/linux/ata.h:782 expecting prototype for Word(). Prototype was for ata_id_sct_data_tables() instead
>>>> Warning: include/linux/ata.h:820 No description found for return value of 'ata_id_major_version'
>>>>
>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>> ---
>>>> Cc: Damien Le Moal <dlemoal@kernel.org>
>>>> Cc: Niklas Cassel <cassel@kernel.org>
>>>> Cc: linux-ide@vger.kernel.org
>>>>
>>>>  include/linux/ata.h |    5 +++--
>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> --- linux-next-20260722.orig/include/linux/ata.h
>>>> +++ linux-next-20260722/include/linux/ata.h
>>>> @@ -767,8 +767,7 @@ static inline bool ata_id_sense_reportin
>>>>  	return id[ATA_ID_COMMAND_SET_4] & BIT(6);
>>>>  }
>>>>  
>>>> -/**
>>>> - *
>>>> +/*
>>>>   * Word: 206 - SCT Command Transport
>>>>   *    15:12 - Vendor Specific
>>>>   *     11:6 - Reserved
>>>> @@ -815,6 +814,8 @@ static inline bool ata_id_sct_supported(
>>>>   *
>>>>   *	The practical impact of this is that ata_id_major_version cannot
>>>>   *	reliably report on drives below ATA3.
>>>> + *
>>>> + *	Returns: major version of ATA drive level or %0 if unknown
>>>
>>> Is the "%0% here intentional ? If yes, why ? Or is it a typo? If it is the
>>> latter, I can fix when applying.
>>
>> It indicates to kernel-doc that it's a constant and should be printed
>> in code/monospace style.
>> But it's perfectly OK to drop it if you prefer that.
> 
> Well, given that the patch is all about *not* having that comment as a kernel
> doc, I would prefer staying consistent with this goals and not use kernel docs
> markings. I will remove it if you agree.
> Thanks!

Yes, I see now. Please drop the '%'.
Thanks.

-- 
~Randy

