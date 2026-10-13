Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1E44F052F;
	Tue, 13 Oct 2026 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897910; cv=none; b=ceqAcwMAnIDaqOfPXI41jYr/l+uRKnSsqq7l8PVLhHsuAQpS1T548UkjD8Y1U4qx9f9uJ9tDSTUYmTh7YXqM9X/YfIUpU3U/+S3xp0ncacqHPSt8nHv/4pSh0BAEpa0hjvl6tUSt9kMq9MWwrr+wGYpyJ/pUCVDqIxrtG9Y+XEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897910; c=relaxed/simple;
	bh=faa77occ2ok3/jwqK/erXDwAC+1QtLnfvg0xNzVCxhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VTyVqFTt3gJOfkBqrxKRDM7pREs0vHfHdJ1GqINiOwf27LYLupBIzK55rqhSH7sXwLMYy1DzYzicuaFT1Zn8uw/GoosoyzMc3xWFUstmmYTZGLOatjyHVYN4ADYFlMaoOZBzhvHnmwO754nTNmMKAJd+Nfw6STpEuVlgIc3wJ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dcui7QKv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dcui7QKv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD1B1F000FF;
	Tue, 13 Oct 2026 13:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897908;
	bh=H3srekk9oU8SdjHCWPr+J18Ctzc9HvlZonIj2zSzGZg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Dcui7QKvfeaIgQIJdMbV4STgmbYq3hp2PPdYLdBqCp0coah+tKxK3Veip8a4NChgC
	 K0p87DekRVZHOhbUCsFv4kQXuyXetQg3KD3dvg8gLYIWt3wO2d1yLgz3zyvhrwChcN
	 7PUCjeqgQEHh6EJJoaTmwXJMCapx4TN3H4nhgtp//w0nFc773J2J6mxm+FfkWbZvUG
	 mm+uf7mG9V9tbUponr99PpTlo3HWCjOoKmT7C9VhCYpvz3RLZmC2qsAp+xlIn6snOm
	 cAYZFGOF1L8Qad7hItiiRbBHKXuUvg/j6Ja5Gm7jGCg1l2o7abxQVCMWjrJ4raW5cJ
	 EiifFF8MA2twA==
Message-ID: <abe9654f-c81d-427a-97ec-a9c4d4e18f74@kernel.org>
Date: Tue, 13 Oct 2026 15:25:05 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 47/53] MAINTAINERS: add an entry for the SGI IOC4 ATA
 driver
To: Imre Kaloz <kaloz@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lee Jones <lee@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 linux-ide@vger.kernel.org
References: <cover.1791890466.git.kaloz@kernel.org>
 <7e185e14e16f071b0850087e30f6cac4af85b1f1.1791890466.git.kaloz@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <7e185e14e16f071b0850087e30f6cac4af85b1f1.1791890466.git.kaloz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/13 15:17, Imre Kaloz wrote:
> Add an entry for drivers/ata/pata_sgiioc4.c, the libata driver for the
> IOC4 ATA/ATAPI controller.
> 
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a30c09a55c72..826f0ffb71fd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24925,6 +24925,12 @@ F:	include/linux/phylink.h
>  F:	include/linux/sfp.h
>  K:	phylink\.h|struct\s+phylink|\.phylink|>phylink_|phylink_(autoneg|clear|connect|create|destroy|disconnect|ethtool|helper|mac|mii|of|set|start|stop|test|validate)
>  
> +SGI IOC4 ATA DRIVER
> +M:	Imre Kaloz <kaloz@kernel.org>
> +L:	linux-ide@vger.kernel.org
> +S:	Maintained
> +F:	drivers/ata/pata_sgiioc4.c
> +
>  SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS
>  M:	D. Wythe <alibuda@linux.alibaba.com>
>  M:	Dust Li <dust.li@linux.alibaba.com>

Please squash this into patch 45.

Also, the cover letter mentions that patch 45-47 are for libata but I did not
receive patch 46. I only received the cover letter, and patches 45 and 47.

Are you planning to get all of this merged through the mips tree?

-- 
Damien Le Moal
Western Digital Research
