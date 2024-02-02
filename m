Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B337AD47
	for <linux-ide@vger.kernel.org>; Fri,  2 Feb 2024 02:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706839755; cv=none; b=aYvIaL+PmwswlB5pTaKqH+UPoks9hZKHJCL829KgiI6Ynxc5TyM9MVetJ7JguNR4vd1U/nHR7eED9aZHM0K987YfnJL1WpVunIlOPZuzOHbxhC9nQ9K9rCze9kzZb1JR4hSeNlk05cdy5p1/bSBmrDWurGQo3vp54LsapeQHBVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706839755; c=relaxed/simple;
	bh=sFHDO2UJF1mSRxZz4IA8fF1LdDi+ylOFoQV7OQkxGh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IDU/oL/lpkQVna5IOM8K5w2uhzBQNwPACReWmwfk6ZbDJKy1Hpxx1g06PNzpDOi2aca1yGK24muQ2wD4eGMe1rDz9vRVXRwXCdwJRKUgdAXViNmk3AxOV2cmhvhorZW9c270ee/wB5i17s351Iay5RCy9NYQxw9Dolec3HDvA40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUIuI5+9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUIuI5+9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF10FC433C7;
	Fri,  2 Feb 2024 02:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706839755;
	bh=sFHDO2UJF1mSRxZz4IA8fF1LdDi+ylOFoQV7OQkxGh0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WUIuI5+9PXBkfvs05GUcyYbhEVFBL6B18iFFFFvOEIi4wI+aAAgeIx/KS1xI4vMLG
	 oJI95gWHfuDYmSuploBMuesfAAA3e2iMucnGcR0rLv7lz8NAF05vw6SH/JdXvCd0sM
	 0BRfo1iEgghBL4tdEiY96mxgEpy0//gw110H3ibLClELwCIG5hW0V+CAVPEyiUMrxz
	 aYVVlM7ICTbEZQGFl3wrFYTjWtkfJIYgk2/8MugkyiVTymtM1wqCc18WSBWbUAcPrP
	 hA9VVyHyCbd4JZonfQRNwujie/SPEP65RMiXnmqa0kleP+q1a8F5t4gO0SVVjuloUs
	 FmPYezaTAB7qw==
Message-ID: <6f3135f0-73c7-4ddf-b4c6-916eab32c237@kernel.org>
Date: Fri, 2 Feb 2024 11:09:12 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] ata: ahci: do not enable LPM on external ports
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>
Cc: Werner Fischer <devlists@wefi.net>, Daniel Drake <drake@endlessos.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jian-Hong Pan <jhp@endlessos.org>, Dieter Mummenschanz
 <dmummenschanz@web.de>, linux-ide@vger.kernel.org
References: <20240201161507.1147521-1-cassel@kernel.org>
 <20240201161507.1147521-5-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240201161507.1147521-5-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/24 01:15, Niklas Cassel wrote:
> The SATA specification contains a known incompatibility between LPM and
> hot-plug events, thus do not enable LPM if the port advertises itself as
> being an external SATA port (i.e. either hot-plug capable or eSATA).
> 
> This matches the power policy used in Microsoft Windows, which disables
> LPM for external SATA ports, such that hot-plug events can be received.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/ahci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 19b605c98d42..d50d1ae44e7f 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1664,6 +1664,14 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap)
>  	if (!(hpriv->flags & AHCI_HFLAG_USE_LPM_POLICY))
>  		return;
>  
> +	/*
> +	 * The SATA specification contains a known incompatibility between LPM
> +	 * and hot-plug events, thus do not enable LPM if the port advertises
> +	 * itself as an external port (i.e. either hot-plug capable or eSATA).
> +	 */

s/SATA/Serial ATA Revision 3.5a ?
s/contains/warns about ?

I see section 5.3.10 "Potential external SATA incompatibility issues" but it
does not mention LPM. Where is this stated in SATA-IO ?

> +	if (ap->pflags & ATA_PFLAG_EXTERNAL)
> +		return;
> +
>  	/* user modified policy via module param */
>  	if (mobile_lpm_policy != -1) {
>  		policy = mobile_lpm_policy;

-- 
Damien Le Moal
Western Digital Research

