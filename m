Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B971624C5
	for <linux-ide@vger.kernel.org>; Wed, 26 Feb 2025 02:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535716; cv=none; b=Ubaxpfx8mW3F0lAr9DrvN9HgNVeseep78VUcg8ijuPbt+EHxwQyhcLIJfa4d20S7Xx66BZlarULCmC84Jd5S8/dnZuY3W34duutIYdOAjqhve4y5G4Q+UcZ8Da/aGjQ3waoxAUNtRKy+PVX5KQ4rTMCsFDpibWt3VVsICbifzhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535716; c=relaxed/simple;
	bh=8dzmC/1cUkroCvdOkKg6DSqKG63A5D63S9LqEeqYWjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dI1c092aHCmkyFHOq4c8NQMQ5lwoQHig/VKBIsfopEy6khpH+WnPmg8ZSTWYJCmNIQVS5r9N/JnvjGWHhD1/oxQInGWPnlkNCw77nVXmLz4V3cZfkmiSBHtj76lMxg1yxR6HgtI8398C+whKeJUVV03aurcJMWCHyLnJWs65Ii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzzKDDCx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzzKDDCx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4BBC4CEDD;
	Wed, 26 Feb 2025 02:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740535716;
	bh=8dzmC/1cUkroCvdOkKg6DSqKG63A5D63S9LqEeqYWjI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rzzKDDCxErNMC6gjwHfKmRsPq308aeIOl2NM2FBSaedQXbyXgIZR0jnaSaxrx25ff
	 8JQOAjoEwJesxoONZVm14HTovKSzJ4CPhmZPbW2DMGsPEcUzBYTjeXHMLZ1Mkhe9BP
	 7wCWQiVsEgYGem2Dudq18d4Q0tCsCm4maH32V7aDNqa+cBm0IJ5gPgkMAFsUtZl1Z2
	 vTAlwnBDj6HkHHisIpsF1GJmLbaJtzCh60eh06028MoZxZ9gbzmdiPdPxFn7mYQ9J2
	 atSySVlgJcQj+LWEpxFS1Q9Bw3qRrwbkeCKWop3OQMsBsZTRqMU/YAsu/3QStIfLpi
	 lOEDVEy5myd1w==
Message-ID: <121ae734-e56e-4731-8d8d-ace79c5e8793@kernel.org>
Date: Wed, 26 Feb 2025 11:08:28 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci: Make ahci_ignore_port() handle empty
 mask_port_map
To: Niklas Cassel <cassel@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Josua Mayer <josua@solid-run.com>
Cc: Klaus Kudielka <klaus.kudielka@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-ide@vger.kernel.org
References: <20250225141612.942170-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250225141612.942170-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/25/25 11:16 PM, Niklas Cassel wrote:
> Commit 8c87215dd3a2 ("ata: libahci_platform: support non-consecutive port
> numbers") added a skip to ahci_platform_enable_phys() for ports that are
> not in mask_port_map.
> 
> The code in ahci_platform_get_resources(), will currently set mask_port_map
> for each child "port" node it finds in the device tree.
> 
> However, device trees that do not have any child "port" nodes will not have
> mask_port_map set, and for non-device tree platforms mask_port_map will
> only exist as a quirk for specific PCI device + vendor IDs, or as a kernel
> module parameter, but will not be set by default.
> 
> Therefore, the common thing is that mask_port_map is only set if you do not
> want to use all ports (as defined by Offset 0Ch: PI – Ports Implemented
> register), but instead only want to use the ports in mask_port_map. If
> mask_port_map is not set, all ports are available.
> 
> Thus, ahci_ignore_port() must be able to handle an empty mask_port_map.
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Closes: https://lore.kernel.org/linux-ide/10b31dd0-d0bb-4f76-9305-2195c3e17670@samsung.com/
> Co-developed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Fixes: 8c87215dd3a2 ("ata: libahci_platform: support non-consecutive port numbers")
> Fixes: 2c202e6c4f4d ("ata: libahci_platform: Do not set mask_port_map when not needed")

I think that it also would be a good idea to add:

Fixes: c9b5be909e65 ("ahci: Introduce ahci_ignore_port() helper")

So that this patch also gets picked up for backporting.

> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/ahci.h    | 8 ++++++--
>  drivers/ata/libahci.c | 1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index aea30df50c58..b2e0ef4efbdc 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -386,8 +386,12 @@ struct ahci_host_priv {
>  static inline bool ahci_ignore_port(struct ahci_host_priv *hpriv,
>  				    unsigned int portid)
>  {
> -	return portid >= hpriv->nports ||
> -		!(hpriv->mask_port_map & (1 << portid));
> +	if (portid >= hpriv->nports)
> +		return true;
> +	/* mask_port_map not set means that all ports are available */
> +	if (!hpriv->mask_port_map)
> +		return false;
> +	return !(hpriv->mask_port_map & (1 << portid));
>  }
>  
>  extern int ahci_ignore_sss;
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index fdfa7b266218..e7ace4b10f15 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -541,6 +541,7 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
>  		hpriv->saved_port_map = port_map;
>  	}
>  
> +	/* mask_port_map not set means that all ports are available */
>  	if (hpriv->mask_port_map) {
>  		dev_warn(dev, "masking port_map 0x%lx -> 0x%lx\n",
>  			port_map,


-- 
Damien Le Moal
Western Digital Research
