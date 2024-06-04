Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A64372;
	Tue,  4 Jun 2024 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717532945; cv=none; b=pzUx8mYdWnIffWga9m5/B0fuy7jH2FZbaSyxYskeIBjgeOYBljIdSXSGPEusX6jx6mQ+76z9S8VjWP7WQY23rn9Wki8oLeU/+R1y6Dk8k2PJn//xHAj6hsVj0kz0xnsBXnETwU0EtYDl0zqZNSXPO1KbTR2Rb6fyJahlIBQr2o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717532945; c=relaxed/simple;
	bh=lhhzCuh045uFrmvUr+7+l46i0pGW+nKv3TQDnUD0NZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UA8WXR4W0oMYV26WgCxrSYd05zWlQDt5HLmy3H5kC1PEwyxdO0DjFsK7Q1str27vxstcRtWzgfLDoXv9w5LwYru0Em1u5MnPCdCtA7XuBuowHv/k2yqiekKubo5FwUo/rEQS36sEj1xWGOt9p0anduWIFMZLp8ArNnL59hB3TgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNCSuNyI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNCSuNyI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962DCC2BBFC;
	Tue,  4 Jun 2024 20:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717532945;
	bh=lhhzCuh045uFrmvUr+7+l46i0pGW+nKv3TQDnUD0NZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bNCSuNyInGPc5/R0ntK4PB+NakI6DiIUGkpZjkqVstYio0MjaDr8M2FTGdEbTsG9m
	 QMnFPPxjClBBtDJ+roEp1tqjC/V8n+Om6AFGjmVt/X8P5Dd2mZsoAXOm9F3WDVqWh0
	 6Youq3h1BpQw6voiH8lkP/yJbqiy5gS/nzDKjSEdH0HXPj28iodTZvJ3szBRkKKbYE
	 +jm5m275LVgeCxhdLCsuIljDZlx3HmWifxhVe32vznvSueKBqwoyD6vYOx81mil0IG
	 yaZjGRRKvv1F3Yd47ASuLSkPfirOiX4OIviiiwljv1TdxmwKDwLKBFFwHWt9xUsjbk
	 6ondAQaV2uSrQ==
Date: Tue, 4 Jun 2024 22:29:00 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Paolo Pisati <p.pisati@gmail.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-m68k@lists.linux-m68k.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: pata_buddha: pata_gayle: consolidate .sff_data_xfer
 around libata::ata_sff_data_xfer()
Message-ID: <Zl95DPtsOXlhaVDF@ryzen.lan>
References: <20240604162217.484789-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604162217.484789-1-p.pisati@gmail.com>

Hello Paolo,

On Tue, Jun 04, 2024 at 06:22:17PM +0200, Paolo Pisati wrote:
> pata_buddha_data_xfer(), pata_gayle_data_xfer() and ata_sff_data_xfer() are the
> same function, consolidate around libata::ata_sff_data_xfer().

Please avoid the C++ namespace operator,
just drop "libata::" here and in the subject.

Also please just split this into two patches, one per driver.


