Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1A83B18C
	for <linux-ide@vger.kernel.org>; Tue, 13 Feb 2024 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820781; cv=none; b=Y1JJbjGt8nFIdRF2eLk1kppiQy+dlzulhngAb6gacQKYrdiDlR/hedZkziCvWVaxWrX9FEznuZ1nlKP+EeCotr8ec11F88DZRGHZZ3ccXdacBZXilIpesIMpFnKdiH1lIqiYLgqPwy5AvaxV5+TU3RfJE1rYIrYiAPMxUzAJRmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820781; c=relaxed/simple;
	bh=1E0s940c2oYYoiNHzcEuVxsJFprV88KLrysrwoWjrvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlZKmceDwwSfG7m8THmjlNiqyjX2L76EV1q2M8vhCosIuWp/JvZfJyJzYDEGAZFBva/k0Is+QXKZ0tPqbNnUCM2vJtp1llpSBJgU3ElJqWmywz5QqkE1R/TvgpQT3ToAPaKxsHNZaZKqRl58hYk5dV5j7836W3tcrULV5phNnVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ej9RG4Ou; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ej9RG4Ou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA88C433C7;
	Tue, 13 Feb 2024 10:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707820780;
	bh=1E0s940c2oYYoiNHzcEuVxsJFprV88KLrysrwoWjrvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ej9RG4OucJZGLWdf+Ee8h6biuuO5ryABreydwXIdXo0nL/TyHcWMrr0qi8cQdQSQ2
	 xxOBlAtdkSG0LlXktNT7NDvf38I5cNniGzte0L/FCjF63BGJlvANW9P1wPzyQXsjvL
	 KmMTzjrbbZmAC3KvMb8xUryTJL1bkbyGtaTHif1alzFVomntOaItdzmPsLJlOLk8Dx
	 j5ytQUZJYzIrdm+CkQ0cdElPey+Fh7QMiGnOm4NzZ2NAEKdX/INqr12b790RMBTRTD
	 fV5bbILdn/bD/2YwaPk5QYpfH2zsPZs3Olnji8W/OdwRnoXaDk5DAu46cKgkQieT5j
	 2uD4z0iYlCRZg==
Date: Tue, 13 Feb 2024 11:39:34 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2] ahci: clean up intel_pcs_quirk
Message-ID: <ZctG5qmBKua3tpPw@x1-carbon>
References: <20240209130307.39113-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209130307.39113-1-cassel@kernel.org>

