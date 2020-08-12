Return-Path: <SRS0=uJpK=BW=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CF2C433E0
	for <linux-ide@archiver.kernel.org>; Wed, 12 Aug 2020 14:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D7C204FD
	for <linux-ide@archiver.kernel.org>; Wed, 12 Aug 2020 14:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMx16CFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgHLONM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 12 Aug 2020 10:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbgHLONK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 12 Aug 2020 10:13:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55916C061386
        for <linux-ide@vger.kernel.org>; Wed, 12 Aug 2020 07:13:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f1so2205122wro.2
        for <linux-ide@vger.kernel.org>; Wed, 12 Aug 2020 07:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BAYgOfe5stUcl69x3S7eimrTDZBSiHB9OvfmPx9Zdrw=;
        b=iMx16CFMmDH2fRRYk1rZbM/ORr/ooYW/ce6+lp1QXcOJO7DkGjJvgbPjnQ9dpqFOcR
         BQd9bFmrHx259fF4+pnLrDLKzHU8BN60APCkxTzh2CWJUqLCcqsalXd8riNjZXhure06
         HoP1PAiNEs/gdPQ2RJCkMX+syFcxq6J2jDdvuRzhAZUZpeK3levdB9KTIGXns2WLSY+7
         jeUM2TP2BBlHH7cwC28jej7YkL0SnN61RWDV1CGs+WI+4pNEn0OBcrpVWB4jvF7RazvK
         FD7XjCicKe1WmhUCAo36zCBymfbB9PK95AKScfv0XaONkZOZKhdAptUin0T8jRh7jV7D
         fmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BAYgOfe5stUcl69x3S7eimrTDZBSiHB9OvfmPx9Zdrw=;
        b=Jr8/yTvnDTfnd/dcXGClWv5iOxQLcSPHJNIKtYLPJJrMoKx2r3kNrU0RxnmcrMxXwA
         ITRrN9+aUVTsYLC+uXf+bR+098+vWDcac0AcNnMG8u5M1rCf+nQfk9DYn2AjvHJsfIlh
         P5uZjNjZe/4OqRm6tvswpa6mceH9aXfvFrNNbCeZGnCKSdgQRS90v3fLDPzrv6MFxBVt
         JKbsfnvYYDIIq8vjr7sszXIaXxu0VI1BN78DCrk0E+svzPIY+9x4O9DIY0tI3cwTZpZA
         +nihrJVbKIE7XjcSlKbPa5H9o3Ll+nHplituB2uIQKFljsEMF8PHzIVQ8QgHu6aYVS7C
         c2Og==
X-Gm-Message-State: AOAM532w2SQ/mtGMNN77TARhQrDoC/j+goTFFbTv/m53ILLN7i/5n7B3
        tbh45P1OWDHfm+abvz04oLqsyDFkZa2gdiq5GjrJ7Q==
X-Google-Smtp-Source: ABdhPJzHu2ZRSBGxhkIBggfOak2BaqrqSKgARW9ic/KPrejEq5Og+5of1oDTl5faeGNIqwjzmhEgxDeTRZCKa32paBc=
X-Received: by 2002:adf:f248:: with SMTP id b8mr36015334wrp.247.1597241588772;
 Wed, 12 Aug 2020 07:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200811081712.4981-1-geert+renesas@glider.be>
In-Reply-To: <20200811081712.4981-1-geert+renesas@glider.be>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 12 Aug 2020 16:12:32 +0200
Message-ID: <CAPDyKFpsWpvsQjG6Oh=FudUbWFUvJv_3PtzauGOckKLtOx8BRg@mail.gmail.com>
Subject: Re: [PATCH v2] ata: sata_rcar: Fix DMA boundary mask
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-ide@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, 11 Aug 2020 at 10:17, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Before commit 9495b7e92f716ab2 ("driver core: platform: Initialize
> dma_parms for platform devices"), the R-Car SATA device didn't have DMA
> parameters.  Hence the DMA boundary mask supplied by its driver was
> silently ignored, as __scsi_init_queue() doesn't check the return value
> of dma_set_seg_boundary(), and the default value of 0xffffffff was used.
>
> Now the device has gained DMA parameters, the driver-supplied value is
> used, and the following warning is printed on Salvator-XS:
>
>     DMA-API: sata_rcar ee300000.sata: mapping sg segment across boundary [start=0x00000000ffffe000] [end=0x00000000ffffefff] [boundary=0x000000001ffffffe]
>     WARNING: CPU: 5 PID: 38 at kernel/dma/debug.c:1233 debug_dma_map_sg+0x298/0x300
>
> (the range of start/end values depend on whether IOMMU support is
>  enabled or not)
>
> The issue here is that SATA_RCAR_DMA_BOUNDARY doesn't have bit 0 set, so
> any typical end value, which is odd, will trigger the check.
>
> Fix this by increasing the DMA boundary value by 1.
>
> Fixes: 8bfbeed58665dbbf ("sata_rcar: correct 'sata_rcar_sht'")
> Fixes: 9495b7e92f716ab2 ("driver core: platform: Initialize dma_parms for platform devices")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: stable <stable@vger.kernel.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> v2:
>   - Add Reviewed-by, Tested-by, Cc.
>
> This is a fix for a regression in v5.7-rc5 that fell through the cracks.
> https://lore.kernel.org/linux-ide/20200513110426.22472-1-geert+renesas@glider.be/
>
> As by default the DMA debug code prints the first error only, this issue
> may be hidden on plain v5.7-rc5, where the FCP driver triggers a similar
> warning.  Merging commit dd844fb8e50b12e6 ("media: platform: fcp: Set
> appropriate DMA parameters", in v5.8-rc1) from the media tree fixes the
> FCP issue, and exposes the SATA issue.
>
> I added the second fixes tag because that commit is already being
> backported to stable kernels, and this patch thus needs backporting,
> too.
> ---
>  drivers/ata/sata_rcar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
> index 141ac600b64c87ef..44b0ed8f6bb8a120 100644
> --- a/drivers/ata/sata_rcar.c
> +++ b/drivers/ata/sata_rcar.c
> @@ -120,7 +120,7 @@
>  /* Descriptor table word 0 bit (when DTA32M = 1) */
>  #define SATA_RCAR_DTEND                        BIT(0)
>
> -#define SATA_RCAR_DMA_BOUNDARY         0x1FFFFFFEUL
> +#define SATA_RCAR_DMA_BOUNDARY         0x1FFFFFFFUL
>
>  /* Gen2 Physical Layer Control Registers */
>  #define RCAR_GEN2_PHY_CTL1_REG         0x1704
> --
> 2.17.1
>
