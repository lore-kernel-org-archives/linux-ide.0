Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F17C7112B
	for <linux-ide@archiver.kernel.org>; Fri, 18 Aug 2023 07:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358239AbjHRHoI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Aug 2023 03:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353097AbjHRHnd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Aug 2023 03:43:33 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0E030FE;
        Fri, 18 Aug 2023 00:43:31 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 6A3615C0109;
        Fri, 18 Aug 2023 03:43:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 18 Aug 2023 03:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692344608; x=1692431008; bh=dgynFTvpIcFvK
        Eo0nbMvK3p2F9Xe31fJomXDBpjns84=; b=TpTIbyFzJgFY+xQiL0O6OXZLQFwzq
        gIQLlb5lIW2WuMN2aJ2lBWXqluX6mIL1wkgQSnMrrVgephGHF7BLk+v0vbSXy/91
        zxSgwt7DKzspEYNNUNIj2uLQ/G5dnJCMspoQx20c/MlQA6fLMghNv8yN5Onwk0GO
        jFlKAAwY2XRH1dtKcx4H2gdW5SR73LoJ7RKiv6Qf43WLOY/uG3x6ZmjGvFU+7GmX
        iV6hS+X6HJMDw7EoQxnKRR1mu04091qb2KFfwIgK9f820EJWACZR1UEc8ueDQHxi
        QlIbNaeelrVYm33VI/0ycn/Y8FfOmIrfTq0RB1ljmNiBurrtDyaeP344w==
X-ME-Sender: <xms:ICHfZOoLh-8fHw-qBVBYYnpBzl2x7p-PxFzkJsJ-QzBm94RRQIsxEQ>
    <xme:ICHfZMpq4oDUWww-qOCJv8HYuDVWcWH3GXIrFlAPjAaa_ooms-zIySND8kkqEzbsU
    a20iZs5aelLFxgTlaE>
X-ME-Received: <xmr:ICHfZDNM8eFC3GSNFBUQQfartGYmMEQlUKYtvdXjJZkCbOsz9Qj_BxkuPW9O4AmJd0PtuTkdonp0AtU9Z67oSyP7TIeuO72ljUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudduvddguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhn
    ucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrf
    grthhtvghrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedv
    ueehueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:ICHfZN6vGrypVU_jOpxPUs9uiPX97Uv3iR0EuCTc2OhzRYzMombsdg>
    <xmx:ICHfZN4ZSvIN9teEZbbDOrnAp7zXBd0pjI2McVPLnqAm35ii5U7lsQ>
    <xmx:ICHfZNgTWZou1vRt-dt8sRLqfqOEjAJov-n0C20XmTen4mTYqxeoUw>
    <xmx:ICHfZA11Q_hpwswz2yhaFQ34RrGipTpPvgFZdY5lxRyBQjwTwEM-TA>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Aug 2023 03:43:26 -0400 (EDT)
Date:   Fri, 18 Aug 2023 17:43:40 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, will@sowerbutts.com, rz@linux-m68k.org,
        geert@linux-m68k.org
Subject: Re: [PATCH v2 2/3] ata: pata_falcon: add data_swab option to byte-swap
 disk data
In-Reply-To: <20230818071405.28581-3-schmitzmic@gmail.com>
Message-ID: <16f01be8-de2e-4fb2-50c3-95f030e740ac@linux-m68k.org>
References: <20230818071405.28581-1-schmitzmic@gmail.com> <20230818071405.28581-3-schmitzmic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On Fri, 18 Aug 2023, Michael Schmitz wrote:

> Some users of pata_falcon on Q40 have IDE disks in default
> IDE little endian byte order, whereas legacy disks use
> host-native big-endian byte order as on the Atari Falcon.
> 
> Add module parameter 'data_swab' to allow connecting drives
> with non-native data byte order. Drives selected by the
> data_swap bit mask will have their user data byte-swapped to
> host byte order, i.e. 'pata_falcon.data_swab=2' will byte-swap
> all user data on drive B, leaving data on drive A in native
> byte order. On Q40, drives on a second IDE interface may be
> added to the bit mask as bits 2 and 3.
> 
> Default setting is no byte swapping, i.e. compatibility with
> the native Falcon or Q40 operating system disk format.
> 
> Cc: William R Sowerbutts <will@sowerbutts.com>
> Cc: Finn Thain <fthain@linux-m68k.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> 
> ---
> 
> Changes since v1:
> 
> Damien Le Moal:
> - change patch title
> - drop swap_data flag
> 
> Finn Thain:
> - drop allocation of ap->private struct, use field as bitmask
> 
> Changes since RFC v4:
> 
> Geert Uytterhoeven:
> - don't shift static module parameter for drive 3/4 bitmask
> - simplify bit mask calculation to always use pdev->id
> 
> Finn Thain:
> - correct bit numbers for drive 3/4
> 
> Changes since RFC v3:
> 
> - split off this byte swap handling into separate patch
> 
> - add hint regarding third and fourth drive on Q40
> 
> Finn Thain:
> - rename module parameter to 'data_swab' to better reflect its use
> 
> William Sowerbutts:
> - correct IDE drive number used in data swap conditional
> ---
>  drivers/ata/pata_falcon.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
> index 346259e3bbc8..27443cb757de 100644
> --- a/drivers/ata/pata_falcon.c
> +++ b/drivers/ata/pata_falcon.c
> @@ -33,6 +33,11 @@
>  #define DRV_NAME "pata_falcon"
>  #define DRV_VERSION "0.1.0"
>  
> +static int pata_falcon_swap_mask;
> +
> +module_param_named(data_swab, pata_falcon_swap_mask, int, 0444);
> +MODULE_PARM_DESC(data_swab, "Data byte swap enable/disable bitmap (0x1==drive1, 0x2==drive2, 0x4==drive3, 0x8==drive4, default==0)");
> +
>  static const struct scsi_host_template pata_falcon_sht = {
>  	ATA_PIO_SHT(DRV_NAME),
>  };
> @@ -46,11 +51,12 @@ static unsigned int pata_falcon_data_xfer(struct ata_queued_cmd *qc,
>  	void __iomem *data_addr = ap->ioaddr.data_addr;
>  	unsigned int words = buflen >> 1;
>  	struct scsi_cmnd *cmd = qc->scsicmd;
> +	int dev_id = dev->devno;

Is that variable really needed?

>  	bool swap = 1;
>  
>  	if (dev->class == ATA_DEV_ATA && cmd &&
>  	    !blk_rq_is_passthrough(scsi_cmd_to_rq(cmd)))
> -		swap = 0;
> +		swap = (uintptr_t)ap->private_data & BIT(dev_id);
>  
>  	/* Transfer multiple of 2 bytes */
>  	if (rw == READ) {
> @@ -199,6 +205,8 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>  	ap->ioaddr.altstatus_addr	= ctl_base + io_offset;
>  	ap->ioaddr.ctl_addr		= ctl_base + io_offset;
>  
> +	ap->private_data = (void *)(uintptr_t)(pata_falcon_swap_mask >> (2 * pdev->id));
> +

My compiler doesn't need that extra type cast in there...

>  	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>  	if (irq_res && irq_res->start > 0) {
>  		irq = irq_res->start;
> 
