Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A96D28ECE3
	for <linux-ide@vger.kernel.org>; Tue, 17 Jun 2025 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750150349; cv=none; b=AdDsuhfzvhOsIZk+GZhT1TdkLTcgYIjeiI1UijamhVMTLXOrVnnAQpylNHa7XlqOJnNdYhOtheGuu+4zRyBMQgOZpDEOgdqwkM0T7eR2ue1k4UeiHnWux2dCHSNkCLlQM3uMt287UfVi1rQ0rWgZ4i3nXiBZ8hn9Dnm0Mt/FYMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750150349; c=relaxed/simple;
	bh=7stH/IdhAGZMYPmKcWK59JC1XvmF7pUd0aOV2Ei9P1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3Ghq24pTSfxViW83ufZsmWJJE9Ahw+e/4uYFbSTnPL8vLkOw8lJEOiLWRBNpYC9Mvyzkr/Bj0VE574bULV5NGmQBuC1UhU+wZIXq/wk+0u9Bhg3OK9FkNoBPY4LBRIb/qxlMJtqpSA35DmbEHAnrMEQDueL65f+XArUUf0YkZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkCJciP8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkCJciP8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9C9C4CEE3;
	Tue, 17 Jun 2025 08:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750150348;
	bh=7stH/IdhAGZMYPmKcWK59JC1XvmF7pUd0aOV2Ei9P1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EkCJciP8Z6QKU5UnTaSy8SvpBcguJlfaZ4bqYrrIAFR1j6rrAkZRYrnIRYg1w8Ome
	 QscfKHU+g01FcC4ATCCc2ddkABS8sV/ntI3ggVCG+9WhDUymKD9eOAHZGtLjC1t8g2
	 53gTnbvY1vF594NSf8xgm1xDU9o1x5yjCn4i3WkcszTAgOt5q02VUvFjfbgoc5RLVU
	 8/k5WGVB5aWHFtfVcybwsm8kVPi7Lb/d0D3z92t+dtTJUpw2mWO/20qShO5NOe2wsw
	 /WNPGDDyYXKSoRFIQo1hWcGb42oh9tXCONFmOzaNjrU2J5zU/Uku0wNxlb2i+KF3OJ
	 UYP4b3hDXEyQQ==
Date: Tue, 17 Jun 2025 10:52:25 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Mikko Korhonen <mjkorhon@gmail.com>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: ahci: Disallow LPM for Asus B550-F motherboard
Message-ID: <aFEsyRGzsM65y0xF@ryzen>
References: <20250617062055.784827-1-mjkorhon@gmail.com>
 <14325a6a-6f95-4767-bcbd-cb9b735e8b37@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14325a6a-6f95-4767-bcbd-cb9b735e8b37@kernel.org>

On Tue, Jun 17, 2025 at 03:32:17PM +0900, Damien Le Moal wrote:
> On 6/17/25 3:18 PM, Mikko Korhonen wrote:
> > Asus ROG STRIX B550-F GAMING (WI-FI) motherboard has problems on some
> > SATA ports with at least one hard drive model (WDC WD20EFAX-68FB5N0)
> > when LPM is enabled. Disabling LPM solves the issue.
> > 
> > Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> > Signed-off-by: Mikko Korhonen <mjkorhon@gmail.com>
> > ---
> > I think we might include the comment about the non working drive model, as
> > we have tested only one model and in principle this could also be an
> > interoperation issue. If one would need to enable LPM for the motherboard
> > and happens to have a working hard drive model, he/she would know
> > why we have made the patch in the first place.
> > 
> >  drivers/ata/ahci.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> > index c8ad8ace7496..ae8c4072a5a3 100644
> > --- a/drivers/ata/ahci.c
> > +++ b/drivers/ata/ahci.c
> > @@ -1454,6 +1454,22 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
> >  			},
> >  			/* 320 is broken, there is no known good version yet. */
> >  		},
> > +		{
> > +			/*
> > +			 * AMD 500 Series Chipset SATA Controller [1022:43eb]
> > +			 * on this motherboard timouts on ports 5 and 6

s/timouts/timeouts/

> > +			 * when LPM enabled at least with WDC WD20EFAX-68FB5N0
> > +			 * hard drives.
> > +			 */
> > +			.matches = {
> > +				DMI_MATCH(DMI_BOARD_VENDOR,
> > +					"ASUSTeK COMPUTER INC."),

align to open parenthesis


> > +				DMI_MATCH(DMI_BOARD_NAME,
> > +					"ROG STRIX B550-F GAMING (WI-FI)"),

align to open parenthesis


> > +			},
> > +			/* 3621 is broken, there is no known good version yet.
> > +			 */
> 
> Please use the correct comment format:
> 
> 			/*
> 			 * 3621 is broken and there is no known good version.
> 			 */

I think having it a single line as:
	/* 3621 is broken and there is no known good version. */

is fine, as it will be less than 80 columns, and matches the
existing single line comments in the same table.


Anyway, I can fix these nits up when applying, no need to send a V2.

Mikko, thank you for your efforts in debugging and helping out with
reviews.


Kind regards,
Niklas
