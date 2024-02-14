Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C68E7F
	for <linux-ide@vger.kernel.org>; Wed, 14 Feb 2024 00:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869545; cv=none; b=PAmVe0poa2bihUHEDqGV/hIdWdw5tSht4PDkidX5O4tdqSsbgqg4dDoRJNo7N7XGSu5ghnWKkCkc1xf7MSGMSmLn2OQy2vJ8CdTnUw9TSEtQHvNb1bWhhjujrkaZpqorwu/Kj0BH6//dEQxFGm7/MtYkHyl1G2VrV5fCCALRCGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869545; c=relaxed/simple;
	bh=2WZnm1s72wFatTEuPunfI8o/uFeY/Ku2XzYCs0OhmmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TenQ01qU8eY+DdI8kQ1Wvq8lqaIZvYDZmd7RWVfAKGrxta6lL6uKv7tMbL2jVYbt8RfKpJu+9E/4PHYAHZWVbSRvx1gdImk0xxiPHX7/wfbnTLkKG24aZUN3QoGRXLeohmJdXViwVlPZQ5P5sWx3lQ1HOx2aE0KkuVA6NhEzcZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQqEWbml; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQqEWbml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF389C433F1;
	Wed, 14 Feb 2024 00:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707869544;
	bh=2WZnm1s72wFatTEuPunfI8o/uFeY/Ku2XzYCs0OhmmQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VQqEWbmlW0HkNWnhtB5oKdyS71ZfOAuuf2ypFMPJbZCzwn0hlU53z+ynXqv23sNFg
	 GuCooZJSvaUXIWRXemsN9RkWQPSzQ/7BY4dO7MjY7pd6Peg/TGCfyv1htBW79l2BZl
	 LoKOeMzS2qBPaBqNxc33wbYt9IY4J3yEH+x6fWfAAfV3snha7j0TAxrhwnE85yrwFT
	 AC0xdYotrdeu4EAfy4BhFkypP7IKcBRfubxV2xWDFk4hPtxLu+I3vEIu9HrnNiDhm+
	 ZXLmDahfy/VLCRQ8+nFNWgcOYZS7ThGhbyI0wgfdwOt2oxHd8A9t1SqFZqig/Az3Sb
	 ILoHi0eB5KULg==
Message-ID: <5a183bb9-e551-4a56-a99b-13a7ac716f19@kernel.org>
Date: Wed, 14 Feb 2024 09:12:20 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ahci: rename board_ahci_nosntf
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-ide@vger.kernel.org
References: <20240213130733.819524-1-cassel@kernel.org>
 <20240213130733.819524-2-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240213130733.819524-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/24 22:07, Niklas Cassel wrote:
> Commit 7edbb6059274 ("ahci: clean up intel_pcs_quirk") added a new board
> type (board_ahci_pcs_quirk) which applies the Intel PCS quirk for legacy
> platforms. However, it also modified board_ahci_avn and board_ahci_nosntf
> to apply the same quirk.
> 
> board_ahci_avn is defined under the label:
> /* board IDs for specific chipsets in alphabetical order */
> This is a board for a specific chipset, so the naming is perfectly fine.
> (The name does not need to be suffixed with _pcs_quirk, since all
> controllers for this chipset require the quirk to be applied).
> 
> board_ahci_nosntf is defined under the label:
> /* board IDs by feature in alphabetical order */
> This is a board for a specific feature/quirk. However, it is used to
> apply two different quirks.
> 
> Rename board_ahci_nosntf to more clearly highlight that this board ID
> applies two different quirks.
> 
> Fixes: 7edbb6059274 ("ahci: clean up intel_pcs_quirk")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/ahci.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 41b4c9777c85..c28ad3f4b59e 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -53,7 +53,7 @@ enum board_ids {
>  	board_ahci_no_debounce_delay,
>  	board_ahci_nomsi,
>  	board_ahci_noncq,
> -	board_ahci_nosntf,
> +	board_ahci_nosntf_pcs_quirk,
>  	/*
>  	 * board_ahci_pcs_quirk is for legacy Intel platforms.
>  	 * Modern Intel platforms should use board_ahci instead.
> @@ -165,7 +165,7 @@ static const struct ata_port_info ahci_port_info[] = {
>  		.udma_mask	= ATA_UDMA6,
>  		.port_ops	= &ahci_ops,
>  	},
> -	[board_ahci_nosntf] = {
> +	[board_ahci_nosntf_pcs_quirk] = {
>  		AHCI_HFLAGS	(AHCI_HFLAG_NO_SNTF |
>  				 AHCI_HFLAG_INTEL_PCS_QUIRK),
>  		.flags		= AHCI_FLAG_COMMON,
> @@ -271,7 +271,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x2683), board_ahci_pcs_quirk }, /* ESB2 */
>  	{ PCI_VDEVICE(INTEL, 0x27c6), board_ahci_pcs_quirk }, /* ICH7-M DH */
>  	{ PCI_VDEVICE(INTEL, 0x2821), board_ahci_pcs_quirk }, /* ICH8 */
> -	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci_nosntf }, /* ICH8/Lewisburg RAID*/
> +	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci_nosntf_pcs_quirk }, /* ICH8/Lewisburg RAID*/

Minor nit: I would name the board board_ahci_pcs_quirk_nosntf to make it easier
to see that this is a sub case of the general board_ahci_pcs_quirk.

>  	{ PCI_VDEVICE(INTEL, 0x2824), board_ahci_pcs_quirk }, /* ICH8 */
>  	{ PCI_VDEVICE(INTEL, 0x2829), board_ahci_pcs_quirk }, /* ICH8M */
>  	{ PCI_VDEVICE(INTEL, 0x282a), board_ahci_pcs_quirk }, /* ICH8M */

With that, this look good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

