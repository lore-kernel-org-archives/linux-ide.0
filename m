Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E115A1CFAF
	for <linux-ide@vger.kernel.org>; Wed, 19 Jun 2024 04:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718772987; cv=none; b=hFS/jXhF0KhZdEeh/K7ZtpQkjgNl6u1A73FygVVuhptilPg4dlhIf0KMYjxp853NbWfP80qaZtpn+86HGsnkkR0XVYXmCTP0YfwBAM3EymsZdpgpaQ6DhxDEx2MmMtkIFipfk5d0zLWjWtc5JBVO5sfUmx7sYxlhRqI8iTYW7xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718772987; c=relaxed/simple;
	bh=pkJch1TRLpNVFMe6bSx7/goPxC2BXInbhneMeqPbhss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYb+2Qu7yhTQpaKteHbPCgD1jVTwB9rijPume/aMPAxPSRN5VU/cqRIPXvrIxbTUXQvpU5fXEF6AD+Fk/Eozl08dgSjDSski1Nf4Fp50vj5lCqdhUQlAz02bar2OTrPfgPx8tOh8DVahiQ94y8qqy8ZzLeZQNll8Xf93XNu3Bk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbCSb3qJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbCSb3qJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC084C2BBFC;
	Wed, 19 Jun 2024 04:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718772986;
	bh=pkJch1TRLpNVFMe6bSx7/goPxC2BXInbhneMeqPbhss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kbCSb3qJKn3jItSTOWfmCkPkBhynNTMbdVxj3Zce1UyvdnSrIHldKe5n9pQvzlYHq
	 5XuUFhINtaNHdk/XoWwC4h+9TyqqDY8qjxV4v8M9OjbPX9NVWgaK50Ls240NNH3GxA
	 p+dZ8XTInB3GIKSNlo85rdi02MeQyqs8gb9dtomIov8zPwkvfaceflKR2YnSyOUcNw
	 QgAbEXHCPVJnsUTKQN8MztFkKyVTtvML3Trldlv7VP6r0deSI/7Tly+unwPl7mgI2D
	 KkjU+16nxmJ7pakqnt4lujBViZpP3RlXwN4saRXrlQbRbyfUVyqFR55Z0OXs1329ZQ
	 ahh+DZpkLraNA==
Message-ID: <c610acce-8828-4158-97fa-11bbd2ffc591@kernel.org>
Date: Wed, 19 Jun 2024 13:56:24 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ata: libata: Assign print_id at port allocation time
To: Niklas Cassel <cassel@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-ide@vger.kernel.org
References: <20240618153537.2687621-7-cassel@kernel.org>
 <20240618153537.2687621-10-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240618153537.2687621-10-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/24 00:35, Niklas Cassel wrote:
> While the assignment of ap->print_id could have been moved to
> ata_host_alloc(), let's simply move it to ata_port_alloc().
> 
> If you allocate a port, you want to give it a unique name that can be used
> for printing.
> 
> By moving the ap->print_id assignment to ata_port_alloc(), means that we
> can also remove the ap->print_id assignment from ata_sas_port_alloc().
> 
> This will allow a LLD to use the ata_port_*() print functions before
> ata_host_register() has been called.

By the way, shouldn't we replace the ata_print_id atomic with an IDA ?

static DEFINE_IDA(ata_ida);

And then use:

	ap->print_id = ida_alloc(&ata_ida, GFP_KERNEL);
	ida_free(&ata_ida, ap->print_id);

That would avoid the print IDs to constantly increase when doing e.g.
rmmod ahci+modprobe ahci.

> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/libata-core.c | 6 ++----
>  drivers/ata/libata-sata.c | 1 -
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 0dc6e18bf492..fb4835c2ba2d 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5463,7 +5463,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
>  
>  	ap->pflags |= ATA_PFLAG_INITIALIZING | ATA_PFLAG_FROZEN;
>  	ap->lock = &host->lock;
> -	ap->print_id = -1;
> +	ap->print_id = atomic_inc_return(&ata_print_id);
>  	ap->local_port_no = -1;
>  	ap->host = host;
>  	ap->dev = host->dev;
> @@ -5903,10 +5903,8 @@ int ata_host_register(struct ata_host *host, const struct scsi_host_template *sh
>  		WARN_ON(host->ports[i]);
>  
>  	/* give ports names and add SCSI hosts */
> -	for (i = 0; i < host->n_ports; i++) {
> -		host->ports[i]->print_id = atomic_inc_return(&ata_print_id);
> +	for (i = 0; i < host->n_ports; i++)
>  		host->ports[i]->local_port_no = i + 1;
> -	}
>  
>  	/* Create associated sysfs transport objects  */
>  	for (i = 0; i < host->n_ports; i++) {
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index c564eac9d430..def0026188f7 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -1234,7 +1234,6 @@ struct ata_port *ata_sas_port_alloc(struct ata_host *host,
>  	ap->flags |= port_info->flags;
>  	ap->ops = port_info->port_ops;
>  	ap->cbl = ATA_CBL_SATA;
> -	ap->print_id = atomic_inc_return(&ata_print_id);
>  
>  	return ap;
>  }

-- 
Damien Le Moal
Western Digital Research