> 
> Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
> ---
>  drivers/ata/pata_buddha.c | 40 ++-------------------------------------
>  drivers/ata/pata_gayle.c  | 40 ++-------------------------------------
>  2 files changed, 4 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/ata/pata_buddha.c b/drivers/ata/pata_buddha.c
> index c36ee991d5e5..234278eb26e1 100644
> --- a/drivers/ata/pata_buddha.c
> +++ b/drivers/ata/pata_buddha.c
> @@ -60,42 +60,6 @@ static const struct scsi_host_template pata_buddha_sht = {
>  	ATA_PIO_SHT(DRV_NAME),
>  };
>  
> -/* FIXME: is this needed? */
> -static unsigned int pata_buddha_data_xfer(struct ata_queued_cmd *qc,
> -					 unsigned char *buf,
> -					 unsigned int buflen, int rw)
> -{
> -	struct ata_device *dev = qc->dev;
> -	struct ata_port *ap = dev->link->ap;
> -	void __iomem *data_addr = ap->ioaddr.data_addr;
> -	unsigned int words = buflen >> 1;
> -
> -	/* Transfer multiple of 2 bytes */
> -	if (rw == READ)
> -		raw_insw((u16 *)data_addr, (u16 *)buf, words);
> -	else
> -		raw_outsw((u16 *)data_addr, (u16 *)buf, words);
> -
> -	/* Transfer trailing byte, if any. */
> -	if (unlikely(buflen & 0x01)) {
> -		unsigned char pad[2] = { };
> -
> -		/* Point buf to the tail of buffer */
> -		buf += buflen - 1;
> -
> -		if (rw == READ) {
> -			raw_insw((u16 *)data_addr, (u16 *)pad, 1);
> -			*buf = pad[0];
> -		} else {
> -			pad[0] = *buf;
> -			raw_outsw((u16 *)data_addr, (u16 *)pad, 1);
> -		}
> -		words++;
> -	}
> -
> -	return words << 1;
> -}
> -
>  /*
>   * Provide our own set_mode() as we don't want to change anything that has
>   * already been configured..
> @@ -131,7 +95,7 @@ static void pata_xsurf_irq_clear(struct ata_port *ap)
>  
>  static struct ata_port_operations pata_buddha_ops = {
>  	.inherits	= &ata_sff_port_ops,
> -	.sff_data_xfer	= pata_buddha_data_xfer,
> +	.sff_data_xfer	= ata_sff_data_xfer,

Since this driver inherits ata_sff_port_ops,
which sets .sff_data_xfer to ata_sff_data_xfer:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/ata/libata-sff.c?h=v6.10-rc2#n46

this line should not be needed.


>  	.sff_irq_check	= pata_buddha_irq_check,
>  	.cable_detect	= ata_cable_unknown,
>  	.set_mode	= pata_buddha_set_mode,
> @@ -139,7 +103,7 @@ static struct ata_port_operations pata_buddha_ops = {
>  
>  static struct ata_port_operations pata_xsurf_ops = {
>  	.inherits	= &ata_sff_port_ops,
> -	.sff_data_xfer	= pata_buddha_data_xfer,
> +	.sff_data_xfer	= ata_sff_data_xfer,
>  	.sff_irq_check	= pata_buddha_irq_check,
>  	.sff_irq_clear	= pata_xsurf_irq_clear,
>  	.cable_detect	= ata_cable_unknown,
> diff --git a/drivers/ata/pata_gayle.c b/drivers/ata/pata_gayle.c
> index 3bdbe2b65a2b..febffc36a18f 100644
> --- a/drivers/ata/pata_gayle.c
> +++ b/drivers/ata/pata_gayle.c
> @@ -38,42 +38,6 @@ static const struct scsi_host_template pata_gayle_sht = {
>  	ATA_PIO_SHT(DRV_NAME),
>  };
>  
> -/* FIXME: is this needed? */
> -static unsigned int pata_gayle_data_xfer(struct ata_queued_cmd *qc,
> -					 unsigned char *buf,
> -					 unsigned int buflen, int rw)
> -{
> -	struct ata_device *dev = qc->dev;
> -	struct ata_port *ap = dev->link->ap;
> -	void __iomem *data_addr = ap->ioaddr.data_addr;
> -	unsigned int words = buflen >> 1;
> -
> -	/* Transfer multiple of 2 bytes */
> -	if (rw == READ)
> -		raw_insw((u16 *)data_addr, (u16 *)buf, words);
> -	else
> -		raw_outsw((u16 *)data_addr, (u16 *)buf, words);
> -
> -	/* Transfer trailing byte, if any. */
> -	if (unlikely(buflen & 0x01)) {
> -		unsigned char pad[2] = { };
> -
> -		/* Point buf to the tail of buffer */
> -		buf += buflen - 1;
> -
> -		if (rw == READ) {
> -			raw_insw((u16 *)data_addr, (u16 *)pad, 1);
> -			*buf = pad[0];
> -		} else {
> -			pad[0] = *buf;
> -			raw_outsw((u16 *)data_addr, (u16 *)pad, 1);
> -		}
> -		words++;
> -	}
> -
> -	return words << 1;
> -}
> -
>  /*
>   * Provide our own set_mode() as we don't want to change anything that has
>   * already been configured..
> @@ -110,7 +74,7 @@ static void pata_gayle_irq_clear(struct ata_port *ap)
>  
>  static struct ata_port_operations pata_gayle_a1200_ops = {
>  	.inherits	= &ata_sff_port_ops,
> -	.sff_data_xfer	= pata_gayle_data_xfer,
> +	.sff_data_xfer	= ata_sff_data_xfer,

Same comment as for the other driver.


Kind regards,
Niklas
