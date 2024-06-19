Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8F32139D3
	for <linux-ide@vger.kernel.org>; Wed, 19 Jun 2024 03:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718769077; cv=none; b=bzLxPKqwBlRTjNcUd0o6EV0M8OxWdqohPJS3bfwifU0akqwoi6CwY365ERoNz0ToNBnmzJi9/ARhmztRkAGtMjGEHkUaRDmZGHtmj4q4vtWKItcGXUiaj+A7TLHjmuJk9NYoUDcqJoOaBBDwbF1yyxpC1+yHBeq2yvO9tEofh9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718769077; c=relaxed/simple;
	bh=w/teWD1CGIOZwkEBmB6v9sAXRbHZGndEgcahtltHEwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YpDg8FDzrcxDPhhZd38E8kzj8ah6ltmgos/J83h92FzUjkWNQn/ZX187UfSaXj7g0Wao9PILPIdTLAU8PMuU1HMhxA4svP1T6JNWgSGLygp7WFVg7QfeGShIvlRTxE+y8oaEpkLrXiSWEUIQfTHKjnNiqxe37b2iwwcBMrA9OXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AehLd27d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AehLd27d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116AAC2BBFC;
	Wed, 19 Jun 2024 03:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718769077;
	bh=w/teWD1CGIOZwkEBmB6v9sAXRbHZGndEgcahtltHEwQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AehLd27ddXeOxkOgTSeQeEE30i/WBQvodGIDIpxOlgyu7+Ej6+srQrv5f2J+R/xaP
	 dxpzz0FiZ9d1yAm7GRolMyJlguhNQkJjI5DNjxYhs5/sMETejgVr0CX14kB+kD0tHm
	 9g6xORrnX1UAsXlQds0X3XVTGN+lrhkL3yPJuEeNoam9DUrqjUz79HQOP5PigKvFGZ
	 Nghwng2t8bTEjVkMQw5CPbsJx7toyMXFCzy7Isetwk5wmicubiMrrgcfb/1YUHpvpL
	 3C+J69v/s1U+Cyq9Ym0LsomJLASknyxLb3MPuNXeLIZV5kbmg1KsMtubjSHrcbFIR9
	 ORoU2q0fCoM8A==
Message-ID: <ca22671d-8403-48b7-9f65-6df3b19d5fef@kernel.org>
Date: Wed, 19 Jun 2024 12:51:16 +0900
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

Nit: I am not sure this comment is still appropriate. Maybe remove it ?

Otherwise, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

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

