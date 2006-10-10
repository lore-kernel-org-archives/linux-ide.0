From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] drivers/ide: fix error return bugs, interface
Date: Tue, 10 Oct 2006 17:49:56 +0400
Message-ID: <20061010134956.GA5347@martell.zuzino.mipt.ru>
References: <20061010131639.GA8523@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:12909 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750786AbWJJNuO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Oct 2006 09:50:14 -0400
Received: by nf-out-0910.google.com with SMTP id x30so320148nfb
        for <linux-ide@vger.kernel.org>; Tue, 10 Oct 2006 06:50:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20061010131639.GA8523@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> --- a/drivers/ide/pci/cs5530.c
> +++ b/drivers/ide/pci/cs5530.c
> @@ -250,7 +250,9 @@ static unsigned int __devinit init_chips
>  	 */
>  
>  	pci_set_master(cs5530_0);
> -	pci_set_mwi(cs5530_0);
> +	if (pci_set_mwi(cs5530_0))
> +		dev_printk(KERN_WARNING, &cs5530_0->dev,
> +			   "MWI enable failed\n");

Use dev_warn()

