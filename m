Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729B02206A7;
	Thu, 25 Jun 2026 01:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782349395; cv=none; b=qpsNkuu8oQXbu8p4QShmpI7Hbg27NQz2zOAyS/3dEJGTrULUR38ZtaeSQwV9VyUIIX9YYps/wZTWX3irEorEq32tIc2UGELg9JfT8uetuTtmVNShWojZfX2BbNlgXPsy/5CCc5aPx3qPxwuh3ty2d66MztR32GooGiVQ9dRGzPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782349395; c=relaxed/simple;
	bh=idyRKjVOFajGLe6gQSinUdIMD061GVticZYyNb2O0a8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFTRgVKpMNrIAlcvYWfZZj9rdydezh3qinbwIZG8Qt26AHGMJ7lkraqSOerIJSIluiD+h9XXXHbX5BmizFxAcI/oO+8hd3NLwkDYE8b4NIcefc7KAnX4hOmr2BuQHxE3iiL8EWpd6F3idAegYCtcqhr5ahZCu5oM5rANtbq1ULA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5bf6Hbw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5bf6Hbw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9384E1F000E9;
	Thu, 25 Jun 2026 01:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782349394;
	bh=prDeeNVcEdvethHA/8ofpledP5ono1+aN1XmpfkkNuo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=F5bf6Hbw2GyK/Y9XvN4hSFdnbzIg3x7+MaazISyt179gfEpzuD/XBEMdgSvL82q1j
	 Fdvk+3shPEMxar2SPkXtyoec3TTGXmOMp89DYakVmpWR+0SSC21pu+MX8Z5W/0m3Uy
	 Pyi12JJhy5DpBLD/S24rsEpitcbgyICkkgA/GBuQAxFu+yaZlDhGGJu5+S1ozj1GKt
	 tm4Vf7CkepxvEHCtbd+kT0+MRDswfYBSCwY9O+N0CAngD+4w2sItFXth2FWQc86iwP
	 Z4v9V8DObVhq1J0Vwx/zN8PdrSJ/VsJQ1k6EQ802mHbpS9d1VRjeFn+8P9zKY5MCfX
	 lQXnGj9ZKqOpg==
Message-ID: <1fdef0bb-c4cb-4baf-9f30-dac406a4c11d@kernel.org>
Date: Thu, 25 Jun 2026 10:03:05 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Add NOLPM quirk for PNY CS900 1TB SSD
To: hexlabsecurity@proton.me, Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <20260619-b4-disp-494070d2-v1-1-0c6d7be96237@proton.me>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260619-b4-disp-494070d2-v1-1-0c6d7be96237@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/26 11:54 AM, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> The PNY CS900 1TB SSD (Phison PS3111-S11, DRAM-less) drops off the bus
> after entering Device-Initiated Slumber during idle. With the default
> med_power_with_dipm policy the link goes down (SStatus 1 SControl 300)
> and does not recover, forcing the filesystem read-only. Forcing
> max_performance keeps the link stable across prolonged idle.
> 
> Add a NOLPM quirk so link power management is disabled for this drive
> specifically, leaving it intact for other devices on the host.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Applied to for-7.2-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research
