Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114971;
	b=amEtdjrhED2skyZM1/BIkS/hnWg6DFAft0XEP1NZH6GlhonebBqutR4Zcpda7ibm6INh
	 XT9XgIYXEB+sUF8T+BetWGn0Fi0aH3mBZtTDAY/IsFxsOWyeKE6gShfoFMCiqp6So7wBB
	 mAJyHs1Gy+KBUN/89i7IyD9a4X/a2ltOgZIyztfzybR04P4r3/fJfHb9faZi+qUcTSfgM
	 R9U3HXpgCvvBTDjBS4CCtzGi4G3AlyzRpND0fNWnltuZDEb/Q449BRsVVDqdI3W7fB0D+
	 uNhfjS+IMwRYQHNsocyukAr5qqiGUEIQ4ibrB123VtpIkEPBOH5RPe5H91RXx7se/ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114971;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UBPR9DAT+8Z0FnLOrEiXJ1kMEQ7hNL++jBbQMN+vBqA=;
	b=Z4C8oeclW3UQzc/u3I1eg0sQFfAcMlnHVUVP1eDbf5Cf3OlKVZhMVhAmvlIne848QZ3u
	 iuPve7fDp9/bC0oaiKw89lrEPIR8IN6OuszieFkSPAe8/mFBtHeJOypVFQxQc62aeDzUS
	 +nOgpnGKhe+91g9ITsx7/9j9d1wOGmn+McE+oloPlif9F8LLTi7HKEoVCNyqI+yf+Cxh0
	 QOFerhA5bJiLd6Bb3upMMi6AVuLz90G3gmpPRfGlswTdUV9KOCftIlzG4v5R8zDsog8u0
	 xzcF5y6bLKeOfFmUJyKZVELRbMuBB0c6ZY038vMw+T5GL2E8tRxYEYUVKG9dCotTCpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mGTYU0fP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D343606A31B;
	Tue, 27 Oct 2026 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mGTYU0fP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82B71F01825;
	Tue, 27 Oct 2026 15:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793114971;
	bh=UBPR9DAT+8Z0FnLOrEiXJ1kMEQ7hNL++jBbQMN+vBqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mGTYU0fPvMrK0QfB0aLDKVSoGJo20/A+UgrOtH0ErZGzXDmLbEUU7mpjaBuA50Mip
	 fD42Tfln3Jzu9bMV/m9jOumNXvQznFin9UY+C6fyn4TgWj2wADHv4XQSHkHJrniGer
	 qkT+y3WWgIrKNZu74eAEz0zdAwf5GQQeHcNx2OEtjES3YE4XZCVCCiabw8DCRMVKww
	 Z1SLipo102rWvPcve7aF1yAbKg0Fpa+pegJz1hMinYfGXxOa5GjynzlggQCJ2V0p0H
	 2sRDh5xob6DIyAz36fwRvFQPDd2nBExPHuqxSPDGV/2G7plmmy9yMGRbpAuZ3bnlN6
	 tNoJVAxZxeXkg==
Date: Tue, 27 Oct 2026 16:29:27 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Roman Gardzinski <romanx.gardzinski@linux.intel.com>
Cc: dlemoal@kernel.org, szczepan.durawa@intel.com,
	szymon.durawa@linux.intel.com, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ATA: ahci: Add Intel PCH-S RAID device ID
Message-ID: <auDDV8POVT65vhvT@ryzen>
References: <20261027141240.7850-1-romanx.gardzinski@linux.intel.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027141240.7850-1-romanx.gardzinski@linux.intel.com>

Hello Roman,

On Tue, Oct 27, 2026 at 03:12:40PM +0100, Roman Gardzinski wrote:
> Add support for SATA devices in RAID mode for Nova Lake.
> No functional changes.
> 
> Suggested-by: Szczepan Durawa <szczepan.durawa@intel.com>
> Reviewed-by: Szymon Durawa <szymon.durawa@linux.intel.com>
> Signed-off-by: Roman Gardzinski <romanx.gardzinski@linux.intel.com>
> ---
>  drivers/ata/ahci.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 9b8c0935001c..c60e7ba24502 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -283,6 +283,10 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  		/* Comet Lake PCH-H RAID */
>  		PCI_VDEVICE(INTEL, 0x06d6),
>  		.driver_data = board_ahci_pcs_quirk,
> +	}, {
> +		/* Nova Lake PCH-S RAID */
> +		PCI_VDEVICE(INTEL, 0x6e66),
> +		.driver_data = board_ahci_pcs_quirk,

Commit message should probably say something like:

When the Intel Nova Lake SATA controller is configured in RAID mode (rather
than AHCI), the generic entry in ahci_pci_tbl which matches any device with
the PCI class code for AHCI, is not sufficient, since the SATA controller
in RAID mode uses a different PCI class code.


Like Sashiko also said, please also check if this entry (for RAID mode)
should use board_ahci_pcs_quirk or board_ahci.


Kind regards,
Niklas
