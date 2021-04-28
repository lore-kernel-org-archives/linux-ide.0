Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652EBC433ED
	for <linux-ide@archiver.kernel.org>; Wed, 28 Apr 2021 05:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44D6A60E0B
	for <linux-ide@archiver.kernel.org>; Wed, 28 Apr 2021 05:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbhD1GAU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 28 Apr 2021 02:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235809AbhD1GAS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 28 Apr 2021 02:00:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6EB5613FB;
        Wed, 28 Apr 2021 05:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619589573;
        bh=PzXRzqyaN0AHEgEDWQ7ORDtLyuOZqfpRHAtszxM+aMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=15ttKwTuuNivW2WUxOzPsphx0FRf9V1T8rt8jHcNnVVId6Lvj5uNEq3xV/c5gCrt8
         kUKvwWswbZa1rZYStYXr3DoADlotDZXvS1mi3zdsqzkseIBK48Yce+nLvCDqZtFmnq
         u1wakr7dYWCrxLNgwu1w0kUdlF1b42NPjmrWwnYo=
Date:   Wed, 28 Apr 2021 07:59:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Timo Sigurdsson <public_timo.s@silentcreek.de>
Cc:     axboe@kernel.dk, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@siol.net, linux-ide@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, oliver@schinagl.nl,
        stable@vger.kernel.org
Subject: Re: [PATCH] ata: ahci_sunxi: Disable DIPM
Message-ID: <YIj5wKTdOVWLdD2d@kroah.com>
References: <20210427230537.21423-1-public_timo.s@silentcreek.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427230537.21423-1-public_timo.s@silentcreek.de>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Apr 28, 2021 at 01:05:37AM +0200, Timo Sigurdsson wrote:
> DIPM is unsupported or broken on sunxi. Trying to enable the power
> management policy med_power_with_dipm on an Allwinner A20 SoC based board
> leads to immediate I/O errors and the attached SATA disk disappears from
> the /dev filesystem. A reset (power cycle) is required to make the SATA
> controller or disk work again. The A10 and A20 SoC data sheets and manuals
> don't mention DIPM at all [1], so it's fair to assume that it's simply not
> supported. But even if it were, it should be considered broken and best be
> disabled in the ahci_sunxi driver.
> 
> Fixes: c5754b5220f0 ("ARM: sunxi: Add support for Allwinner SUNXi SoCs sata to ahci_platform")
> 
> [1] https://github.com/allwinner-zh/documents/tree/master/
> 
> Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>
> Tested-by: Timo Sigurdsson <public_timo.s@silentcreek.de>
> ---
>  drivers/ata/ahci_sunxi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
> index cb69b737cb49..56b695136977 100644
> --- a/drivers/ata/ahci_sunxi.c
> +++ b/drivers/ata/ahci_sunxi.c
> @@ -200,7 +200,7 @@ static void ahci_sunxi_start_engine(struct ata_port *ap)
>  }
>  
>  static const struct ata_port_info ahci_sunxi_port_info = {
> -	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NCQ,
> +	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NCQ | ATA_FLAG_NO_DIPM,
>  	.pio_mask	= ATA_PIO4,
>  	.udma_mask	= ATA_UDMA6,
>  	.port_ops	= &ahci_platform_ops,
> -- 
> 2.26.2
> 
<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
