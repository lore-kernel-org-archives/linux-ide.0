Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C43176AB5
	for <linux-ide@vger.kernel.org>; Wed,  9 Oct 2024 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728466718; cv=none; b=WeziNXSpq2m94zaLxVjU+NFpkN0tlIe29308EqmPpShBgMYvSCttecpjKwmExwhz6gV1DymFVLcfUM3yiZWVPJAMAQ+u9nppoOzjt6ZwTcEE6wPm1qaNSESTbWMAR0F/rftzjmiadMfcvZzSODst1+/IfeAI/IiNPCrrUWG7Yx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728466718; c=relaxed/simple;
	bh=QqXwP3jZvaFubC+fTACKgHyFJT3M47LGPFUQ5CA5f/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k28gfN3owWA6O775LkGU3p+teIAA+C9Sw8PgeeQ88dzl1JktYolKp12OOpsjZtkw71iHkKtqxdUg20jsBRc9cRDRYot9xIm2enFeVxLdi3Av7pqTcE4HD3pmeyVxiv/CkvrVpCG4T2dj0cHNo7pbetSl8m6S/5NaES8MYHa04Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9pTqaFY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9pTqaFY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EA9C4CEC5;
	Wed,  9 Oct 2024 09:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728466717;
	bh=QqXwP3jZvaFubC+fTACKgHyFJT3M47LGPFUQ5CA5f/s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s9pTqaFYNeguI1Sgdy8+bteUFOQ9HG+XVRx4czAt8NLOUeYhN5H7yd0kh1fIKDH8F
	 1pDGKo2V4dp5hznNCu0cQGHd/uUYq4fZJwEgnxhB1YzJcW6+jPqQoh5pDs2Aj3eeQw
	 Yy/YGFlf9KmZHAYIpT48otgbamOHzQ8gYbjevUZZBBgbGkYcz0iXL1zRjMStRm047A
	 rxO94t+UJdl9ygc4tBYw63ArxFRxVi69cOJHIiUSx/xw1HQ3mod89dg5zCNA936goK
	 ukfB3XugnSdK4hYtEpTUrtw6th0ye46cM+nYcxafYvoMBck7aXrlRPPr8LUp6YKWcd
	 WuqFt3+M9oPTg==
Message-ID: <1ed61e4d-300e-4f79-948a-5aa7dcc06a6d@kernel.org>
Date: Wed, 9 Oct 2024 18:38:36 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci_platform: Modify MAINTAINERS entry
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20241009081557.377035-1-dlemoal@kernel.org>
 <ZwZKW-KlUZR0UMDd@ryzen>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ZwZKW-KlUZR0UMDd@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/24 18:18, Niklas Cassel wrote:
> On Wed, Oct 09, 2024 at 05:15:57PM +0900, Damien Le Moal wrote:
>> Modify the MAINTAINERS entry for the ahci_platform driver (LIBATA SATA
>> AHCI PLATFORM devices support) to remove Jens as maintainer.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>  MAINTAINERS | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index c27f3190737f..d377e81ab2bc 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -12961,7 +12961,6 @@ F:	drivers/ata/sata_gemini.h
>>  
>>  LIBATA SATA AHCI PLATFORM devices support
>>  M:	Hans de Goede <hdegoede@redhat.com>
>> -M:	Jens Axboe <axboe@kernel.dk>
>>  L:	linux-ide@vger.kernel.org
>>  S:	Maintained
>>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> 
> This entry, and other "LIBATA XXX" entries still mention
> axboe/linux-block.git as the tree.
> 
> Another "LIBATA YYY" entry mentions dlemoal/libata.git as the tree.
> 
> Anothe "LIBATA ZZZ" entry has no tree defined at all.
> 
> 
> It would be nice if you could either:
> -Update all entries to use libata/linux.git as the tree
> or
> -Remove the defined tree for all entries except "LIBATA SUBSYSTEM".

OK. Let me do that.

> 
> 
> Kind regards,
> Niklas


-- 
Damien Le Moal
Western Digital Research
