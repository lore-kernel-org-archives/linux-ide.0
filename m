Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4132D248D
	for <linux-ide@vger.kernel.org>; Tue, 18 Nov 2025 20:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763496502; cv=none; b=VS4eVCWnFXevVA1pFPZT5hKQLDWiGO+IOoZJM4koTtobZ26fYZdD5CQHXrpuoHAr67yK//4yg8E1IRV8fylf0xHbebEuP0O2L9VwY9gc0LzzUlBZ16Q1aY9Ip2/AxhHhtI3LBS2TYH0NINIZhP86OoMQL0KiX5ZfD/QI1ofe8wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763496502; c=relaxed/simple;
	bh=rE8/7ushdJRiikEpNZke2aSt/DIK3wp/EcW1JKWIIzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAbY3mrm5zu1jta3zXv4sBGRRy0Yr0uq9PJFN4Ninxy24cjz7MfYrotOymRFOyXwAhD38Ye4wKjJIlM5gGhwMB4pZR3iz3aiNDbDKgA9/B/rdUCDrfEU+BeVViHiyiLb0/HqYdPk4/jC9pY6cQPqj7QRfOrGgVAJ1U/u4tiqoY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oV2fOwof; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oV2fOwof"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4431FC116D0;
	Tue, 18 Nov 2025 20:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763496501;
	bh=rE8/7ushdJRiikEpNZke2aSt/DIK3wp/EcW1JKWIIzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oV2fOwofkGUliMcIuqZyoRZtWPTh9aVSXGnm50H99SCPoJvV/d8h14bATjXH81AJS
	 v6x6J38uFN9xgNs2Qun1kYlYq2/cmuZSnTScEpsoQ6S3guHLhLA2AaZJijAaR57Jun
	 TrlxTzOYpWwbMe1o4Ym8Y8qCdRCN1MszxTM9Q2szbe5TQxQ6e70WP+lGm3Pi5yJlcA
	 k/k+WciLUYYB9fmKOzZm/3KXD3hLf1iaHmAvV78EozS696l/EsPtSjiP9CirwRALeE
	 f1ZnoKjIOV4WHpmi+dQL4mWEs+sBJ4lN3EJp43IFnaABuHgIhCNNVzUVu8lxFHNKvF
	 lkYFtbyhO67XA==
Date: Tue, 18 Nov 2025 21:08:17 +0100
From: Niklas Cassel <cassel@kernel.org>
To: =?utf-8?B?UmVuw6k=?= Rebe <rene@exactco.de>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH V2] ata: pata_pcmcia: Add Iomega Clik! PCMCIA ATA/ATAPI
 Adapter
Message-ID: <aRzSMYp-i4RDYl-l@ryzen>
References: <20251118.174654.1384716262322584447.rene@exactco.de>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251118.174654.1384716262322584447.rene@exactco.de>

On Tue, Nov 18, 2025 at 05:46:54PM +0100, René Rebe wrote:
> Add Iomega Clik! "PCMCIA ATA/ATAPI Adapter" ID to pata_pcmcia.
> 
> Signed-off-by: René Rebe <rene@exactco.de>
> ---
> v2: style and sorted
> ---
>  drivers/ata/pata_pcmcia.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
> index cf3810933a27..caefcd8c4b3c 100644
> --- a/drivers/ata/pata_pcmcia.c
> +++ b/drivers/ata/pata_pcmcia.c
> @@ -344,6 +344,7 @@ static const struct pcmcia_device_id pcmcia_devices[] = {
>  	PCMCIA_DEVICE_PROD_ID2("NinjaATA-", 0xebe0bd79),
>  	PCMCIA_DEVICE_PROD_ID12("PCMCIA", "CD-ROM", 0x281f1c5d, 0x66536591),
>  	PCMCIA_DEVICE_PROD_ID12("PCMCIA", "PnPIDE", 0x281f1c5d, 0x0c694728),
> +	PCMCIA_DEVICE_PROD_ID2("PCMCIA ATA/ATAPI Adapter", 0x888d7b73),

Don't we want Iomega somewhere in the name here?


Kind regards,
Niklas
