Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A4472621
	for <linux-ide@vger.kernel.org>; Sun, 21 Jun 2026 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782046096; cv=none; b=DGRO8pCyyp9b7Oc2+esdNrM1qZ7xUMpRT7H1zFmZoYuTP+BWSEmaspNmztjPuT59gkbSU8Wui13S0vPyv2L0ebUf0YhMbK4Xjj0rSCiGbVYhHziLHqtmmMeOtUA+wx4Mio/msLq3pPLzl40pcGdHtPUsECg+yjsZ8yJzf4+4svM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782046096; c=relaxed/simple;
	bh=dwd1k+IJABctYDLMq+DgsmYr4JGdBw799Gys1m4tQ18=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FtsE/YelsubAk+VzVU152pc3h+MGyXEKxKIl37BkZIxMAi19zUFDa4smHw6wu9ZZp7dVb0GigX+SbJCIfg4pyNU3B/h7T/JJ9Nxb8xiUxUzUdgxmaDpKFB9oFLV+4F8/e6HVpVQT+T4oq9Hl50pG94lqkJN0vvzrIpnjmeVAa5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmRJ7Mw3; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmRJ7Mw3"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4629051c946so2558296f8f.1
        for <linux-ide@vger.kernel.org>; Sun, 21 Jun 2026 05:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782046093; x=1782650893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIV4b3lS40cEQDNqNshmkXrtRoxu1KZxLASIPEaidyw=;
        b=TmRJ7Mw3ssz0jHRsOE4DmrKY8wZ+O9MbfvmkbD4nqbAepu27S/aKfukCDJXkxljJhi
         7GFHLI13DOaock28j5Ot/Sr/KBikm266U2s8IcCd4YyxHt0aDEfdu9XHkamEgAIZcwUD
         wXR79MzNKlkte79k3gCnsUZdDf6AHe5AArQul+i4N4drFaXptcPzlVB0KssREAK+7bHl
         7xpkyBeMp+qZtwCtkVBDdtX49o9FwoyUiOIAc/0+m371/+4nPterh3GJxLbrUngomdKY
         F/ALR/nBkvgGwURn0Aq2xzqNtri8zrECsx5uvuDJI0EyZWqrDC7KEC5018789IUhmbex
         UBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782046093; x=1782650893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hIV4b3lS40cEQDNqNshmkXrtRoxu1KZxLASIPEaidyw=;
        b=YW/8jU0DSpUUIR8RqwGgpf17v8OYSZRxMUIl03ZDHKi9Om1Q6BCBh3NESBba6rcdwg
         D/fZD7y2Ax2QksfFgqXuvOX+1YaVy9yXTmww+9+inaS86gqPzCS89Mb1Cc/eY1MH2vdt
         Swp96ZMKYf1tFG1KOEJL+6ovFiKUs1oFX+8iMKXgXqtbxLFj195jJrrMhRl3Ut4pd/w4
         KjsqVq+Lk1bLOVAuRaCejMiiNrxQFLp7V0bMvv7EgKelwG3NC0bt5BJHLHPrhbeb/Myq
         K9hz3jltXUKg58UKe1I7fJhQhUbGdrxDHO5cwmBF9VrpH4KGKZ1wAJJkYTDlYvI7M80g
         vR+Q==
X-Gm-Message-State: AOJu0Yzb5ykYqV3n92cRJjooYBgGK9MT1bIyJ05E/K2rTcqBeW18AzV3
	fyb4it6TeNT4oXyCMYEm48gX22M3w7kRaKd9ZzbohBnMwYOAL5HFbavT
X-Gm-Gg: AfdE7cmlnKiob8vJWs8LcxVpDaiMsBY6XvKHmyYQ76ZmZmDxJTT6X8SKqUc4I3J6UR1
	jqrIjjI2NYhLcEDa0S5o0Rpx2BzZZ5KaUnN4W1JbImhKz1y7aE+VHsYo695r8UFXhSC6UUqpmua
	UMT/4Wd/rlWPjarGkNbMwII7Y9R60drtEDBd9whkRgqf7Di9w+mg8xCBae5AaBJFsvog7Cv0FNl
	YCNOjBSewsOUkuDA9IoUlGTcgiSMbaQtifJ8EeiZ1QKz6eQhmQmp5iE8W5U+vEUXZ2TI9tHH3xN
	kmr9CBybH2+SGlywf3YX7bOvlj5pmh51uH9LqfjW9yAa0lQEIL9LfXAejFJfperHyG6vx81A5//
	HR4P50km/7KzwqF0uMTCneZLuGfvbWwQGNTKsfraHH+iktK/aE5DnSQP6QERtthwn9ToJUXNeeo
	eG7o/q8+Bpo7vPAEq37xtefNjlwnN2bsV+LEP5KesFPSPiETfZ6g==
X-Received: by 2002:a5d:5f92:0:b0:45e:9304:a4c3 with SMTP id ffacd0b85a97d-4651e5c4122mr16430995f8f.19.1782046092926;
        Sun, 21 Jun 2026 05:48:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4666cea9581sm15509474f8f.0.2026.06.21.05.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 05:48:12 -0700 (PDT)
