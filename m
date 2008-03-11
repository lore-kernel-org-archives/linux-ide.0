From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ATA: logical-bitwise and confusion in ahci_save_initial_config()
Date: Mon, 10 Mar 2008 20:52:11 -0400
Message-ID: <47D5D7BB.1070206@pobox.com>
References: <47D44BC0.2090906@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50899 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755320AbYCKAwO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Mar 2008 20:52:14 -0400
In-Reply-To: <47D44BC0.2090906@tiscali.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roel Kluin <12o3l@tiscali.nl>
Cc: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

Roel Kluin wrote:
> logical-bitwise & confusion
> 
> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
> ---
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 8a49835..1b73307 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -672,7 +672,7 @@ static void ahci_save_initial_config(struct pci_dev *pdev,
>  		cap &= ~HOST_CAP_NCQ;
>  	}
>  
> -	if ((cap && HOST_CAP_PMP) && (hpriv->flags & AHCI_HFLAG_NO_PMP)) {
> +	if ((cap & HOST_CAP_PMP) && (hpriv->flags & AHCI_HFLAG_NO_PMP)) {
>  		dev_printk(KERN_INFO, &pdev->dev,
>  			   "controller can't do PMP, turning off CAP_PMP\n");
>  		cap &= ~HOST_CAP_PMP;

applied


