From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 07/64] pata_atiixp: enable parallel scan
Date: Mon, 18 Jan 2010 17:52:56 +0000
Message-ID: <20100118175256.32096b44@lxorguk.ukuu.org.uk>
References: <20100118171349.14623.90030.sendpatchset@localhost>
	<20100118171447.14623.47438.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35963 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753673Ab0ARRuL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2010 12:50:11 -0500
In-Reply-To: <20100118171447.14623.47438.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

>  	const struct ata_port_info *ppi[] = { &info, &info };
> +	struct ata_host *host;
> +	int rc;
>  
> -	return ata_pci_sff_init_one(pdev, ppi, &atiixp_sht, NULL);
> +	/* enable device and prepare host */
> +	rc = pcim_enable_device(pdev);
> +	if (rc)
> +		return rc;
> +
> +	rc = ata_pci_sff_prepare_host(pdev, ppi, &host);
> +	if (rc)
> +		return rc;
> +
> +	host->flags |= ATA_HOST_PARALLEL_SCAN;
> +
> +	pci_set_master(pdev);
> +
> +	return ata_pci_sff_activate_host(host, ata_sff_interrupt, &atiixp_sht);
>  }

Adding a small essay to each host that activates parallel scan doesn't
make sense. This should be a helper (ignore that if you make it a helper
later in the patch set...)
