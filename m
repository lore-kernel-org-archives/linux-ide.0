Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2E345D900;
	Thu, 15 Oct 2026 06:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792044864; cv=none; b=DHVW7VmA4KlyL09SbQrhyEoDO2onXmwS1W537UaJEc9p1Ubvo6xjggnlmcfziTyB4ozgPAd28tXFVfs2xfa2UmUEOe6WfyecO4L3eaQd9ABm2KHrRc7T8T+K5a1iO9gtf+qtcqU0A8ALtnP2jZ12r3FhwSP1GcBf2XF2+0AAP5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792044864; c=relaxed/simple;
	bh=nCj9C+gm57nhnD/OyFfHRR3QL2V7zfQ5T0JAlEU3bW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQLEiHIf4Fc1sKaEM1hX7M/BhUMzQFzrLAiHfcpTUJzhDJ/eE2+QP4FmRBi/+Kjc2tuI09ZVAXRYFxDXDBM3plG2/0j7EZyprCgk7zMhhil/yREIt8RsIltooXUs+MqV/bEeHqZ9pqNCobWYM61hh5p9AyIaeAy74pGJeYcZ5Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnkdIoe5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnkdIoe5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2111F000C5;
	Thu, 15 Oct 2026 06:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792044856;
	bh=oI436hog+iKw/cDo0ZT9gycv3DmXtdRvUlAQ32Zbfeg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AnkdIoe5PMf81ktrpEePOBTfzuZ3YV30Rd8NiwAilJcs0MwSebyScrcCOstFzcjhR
	 h2Uc1cHbdQobNpN6rPvW+471kbCJ5WA/w6byF22l/+hLQSsmDHMKWEshzf3+tnm0rX
	 ytNH5nDbhUMvCtQQI3owO85PIpDslS7QqdgO5A6FfJQn0Mtzy2hif4/7dLIk7/HURj
	 MaSzwJIgS7xcT8eluIBeYjh2Q5uUMcCxsa4XsXg8hNeltCPFhdfwJ4V0p99GFQtz88
	 naxuju6OmEr+qQtte2504080fJW7YMNnr66dKtcIG6FzzFHvGbY7N3fcbJGL1Xq8ft
	 CrySe46LOIPGA==
Message-ID: <8f74cc11-b4ee-4fcc-887b-1989ce33d94a@kernel.org>
Date: Thu, 15 Oct 2026 08:14:13 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Ignore forced transfer modes the host
 does not support
To: Rand Deeb <rand.sec96@gmail.com>, Niklas Cassel <cassel@kernel.org>
Cc: deeb.rand@confident.ru, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, shda@confident.ru
References: <20261014125916.1975-1-rand.sec96@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261014125916.1975-1-rand.sec96@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/14 14:59, Rand Deeb wrote:
> The libata.force parameter can force a transfer mode (pio0-6, mwdma0-4,
> udma0-7) for a port or device. ata_force_xfermask() applies it in
> ata_do_set_mode() right after ata_dev_xfermask() has limited the device
> masks to what the host supports. It replaces those masks with the forced
> mode without checking the host masks, so a mode the controller does not
> support is passed to the driver's ->set_piomode() or ->set_dmamode().
> 
> Several PATA drivers rely on the host masks to keep the mode number in
> range when indexing their timing tables. ata_piix, pata_efar,
> pata_it8213, pata_oldpiix, pata_radisys and pata_rdc declare ATA_PIO4
> and ATA_MWDMA12_ONLY, index a five-entry PIO timing table with
> pio_mode - XFER_PIO_0, and index a three-entry needed_pio[] table with
> dma_mode - XFER_MW_DMA_0. Booting with libata.force=pio5, pio6, mwdma3
> or mwdma4 makes them read past those tables, use the values read as
> further indices into the timing table, and write the result to the
> controller's timing registers.
> 
> Make ata_force_xfermask() ignore a forced transfer mode that is not in
> the port's PIO, MWDMA or UDMA mask, and warn about it. Forcing a mode the
> host supports still works as before, including a mode that
> ata_dev_xfermask() removed for the device or cable.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 332673257056 ("libata: implement libata.force module parameter")
> Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
> ---
>  drivers/ata/libata-core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 92233fb25..324aaa81c 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -434,6 +434,7 @@ static void ata_force_link_limits(struct ata_link *link)
>   */
>  static void ata_force_xfermask(struct ata_device *dev)
>  {
> +	struct ata_port *ap = dev->link->ap;
>  	int devno = dev->link->pmp + dev->devno;
>  	int alt_devno = devno;
>  	int i;
> @@ -458,6 +459,17 @@ static void ata_force_xfermask(struct ata_device *dev)
>  
>  		ata_unpack_xfermask(fe->param.xfer_mask,
>  				    &pio_mask, &mwdma_mask, &udma_mask);
> +
> +		/* Never force a transfer mode the host does not support */
> +		if ((pio_mask & ~ap->pio_mask) ||
> +		    (mwdma_mask & ~ap->mwdma_mask) ||
> +		    (udma_mask & ~ap->udma_mask)) {
> +			ata_dev_warn(dev,
> +				     "FORCE: %s not supported by the host, ignored\n",
> +				     fe->param.name);
> +			return;
> +		}

I would rewrite this as:

		/* Make sure that the port supports the specified xfer modes. */
		if (!(pio_mask & ap->pio_mask) &&
		    !(mwdma_mask & ap->mwdma_mask) &&
		    !(udma_mask & ap->udma_mask)) {
			ata_dev_warn(dev,
				"FORCE: ignoring unsupported xfer_mask %s\n",
				fe->param.name);
			continue;
		}

as that is easier to understand. The "continue" here should address Sashiko comment.

> +
>  		if (udma_mask)
>  			dev->udma_mask = udma_mask;
>  		else if (mwdma_mask) {
> 
> base-commit: 4056b3c9d3c92ea45955641dbafeb9b960e146ef


-- 
Damien Le Moal
Western Digital Research
