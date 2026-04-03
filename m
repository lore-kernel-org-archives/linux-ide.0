Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9A51DF980
	for <linux-ide@vger.kernel.org>; Fri,  3 Apr 2026 07:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775199753; cv=none; b=dhNTBL3EYfErT37BhqyoP2FC950kOjfgEi2PSW/HeBB45mC5Bnban4ckFaBYD1CKD1QfFg25yUNGvogfk8iHI5ANuZME/wkTjq1B1J6/Ksi3Kq13crTGstGSuQlWM+5OcIBF/Cw1jjEeR9M0TmHn4UnD7RKyvKeNksUiLL7JT3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775199753; c=relaxed/simple;
	bh=u0pWnDIY+BkyGyjOfK+GZ0suVjuuyVhADNo/bzk0Ww0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQEHutYVGPOR1v07Yg1xtlWXIm3S68pwTdKe5VrZAnDb/jaIjSzNuykB5LfUq/ufXS72Kqr5rR5uMchbjn+khr8092S0AYqGQHEAEAekD32dgp5xRfipmnz8toiDqSFG8LzUcLvDv8Z4WMQ5kLkwNrel8i6MQexn52pcVjLsMGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3BEqpIl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3BEqpIl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0211C4CEF7;
	Fri,  3 Apr 2026 07:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775199753;
	bh=u0pWnDIY+BkyGyjOfK+GZ0suVjuuyVhADNo/bzk0Ww0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N3BEqpIl8mCZMON9+vWZHADcY3KDBleG5QIyNR6K4a1lij1jD2+ztIdYAtgA/Gg7q
	 UU76tSJxOjfUN3fKVXwe9s9gj2giuI7dhtZnTSoGfOVJZ/o7IGDlvhZIr/ewN4C4pQ
	 Q/ViBORnTp1DVrpnUx4G3tLOd7Vu4ChrCcWuxkvILlLUWq/ok2k1P0nGcyodvMAXZG
	 FfAA6jiZyfDTWdMMonJ+wGY5QIBxURxUa/bQ+ZE6pxz03KYfQ4nXJh8Z2OpSoD9B/n
	 K04bpHLqeJy2KP1giIxucgmOGb9DQTiHTGOckIvO7th5pRS5EpxJ5zP3guVoidRzt8
	 ErAIm4CI3wL6w==
Message-ID: <1f4df7ac-6346-4004-9c78-06706f3a91cf@kernel.org>
Date: Fri, 3 Apr 2026 16:02:31 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ahci: force 32-bit DMA for JMicron JMB582/JMB585
To: Arthur Husband <artmoty@gmail.com>, linux-ide@vger.kernel.org
Cc: cassel@kernel.org
References: <20260403050418.50398-1-artmoty@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260403050418.50398-1-artmoty@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/3/26 14:04, Arthur Husband wrote:
> The JMicron JMB585 (and JMB582) SATA controllers advertise 64-bit DMA
> support via the S64A bit in the AHCI CAP register, but their 64-bit DMA
> implementation is defective. Under sustained I/O, DMA transfers targeting
> addresses above 4GB silently corrupt data — writes land at incorrect
> memory addresses with no errors logged.
> 
> This has been confirmed on multiple platforms (Minisforum N5 Pro,
> Raspberry Pi, Unraid, Proxmox, TrueNAS) and is consistent with the
> controller truncating or mishandling upper address bits during 64-bit
> DMA transactions.
> 
> The failure pattern is identical to the ASMedia ASM1062 (commit
> edb96a15dc18), which also falsely advertised 64-bit DMA and was fixed
> with AHCI_HFLAG_32BIT_ONLY.
> 
> On the Minisforum N5 Pro specifically, the combination of the JMB585's
> broken 64-bit DMA with the AMD Family 1Ah (Strix Point) IOMMU causes
> silent data corruption that is only detectable via checksumming
> filesystems (BTRFS/ZFS scrub). The corruption occurs when 32-bit IOVA
> space is exhausted and the kernel transparently switches to 64-bit DMA
> addresses.
> 
> Add device-specific PCI ID entries for the JMB582 (0x0582) and JMB585
> (0x0585) before the generic JMicron class match, using a new board type
> that combines AHCI_HFLAG_IGN_IRQ_IF_ERR (preserving existing behavior)
> with AHCI_HFLAG_32BIT_ONLY to force 32-bit DMA masks.
> 
> Investigation and patch development assisted by Claude (Anthropic AI).

We do not do advertisement for commercial software. So please drop this.

> 
> Signed-off-by: Arthur Husband <artmoty@gmail.com>
> ---
>  drivers/ata/ahci.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index XXXXXXX..XXXXXXX 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -51,6 +51,7 @@ enum board_ids {
>  	board_ahci,
>  	board_ahci_43bit_dma,
>  	board_ahci_ign_iferr,
> +	board_ahci_jmb585,

Please move this entry down in the chipset specific section of the enum.

Other than this, looks OK to me. Thanks for the detailed commit message.

>  	board_ahci_no_debounce_delay,
>  	board_ahci_no_msi,
>  	/*
> @@ -115,6 +116,14 @@ static const struct ata_port_info ahci_port_info[] = {
>  		.udma_mask	= ATA_UDMA6,
>  		.port_ops	= &ahci_ops,
>  	},
> +	/* JMicron JMB582/585: 64-bit DMA is broken, force 32-bit */
> +	[board_ahci_jmb585] = {
> +		AHCI_HFLAGS	(AHCI_HFLAG_IGN_IRQ_IF_ERR |
> +				 AHCI_HFLAG_32BIT_ONLY),
> +		.flags		= AHCI_FLAG_COMMON,
> +		.pio_mask	= ATA_PIO4,
> +		.udma_mask	= ATA_UDMA6,
> +		.port_ops	= &ahci_ops,
> +	},
>  	[board_ahci_no_debounce_delay] = {
>  		.flags		= AHCI_FLAG_COMMON,
>  		.link_flags	= ATA_LFLAG_NO_DEBOUNCE_DELAY,
> @@ -XXX,7 +XXX,12 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	...
> 
> -	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
> +	/* JMicron JMB582/585: force 32-bit DMA (broken 64-bit implementation) */
> +	{ PCI_VDEVICE(JMICRON, 0x0582), board_ahci_jmb585 },
> +	{ PCI_VDEVICE(JMICRON, 0x0585), board_ahci_jmb585 },
> +
> +	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
>  	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>  	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci_ign_iferr },
> 
> --


-- 
Damien Le Moal
Western Digital Research
