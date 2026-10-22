Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655743;
	b=2DXhFgkl5xygrQFsRyUO/yCnScoHIA8FCOLDUMRQIFLFoU7c0wukyGOCmiC7PBtKOIZp
	 WMx09C7V28j7vmU398yUG0o5+sBrIE6us76l1MoA7H1rrfYH4CY0OZ80rvTZ0dDkJQ9R2
	 iKMi8bM3YNhwVZqyW3UXsg25BnVxz7KngV8EsEa9VpZQTHvhQwMoxU5higTE6DCxWKQNC
	 TBAoy8Aa42ABLk9F7BrhnBya/6ZWo+ihGJ/mkk82hzfLk+P6fFuxjw9t0LOb5wvXWCYGW
	 LgZDRYLL1bOnPjZgA8l94u1Vxg9hPyptwnQugNGfu1J+fyaC21cg3zVYqdWuWJbpwwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655743;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=HoMBqUWXSrCfnD82GWY+9mI0yQyUEra3bWonMCdMjlE=;
	b=k35Bf8azo2wJO+kb34agcVP7y+vzu/X0IBG2RZAoESSUk/WgHijtn1r5rZDIACwb6bv4
	 xKgvWeFyaewlgkCThXYKS/rHjd7Vm6O7doOFig2Sbf0Y+Tj8I6bWBoiGXLuktmjHCY2SI
	 1zaFgSbybny8LUUTicC8MXg4svHT3ZXuNV7lPCmcvxctInSf8FAF8mwN8SHGvG1YOyXup
	 w4MmF/mOU4+l6mG2aUVzbucDJBqmunTeo4cbW+k0pjAAHuwvfW3cTgC+1AP3tx7z2S2ir
	 RVPKWTmpPlxTAmP5EwP1t7+FBJI0Ei8w5bgTMty0a/Epb3xUKXKp7IwMeUfAG3hcUUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oivdhJrZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C74A606A31A;
	Thu, 22 Oct 2026 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oivdhJrZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC9E1F000C1;
	Thu, 22 Oct 2026 07:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792655738;
	bh=HoMBqUWXSrCfnD82GWY+9mI0yQyUEra3bWonMCdMjlE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oivdhJrZL4e1zExJbwmsVL74aVUzl5AO9zaJE9/QPY0/CoH5vWuqY0A4rChL71zjW
	 y6LO5HJ4Dj3D3Qm8PWzaw7vM9Fa6HfDBgJg9wGEYAS1Agh03V9zL8bMTs8ItBkf1sX
	 Q2RgUgFmEFUUm47pN3vDnHAJyhNZGhYm4tNIrinHPNnhdsbKqnS2sXFBdFKg8x9efJ
	 MR76cQ3NRH96uYBzi4Mwg+CG3a6p9O2/GRcUL4AjfzyO4/o5VMpaEOqOJLaOwNT5PO
	 IhmY1h1N7QR3GgpY4+HQokvvBV/GmMaPxJfcEjPy1D7sI3iPKMd4FrBzlESfLKEGLr
	 nbyGVZ0S3pb9Q==
Message-ID: <fb677bdb-355d-4a46-9e4b-db989a7690d9@kernel.org>
Date: Thu, 22 Oct 2026 09:55:35 +0200
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata-core: Ignore forced transfer modes the
 host does not support
To: Rand Deeb <rand.sec96@gmail.com>, Niklas Cassel <cassel@kernel.org>
Cc: deeb.rand@confident.ru, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, shda@confident.ru
References: <20261015194935.1497-1-rand.sec96@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261015194935.1497-1-rand.sec96@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/15 21:49, Rand Deeb wrote:
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
> Make ata_force_xfermask() skip, with a warning, a forced transfer mode
> that is not in the port's PIO, MWDMA or UDMA mask, and keep looking for
> an earlier matching libata.force entry, as it already does for entries
> that do not apply to the device. With libata.force=pio4,1.0:pio5 on a
> PIO4 host, device 1.0 now gets pio4 instead of pio5. Forcing a mode the
> host supports still works as before, including a mode that
> ata_dev_xfermask() removed for the device or cable.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 332673257056 ("libata: implement libata.force module parameter")
> Signed-off-by: Rand Deeb <rand.sec96@gmail.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
