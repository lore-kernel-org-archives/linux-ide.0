From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Withdraw IGN_SERR_INTERNAL for SB800 SATA
Date: Wed, 19 Nov 2008 01:09:40 +0900
Message-ID: <4922E8C4.1000006@gmail.com>
References: <1227000451.5631.7.camel@chunhao-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:11992 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbYKRQJr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Nov 2008 11:09:47 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1900002tic.23
        for <linux-ide@vger.kernel.org>; Tue, 18 Nov 2008 08:09:45 -0800 (PST)
In-Reply-To: <1227000451.5631.7.camel@chunhao-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shane Huang <shane.huang@amd.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Shane Huang wrote:
> There is an issue in ATI SB600/SB700 SATA that PxSERR.E should not be
> set on some conditions, which will lead to many SATA ODD error messages.
> commit 55a61604cd1354e1783364e1c901034f2f474b7d is the workaround.
> Since SB800 fixed this HW issue, IGN_SERR_INTERNAL should be withdrawn
> for SB800.
> 
> Signed-off-by: Shane Huang <shane.huang@amd.com>
> 
> diff -ruN c/drivers/ata/ahci.c d/drivers/ata/ahci.c
> --- c/drivers/ata/ahci.c	2008-11-07 11:23:24.000000000 +0800
> +++ d/drivers/ata/ahci.c	2008-11-07 11:23:28.000000000 +0800
> @@ -105,7 +105,7 @@
>  	board_ahci_ign_iferr	= 2,
>  	board_ahci_sb600	= 3,
>  	board_ahci_mv		= 4,
> -	board_ahci_sb700	= 5,
> +	board_ahci_sb700	= 5, /* for SB700 and SB800 */
>  	board_ahci_mcp65	= 6,
>  	board_ahci_nopmp	= 7,
>  
> @@ -439,7 +439,7 @@
>  		.udma_mask	= ATA_UDMA6,
>  		.port_ops	= &ahci_ops,
>  	},
> -	/* board_ahci_sb700 */
> +	/* board_ahci_sb700, for SB700 and SB800 */
>  	{
>  		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL),
>  		.flags		= AHCI_FLAG_COMMON,
> @@ -2610,6 +2610,10 @@
>  	    (pdev->revision == 0xa1 || pdev->revision == 0xa2))
>  		hpriv->flags |= AHCI_HFLAG_NO_MSI;
>  
> +	/* SB800 does NOT need the workaround to ignore SERR_INTERNAL */
> +	if (board_id == board_ahci_sb700 && pdev->revision >= 0x40)
> +		hpriv->flags &= ~AHCI_HFLAG_IGN_SERR_INTERNAL;
> +
>  	if ((hpriv->flags & AHCI_HFLAG_NO_MSI) || pci_enable_msi(pdev))
>  		pci_intx(pdev, 1);

Great, but please use separate board_ahci_* entry.  ie.
board_ahci_sb700_ign_serr for the ones with the problem and
board_ahci_sb700 for other sb700s and sb800s.

Thanks.

-- 
tejun
