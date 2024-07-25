Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8482339A0
	for <linux-ide@vger.kernel.org>; Thu, 25 Jul 2024 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721925779; cv=none; b=ohLjxYlPJcKxp7+Tc9s4It8rqyNmKFHvqfeTKVt7jJRnoAyDQcpX0wJRRSpXEw8PE1JEu14zzFHPea55f1CDYZW0xNr9QQ5H5T3kcKhUTGT4E7r4wZ51cGoPixt/QrXjuxfCziEe2ETFGAMqk+/h07fKEtz+X0TyE6Hb3xgyBiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721925779; c=relaxed/simple;
	bh=CZXeXJjE+19n+dhEHjl+vuJ7KZsDa+1R4s9+ZZsSKK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rab5JgoArL23/xHzQ6ABqJ8DAjSdNotsnFa+g6SrTg6odLyWNGRJxPbqzDIIYrvlGtucxn9/WeWK5KT06gsSAR9WN/QVDyR0MjfhTWxc+YaR5dB03DTatS3kB03xInLQknIaHlsHIqw2xikfZlTQJjKmLtNiOa7hzaUxG3FfKO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVTe5jsP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVTe5jsP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52B9C116B1;
	Thu, 25 Jul 2024 16:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721925779;
	bh=CZXeXJjE+19n+dhEHjl+vuJ7KZsDa+1R4s9+ZZsSKK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JVTe5jsPxZyO0SYI5jL3GUd6I8DqeY0S++T77kUBFBJ+VMJj+6K8pETUi2brm+28f
	 YmLt/ag8UaqImAYgsXQ+tYEWMHBHHw52zM8+51PRDHUnnz7TimyyZpCQJVexQ9GIc4
	 oJfy4/jlpGLXyQn89Db46B5XnolVPlrIlnT61+nqtjp7ngdpEQuOgExojawqO/3H7l
	 dAa4Ceojyr3VQFF/aiEp9tBmx6kme/8gSdbLxHC0pLAk3L68xzgqB9nRd+8p1jr6kP
	 AQ0RM3wCY5m4MtddxepiX5crTJs0KiDUeikxSYaBuVma/tzqiQKqKGhEUewfOUAQwz
	 AJ4lOgEbkOzgg==
Date: Thu, 25 Jul 2024 18:42:55 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v5 1/4] ata: libata: Rename ata_dma_blacklisted()
Message-ID: <ZqKAj-wlHTLqCnjj@ryzen.lan>
References: <20240724054539.182655-1-dlemoal@kernel.org>
 <20240724054539.182655-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724054539.182655-2-dlemoal@kernel.org>

On Wed, Jul 24, 2024 at 02:45:36PM +0900, Damien Le Moal wrote:
> Rename the function ata_dma_blacklisted() to ata_dev_nodma() as this new
> name is more neutral. The function signature is also changed to return a
> boolean instead of an int.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/ata/libata-core.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index c7752dc80028..a35bce4236d3 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4287,16 +4287,17 @@ static unsigned long ata_dev_blacklisted(const struct ata_device *dev)
>  	return 0;
>  }
>  
> -static int ata_dma_blacklisted(const struct ata_device *dev)
> +static bool ata_dev_nodma(const struct ata_device *dev)
>  {
> -	/* We don't support polling DMA.
> -	 * DMA blacklist those ATAPI devices with CDB-intr (and use PIO)
> -	 * if the LLDD handles only interrupts in the HSM_ST_LAST state.
> +	/*
> +	 * We do not support polling DMA. Deny DMA for those ATAPI devices
> +	 * with CDB-intr (and use PIO) if the LLDD handles only interrupts in
> +	 * the HSM_ST_LAST state.
>  	 */
>  	if ((dev->link->ap->flags & ATA_FLAG_PIO_POLLING) &&
>  	    (dev->flags & ATA_DFLAG_CDB_INTR))
> -		return 1;
> -	return (dev->horkage & ATA_HORKAGE_NODMA) ? 1 : 0;
> +		return true;
> +	return dev->horkage & ATA_HORKAGE_NODMA;
>  }
>  
>  /**
> @@ -4404,7 +4405,7 @@ static void ata_dev_xfermask(struct ata_device *dev)
>  		xfer_mask &= ~(0x03 << (ATA_SHIFT_MWDMA + 3));
>  	}
>  
> -	if (ata_dma_blacklisted(dev)) {
> +	if (ata_dev_nodma(dev)) {
>  		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
>  		ata_dev_warn(dev,
>  			     "device is on DMA blacklist, disabling DMA\n");

Nit: if you rename blacklist, perhaps you should rename/avoid it in the above
print as well.

Regardless:
Reviewed-by: Niklas Cassel <cassel@kernel.org>
