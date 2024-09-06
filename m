Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4610D45BE3
	for <linux-ide@vger.kernel.org>; Fri,  6 Sep 2024 08:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611540; cv=none; b=bRakU0OQpgG3jkxfGWAANrntnk5PXlBzcezKQ8aV9LeuT77G/IOWM4EBZRsxdKVV68WMJoNhXJwLgdIctZ/AeQSRmvxYB2yci5URKGxh0sX+kB5or7g+gA7uRRzV7k6bZkwJ16WX/ctQs8w7x+57ZhuQMlVb8FJ1Wrm6mVYObvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611540; c=relaxed/simple;
	bh=d+u4mD9tVyDksVuCDmXGbeYpY6D8uSpG6hBGdUfdIt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M62fCBuFNrdC1J3q+JADnmRpKAlVsczi0kZXou5R+TsJkCBWerG4onmIzwJbooah7ZCbas7wOMdyZFjddPSTzuneENAT/+lJn7IqScuVuX8LNZGcMPnKJ7l+ccvXSyxHL5Pj0c+jUl/SOz4iwU/dZrSUPCPMQ0Z6ahqQcANCOMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrNf1TbO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrNf1TbO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2366EC4CEC8;
	Fri,  6 Sep 2024 08:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725611539;
	bh=d+u4mD9tVyDksVuCDmXGbeYpY6D8uSpG6hBGdUfdIt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hrNf1TbO4uCpi9zhdJllKaXigZ0oyHT+/u5m+t720IGEVl7W/L8i3mcneFtLRDNK9
	 UEBEDCajuFsKgQZWwCHJXUc1spvUFQsas170QeDLuBaSjLOHgdCrAw7MnNqyP6D/GO
	 MpoynJqk5dw6QPrah9biz8ZLUO+UGLdE6RpQKx5kwfdogvq5o2Qjypz9Skyxs50JRb
	 hLmyrjaL2n4RwsDWS11W/V586/cK5f2aZeVxQWbiTjBus9CcjNGySmY+HZ/TwP1Q4c
	 eQF+mkl3dDf+Xl8l/JfjF4sVTUh3JJ72RoOSaUM3q8WnOVpntrZ4pHwf6cupElH8w/
	 JOijoNf9c2x5w==
Date: Fri, 6 Sep 2024 10:32:16 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v5 2/9] ata: libata-scsi: Improve
 ata_scsi_handle_link_detach()
Message-ID: <Ztq-EF0jLrn8iCOC@ryzen.lan>
References: <20240906015847.229539-1-dlemoal@kernel.org>
 <20240906015847.229539-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906015847.229539-3-dlemoal@kernel.org>

On Fri, Sep 06, 2024 at 10:58:40AM +0900, Damien Le Moal wrote:
> A struct ata_device flags are always set iand cleared with the device

s/iand/and/

I can see many cases function that currently set or clear dev->flags
withouth holding ap->lock, done by functions that run in EH context,
which will thus not hold ap->lock.

Perhaps rephrase this to:
struct ata_device flags should always be set and cleared with the device


> port locked.  Testing for a flag should thus also be done while holding
> the device port lock. In accordance to this, modify
> ata_scsi_handle_link_detach() to both test and clear the
> ATA_DFLAG_DETACHED flag while holding the device port lock.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/libata-scsi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index a3ffce4b218d..1a135d44286c 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -4616,10 +4616,12 @@ static void ata_scsi_handle_link_detach(struct ata_link *link)
>  	ata_for_each_dev(dev, link, ALL) {
>  		unsigned long flags;
>  
> -		if (!(dev->flags & ATA_DFLAG_DETACHED))
> +		spin_lock_irqsave(ap->lock, flags);
> +		if (!(dev->flags & ATA_DFLAG_DETACHED)) {
> +			spin_unlock_irqrestore(ap->lock, flags);
>  			continue;
> +		}
>  
> -		spin_lock_irqsave(ap->lock, flags);
>  		dev->flags &= ~ATA_DFLAG_DETACHED;
>  		spin_unlock_irqrestore(ap->lock, flags);
>  
> -- 
> 2.46.0
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>
