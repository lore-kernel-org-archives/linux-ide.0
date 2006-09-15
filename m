From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] libata: fix non-uniform ports handling
Date: Fri, 15 Sep 2006 15:29:32 -0700
Message-ID: <20060915152932.6aafff8e.akpm@osdl.org>
References: <20060915180415.GB25800@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:13987 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932334AbWIOW3v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Sep 2006 18:29:51 -0400
In-Reply-To: <20060915180415.GB25800@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, alan@lxorguk.ukuu.org.uk, "Nelson A. de Oliveira" <naoliv@gmail.com>

On Sat, 16 Sep 2006 03:04:15 +0900
Tejun Heo <htejun@gmail.com> wrote:

> @@ -5269,11 +5269,19 @@ void ata_port_init(struct ata_port *ap, 
>  	ap->host = host;
>  	ap->dev = ent->dev;
>  	ap->port_no = port_no;
> -	ap->pio_mask = ent->pio_mask;
> -	ap->mwdma_mask = ent->mwdma_mask;
> -	ap->udma_mask = ent->udma_mask;
> -	ap->flags |= ent->port_flags;
> -	ap->ops = ent->port_ops;
> +	if (port_no == 1 && ent->pinfo2) {
> +		ap->pio_mask = ent->pinfo2->pio_mask;
> +		ap->mwdma_mask = ent->pinfo2->mwdma_mask;
> +		ap->udma_mask = ent->pinfo2->udma_mask;
> +		ap->flags |= ent->pinfo2->flags;
> +		ap->ops = ent->pinfo2->port_ops;
> +	} else {
> +		ap->pio_mask = ent->pio_mask;
> +		ap->mwdma_mask = ent->mwdma_mask;
> +		ap->udma_mask = ent->udma_mask;
> +		ap->flags |= ent->port_flags;
> +		ap->ops = ent->port_ops;
> +	}


Same problem: the git-libata-all which I pulled 30 seconds ago
has:

	ap->flags |= ent->port_flags | ent->_port_flags[port_no];

and not

	ap->flags |= ent->port_flags;

which is what your patch expects.

Oh well, hopefully Jeff will sort it out.
