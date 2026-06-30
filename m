Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174E7263F5E;
	Tue, 30 Jun 2026 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810050; cv=none; b=ohOYgwOaaWai2RzgSz7e72DTxvcNoK+L9vljDAnhbOpEC/HUDKRNQOKDWOAtXrprDCMvtjK/B7C8MSe3HwKUogTZHGBVtvXHJ4L6mDLm4oa/LYq71luIr1kHjIvHJ8IxCz88oSuz8viojp0nBlvlH1I9PcaAn4e336poCtdMAKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810050; c=relaxed/simple;
	bh=xTCK+xgR/NHb3bGYsSKbmSTDJvTZ7/vWpMmTEy+wkF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3akr8Bpna4ezE4vOflFk/No9FpHyHwk/vQJEttb5lfHzhP+BsQ5nXqASFQZIRHeQLXoFRPvKhkGXFAO5EFjwX2vX1Ztr35razfY4KqIlPBtqbXsqEOiBoD05qd7zeeDzMQeI9mZaz4YhQ3roZxqRc7lCRN7Kiz8FJLnmu2k5Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTLvXJTo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTLvXJTo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149B81F00A3A;
	Tue, 30 Jun 2026 09:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782810048;
	bh=+Z6croAS1WxiU2hzcBBPVEzURpznCqERL+LYfJKT2H0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eTLvXJToXC3YRWDuGnonUWWg+/QZE2ZTUSrBQBY4Y4B1W4y9pKr0ur7EbR7JASkv2
	 HYxoy8G3+11n8YdQongDq3a9+xe1WPWSy7xsPKhzK2iA0gJhZ6B+zY6cGTMgkGSFb/
	 A2VQklQ2Xr5LLkHF8AVV3b6cZzJi3FvBr8r1IL7r2wgZbuMJeshZMCZkphy45tvYJa
	 f4RzhyZqvxMQ+xuJ3JVzl9G+jGasde8OtaXrDQ07pDP568baQ2VeAWNVh/LX9H8Qpw
	 LO8MJUEbsH5YpbbOTK6+myVuR1iENAseMbEskt/yLrr0QymkKoKQ8D9dVyJgooIK0c
	 BgPDD80YCT+Ig==
Message-ID: <743a2748-a458-4e65-a1d2-f54a6657e7a6@kernel.org>
Date: Tue, 30 Jun 2026 18:00:46 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: sata_dwc_460ex: use platform_get_irq()
To: Rosen Penev <rosenp@gmail.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
References: <20260628230310.1214770-1-rosenp@gmail.com>
 <akNzEGgiYC5V3rtc@ryzen> <9327f32a-5037-477c-80dc-f99b97ed9740@kernel.org>
 <DF85BCA7-B344-4AD6-8F6B-22CB3A3DF823@kernel.org>
 <CAKxU2N8uWY3k3nHTmdxEn86zEZ_hGJgyPvHWuHt=zRaPk-29kg@mail.gmail.com>
 <CAKxU2N_2N0YWBrF1k82qXCYYyvZxa26GYi09xiyKbBAtUoC_mA@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAKxU2N_2N0YWBrF1k82qXCYYyvZxa26GYi09xiyKbBAtUoC_mA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/26 17:52, Rosen Penev wrote:
>>> Inside ifdef, that is probably why Sashiko did not catch this new warning.
>>>
>>> Rosen, I suggest that you use dev->of_node directly within the ifdef, and drop the local np variable.
>> device_property_present is probably better. But yeah. I'll whip up a v2.
> thinking about this some more. Should use IS_ENABLED to prevent hiding
> this code from the compiler.

What code are you talking about ?
What is in the #ifdef CONFIG_SATA_DWC_OLD_DMA ?
CONFIG_SATA_DWC_OLD_DMA is determined automatically by Kconfig. So this is not
hidding anything and why I did not see the warning in my compile tests
(CONFIG_SATA_DWC_OLD_DMA was enabled for me). The report was for Sparc, and
CONFIG_SATA_DWC_OLD_DMA was disabled so the unused variable warning showed up.


-- 
Damien Le Moal
Western Digital Research
