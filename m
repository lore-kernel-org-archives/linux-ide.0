Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F2D2343AB
	for <linux-ide@vger.kernel.org>; Wed, 21 May 2025 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747830111; cv=none; b=l9d+C5JFBxgYE+yhoNl5si2Tbtsk01KURFk4ZCWkHAEuZ6liwD79xlSf+EJUpgdai2eah/7hqNIdFJ88pRusV2e3PCqtntqeVZOcujf0GYb2BP6Rs4PTqc/HPaMkQcxGGpAB0Mg+/fz5qVRRBDb8gOY9MF39kSPBHStdZMnc/7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747830111; c=relaxed/simple;
	bh=bC7QZ3wmiWc58jV9DvUG11jhd6Jq/zeZkLj8Mq2O5ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XR7L4vsSSn3GPIwFALxA/jfQH1qJJOUWD7fCdXfjRpDIOz1b5feoB7InsPX16sl6qCX2Xjy3hewMIEkOYDJk7Vm4szZ244q5jhgKKjKQGG+17YYrNQQsBBb/6rVI+AaAQQ0kDKI17hV2kV51TbfCweiHi4AYWTWgsduKaKsGoWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHa47y3w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHa47y3w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6F2C4CEE4;
	Wed, 21 May 2025 12:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747830111;
	bh=bC7QZ3wmiWc58jV9DvUG11jhd6Jq/zeZkLj8Mq2O5ew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FHa47y3wmrLRIgwam9N0NfOHcsqC1QpTGgsGjeYw1KNVbo85+U1hmYiMRawkH0u31
	 LMETwPefRzaHkCONRqDo4RRfgbsdlX31ywWLK4z7cStOOzC7uqZ5xS+gjuFslFeoWP
	 u62XuIIOD49D+ydyHY5iqlz6nYH1rZrobXM58M+NXrMusWBaxlXnk/jfL3WJ9sybGJ
	 OhfMfxT4aatrisQ5yjBKdXeNPgA9D/T2xUiRMzPqsiBHOmWjKOFePjxjtAFEuSzJ76
	 NQ5YWJVoDpAVLWiGFV3kbQa79SrNF83fup6SyGXVZ/GqIfp756iTpzkRiL6BeMwpdt
	 sdv+vMnzKRFhw==
Message-ID: <135c9506-6924-48c9-8660-6a63797a70cc@kernel.org>
Date: Wed, 21 May 2025 14:21:47 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata-acpi: Do not assume 40 wire cable if no
 devices are enabled
To: Tasos Sahanidis <tasos@tasossah.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
References: <20250519085945.1399466-1-tasos@tasossah.com>
 <001a24b4-1f77-42db-91ad-462bc835e275@kernel.org>
 <920a533b-a881-4e26-9129-9e4499b13774@tasossah.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <920a533b-a881-4e26-9129-9e4499b13774@tasossah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/25 10:56, Tasos Sahanidis wrote:
> On 2025-05-20 12:29, Damien Le Moal wrote:
>> Nit: "it has been renamed" -> "it is renamed"
> 
> Will do.
> 
>>> @@ -530,13 +534,17 @@ int ata_acpi_cbl_80wire(struct ata_port *ap, const struct ata_acpi_gtm *gtm)
>>>  		xfer_mask = ata_acpi_gtm_xfermask(dev, gtm);
>>>  		ata_unpack_xfermask(xfer_mask, NULL, NULL, &udma_mask);
>>>  
>>> -		if (udma_mask & ~ATA_UDMA_MASK_40C)
>>> -			return 1;
>>> +		ret = ATA_CBL_PATA40;
>>> +
>>> +		if (udma_mask & ~ATA_UDMA_MASK_40C) {
>>> +			ret = ATA_CBL_PATA80;
>>
>> Please change this to "return ATA_CBL_PATA80;" and change the last return at the
>> end of the function to "return ATA_CBL_PATA40;". That will be cleaner.
>>
>> Other than these, this looks good.
>>
> 
> Apologies, but I am not sure I understand.
> 
> Wouldn't changing the last return to ATA_CBL_PATA40 undo the point of
> this change? The function must return ATA_CBL_PATA_UNK if the loop is
> never entered (no enabled devices).

Yes, my bad. That last return should return unknown.
Let me apply the patches and see how it looks. This is all cosmetic anyway.

> 
> If it does enter the loop but the mask hasn't matched at all after it
> has gone through all the devices, it must return ATA_CBL_PATA40, which
> is why there's the unconditional assignment ret = ATA_CBL_PATA40. If,
> however, there is at least one "80 wire device", the whole cable is
> considered 80 wire (thus the immediate break in the if).
> 
> I believe the most that can be done is:
> 
> if (udma_mask & ~ATA_UDMA_MASK_40C)
> 	return ATA_CBL_PATA80;
> 
> with the rest remaining the same. I opted for assignment + break there
> instead of return as it seemed more readable to me, and it's consistent.


-- 
Damien Le Moal
Western Digital Research