On Fri, Feb 09, 2024 at 02:03:06PM +0100, Niklas Cassel wrote:
> The comment in front of board_ahci_pcs7 is completely wrong.
> It claims that board_ahci_pcs7 is needing the quirk, but in fact,
> the logic implemented in ahci_intel_pcs_quirk() is the exact opposite,
> only board_ahci_pcs7 is _excluded_ from the quirk.
> 
> This way of implementing a quirk is unconventional in several ways:
> First of all because it has a board ID for which the quirk should _not_ be
> applied (board_ahci_pcs7), instead of the usual way where we have a board
> ID for which the quirk should be applied.
> 
> The second reason is that other than only excluding board_ahci_pcs7 from
> the quirk, PCI devices that make use of the generic entry in ahci_pci_tbl
> (which matches on AHCI class code) are also excluded.
> 
> This can of course lead to very subtle breakage, and did indeed do so in:
> commit 104ff59af73a ("ata: ahci: Add Tiger Lake UP{3,4} AHCI controller"),
> which added an explicit entry with board_ahci_low_power to ahci_pci_tbl.
> 
> This caused many users to complain that their SATA drives disappeared.
> The logical assumption was of course that the issue was related to LPM,
> and was therefore reverted in commit 6210038aeaf4 ("ata: ahci: Revert
> "ata: ahci: Add Tiger Lake UP{3,4} AHCI controller"").
> 
> It took a lot of time to figure out that this was all completely unrelated
> to LPM, and was instead caused by an unconventional Intel quirk.
> 
> Clean up the quirk so that it behaves like other quirks, i.e. define a
> board where the quirk is applied. Platforms that were using
> board_ahci_pcs7 are converted to use board_ahci, this is safe since the
> boards were identical, and board_ahci_pcs7 did not define any custom
> port_ops.
> 
> This way, new Intel platforms can be added using the correct "board_ahci"
> board, without getting any unexpected quirks applied.
> 
> This means that we currently have some modern platforms defined that are
> using the Intel PCS quirk, but that is identical to the behavior that
> was there before this commit.
> 
> No functional changes intended.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217114
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Changes since v1: Just do the actual cleanup instead of documenting how
> weird the existing quirk is. (Simply documenting the quirk would not have
> stopped people from encountering the same problem as we encountered when
> trying to add support for Tiger Lake.)
> 
>  drivers/ata/ahci.c | 361 ++++++++++++++++++++++-----------------------
>  drivers/ata/ahci.h |   1 +
>  2 files changed, 180 insertions(+), 182 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index ae0a592e2185..41b4c9777c85 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -54,6 +54,14 @@ enum board_ids {
>  	board_ahci_nomsi,
>  	board_ahci_noncq,
>  	board_ahci_nosntf,
> +	/*
> +	 * board_ahci_pcs_quirk is for legacy Intel platforms.
> +	 * Modern Intel platforms should use board_ahci instead.
> +	 * (Some modern Intel platforms might have been added with
> +	 * board_ahci_pcs_quirk, however, we cannot change them to board_ahci
> +	 * without testing that the platform actually works without the quirk.)
> +	 */
> +	board_ahci_pcs_quirk,
>  	board_ahci_yes_fbs,
>  
>  	/* board IDs for specific chipsets in alphabetical order */
> @@ -67,12 +75,6 @@ enum board_ids {
>  	board_ahci_sb700,	/* for SB700 and SB800 */
>  	board_ahci_vt8251,
>  
> -	/*
> -	 * board IDs for Intel chipsets that support more than 6 ports
> -	 * *and* end up needing the PCS quirk.
> -	 */
> -	board_ahci_pcs7,
> -
>  	/* aliases */
>  	board_ahci_mcp_linux	= board_ahci_mcp65,
>  	board_ahci_mcp67	= board_ahci_mcp65,
> @@ -164,7 +166,15 @@ static const struct ata_port_info ahci_port_info[] = {
>  		.port_ops	= &ahci_ops,
>  	},
>  	[board_ahci_nosntf] = {
> -		AHCI_HFLAGS	(AHCI_HFLAG_NO_SNTF),
> +		AHCI_HFLAGS	(AHCI_HFLAG_NO_SNTF |
> +				 AHCI_HFLAG_INTEL_PCS_QUIRK),
> +		.flags		= AHCI_FLAG_COMMON,
> +		.pio_mask	= ATA_PIO4,
> +		.udma_mask	= ATA_UDMA6,
> +		.port_ops	= &ahci_ops,
> +	},
> +	[board_ahci_pcs_quirk] = {
> +		AHCI_HFLAGS	(AHCI_HFLAG_INTEL_PCS_QUIRK),
>  		.flags		= AHCI_FLAG_COMMON,
>  		.pio_mask	= ATA_PIO4,
>  		.udma_mask	= ATA_UDMA6,
> @@ -186,6 +196,7 @@ static const struct ata_port_info ahci_port_info[] = {
>  		.port_ops	= &ahci_ops,
>  	},
>  	[board_ahci_avn] = {
> +		AHCI_HFLAGS	(AHCI_HFLAG_INTEL_PCS_QUIRK),
>  		.flags		= AHCI_FLAG_COMMON,
>  		.pio_mask	= ATA_PIO4,
>  		.udma_mask	= ATA_UDMA6,
> @@ -244,119 +255,113 @@ static const struct ata_port_info ahci_port_info[] = {
>  		.udma_mask	= ATA_UDMA6,
>  		.port_ops	= &ahci_vt8251_ops,
>  	},
> -	[board_ahci_pcs7] = {
> -		.flags		= AHCI_FLAG_COMMON,
> -		.pio_mask	= ATA_PIO4,
> -		.udma_mask	= ATA_UDMA6,
> -		.port_ops	= &ahci_ops,
> -	},
>  };
>  
>  static const struct pci_device_id ahci_pci_tbl[] = {
>  	/* Intel */
> -	{ PCI_VDEVICE(INTEL, 0x06d6), board_ahci }, /* Comet Lake PCH-H RAID */
> -	{ PCI_VDEVICE(INTEL, 0x2652), board_ahci }, /* ICH6 */
> -	{ PCI_VDEVICE(INTEL, 0x2653), board_ahci }, /* ICH6M */
> -	{ PCI_VDEVICE(INTEL, 0x27c1), board_ahci }, /* ICH7 */
> -	{ PCI_VDEVICE(INTEL, 0x27c5), board_ahci }, /* ICH7M */
> -	{ PCI_VDEVICE(INTEL, 0x27c3), board_ahci }, /* ICH7R */
> +	{ PCI_VDEVICE(INTEL, 0x06d6), board_ahci_pcs_quirk }, /* Comet Lake PCH-H RAID */
> +	{ PCI_VDEVICE(INTEL, 0x2652), board_ahci_pcs_quirk }, /* ICH6 */
> +	{ PCI_VDEVICE(INTEL, 0x2653), board_ahci_pcs_quirk }, /* ICH6M */
> +	{ PCI_VDEVICE(INTEL, 0x27c1), board_ahci_pcs_quirk }, /* ICH7 */
> +	{ PCI_VDEVICE(INTEL, 0x27c5), board_ahci_pcs_quirk }, /* ICH7M */
> +	{ PCI_VDEVICE(INTEL, 0x27c3), board_ahci_pcs_quirk }, /* ICH7R */
>  	{ PCI_VDEVICE(AL, 0x5288), board_ahci_ign_iferr }, /* ULi M5288 */
> -	{ PCI_VDEVICE(INTEL, 0x2681), board_ahci }, /* ESB2 */
> -	{ PCI_VDEVICE(INTEL, 0x2682), board_ahci }, /* ESB2 */
> -	{ PCI_VDEVICE(INTEL, 0x2683), board_ahci }, /* ESB2 */
> -	{ PCI_VDEVICE(INTEL, 0x27c6), board_ahci }, /* ICH7-M DH */
> -	{ PCI_VDEVICE(INTEL, 0x2821), board_ahci }, /* ICH8 */
> +	{ PCI_VDEVICE(INTEL, 0x2681), board_ahci_pcs_quirk }, /* ESB2 */
> +	{ PCI_VDEVICE(INTEL, 0x2682), board_ahci_pcs_quirk }, /* ESB2 */
> +	{ PCI_VDEVICE(INTEL, 0x2683), board_ahci_pcs_quirk }, /* ESB2 */
> +	{ PCI_VDEVICE(INTEL, 0x27c6), board_ahci_pcs_quirk }, /* ICH7-M DH */
> +	{ PCI_VDEVICE(INTEL, 0x2821), board_ahci_pcs_quirk }, /* ICH8 */
>  	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci_nosntf }, /* ICH8/Lewisburg RAID*/
> -	{ PCI_VDEVICE(INTEL, 0x2824), board_ahci }, /* ICH8 */
> -	{ PCI_VDEVICE(INTEL, 0x2829), board_ahci }, /* ICH8M */
> -	{ PCI_VDEVICE(INTEL, 0x282a), board_ahci }, /* ICH8M */
> -	{ PCI_VDEVICE(INTEL, 0x2922), board_ahci }, /* ICH9 */
> -	{ PCI_VDEVICE(INTEL, 0x2923), board_ahci }, /* ICH9 */
> -	{ PCI_VDEVICE(INTEL, 0x2924), board_ahci }, /* ICH9 */
> -	{ PCI_VDEVICE(INTEL, 0x2925), board_ahci }, /* ICH9 */
> -	{ PCI_VDEVICE(INTEL, 0x2927), board_ahci }, /* ICH9 */
> -	{ PCI_VDEVICE(INTEL, 0x2929), board_ahci }, /* ICH9M */
> -	{ PCI_VDEVICE(INTEL, 0x292a), board_ahci }, /* ICH9M */
> -	{ PCI_VDEVICE(INTEL, 0x292b), board_ahci }, /* ICH9M */
> -	{ PCI_VDEVICE(INTEL, 0x292c), board_ahci }, /* ICH9M */
> -	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci }, /* ICH9M */
> -	{ PCI_VDEVICE(INTEL, 0x294d), board_ahci }, /* ICH9 */
> -	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci }, /* ICH9M */
> -	{ PCI_VDEVICE(INTEL, 0x502a), board_ahci }, /* Tolapai */
> -	{ PCI_VDEVICE(INTEL, 0x502b), board_ahci }, /* Tolapai */
> -	{ PCI_VDEVICE(INTEL, 0x3a05), board_ahci }, /* ICH10 */
> -	{ PCI_VDEVICE(INTEL, 0x3a22), board_ahci }, /* ICH10 */
> -	{ PCI_VDEVICE(INTEL, 0x3a25), board_ahci }, /* ICH10 */
> -	{ PCI_VDEVICE(INTEL, 0x3b22), board_ahci }, /* PCH AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x3b23), board_ahci }, /* PCH AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x3b24), board_ahci }, /* PCH RAID */
> -	{ PCI_VDEVICE(INTEL, 0x3b25), board_ahci }, /* PCH RAID */
> -	{ PCI_VDEVICE(INTEL, 0x3b29), board_ahci }, /* PCH M AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x3b2b), board_ahci }, /* PCH RAID */
> -	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci }, /* PCH M RAID */
> -	{ PCI_VDEVICE(INTEL, 0x3b2f), board_ahci }, /* PCH AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x19b0), board_ahci_pcs7 }, /* DNV AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x19b1), board_ahci_pcs7 }, /* DNV AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x19b2), board_ahci_pcs7 }, /* DNV AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x19b3), board_ahci_pcs7 }, /* DNV AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x19b4), board_ahci_pcs7 }, /* DNV AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x19b5), board_ahci_pcs7 }, /* DNV AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x19b6), board_ahci_pcs7 }, /* DNV AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x19b7), board_ahci_pcs7 }, /* DNV AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x19bE), board_ahci_pcs7 }, /* DNV AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x19bF), board_ahci_pcs7 }, /* DNV AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x19c0), board_ahci_pcs7 }, /* DNV AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x19c1), board_ahci_pcs7 }, /* DNV AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x19c2), board_ahci_pcs7 }, /* DNV AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x19c3), board_ahci_pcs7 }, /* DNV AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x19c4), board_ahci_pcs7 }, /* DNV AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x19c5), board_ahci_pcs7 }, /* DNV AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x19c6), board_ahci_pcs7 }, /* DNV AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x19c7), board_ahci_pcs7 }, /* DNV AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x19cE), board_ahci_pcs7 }, /* DNV AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x19cF), board_ahci_pcs7 }, /* DNV AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x1c02), board_ahci }, /* CPT AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x1c03), board_ahci }, /* CPT M AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x1c04), board_ahci }, /* CPT RAID */
> -	{ PCI_VDEVICE(INTEL, 0x1c05), board_ahci }, /* CPT M RAID */
> -	{ PCI_VDEVICE(INTEL, 0x1c06), board_ahci }, /* CPT RAID */
> -	{ PCI_VDEVICE(INTEL, 0x1c07), board_ahci }, /* CPT RAID */
> -	{ PCI_VDEVICE(INTEL, 0x1d02), board_ahci }, /* PBG AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x1d04), board_ahci }, /* PBG RAID */
> -	{ PCI_VDEVICE(INTEL, 0x1d06), board_ahci }, /* PBG RAID */
> -	{ PCI_VDEVICE(INTEL, 0x2323), board_ahci }, /* DH89xxCC AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x1e02), board_ahci }, /* Panther Point AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci }, /* Panther M AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x1e04), board_ahci }, /* Panther Point RAID */
> -	{ PCI_VDEVICE(INTEL, 0x1e05), board_ahci }, /* Panther Point RAID */
> -	{ PCI_VDEVICE(INTEL, 0x1e06), board_ahci }, /* Panther Point RAID */
> -	{ PCI_VDEVICE(INTEL, 0x1e07), board_ahci }, /* Panther M RAID */
> -	{ PCI_VDEVICE(INTEL, 0x1e0e), board_ahci }, /* Panther Point RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c02), board_ahci }, /* Lynx Point AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x8c03), board_ahci }, /* Lynx M AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x8c04), board_ahci }, /* Lynx Point RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c05), board_ahci }, /* Lynx M RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c06), board_ahci }, /* Lynx Point RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c07), board_ahci }, /* Lynx M RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c0e), board_ahci }, /* Lynx Point RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c0f), board_ahci }, /* Lynx M RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c02), board_ahci }, /* Lynx LP AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x9c03), board_ahci }, /* Lynx LP AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x9c04), board_ahci }, /* Lynx LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c05), board_ahci }, /* Lynx LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c06), board_ahci }, /* Lynx LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c07), board_ahci }, /* Lynx LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c0e), board_ahci }, /* Lynx LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c0f), board_ahci }, /* Lynx LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9dd3), board_ahci }, /* Cannon Lake PCH-LP AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x1f22), board_ahci }, /* Avoton AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x1f23), board_ahci }, /* Avoton AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x1f24), board_ahci }, /* Avoton RAID */
> -	{ PCI_VDEVICE(INTEL, 0x1f25), board_ahci }, /* Avoton RAID */
> -	{ PCI_VDEVICE(INTEL, 0x1f26), board_ahci }, /* Avoton RAID */
> -	{ PCI_VDEVICE(INTEL, 0x1f27), board_ahci }, /* Avoton RAID */
> -	{ PCI_VDEVICE(INTEL, 0x1f2e), board_ahci }, /* Avoton RAID */
> -	{ PCI_VDEVICE(INTEL, 0x1f2f), board_ahci }, /* Avoton RAID */
> +	{ PCI_VDEVICE(INTEL, 0x2824), board_ahci_pcs_quirk }, /* ICH8 */
> +	{ PCI_VDEVICE(INTEL, 0x2829), board_ahci_pcs_quirk }, /* ICH8M */
> +	{ PCI_VDEVICE(INTEL, 0x282a), board_ahci_pcs_quirk }, /* ICH8M */
> +	{ PCI_VDEVICE(INTEL, 0x2922), board_ahci_pcs_quirk }, /* ICH9 */
> +	{ PCI_VDEVICE(INTEL, 0x2923), board_ahci_pcs_quirk }, /* ICH9 */
> +	{ PCI_VDEVICE(INTEL, 0x2924), board_ahci_pcs_quirk }, /* ICH9 */
> +	{ PCI_VDEVICE(INTEL, 0x2925), board_ahci_pcs_quirk }, /* ICH9 */
> +	{ PCI_VDEVICE(INTEL, 0x2927), board_ahci_pcs_quirk }, /* ICH9 */
> +	{ PCI_VDEVICE(INTEL, 0x2929), board_ahci_pcs_quirk }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x292a), board_ahci_pcs_quirk }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x292b), board_ahci_pcs_quirk }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x292c), board_ahci_pcs_quirk }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci_pcs_quirk }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x294d), board_ahci_pcs_quirk }, /* ICH9 */
> +	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci_pcs_quirk }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x502a), board_ahci_pcs_quirk }, /* Tolapai */
> +	{ PCI_VDEVICE(INTEL, 0x502b), board_ahci_pcs_quirk }, /* Tolapai */
> +	{ PCI_VDEVICE(INTEL, 0x3a05), board_ahci_pcs_quirk }, /* ICH10 */
> +	{ PCI_VDEVICE(INTEL, 0x3a22), board_ahci_pcs_quirk }, /* ICH10 */
> +	{ PCI_VDEVICE(INTEL, 0x3a25), board_ahci_pcs_quirk }, /* ICH10 */
> +	{ PCI_VDEVICE(INTEL, 0x3b22), board_ahci_pcs_quirk }, /* PCH AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x3b23), board_ahci_pcs_quirk }, /* PCH AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x3b24), board_ahci_pcs_quirk }, /* PCH RAID */
> +	{ PCI_VDEVICE(INTEL, 0x3b25), board_ahci_pcs_quirk }, /* PCH RAID */
> +	{ PCI_VDEVICE(INTEL, 0x3b29), board_ahci_pcs_quirk }, /* PCH M AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x3b2b), board_ahci_pcs_quirk }, /* PCH RAID */
> +	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci_pcs_quirk }, /* PCH M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x3b2f), board_ahci_pcs_quirk }, /* PCH AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x19b0), board_ahci }, /* DNV AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x19b1), board_ahci }, /* DNV AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x19b2), board_ahci }, /* DNV AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x19b3), board_ahci }, /* DNV AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x19b4), board_ahci }, /* DNV AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x19b5), board_ahci }, /* DNV AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x19b6), board_ahci }, /* DNV AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x19b7), board_ahci }, /* DNV AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x19bE), board_ahci }, /* DNV AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x19bF), board_ahci }, /* DNV AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x19c0), board_ahci }, /* DNV AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x19c1), board_ahci }, /* DNV AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x19c2), board_ahci }, /* DNV AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x19c3), board_ahci }, /* DNV AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x19c4), board_ahci }, /* DNV AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x19c5), board_ahci }, /* DNV AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x19c6), board_ahci }, /* DNV AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x19c7), board_ahci }, /* DNV AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x19cE), board_ahci }, /* DNV AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x19cF), board_ahci }, /* DNV AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x1c02), board_ahci_pcs_quirk }, /* CPT AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x1c03), board_ahci_pcs_quirk }, /* CPT M AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x1c04), board_ahci_pcs_quirk }, /* CPT RAID */
> +	{ PCI_VDEVICE(INTEL, 0x1c05), board_ahci_pcs_quirk }, /* CPT M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x1c06), board_ahci_pcs_quirk }, /* CPT RAID */
> +	{ PCI_VDEVICE(INTEL, 0x1c07), board_ahci_pcs_quirk }, /* CPT RAID */
> +	{ PCI_VDEVICE(INTEL, 0x1d02), board_ahci_pcs_quirk }, /* PBG AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x1d04), board_ahci_pcs_quirk }, /* PBG RAID */
> +	{ PCI_VDEVICE(INTEL, 0x1d06), board_ahci_pcs_quirk }, /* PBG RAID */
> +	{ PCI_VDEVICE(INTEL, 0x2323), board_ahci_pcs_quirk }, /* DH89xxCC AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x1e02), board_ahci_pcs_quirk }, /* Panther Point AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci_pcs_quirk }, /* Panther M AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x1e04), board_ahci_pcs_quirk }, /* Panther Point RAID */
> +	{ PCI_VDEVICE(INTEL, 0x1e05), board_ahci_pcs_quirk }, /* Panther Point RAID */
> +	{ PCI_VDEVICE(INTEL, 0x1e06), board_ahci_pcs_quirk }, /* Panther Point RAID */
> +	{ PCI_VDEVICE(INTEL, 0x1e07), board_ahci_pcs_quirk }, /* Panther M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x1e0e), board_ahci_pcs_quirk }, /* Panther Point RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c02), board_ahci_pcs_quirk }, /* Lynx Point AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x8c03), board_ahci_pcs_quirk }, /* Lynx M AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x8c04), board_ahci_pcs_quirk }, /* Lynx Point RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c05), board_ahci_pcs_quirk }, /* Lynx M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c06), board_ahci_pcs_quirk }, /* Lynx Point RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c07), board_ahci_pcs_quirk }, /* Lynx M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c0e), board_ahci_pcs_quirk }, /* Lynx Point RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c0f), board_ahci_pcs_quirk }, /* Lynx M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c02), board_ahci_pcs_quirk }, /* Lynx LP AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x9c03), board_ahci_pcs_quirk }, /* Lynx LP AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x9c04), board_ahci_pcs_quirk }, /* Lynx LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c05), board_ahci_pcs_quirk }, /* Lynx LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c06), board_ahci_pcs_quirk }, /* Lynx LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c07), board_ahci_pcs_quirk }, /* Lynx LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c0e), board_ahci_pcs_quirk }, /* Lynx LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c0f), board_ahci_pcs_quirk }, /* Lynx LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9dd3), board_ahci_pcs_quirk }, /* Cannon Lake PCH-LP AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x1f22), board_ahci_pcs_quirk }, /* Avoton AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x1f23), board_ahci_pcs_quirk }, /* Avoton AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x1f24), board_ahci_pcs_quirk }, /* Avoton RAID */
> +	{ PCI_VDEVICE(INTEL, 0x1f25), board_ahci_pcs_quirk }, /* Avoton RAID */
> +	{ PCI_VDEVICE(INTEL, 0x1f26), board_ahci_pcs_quirk }, /* Avoton RAID */
> +	{ PCI_VDEVICE(INTEL, 0x1f27), board_ahci_pcs_quirk }, /* Avoton RAID */
> +	{ PCI_VDEVICE(INTEL, 0x1f2e), board_ahci_pcs_quirk }, /* Avoton RAID */
> +	{ PCI_VDEVICE(INTEL, 0x1f2f), board_ahci_pcs_quirk }, /* Avoton RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1f32), board_ahci_avn }, /* Avoton AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1f33), board_ahci_avn }, /* Avoton AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1f34), board_ahci_avn }, /* Avoton RAID */
> @@ -365,65 +370,65 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x1f37), board_ahci_avn }, /* Avoton RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1f3e), board_ahci_avn }, /* Avoton RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1f3f), board_ahci_avn }, /* Avoton RAID */
> -	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Wellsburg/Lewisburg AHCI*/
> -	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* *burg SATA0 'RAID' */
> -	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* *burg SATA1 'RAID' */
> -	{ PCI_VDEVICE(INTEL, 0x282f), board_ahci }, /* *burg SATA2 'RAID' */
> -	{ PCI_VDEVICE(INTEL, 0x43d4), board_ahci }, /* Rocket Lake PCH-H RAID */
> -	{ PCI_VDEVICE(INTEL, 0x43d5), board_ahci }, /* Rocket Lake PCH-H RAID */
> -	{ PCI_VDEVICE(INTEL, 0x43d6), board_ahci }, /* Rocket Lake PCH-H RAID */
> -	{ PCI_VDEVICE(INTEL, 0x43d7), board_ahci }, /* Rocket Lake PCH-H RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8d02), board_ahci }, /* Wellsburg AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x8d04), board_ahci }, /* Wellsburg RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8d06), board_ahci }, /* Wellsburg RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8d0e), board_ahci }, /* Wellsburg RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8d62), board_ahci }, /* Wellsburg AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x8d64), board_ahci }, /* Wellsburg RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8d66), board_ahci }, /* Wellsburg RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8d6e), board_ahci }, /* Wellsburg RAID */
> -	{ PCI_VDEVICE(INTEL, 0x23a3), board_ahci }, /* Coleto Creek AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x9c83), board_ahci }, /* Wildcat LP AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x9c85), board_ahci }, /* Wildcat LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c87), board_ahci }, /* Wildcat LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c8f), board_ahci }, /* Wildcat LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c82), board_ahci }, /* 9 Series AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x8c83), board_ahci }, /* 9 Series M AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x8c84), board_ahci }, /* 9 Series RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c85), board_ahci }, /* 9 Series M RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c86), board_ahci }, /* 9 Series RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c87), board_ahci }, /* 9 Series M RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c8e), board_ahci }, /* 9 Series RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c8f), board_ahci }, /* 9 Series M RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9d03), board_ahci }, /* Sunrise LP AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x9d05), board_ahci }, /* Sunrise LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9d07), board_ahci }, /* Sunrise LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0xa102), board_ahci }, /* Sunrise Point-H AHCI */
> -	{ PCI_VDEVICE(INTEL, 0xa103), board_ahci }, /* Sunrise M AHCI */
> -	{ PCI_VDEVICE(INTEL, 0xa105), board_ahci }, /* Sunrise Point-H RAID */
> -	{ PCI_VDEVICE(INTEL, 0xa106), board_ahci }, /* Sunrise Point-H RAID */
> -	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci }, /* Sunrise M RAID */
> -	{ PCI_VDEVICE(INTEL, 0xa10f), board_ahci }, /* Sunrise Point-H RAID */
> -	{ PCI_VDEVICE(INTEL, 0xa182), board_ahci }, /* Lewisburg AHCI*/
> -	{ PCI_VDEVICE(INTEL, 0xa186), board_ahci }, /* Lewisburg RAID*/
> -	{ PCI_VDEVICE(INTEL, 0xa1d2), board_ahci }, /* Lewisburg RAID*/
> -	{ PCI_VDEVICE(INTEL, 0xa1d6), board_ahci }, /* Lewisburg RAID*/
> -	{ PCI_VDEVICE(INTEL, 0xa202), board_ahci }, /* Lewisburg AHCI*/
> -	{ PCI_VDEVICE(INTEL, 0xa206), board_ahci }, /* Lewisburg RAID*/
> -	{ PCI_VDEVICE(INTEL, 0xa252), board_ahci }, /* Lewisburg RAID*/
> -	{ PCI_VDEVICE(INTEL, 0xa256), board_ahci }, /* Lewisburg RAID*/
> -	{ PCI_VDEVICE(INTEL, 0xa356), board_ahci }, /* Cannon Lake PCH-H RAID */
> -	{ PCI_VDEVICE(INTEL, 0x06d7), board_ahci }, /* Comet Lake-H RAID */
> -	{ PCI_VDEVICE(INTEL, 0xa386), board_ahci }, /* Comet Lake PCH-V RAID */
> -	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci }, /* Bay Trail AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci }, /* Bay Trail AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci }, /* Cherry Tr. AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci }, /* ApolloLake AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x34d3), board_ahci }, /* Ice Lake LP AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x02d3), board_ahci }, /* Comet Lake PCH-U AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci }, /* Comet Lake PCH RAID */
> +	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci_pcs_quirk }, /* Wellsburg/Lewisburg AHCI*/
> +	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci_pcs_quirk }, /* *burg SATA0 'RAID' */
> +	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci_pcs_quirk }, /* *burg SATA1 'RAID' */
> +	{ PCI_VDEVICE(INTEL, 0x282f), board_ahci_pcs_quirk }, /* *burg SATA2 'RAID' */
> +	{ PCI_VDEVICE(INTEL, 0x43d4), board_ahci_pcs_quirk }, /* Rocket Lake PCH-H RAID */
> +	{ PCI_VDEVICE(INTEL, 0x43d5), board_ahci_pcs_quirk }, /* Rocket Lake PCH-H RAID */
> +	{ PCI_VDEVICE(INTEL, 0x43d6), board_ahci_pcs_quirk }, /* Rocket Lake PCH-H RAID */
> +	{ PCI_VDEVICE(INTEL, 0x43d7), board_ahci_pcs_quirk }, /* Rocket Lake PCH-H RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8d02), board_ahci_pcs_quirk }, /* Wellsburg AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x8d04), board_ahci_pcs_quirk }, /* Wellsburg RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8d06), board_ahci_pcs_quirk }, /* Wellsburg RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8d0e), board_ahci_pcs_quirk }, /* Wellsburg RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8d62), board_ahci_pcs_quirk }, /* Wellsburg AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x8d64), board_ahci_pcs_quirk }, /* Wellsburg RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8d66), board_ahci_pcs_quirk }, /* Wellsburg RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8d6e), board_ahci_pcs_quirk }, /* Wellsburg RAID */
> +	{ PCI_VDEVICE(INTEL, 0x23a3), board_ahci_pcs_quirk }, /* Coleto Creek AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x9c83), board_ahci_pcs_quirk }, /* Wildcat LP AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x9c85), board_ahci_pcs_quirk }, /* Wildcat LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c87), board_ahci_pcs_quirk }, /* Wildcat LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c8f), board_ahci_pcs_quirk }, /* Wildcat LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c82), board_ahci_pcs_quirk }, /* 9 Series AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x8c83), board_ahci_pcs_quirk }, /* 9 Series M AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x8c84), board_ahci_pcs_quirk }, /* 9 Series RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c85), board_ahci_pcs_quirk }, /* 9 Series M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c86), board_ahci_pcs_quirk }, /* 9 Series RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c87), board_ahci_pcs_quirk }, /* 9 Series M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c8e), board_ahci_pcs_quirk }, /* 9 Series RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c8f), board_ahci_pcs_quirk }, /* 9 Series M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9d03), board_ahci_pcs_quirk }, /* Sunrise LP AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x9d05), board_ahci_pcs_quirk }, /* Sunrise LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9d07), board_ahci_pcs_quirk }, /* Sunrise LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0xa102), board_ahci_pcs_quirk }, /* Sunrise Point-H AHCI */
> +	{ PCI_VDEVICE(INTEL, 0xa103), board_ahci_pcs_quirk }, /* Sunrise M AHCI */
> +	{ PCI_VDEVICE(INTEL, 0xa105), board_ahci_pcs_quirk }, /* Sunrise Point-H RAID */
> +	{ PCI_VDEVICE(INTEL, 0xa106), board_ahci_pcs_quirk }, /* Sunrise Point-H RAID */
> +	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci_pcs_quirk }, /* Sunrise M RAID */
> +	{ PCI_VDEVICE(INTEL, 0xa10f), board_ahci_pcs_quirk }, /* Sunrise Point-H RAID */
> +	{ PCI_VDEVICE(INTEL, 0xa182), board_ahci_pcs_quirk }, /* Lewisburg AHCI*/
> +	{ PCI_VDEVICE(INTEL, 0xa186), board_ahci_pcs_quirk }, /* Lewisburg RAID*/
> +	{ PCI_VDEVICE(INTEL, 0xa1d2), board_ahci_pcs_quirk }, /* Lewisburg RAID*/
> +	{ PCI_VDEVICE(INTEL, 0xa1d6), board_ahci_pcs_quirk }, /* Lewisburg RAID*/
> +	{ PCI_VDEVICE(INTEL, 0xa202), board_ahci_pcs_quirk }, /* Lewisburg AHCI*/
> +	{ PCI_VDEVICE(INTEL, 0xa206), board_ahci_pcs_quirk }, /* Lewisburg RAID*/
> +	{ PCI_VDEVICE(INTEL, 0xa252), board_ahci_pcs_quirk }, /* Lewisburg RAID*/
> +	{ PCI_VDEVICE(INTEL, 0xa256), board_ahci_pcs_quirk }, /* Lewisburg RAID*/
> +	{ PCI_VDEVICE(INTEL, 0xa356), board_ahci_pcs_quirk }, /* Cannon Lake PCH-H RAID */
> +	{ PCI_VDEVICE(INTEL, 0x06d7), board_ahci_pcs_quirk }, /* Comet Lake-H RAID */
> +	{ PCI_VDEVICE(INTEL, 0xa386), board_ahci_pcs_quirk }, /* Comet Lake PCH-V RAID */
> +	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci_pcs_quirk }, /* Bay Trail AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci_pcs_quirk }, /* Bay Trail AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci_pcs_quirk }, /* Cherry Tr. AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci_pcs_quirk }, /* ApolloLake AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x34d3), board_ahci_pcs_quirk }, /* Ice Lake LP AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x02d3), board_ahci_pcs_quirk }, /* Comet Lake PCH-U AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_pcs_quirk }, /* Comet Lake PCH RAID */
>  	/* Elkhart Lake IDs 0x4b60 & 0x4b62 https://sata-io.org/product/8803 not tested yet */
> -	{ PCI_VDEVICE(INTEL, 0x4b63), board_ahci }, /* Elkhart Lake AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x7ae2), board_ahci }, /* Alder Lake-P AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x4b63), board_ahci_pcs_quirk }, /* Elkhart Lake AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x7ae2), board_ahci_pcs_quirk }, /* Alder Lake-P AHCI */
>  
>  	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
>  	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> @@ -458,7 +463,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  
>  	/* Dell S140/S150 */
>  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, PCI_SUBVENDOR_ID_DELL, PCI_ANY_ID,
> -	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
> +	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci_pcs_quirk },
>  
>  	/* VIA */
>  	{ PCI_VDEVICE(VIA, 0x3349), board_ahci_vt8251 }, /* VIA VT8251 */
> @@ -1681,17 +1686,9 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap)
>  
>  static void ahci_intel_pcs_quirk(struct pci_dev *pdev, struct ahci_host_priv *hpriv)
>  {
> -	const struct pci_device_id *id = pci_match_id(ahci_pci_tbl, pdev);
>  	u16 tmp16;
>  
> -	/*
> -	 * Only apply the 6-port PCS quirk for known legacy platforms.
> -	 */
> -	if (!id || id->vendor != PCI_VENDOR_ID_INTEL)
> -		return;
> -
> -	/* Skip applying the quirk on Denverton and beyond */
> -	if (((enum board_ids) id->driver_data) >= board_ahci_pcs7)
> +	if (!(hpriv->flags & AHCI_HFLAG_INTEL_PCS_QUIRK))
>  		return;
>  
>  	/*
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 4a0a602c6b16..344c87210d8f 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -245,6 +245,7 @@ enum {
>  						      suspend/resume */
>  	AHCI_HFLAG_NO_SXS		= BIT(26), /* SXS not supported */
>  	AHCI_HFLAG_43BIT_ONLY		= BIT(27), /* 43bit DMA addr limit */
> +	AHCI_HFLAG_INTEL_PCS_QUIRK	= BIT(28), /* apply Intel PCS quirk */
>  
>  	/* ap->flags bits */
>  
> -- 
> 2.43.0
> 

Applied:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-6.9
