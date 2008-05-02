From: Alan Cox <alan@redhat.com>
Subject: Re: [patch 3/3] pata_atiixp: Don't disable
Date: Fri, 2 May 2008 17:40:58 -0400
Message-ID: <20080502214058.GA5706@devserv.devel.redhat.com>
References: <200805022037.m42Kbg4s013536@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:60061 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765754AbYEBVlp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 May 2008 17:41:45 -0400
Content-Disposition: inline
In-Reply-To: <200805022037.m42Kbg4s013536@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com, davidg@havidave.com

> diff -puN drivers/ata/pata_atiixp.c~pata_atiixp-dont-disable drivers/ata/pata_atiixp.c
> --- a/drivers/ata/pata_atiixp.c~pata_atiixp-dont-disable
> +++ a/drivers/ata/pata_atiixp.c
> @@ -243,9 +243,6 @@ static int atiixp_init_one(struct pci_de
>  		.port_ops = &atiixp_port_ops
>  	};
>  	const struct ata_port_info *ppi[] = { &info, NULL };
> -	/* Some of the quirk reconfiguration messes up the simplex flag, so
> -	   clear it again */
> -	ata_pci_bmdma_clear_simplex(dev);
>  	return ata_pci_sff_init_one(dev, ppi, &atiixp_sht, NULL);

And this segment can be dropped as the original patch that adds it isn't
needed
