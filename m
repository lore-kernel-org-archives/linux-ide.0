Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2E8C001DE
	for <linux-ide@archiver.kernel.org>; Fri, 18 Aug 2023 07:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358287AbjHRHwg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Aug 2023 03:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358333AbjHRHwU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Aug 2023 03:52:20 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81F03A82;
        Fri, 18 Aug 2023 00:52:18 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 21CB15C006D;
        Fri, 18 Aug 2023 03:52:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 18 Aug 2023 03:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692345138; x=1692431538; bh=yuGiPmPOkXt8/
        huwbFE6YL0ktmucgneb7YQUDAybfZs=; b=BJOHL4dc1tV+VGti61JaAo/igtg+Q
        7mbsdqHxXPxkLMyPnW0gnhRPmAZ7c0Nl7F7bebfkHHiBKwbj5t3yPAB3S843ayXt
        Tx/nX+ZyDNVM+aSkq5DTqzYbIJCYAhzS6PI+WYDTzyARN9wCph4c0r80zo74hDwm
        Q4gBu7NFT5itzL9bZxbc8NI+KZLp6fXfcnECnO4q8LKJZyUHRSKfpGetQFhQoqRe
        qwFuJjee3EyrKZTNHd+PumqrdLcOYNJJaL8s+Z9cp7w5xLR4ZichZF/ScZR8a8X6
        hIHQfIHGEmc8x7mPL5MeKbWjOFIQPG3ss0pSwkvINRYtalGdq5ZGXQMjg==
X-ME-Sender: <xms:MSPfZG8S62OM85apuAweHTkQaaAjy7RQWYUxUaVpZgMFqLqSJ-Hg2Q>
    <xme:MSPfZGuv8EWkA_zL0s_7LdFUq0uthmLbfA728U4d536L7SSujmvSg8CKi17bw-BAT
    _cOq_qNTZBvBSBFPpI>
X-ME-Received: <xmr:MSPfZMAqGX13ZZrlyfXeIzPXdPr4Fje83L28h3Q652k-qJvbUkucpagnxxgNmUl-1T8BtvMyIflmNlg5oanYwXgMN-HgWEGCbe4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudduvddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhn
    ucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrf
    grthhtvghrnhepfeeiheejvdetgfeitddutefhkeeilefhveehgfdvtdekkedvkeehffdt
    keevvdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmhei
    kehkrdhorhhg
X-ME-Proxy: <xmx:MSPfZOcfAw60UuDGZrDl2d8FwuhpLnDwmMu0PE-S_xiePBhkTQxtxQ>
    <xmx:MSPfZLPjNb0yRlXZCVomBIRDMD2ULmkQsmWaPYy9Eiz8oQyHPwP-yQ>
    <xmx:MSPfZIlhb56S3hYUR3xjrQGt7V_Ho3qvCn2cQVV1qDw9Hcp54v48Qw>
    <xmx:MiPfZAqej5Ydc1riE4Mi43aTyng5DNtMX3NCHAxdgGW1Ht2m-dO7cw>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Aug 2023 03:52:14 -0400 (EDT)
Date:   Fri, 18 Aug 2023 17:52:29 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, will@sowerbutts.com, rz@linux-m68k.org,
        geert@linux-m68k.org
Subject: Re: [PATCH v2 1/3] ata: pata_falcon: fix IO base selection for Q40
In-Reply-To: <20230818071405.28581-2-schmitzmic@gmail.com>
Message-ID: <5cd777ad-17c4-ce63-c10a-7c379b356fb1@linux-m68k.org>
References: <20230818071405.28581-1-schmitzmic@gmail.com> <20230818071405.28581-2-schmitzmic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On Fri, 18 Aug 2023, Michael Schmitz wrote:

