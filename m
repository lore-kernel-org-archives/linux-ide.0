Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627721DF980
	for <linux-ide@vger.kernel.org>; Fri, 13 Mar 2026 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773387460; cv=none; b=UvfIqkbSxO+erdOYrbD+3+vqx5WLh60bMgJrbR3lmU7t/qSuO12FvbvvdeSqdJEOCnwrUbv5HY4y7BbZcwOjiiXSID0qGPKG2frH6iTJ5+BwsXyf2jGkhti+l+/qsmY1tShrrNEAeI9RN0zMdWYy7dex+KnktdTW891ZE4xmvy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773387460; c=relaxed/simple;
	bh=v0Eiv0Y+BnZHzsp2eZdn4OgIYITIaM+mBrNJzeeKRA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h0yUMPGGmGl5j1HqMg/4DT8VOCHpWvG9ROgNO0D/LwXqBsXIUuyfBPBQVCSecqowCqkIaXJZMw036604gKnTbHs/d/kGMXSoL4+GY3p17v9zNaZ1i5V3HYEthReTpO6nuAaFZDSzMHxTg4dB2hGiBsnZ2vRoumBTJ+/PCBoDU/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCeZCE/C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCeZCE/C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD856C19421;
	Fri, 13 Mar 2026 07:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773387460;
	bh=v0Eiv0Y+BnZHzsp2eZdn4OgIYITIaM+mBrNJzeeKRA8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=VCeZCE/CyVy/0W8RXcJwD0FudoT3017K+dg6IAOk3jd3AhRUVJi03vJqYHS9cTXWy
	 Cvp80aAyRwrIytlkkhu2UUs+EjUk03bDistr0BS6cF76Xbaj42HG8z6e75B6cp7p7R
	 U1sKyeqAnLzTbq69hBGHaNhPM3sc77sdq6e9I7zBG9ZFUBw8RzgOmSB/LCmZKBCeIS
	 z8IGUKVtGUGJOI9Eq9O03AQe7wxiSlkURt1hnXXNABnwM89OleZ8iLhbFaBj4kkNbf
	 G+QbFw4lhzpAJfFIMRvvX6CsjIBHAnCQLWTtgslZY5evLVRlVvS9M66GTxIwppJFhN
	 1MhopNCgiZ8Pg==
Message-ID: <d3ab269c-697d-4768-b7c7-61d0beed3879@kernel.org>
Date: Fri, 13 Mar 2026 16:37:37 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] libata/AHCI: ADATA SU680 on Dell Vostro 15 3510 shows
 repeated FPDMA timeouts, ATA bus errors, hard link resets, GPT/metadata
 instability, and SMART reset-counter inflation unless link power management
 is forced to max_performance
To: Mohammad Khaled Bayan <mhd.khaled.bayan@gmail.com>,
 linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
References: <CABn6530JJUe5vYA9f-TBY9fgi-wacqNriVPeiKD0EfYQ+ZPi0A@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CABn6530JJUe5vYA9f-TBY9fgi-wacqNriVPeiKD0EfYQ+ZPi0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/26 10:38, Mohammad Khaled Bayan wrote:
> Hello,
> 
> A reproducible storage issue has been observed on a Dell Vostro 15
> 3510 using an ADATA SU680 1TB SATA SSD as the Ubuntu/Linux system
> disk.
> 
> Hardware / environment:
> - Laptop: Dell Vostro 15 3510
> - Affected disk: ADATA SU680 1TB SATA SSD
> - Firmware: VE1R910D

Please send the exact model string reported by "hdparm -I".
We need to quirk this device with ATA_QUIRK_NOLPM.
Such patch is rather simple. You can send it if you like and we'll apply.
Look in drivers/ata/libata-core.c for similar quirk cases.

-- 
Damien Le Moal
Western Digital Research
