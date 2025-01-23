Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAAC70817
	for <linux-ide@vger.kernel.org>; Thu, 23 Jan 2025 04:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737606070; cv=none; b=HyvttzC4osDoJ5lkB9Kz7P8biO3vWymJOwFKOYDuVOvpGNfZkjWLMB2qgxcqNlYRoILyY1M/vYsK5UkW0g4g31IOT/7NzyL/O8Pmz7mnaKNO+OW5KAUKN4b5NbNgeTam7rusGYguFWP7wMPdxPUmlE9Orew5+HqZDlyUikmuvAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737606070; c=relaxed/simple;
	bh=383mpZ7Anm3kYH2ghmKP8yod34sKn51dfM2yzatZFyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U97Ir3+Mri0xXpAjnyV5KBwbR5RS0cIf3w2evLrxu8cXpdAndoSU0PyvTCBP9BA39PbDAvBLszLNz7SBIIuXCF7VExwVAt+WMsChPeAKcVLc0HzRMRE/KjYh4P/H8/AmQvJU31+KBO4Qwo9G65SbQ+6EiTJ6JxwGrVBsMZ+NUdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfDHYqYh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfDHYqYh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E63C4CED3;
	Thu, 23 Jan 2025 04:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737606069;
	bh=383mpZ7Anm3kYH2ghmKP8yod34sKn51dfM2yzatZFyo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NfDHYqYhqnhRiXboaulRNB61GlGxlwCBiHi/aI1+Ry+wikIE/y5n7XvvfWzGA1udI
	 Yrdu5QSS1xt8U2Mm2WLN/tIrVoEoUDyTQzI1UQRiq6TRbjZXBLqE6A3pRH5JPD5UNK
	 OPPUe6slUVeLe7wIc6MT34TSuOMvKqGvIqYMG8VK5lCvMPqHVfkU67+DccaqJPM4ny
	 qV3/s18VAa+fe+wYZEd43w3XU7M0aP5JHp7gTvEropcOIR39uocYBnlWdmxycTcx5V
	 jxcFdpLpV+wL3V5BfRKzVSDRURr+aA8FHbzGd9DQUB7nvAvnEp08swMH90O9SwINP6
	 QG+bpdLaplqRg==
Message-ID: <14ead38d-9a43-4b14-ac7f-7b0410b9cdfb@kernel.org>
Date: Thu, 23 Jan 2025 13:21:06 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Disabling link power-management on Samsung SSD 870 QVO
 drives to make them work.
To: daniel@debian.org, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <a421afd8-d841-4d3c-bfe9-9dee707bb319@debian.org>
 <Z45NEMKVAsxKvafa@ryzen> <ac64a484-022c-42a0-95bc-1520333b1536@debian.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ac64a484-022c-42a0-95bc-1520333b1536@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/21/25 12:08 AM, Daniel Baumann wrote:
> Hi Niklas,
> 
> On 1/20/25 14:18, Niklas Cassel wrote:
>>> I've added a new case for 870 QVO specifically as regular 870 don't have
>>> the issue.
>>
>> This should have been in the commit message.
> 
> thanks for the pointer, I have now adjusted the commit message.
> 
>> Out of curiosity, did you test on regular 870, so you know they are not
>> broken as well?
> 
> we don't have many of non-QVO variants, but so far none of them has
> needed it. I've added that to the commit message as well.
> 
>> You probably also want to add:
>> Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
>> Cc: stable@vger.kernel.org
> 
> added, thanks!
> 
> Updated patch attached.

For reference for future patches: please use "git send-email" to send patches.
Also please make sure to version the patches (git format-patch -vX ...) and add
changelog notes after the "---" at the end of the commit message and before the
first line of the patch content (in your case, the line
"drivers/ata/libata-core.c | 4 ++++")

Thank you.

-- 
Damien Le Moal
Western Digital Research
