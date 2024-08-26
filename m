Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF99518BB84
	for <linux-ide@vger.kernel.org>; Mon, 26 Aug 2024 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683172; cv=none; b=CwPtvBq/4WEZ/V3Uncy+oQ06A5IWVJ1mzJaippNAJX3ctbwftIUHZJ1xHhrHbZaILClvdUDcZyXjBhYQ75j13boKZMAArmDhbV7ubcyxAXU177f0EVXak9fdOzIO5jhmuj0a/xpIvMZvHkfM93mTE8s+v1kF49U9vwSNcgNMVGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683172; c=relaxed/simple;
	bh=pElz/HbtGu07tM2xQu5Akvu9adNtkQ3AVidnMhmpE1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4E8oqd1voHouEsciKwWf59ZObqYRYEfRwHwkgK5+T99NaOiAmk9gpTC2xPntC84j1FScQdmRTKVwTsnK3Y5BEIbe43jasXmf7aPHQUSb/5EfgjQujn9+gaxcSimqtbZV8uLbT0RA4eZKJim2jrxwo+5lpMTQU6TymAQUpasEp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZehAmO6Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZehAmO6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21320C4FEEA;
	Mon, 26 Aug 2024 14:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724683171;
	bh=pElz/HbtGu07tM2xQu5Akvu9adNtkQ3AVidnMhmpE1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZehAmO6QvxmB6pSLZifETNhvJG1hC2So/g2HsIWXXrxfG6yiK8lhXgVD0vYF7K7gG
	 Dd8KFaEhmAqD0e2E1xCmfSXfwzQRgn1LBiMWy+9S6WZvLrb/YRrP7BuojDzovQ56Xj
	 HHfhg60CdXqA23jbBtxZwV8xQ4BIXOJLsLegJxIpQsrMrAUE9hnxj+vc0xDcGSPhcx
	 1WvD7mgJMlAlQYUcB4OG39yD1gFS4n8bxBI9mRrpe5ekNO59F9AiUXtMebND7gLHJ1
	 hyPUxM8zof/8P/Ojh3yS2I64JVlSRsG+GA8Q28g+hFUgPxtdXQM8zdVTT60k1+HiKz
	 nq+lIF9t6a+Uw==
Date: Mon, 26 Aug 2024 16:39:28 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 2/7] ata: libata: Improve __ata_qc_complete()
Message-ID: <ZsyToLN_idabIFIa@ryzen.lan>
References: <20240826073106.56918-1-dlemoal@kernel.org>
 <20240826073106.56918-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826073106.56918-3-dlemoal@kernel.org>

On Mon, Aug 26, 2024 at 04:31:01PM +0900, Damien Le Moal wrote:
> The function __ata_qc_complete() is always called with a qc that already
> has been dereferenced and so is guaranteed to be non-NULL (as otherwise
> the kernel would have crashed). So remove the warning for a NULL qc as
> it is useless.
> 
> Furthermore, the qc passed to __ata_qc_complete() must always be marked
> as active with the ATA_QCFLAG_ACTIVE flag. If that is not the case, in
> addition to the existing warning, return early so that we do not attempt
> to complete an invalid qc.
> 
> Finally, fix the comment related to clearing the qc active flag as that
> operation applies to all devices, not just ATAPI ones.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/libata-core.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index e4023fc288ac..5acc37397f4b 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4829,8 +4829,9 @@ void __ata_qc_complete(struct ata_queued_cmd *qc)
>  	struct ata_port *ap;
>  	struct ata_link *link;
>  
> -	WARN_ON_ONCE(qc == NULL); /* ata_qc_from_tag _might_ return NULL */
> -	WARN_ON_ONCE(!(qc->flags & ATA_QCFLAG_ACTIVE));
> +	if (WARN_ON_ONCE(!(qc->flags & ATA_QCFLAG_ACTIVE)))
> +		return;
> +
>  	ap = qc->ap;
>  	link = qc->dev->link;
>  
> @@ -4852,9 +4853,10 @@ void __ata_qc_complete(struct ata_queued_cmd *qc)
>  		     ap->excl_link == link))
>  		ap->excl_link = NULL;
>  
> -	/* atapi: mark qc as inactive to prevent the interrupt handler
> -	 * from completing the command twice later, before the error handler
> -	 * is called. (when rc != 0 and atapi request sense is needed)
> +	/*
> +	 * Mark qc as inactive to prevent the port interrupt handler from
> +	 * completing the command twice later, before the error handler is
> +	 * called.
>  	 */
>  	qc->flags &= ~ATA_QCFLAG_ACTIVE;
>  	ap->qc_active &= ~(1ULL << qc->tag);
> -- 
> 2.46.0
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>