Date: Sun, 21 Jun 2026 13:48:09 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Alvin Lim <alvinwylim@gmail.com>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas
 Cassel <cassel@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] ata: ahci: force 32-bit DMA for ASMedia ASM1166
Message-ID: <20260621134809.7b1b2e3f@pumpkin>
In-Reply-To: <20260621100844.1224301-1-alvinwylim@gmail.com>
References: <20260621100844.1224301-1-alvinwylim@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Jun 2026 18:08:44 +0800
Alvin Lim <alvinwylim@gmail.com> wrote:

> The ASMedia ASM1166 SATA controller (1b21:1166) advertises 64-bit DMA
> support (AHCI CAP.S64A), but on systems with the IOMMU enabled - where it
> can be handed DMA addresses above 4 GB - it silently corrupts data in
> transit.

That seems wrong.
If any iommu is disabled the sata cotroller will be passed the memory's
physical address which is very likely to be over 4G.
So the controller seems to support 64bit addresses - as advertised.

But with the iommu enabled the addresses the controller needs to use are
different from the physical address - so the controller will almost
certainly see sub 4G addresses for buffers above 4G.
(The iommu probably allocates 32bit PCIe addresses for all buffers so that
it doesn't have to worry about targets that only support 32bit addresses.)

It seems more likely that the wrong addresses are ending up in the host
side of the iommu and using bounce buffers fixes that.
Using the wrong addresses is likely to lead to major kernel memory
corruptions.

Mixing up physical addresses and dma addresses, assuming that memory
from dma_alloc_coherent() is physically contiguous, or just losing the
high bits of the physical address passed to the iommu seem more likely.

	David



> Reads return different, wrong data on each access. SMART is clean,
> there are no SATA link resets and no MCE is raised, so the corruption is
> invisible until it surfaces as filesystem metadata errors (XFS EUCLEAN)
> or, on Ceph, mass scrub errors across multiple independent filesystems at
> once - i.e. host-level, not filesystem-level.
> 
> This is the same failure mode already quirked for other controllers that
> falsely claim working 64-bit DMA. See commit 105c42566a55 ("ata: ahci:
> force 32-bit DMA for JMicron JMB582/JMB585") and commit 20730e9b2778
> ("ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers").
> The ASM1166 currently maps to plain board_ahci with no DMA limit.
> 
> Limit the ASM1166 to 32-bit DMA. 32-bit is the guaranteed-correct lower
> bound; the only cost is extra SWIOTLB bounce-buffering on transfers above
> 4 GB, negligible for storage. A future change can widen it to the
> controller's true addressable width if characterised. Until this lands the
> only workarounds are disabling the IOMMU (amd_iommu=off / intel_iommu=off)
> or using an HBA.
> 
> Reproduced on an AOOSTAR WTR MAX (AMD Ryzen 7 PRO 8845HS) whose six SATA
> bays all hang off one ASM1166: with the IOMMU on, six concurrent
> 'dd ... | md5sum' of the same large file return six different sums; with
> amd_iommu=off they are identical, and a full Ceph deep-scrub of a 5.4 TiB
> / 1.43M-object pool re-reads end-to-end with zero scrub errors.
> 
> Add a board_ahci_32bit_dma board type (mirroring board_ahci_43bit_dma)
> and point the ASM1166 entry at it.
> 
> Fixes: 3bf614106094 ("ata: ahci: add identifiers for ASM2116 series adapters")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4.8
> Signed-off-by: Alvin Lim <alvinwylim@gmail.com>
> ---
>  drivers/ata/ahci.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 58f512f8952a..895956c2ca15 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -48,6 +48,7 @@ enum {
>  enum board_ids {
>  	/* board IDs by feature in alphabetical order */
>  	board_ahci,
> +	board_ahci_32bit_dma,
>  	board_ahci_43bit_dma,
>  	board_ahci_ign_iferr,
>  	board_ahci_no_debounce_delay,
> @@ -132,6 +133,13 @@ static const struct ata_port_info ahci_port_info[] = {
>  		.udma_mask	= ATA_UDMA6,
>  		.port_ops	= &ahci_ops,
>  	},
> +	[board_ahci_32bit_dma] = {
> +		AHCI_HFLAGS	(AHCI_HFLAG_32BIT_ONLY),
> +		.flags		= AHCI_FLAG_COMMON,
> +		.pio_mask	= ATA_PIO4,
> +		.udma_mask	= ATA_UDMA6,
> +		.port_ops	= &ahci_ops,
> +	},
>  	[board_ahci_43bit_dma] = {
>  		AHCI_HFLAGS	(AHCI_HFLAG_43BIT_ONLY),
>  		.flags		= AHCI_FLAG_COMMON,
> @@ -1559,7 +1567,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	}, {
>  		/* ASM1166 */
>  		PCI_VDEVICE(ASMEDIA, 0x1166),
> -		.driver_data = board_ahci,
> +		.driver_data = board_ahci_32bit_dma,
>  	}, {
>  		/*
>  		 * Samsung SSDs found on some macbooks.  NCQ times out if MSI is
> 
> base-commit: 322008f87f917e2217eeac386a9410945092eb2e

