From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata-sff: PCI IRQ handling fix
Date: Wed, 09 Jan 2008 11:38:22 +0900
Message-ID: <4784339E.2090604@gmail.com>
References: <20080103172228.0e091daf@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:47296 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbYAICia (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jan 2008 21:38:30 -0500
Received: by rv-out-0910.google.com with SMTP id k20so58676rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 08 Jan 2008 18:38:29 -0800 (PST)
In-Reply-To: <20080103172228.0e091daf@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, jeff@garzik.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> It is legitimate (although annoying and silly) for a PCI IDE controller
> not to be assigned an interrupt and to be polled. The libata-sff code
> should therefore not try and request IRQ 0 in this case.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc6-mm1/drivers/ata/libata-sff.c linux-2.6.24-rc6-mm1/drivers/ata/libata-sff.c
> --- linux.vanilla-2.6.24-rc6-mm1/drivers/ata/libata-sff.c	2008-01-02 16:04:19.000000000 +0000
> +++ linux-2.6.24-rc6-mm1/drivers/ata/libata-sff.c	2008-01-02 16:12:39.000000000 +0000
> @@ -808,7 +808,10 @@
>  	if (rc)
>  		goto err_out;
>  
> -	if (!legacy_mode) {
> +	if (!legacy_mode && pdev->irq) {
> +		/* We may have no IRQ assigned in which case we can poll. This
> +		   shouldn't happen on a sane system but robustness is cheap
> +		   in this case */
>  		rc = devm_request_irq(dev, pdev->irq, pi->port_ops->irq_handler,
>  				      IRQF_SHARED, DRV_NAME, host);
>  		if (rc)
> @@ -816,7 +819,7 @@
>  
>  		ata_port_desc(host->ports[0], "irq %d", pdev->irq);
>  		ata_port_desc(host->ports[1], "irq %d", pdev->irq);
> -	} else {
> +	} else if (legacy_mode) {

I would prefer to put if (pdev->irq) inside if (!legacy_mode) but that's
nothing major.

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
