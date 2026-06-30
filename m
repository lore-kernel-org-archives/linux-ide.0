Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116D637A498;
	Tue, 30 Jun 2026 09:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810390; cv=none; b=fWZvaSJfF2Ye66czbhh1g3NgnOMvS91vxsN7jh0ergJB7tTwLy8cf+b5G+iXo/fxECr5Uak9ibEIGV//xnkubzgFq7IWTG/N9rMU2zLnuvzvOkx7ymq7iXrb2a/djT12HjNKpDGdGAkdnkGNMcOcC1ixgSKwzxudIjGt+/kOJKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810390; c=relaxed/simple;
	bh=ESNR9GJwfIAWzMjTVDMKsZBFP80+4wFCuLUKhrT2250=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqAdI0Vppa4zAJ3X/wcvtHP4EIwCvl6Aaz+zAf3DMM7sYt+qWlZpSBRvXB+gJhXBoRtSf5yPJbUAY8i1gl0U/Er++Q0FQ8vFVXlxHf3QMyXoGYUew3wVsj2+/6Ic+9S6cdEuz+Wshdn88R0focDmDYdXLvvQMHWfkHSFgng/if4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ainyuAJJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ainyuAJJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8551F000E9;
	Tue, 30 Jun 2026 09:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782810388;
	bh=yNuzH6Duh1YP5j8K2SIeniXw5q17e0Yz2Asf4rP1qBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ainyuAJJs7sdjD1Criulw4nNo+bRk1vVcyX4F1yY7q7mNX46hSJzainOFqxl8H1wt
	 hvt+DXOW7lw+5bAQWXh+mWuaMGpaGnruj7p5AJePT8nXoxmQxSLvrAzwQBrU7+llI1
	 sJpPsjuFpPN/KQS0TL2BamYVKX2DI3UiAMKdWadvg6M3FJ5Ojsbjq6OCeWB8gFlw9x
	 Z3Vgf2aC1MC0e9sOyuaW6muWnHaIk6HSTVznZqPQMdK0ojc6qQrW/NsyZH1+BIWlbl
	 Go+MABHj1xZmrlRiSjO4qJaJvXZX3tjUTXYTOaKH+rSmqKOSHyyfhrGVPrcEqiMIi6
	 4qiW+qnZZnjUQ==
Date: Tue, 30 Jun 2026 11:06:24 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ata: sata_dwc_460ex: use platform_get_irq()
Message-ID: <akOHEDdu3zw9Uhph@ryzen>
References: <20260628230310.1214770-1-rosenp@gmail.com>
 <akNzEGgiYC5V3rtc@ryzen>
 <9327f32a-5037-477c-80dc-f99b97ed9740@kernel.org>
 <DF85BCA7-B344-4AD6-8F6B-22CB3A3DF823@kernel.org>
 <CAKxU2N8uWY3k3nHTmdxEn86zEZ_hGJgyPvHWuHt=zRaPk-29kg@mail.gmail.com>
 <CAKxU2N_2N0YWBrF1k82qXCYYyvZxa26GYi09xiyKbBAtUoC_mA@mail.gmail.com>
 <743a2748-a458-4e65-a1d2-f54a6657e7a6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <743a2748-a458-4e65-a1d2-f54a6657e7a6@kernel.org>

On Tue, Jun 30, 2026 at 06:00:46PM +0900, Damien Le Moal wrote:
> On 6/30/26 17:52, Rosen Penev wrote:
> >>> Inside ifdef, that is probably why Sashiko did not catch this new warning.
> >>>
> >>> Rosen, I suggest that you use dev->of_node directly within the ifdef, and drop the local np variable.
> >> device_property_present is probably better. But yeah. I'll whip up a v2.
> > thinking about this some more. Should use IS_ENABLED to prevent hiding
> > this code from the compiler.
> 
> What code are you talking about ?
> What is in the #ifdef CONFIG_SATA_DWC_OLD_DMA ?
> CONFIG_SATA_DWC_OLD_DMA is determined automatically by Kconfig. So this is not
> hidding anything and why I did not see the warning in my compile tests
> (CONFIG_SATA_DWC_OLD_DMA was enabled for me). The report was for Sparc, and
> CONFIG_SATA_DWC_OLD_DMA was disabled so the unused variable warning showed up.

I think he means: keep the local np variable,
and replace the #ifdef with
if (IS_ENABLED(CONFIG_SATA_DWC_OLD_DMA) && !of_property_present(np, "dmas")) {


I think it will work for both CONFIG_SATA_DWC_OLD_DMA=y and
CONFIG_SATA_DWC_OLD_DMA=n without giving any warnings.



Kind regards,
Niklas