> With commit 44b1fbc0f5f3 ("m68k/q40: Replace q40ide driver
> with pata_falcon and falconide"), the Q40 IDE driver was
> replaced by pata_falcon.c.
> 
> Both IO and memory resources were defined for the Q40 IDE
> platform device, but definition of the IDE register addresses
> was modeled after the Falcon case, both in use of the memory
> resources and in including register scale and byte vs. word
> offset in the address.
> 
> This was correct for the Falcon case, which does not apply
> any address translation to the register addresses. In the
> Q40 case, all of device base address, byte access offset
> and register scaling is included in the platform specific
> ISA access translation (in asm/mm_io.h).
> 
> As a consequence, such address translation gets applied
> twice, and register addresses are mangled.
> 
> Use the device base address from the platform IO resource,
> and use standard register offsets from that base in order
> to calculate register addresses (the IO address translation
> will then apply the correct ISA window base and scaling).
> 
> Encode PIO_OFFSET into IO port addresses for all registers
> except the data transfer register. Encode the MMIO offset
> there (pata_falcon_data_xfer() directly uses raw IO with
> no address translation).
> 
> Reported-by: William R Sowerbutts <will@sowerbutts.com>
> Closes: https://lore.kernel.org/r/CAMuHMdUU62jjunJh9cqSqHT87B0H0A4udOOPs=WN7WZKpcagVA@mail.gmail.com
> Link: https://lore.kernel.org/r/CAMuHMdUU62jjunJh9cqSqHT87B0H0A4udOOPs=WN7WZKpcagVA@mail.gmail.com
> Fixes: 44b1fbc0f5f3 ("m68k/q40: Replace q40ide driver with pata_falcon and falconide")
> Cc: Finn Thain <fthain@linux-m68k.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>

Cc: stable@vger.kernel.org

From Documentation/process/submitting-patches.rst --
"Note: Attaching a Fixes: tag does not subvert the stable kernel rules 
process nor the requirement to Cc: stable@vger.kernel.org on all stable 
patch candidates... "

> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> 
> ---
> 
> Changes from v1:
> 
> Damien Le Moal:
> - change patch title
> - drop stable backport tag
> 
> Changes from RFC v3:
> 
> - split off byte swap option into separate patch
> 
> Geert Uytterhoeven:
> - review comments
> 
> Changes from RFC v2:
> - add driver parameter 'data_swap' as bit mask for drives to swap
> 
> Changes from RFC v1:
> 
> Finn Thain:
> - take care to supply IO address suitable for ioread8/iowrite8
> - use MMIO address for data transfer
> ---
>  drivers/ata/pata_falcon.c | 55 ++++++++++++++++++++++++---------------
>  1 file changed, 34 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
> index 996516e64f13..346259e3bbc8 100644
> --- a/drivers/ata/pata_falcon.c
> +++ b/drivers/ata/pata_falcon.c
> @@ -123,8 +123,8 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>  	struct resource *base_res, *ctl_res, *irq_res;
>  	struct ata_host *host;
>  	struct ata_port *ap;
> -	void __iomem *base;
> -	int irq = 0;
> +	void __iomem *base, *ctl_base;
> +	int irq = 0, io_offset = 1, reg_scale = 4;
>  
>  	dev_info(&pdev->dev, "Atari Falcon and Q40/Q60 PATA controller\n");
>  
> @@ -165,26 +165,39 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>  	ap->pio_mask = ATA_PIO4;
>  	ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
>  
> -	base = (void __iomem *)base_mem_res->start;
>  	/* N.B. this assumes data_addr will be used for word-sized I/O only */
> -	ap->ioaddr.data_addr		= base + 0 + 0 * 4;
> -	ap->ioaddr.error_addr		= base + 1 + 1 * 4;
> -	ap->ioaddr.feature_addr		= base + 1 + 1 * 4;
> -	ap->ioaddr.nsect_addr		= base + 1 + 2 * 4;
> -	ap->ioaddr.lbal_addr		= base + 1 + 3 * 4;
> -	ap->ioaddr.lbam_addr		= base + 1 + 4 * 4;
> -	ap->ioaddr.lbah_addr		= base + 1 + 5 * 4;
> -	ap->ioaddr.device_addr		= base + 1 + 6 * 4;
> -	ap->ioaddr.status_addr		= base + 1 + 7 * 4;
> -	ap->ioaddr.command_addr		= base + 1 + 7 * 4;
> -
> -	base = (void __iomem *)ctl_mem_res->start;
> -	ap->ioaddr.altstatus_addr	= base + 1;
> -	ap->ioaddr.ctl_addr		= base + 1;
> -
> -	ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx",
> -		      (unsigned long)base_mem_res->start,
> -		      (unsigned long)ctl_mem_res->start);
> +	ap->ioaddr.data_addr = (void __iomem *)base_mem_res->start;
> +
> +	if (base_res) {		/* only Q40 has IO resources */
> +		io_offset = 0x10000;
> +		reg_scale = 1;
> +		base = (void __iomem *)base_res->start;
> +		ctl_base = (void __iomem *)ctl_res->start;
> +
> +		ata_port_desc(ap, "cmd %pa ctl %pa",
> +			      &base_res->start,
> +			      &ctl_res->start);
> +	} else {
> +		base = (void __iomem *)base_mem_res->start;
> +		ctl_base = (void __iomem *)ctl_mem_res->start;
> +
> +		ata_port_desc(ap, "cmd %pa ctl %pa",
> +			      &base_mem_res->start,
> +			      &ctl_mem_res->start);
> +	}
> +
> +	ap->ioaddr.error_addr	= base + io_offset + 1 * reg_scale;
> +	ap->ioaddr.feature_addr	= base + io_offset + 1 * reg_scale;
> +	ap->ioaddr.nsect_addr	= base + io_offset + 2 * reg_scale;
> +	ap->ioaddr.lbal_addr	= base + io_offset + 3 * reg_scale;
> +	ap->ioaddr.lbam_addr	= base + io_offset + 4 * reg_scale;
> +	ap->ioaddr.lbah_addr	= base + io_offset + 5 * reg_scale;
> +	ap->ioaddr.device_addr	= base + io_offset + 6 * reg_scale;
> +	ap->ioaddr.status_addr	= base + io_offset + 7 * reg_scale;
> +	ap->ioaddr.command_addr	= base + io_offset + 7 * reg_scale;
> +
> +	ap->ioaddr.altstatus_addr	= ctl_base + io_offset;
> +	ap->ioaddr.ctl_addr		= ctl_base + io_offset;
>  
>  	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>  	if (irq_res && irq_res->start > 0) {
> 
