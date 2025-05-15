Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6851BC4E
	for <linux-ide@vger.kernel.org>; Thu, 15 May 2025 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314296; cv=none; b=jhbqZ/TGYcMknGHjIxloOr1w7SrsdJ7wOf1Yx9LryJx/N0+9gVb2WB9fyqOX/DeY3uYlDzR/biRi4/POAMJAOz0gW3IFipDitcWW2ae7Xn10wEIrZOsN40YGsbKgbRo37q1ySGU7sG9VutBSpcBMwJiaTU2+AN4M1gHStQ8ZW2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314296; c=relaxed/simple;
	bh=Y/sZy78IJ4fyo/Kk6rg3B6JOYyf7DqbwnuuOQtXQS7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sRhAt2yDX1q6bOJHHVmOI3oRs2ZYCMecQ8+Vi2UU6v6IvSPaAGOiFJFMTFI6YqQEqvM/LFFDISQ79WsyHfUsN+LK/gP/PTdmfTohGh4KlwLtghQjdBatDUZnRTQeHBoh9w2iU0AjhA+CkU4sdn1wd51y/0Yi/4E9iUFKkYpu2JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHhHaI/Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHhHaI/Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E39C4CEE7;
	Thu, 15 May 2025 13:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747314294;
	bh=Y/sZy78IJ4fyo/Kk6rg3B6JOYyf7DqbwnuuOQtXQS7g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eHhHaI/YdiHzTBd8iL2+6Jx57XjaruYoje3hb7hbb4EHW3G7h1Yq++IIpp23Gs824
	 stL/6z+RwoJ/eVDeZ7D5mcjEWuqDS4qg1R1xi5feK9Z6XfSZvpOUiNVWaK8ZAngkvx
	 p5WEiR2baf8PJDwifAFq6k9Yk0YF9Uu++fCVgV7gWiRoWb9qJSZ7/CDfBiq/NedhK/
	 aj4ROllpetW5Opr5AjCENWYZRoeT1fdiF+rc0bZo9Nik4e6vvyVBy2QCaqLuthlwzf
	 MZ1fR1BwF6Uqd52fN58PVVaf53p4ed3NX4LIgcnEXOberlo/J1KsuJ9H1SM4gjkcmO
	 huvLrQR+JtAGg==
Message-ID: <2626af3e-4438-4440-89e5-43d337672f5f@kernel.org>
Date: Thu, 15 May 2025 15:04:50 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] ata: libata-eh: Always disable DIPM before calling
 set_lpm() callback
To: Niklas Cassel <cassel@kernel.org>
Cc: Mikko Korhonen <mjkorhon@gmail.com>, linux-ide@vger.kernel.org
References: <20250514172210.383801-9-cassel@kernel.org>
 <20250514172210.383801-16-cassel@kernel.org>
 <840a1671-997f-45e4-af25-03f702bad237@kernel.org> <aCXlQshOdNa96Js3@ryzen>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <aCXlQshOdNa96Js3@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/25 14:59, Niklas Cassel wrote:
> On Thu, May 15, 2025 at 02:42:17PM +0200, Damien Le Moal wrote:
>> On 5/14/25 19:22, Niklas Cassel wrote:
>>> The current code performs a SET FEATURES command to disable DIPM if
>>> policy < ATA_LPM_MED_POWER_WITH_DIPM, this means that it will disable
>>> DIPM for policies:
>>> ATA_LPM_UNKNOWN, ATA_LPM_MAX_POWER, ATA_LPM_MED_POWER
>>> (but not for policy ATA_LPM_MED_POWER_WITH_DIPM).
>>
>> [...]
>>
>>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>>> index 91d97d98eed1..1727248f135d 100644
>>> --- a/drivers/ata/libata-eh.c
>>> +++ b/drivers/ata/libata-eh.c
>>> @@ -3473,7 +3473,7 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
>>>  			hints &= ~ATA_LPM_HIPM;
>>>  
>>>  		/* disable DIPM before changing link config */
>>> -		if (policy < ATA_LPM_MED_POWER_WITH_DIPM && dev_has_dipm) {
>>> +		if (dev_has_dipm) {
>>
>> This changes the same line that patch 6 changed... Can you squash these patches
>> together ?
> 
> It is two separate logical changes, so squashing them seems wrong IMO.

Hmm... Given that the same line is changed, I would prefer a single patch. But OK.

-- 
Damien Le Moal
Western Digital Research
