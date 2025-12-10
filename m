Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A6726529A
	for <linux-ide@vger.kernel.org>; Wed, 10 Dec 2025 04:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765341003; cv=none; b=MzGSOikTKFEzF5pRj00SZiT71s3uZ+1eakIGJlJNS92qehxPjLASQuLeN0DM/95ay/Mx9zaCR9QobuUYzWEtcaiEtA1RgYXgHAJD/J+LslVX3W9EOCH5nrFBugqJZGxq6ix/o9RYzxX1kf3RQzb41iJ6qazOrGlrp8ubF/aC86k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765341003; c=relaxed/simple;
	bh=uJROTeQQ5kB007x9eWZhUQgLJCSS5lE0PdD8azqTuLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/6AiJ9UICZqah9k0R7ADdQRROuIC4xMbu3r+dxqa+0TRqzwv5YfyYcGUdQsUBRoTKCV9DD0a1Bt3eho2VWsSpSy27UjixP0HdkSCxGMcHyVsz1gA8Z/dvu0W38q39zishlPwyJeFccCmFFruNx0QFt+7LDqpvzDDdY3At5EzdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/UKLGS7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/UKLGS7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A84EC4CEF1;
	Wed, 10 Dec 2025 04:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765341001;
	bh=uJROTeQQ5kB007x9eWZhUQgLJCSS5lE0PdD8azqTuLM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n/UKLGS7oZ13e5HHY9eDWarmkZ/Eh8E3bopXa361B9x8ax73HjjO4C0IFFXjPBAFk
	 xSvA5SPj3UddkbGqaCBYoGDtlykQW4WlASdPdM846pueKhs0HYn9mdL/54TmO/eJaq
	 KJNdRxPqJnuyA8AQJI7S60Be1e+Z4K/ycG7TkFmIF0DOfMSvOUAx/rrazAFbnZxdpo
	 FSGAjAb6/OkyOvHFuCapR2L508bp6NUFkO0jHVEt20JE4mn4KN+/Usgw6HxZQaxbzh
	 vY4Y/CN8I82b3TMddeJJig1mOrQwJnvg6sv0LCo+qyJoouVy+7Xfz4TGDP1Vlge4zo
	 jRUoJIlr+oG9Q==
Message-ID: <66ea31a4-0ae2-4ada-b253-224cc4ae596b@kernel.org>
Date: Tue, 9 Dec 2025 20:30:01 -0800
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Disable LPM on ST2000DM008-2FR102
To: Niklas Cassel <cassel@kernel.org>
Cc: Emerson Pinter <e@pinter.dev>, linux-ide@vger.kernel.org
References: <20251209042359.1467124-2-cassel@kernel.org>
 <de7c9e53-b153-4e29-a841-99802cabf44b@kernel.org>
 <aTja9mQwpjAJqrFd@dhcp-10-89-81-223>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aTja9mQwpjAJqrFd@dhcp-10-89-81-223>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/12/09 18:29, Niklas Cassel wrote:
> On Tue, Dec 09, 2025 at 05:42:37PM -0800, Damien Le Moal wrote:
>> On 2025/12/08 20:24, Niklas Cassel wrote:
>>> According to a user report, the ST2000DM008-2FR102 has problems with LPM.
>>>
>>> Reported-by: Emerson Pinter <e@pinter.dev>
>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220693
>>> Signed-off-by: Niklas Cassel <cassel@kernel.org>
>>> ---
>>>  drivers/ata/libata-core.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>> index b96105481784..94c0e0ff981f 100644
>>> --- a/drivers/ata/libata-core.c
>>> +++ b/drivers/ata/libata-core.c
>>> @@ -4187,6 +4187,9 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
>>>  						ATA_QUIRK_NOLPM },
>>>  	{ "VB0250EAVER",	"HPG7",		ATA_QUIRK_BROKEN_FPDMA_AA },
>>>  
>>> +	/* ST disks with LPM issues */
>>
>> s/ST/Seagate
>>
>> Other than that, looks good.
> 
> Perhaps you can fix up while applying?

OK. Will do.


-- 
Damien Le Moal
Western Digital Research
