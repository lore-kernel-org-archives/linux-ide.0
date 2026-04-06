Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6192030A;
	Mon,  6 Apr 2026 07:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775460636; cv=none; b=Vq4v2uOGu9KG3gm5O33MNd73r8X1GwKjPkXOPIvC0InN9uyhCxUMfuO+pQzovwiM7/i+UIggbilMdA/Ri4kvED2sGev4QI1oTsfW+HHiQozBZb026hztbJEdCVg6FlVPXo07jCsuU3c+roMIon0FNLzv5iLb0PCnWPHOxPFfRR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775460636; c=relaxed/simple;
	bh=U+nbissSvvOO3VCP2qo9/CsMlLZXa9Ov4eJ7ZhvkHcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RvaUD9+/tlL5jPMU6hWwbp4vlcKLSL8omGWZUVeXfzi/bPT1AfuXy8P7sofykEeSrIIUQ2oBGCinXNnRCr5ALAxt/okC63uQaL2WB1oMAF3Lsy/9UdtLy0gEtSTSDBIPG7/IwTukLeswyhuO+GDQFE9cbFz97j5GLF2qXblz99U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaTyWcvc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaTyWcvc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983C9C4CEF7;
	Mon,  6 Apr 2026 07:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775460636;
	bh=U+nbissSvvOO3VCP2qo9/CsMlLZXa9Ov4eJ7ZhvkHcg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JaTyWcvccXWxsvClQ+TpJ0gVmq2uP52yX0AZajvAuH91K6GzTYR2kbcMeE25tikiy
	 ZB5BS5CrN8S5mAYAWA28C4LbYEPKqTvHFN118ZapG0noJ2KYx+iB0s86uhc0wtT4c5
	 UZDs1aBt6/+puXrIz/IaXJT57D0ZvuI++8m67KpNwAL4zQWIooP1uBIoL6cdrfJxtz
	 8J9q0U7rgOIehtNlQWNAJthbAxJmPrzhMoZkCT6ZZKWrpWnLQGiuMIF9ZnQmmNU3jh
	 bhi4W+hgBCZjATEvhVxCiJaVxes2OIYBcKJH204nA4A9a4Rrt3r/sG0YnqlNVl1GNp
	 nRvy9dWrJFrHg==
Message-ID: <73386b55-933f-42b3-b566-e9f4e3ea001d@kernel.org>
Date: Mon, 6 Apr 2026 09:30:34 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ata: ahci: regression in f7870e8d345c disables DevSleep for
 ACS-5 drives on PSC=0/SSC=0/SDS=1 controllers
To: Patrick Zima <pz.102010@gmail.com>, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <1350BE53-13DB-4250-B323-7FBA335583BB@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <1350BE53-13DB-4250-B323-7FBA335583BB@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/04/05 21:01, Patrick Zima wrote:
> Commit f7870e8d345c ("ata: ahci: Disable DIPM if host lacks support") introduced
>   a regression: it disables DIPM — and thereby DevSleep — on drives behind AHCI
>   controllers that have CAP.PSC=0 and CAP.SSC=0 but CAP2.SDS=1 (DevSleep capable).
>   The guard condition is too broad; it treats the absence of Partial/Slumber state
>   bits as grounds to disable DIPM, but DevSleep does not depend on Partial or
>   Slumber being exposed to the OS — only on SDS=1 in CAP2.
> 
>   --- The logic flaw ---
> 
>   The new code (simplified):
> 
>     if (!(cap & HOST_CAP_PART) || !(cap & HOST_CAP_SSC))
>         set ATA_FLAG_NO_DIPM on port
>         → SETFEATURES DISABLE DIPM to all drives with word 78 bit 3 set
> 
>   On a controller with PSC=0, SSC=0 but SDS=1, this fires unconditionally,
>   even though the controller is fully capable of negotiating DevSleep.
>   The flag ATA_FLAG_NO_DIPM then also suppresses ALPM port behaviour at the
>   kernel level — re-enabling DIPM at the drive level via SETFEATURES after the
>   fact does not restore DevSleep.
> 
>   --- Suggested fix ---
> 
>   Gate the DIPM-disable path on the absence of DevSleep support:
> 
>     if (!(cap & HOST_CAP_PART) && !(cap & HOST_CAP_SSC)
>   +     && !(cap2 & HOST_CAP2_SDS)
>         && (ap->flags & ATA_FLAG_DIPM)) {
> 
>   If the controller can do DevSleep (SDS=1), there is no reason to disable
>   DIPM — the power state sequence Active → DevSleep does not require Partial
>   or Slumber to be present.

Instead of sending what looks like an AI generated report, what about you
actually generate a proper patch from the suggested fix and test it ? And send
said patch if the suggested fix works ?


-- 
Damien Le Moal
Western Digital Research
