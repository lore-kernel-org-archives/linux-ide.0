Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD78350A7E
	for <linux-ide@vger.kernel.org>; Thu,  8 Feb 2024 23:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707435199; cv=none; b=YbULY3Is0kXN/S48cdDr4SJ77JEJzsObE5HgaCrQKR29tzFpANgfs+gXqk02HdDzVfZ6hWQIAWRSfV4sTCdoKR48/7vVRJZEhcfPudSuUjKFhj6zEEDLApgddyB8rMv59K24ROgVmvT7XwvSQSKmDd9f/vnB4UTjwyT4ttvnZ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707435199; c=relaxed/simple;
	bh=pXHqnhF2DFDCKsLTvxtkWcI5L1stEU8Eu7oCXhNqMvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X29Bdfm4pF+NLjbIYiD5QVuw3JOKOXgyvHHWebc+oaOCOkNFqxmV8yHJ+KN7Q1oYtjbFRLO7ub1JwWfvoA3q4f593V8hnhSmOgSqNQZt0pPDk4jGLYgIe0MtNe1R6aCWBXpZbG0+GgopCgWy7kCFYsq5KyAmK0WeBc7ppa95CHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6dfyYV6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6dfyYV6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948A2C433C7;
	Thu,  8 Feb 2024 23:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707435199;
	bh=pXHqnhF2DFDCKsLTvxtkWcI5L1stEU8Eu7oCXhNqMvI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g6dfyYV6Tq3PKzui9HvqgIiopE49iFUnYjjDdc4/nGgsk0SaarWiM2H9O9AUwj9Lj
	 +NFbZolPea0VH9/cRUDTFIoTDfjTwTyAH9reNYPCq8wgfzglNiEBt88c9niyxcMIga
	 MlTMgblzjcH/CsVuCgSKWkKo3Gc//UaAudSWhIAMk17jORyT3ar3lpQFlTk47n7H7N
	 WTlQdBS4Xo+CtVQwCyV53iTf468Y32FQ8tw6trAgZPrhak12cuvH+XdlsZhMUJEtoI
	 k7YxFkxymMnQ9ZFrNJNfLYHNgdwM2Vi8TY27a/Xwu5nTXU0fRIOpgU5nNkEGHJXwY/
	 wydtumHwWMtIw==
Message-ID: <2bd6908c-e428-46f2-9155-10b50a81fa79@kernel.org>
Date: Fri, 9 Feb 2024 08:33:17 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ahci: document and clarify unconventional intel quirk
To: Niklas Cassel <cassel@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-ide@vger.kernel.org
References: <20240207091054.1697236-1-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240207091054.1697236-1-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/24 18:10, Niklas Cassel wrote:
> The ahci_intel_pcs_quirk is unconventional in several ways:
> First of all because it has a board ID for which the quirk should NOT be
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
> While this quirk should definitely be cleaned up to be implemented like
> all other quirks, for now, at least document the behavior of this quirk.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217114
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/ahci.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index da2e74fce2d9..122278438092 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -69,8 +69,8 @@ enum board_ids {
>  	board_ahci_vt8251,
>  
>  	/*
> -	 * board IDs for Intel chipsets that support more than 6 ports
> -	 * *and* end up needing the PCS quirk.
> +	 * board IDs for Intel chipsets that should NOT have the
> +	 * ahci_intel_pcs_quirk applied. Yes, this is not a typo.
>  	 */
>  	board_ahci_pcs7,
>  
> @@ -1670,14 +1670,33 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap,
>  		ap->target_lpm_policy = policy;
>  }
>  
> +/*
> + * NOTE: this quirk is applied for all board IDs in ahci_pci_tbl, where
> + * the PCI vendor ID == PCI_VENDOR_ID_INTEL (except for board_ahci_pcs7).
> + *
> + * This quirk causes some Intel AHCI controllers (e.g. Intel Tiger Lake)
> + * to not get a link up when Intel VMD is enabled, see:
> + * https://bugzilla.kernel.org/show_bug.cgi?id=217114
> + *
> + * Since the quirk is only applied for explicit entries in ahci_pci_tbl
> + * (it does not apply to the generic entry in ahci_pci_tbl that matches on
> + * AHCI class code), if your Intel AHCI controller does not get a link up
> + * because of this quirk, try to remove the explicit entry from ahci_pci_tbl.
> + */
>  static void ahci_intel_pcs_quirk(struct pci_dev *pdev, struct ahci_host_priv *hpriv)
>  {
> -	const struct pci_device_id *id = pci_match_id(ahci_pci_tbl, pdev);
> +	const struct pci_device_id *id;
>  	u16 tmp16;
>  
> +	/* If the detected PCI device is not an Intel device, skip. */
> +	if (pdev->vendor != PCI_VENDOR_ID_INTEL)
> +		return;

Can't we also skip TigerLake ?

> +
>  	/*
> -	 * Only apply the 6-port PCS quirk for known legacy platforms.
> +	 * See if there is an explicit entry for this PCI device in
> +	 * ahci_pci_tbl, if there is not, do not apply the quirk.
>  	 */
> +	id = pci_match_id(ahci_pci_tbl, pdev);
>  	if (!id || id->vendor != PCI_VENDOR_ID_INTEL)
>  		return;
>  

-- 
Damien Le Moal
Western Digital Research

