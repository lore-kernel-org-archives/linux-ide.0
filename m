Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1579533D6;
	Thu,  2 Jul 2026 02:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782957773; cv=none; b=tzU2jA2EfKpQrIkuKPh0Bm0+0b5S/U7Tpn6LuXoAE//rgoj5xfrwJO4lf9ruT+JEl2ng/YmlmlUTqfsXAheS6Z19mWj11ph8lW0WbmndkXD6xS/d9gziC/UTKP4BQcpsLozRE6xiTQzX2jR94/3GsT9rQDcWXnA9LiofhY1PZYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782957773; c=relaxed/simple;
	bh=EVhcObEECHTjAeVYmHE+vPVc2mAyf49zpo3beYu8aMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HYZFrrSNg5Ndq60PInaVlLRxkXDaI84JyVriq8VaBgaGVRPNY3d4hnCYa/Yh0F3nBYVPppw3I05Hc2ld0/K9FDDliDrfEpDtSLDYzPuL8/3jCEYE0mNb0/cGBDaYBc5gjDjJSPfblWogdYBWb6dUGdtGTqairAY6qcEiGfb6hT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJndfuqT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJndfuqT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A59D1F000E9;
	Thu,  2 Jul 2026 02:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782957772;
	bh=N6QdvP25qfvZrufRAvYCnW3j+yy6X+IASdCTsh9x5AM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RJndfuqTVBc700G3+nDF2gtuYTJPMhg1cRDCk7r49YoUHOxOfuZm5NRkqudpq1Hjd
	 UxkmzO/qABHx/UiLWj+jgnUlLGkz4nXQ2ogW0vdGjvqlZ612c5WHbAQ0fxCExz77ZV
	 WjkHijQm0xBnYS9HmeEGP541bsqHpCiaKzP79vqeT2A/K0hmYl8OkBQ2NGEB4OEF2p
	 1H24TMRAqC4CnsqUZLbQ5Bx2joxf4BgRvugAIBwj1t+OhSETtkernWOXDCxS5uoEyR
	 p/HjLo0zngngyahYP2R2PqAp0+6a1FITxxqFDB5N6SkQFxD+oupDPkXkFcV3hNGx+Q
	 BLNM5U7G3m/Kw==
Message-ID: <5eb27fed-607b-4f86-ac55-e2eb99a00ec0@kernel.org>
Date: Thu, 2 Jul 2026 11:02:50 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/8] ata: sata_dwc_460ex: cleanups and interrupt
 ordering fix
To: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260702000350.68331-1-rosenp@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260702000350.68331-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/26 09:03, Rosen Penev wrote:
> This series modernizes the sata_dwc_460ex driver by replacing legacy OF
> APIs with their modern device-property and platform-device counterparts,
> converting old DMA resource teardown to devm-managed cleanup, fixing a
> latent interrupt-ordering bug, and dropping a redundant stack copy of
> port_info.
> 
> Patch 4 fixes a real issue: sata_dwc_enable_interrupts() was called
> before the IRQ handler was registered, so a probe failure or an
> asserted interrupt could trigger an unhandled irq storm.
> 
> v2: sashiko fixes.

Several patches in this series are clearly bug fixes that should come first in
the series and have a fixes tag and cc-stable. Can you please reorganize the
series with the fixes first ?

Also please try to avoid growing the patch series with more patches in response
to sachiko "not introduced by this patch" comments on valid problems. Send
incremental patches instead. Otherwise, making progress will take a longer time,
and bigger series are harder to review.

> 
> Rosen Penev (8):
>   ata: sata_dwc_460ex: use device_property_present()
>   ata: sata_dwc_460ex: use platform_get_irq()
>   ata: sata_dwc_460ex: enable SATA interrupts only after IRQ handler is
>     registered
>   ata: sata_dwc_460ex: drop redundant struct copy of port_info
>   ata: sata_dwc_460ex: fix data race on hsdev->sactive_issued in
>     interrupt handler
>   ata: sata_dwc_460ex: disable SATA interrupts on device removal
>   ata: sata_dwc_460ex: fix PHY lifecycle ordering on device removal
>   ata: sata_dwc_460ex: use devm for old DMA resource lifetime management
> 
>  drivers/ata/sata_dwc_460ex.c | 99 ++++++++++++++++++------------------
>  1 file changed, 49 insertions(+), 50 deletions(-)
> 
> --
> 2.55.0
> 


-- 
Damien Le Moal
Western Digital Research
