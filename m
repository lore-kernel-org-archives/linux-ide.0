Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4F8C433DB
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 13:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D48AD64E97
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 13:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhBAN5S (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 1 Feb 2021 08:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBAN5R (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 1 Feb 2021 08:57:17 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F53CC061756
        for <linux-ide@vger.kernel.org>; Mon,  1 Feb 2021 05:56:36 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id g10so16687559wrx.1
        for <linux-ide@vger.kernel.org>; Mon, 01 Feb 2021 05:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hNt79SEwyevHlCnNpQqVrGlo2a3i4FGi8Hmj5UsB0YU=;
        b=M3PnKpu5bp1bl2yYEhhr4sCnuaO9FGuJbLvEBWPW0WULJh3Cpkm8GLVAU6DYeu8dRy
         pP1rj3IK0ON+NY7DRc8z82F+pbzd4oDCGZ4CY34AHOaHtMsmT3H+Kfu/PATcu2F/rS8n
         fWdTB3af7hfwLCuQKmuYr6QEKdfcDNFKdP6rss0uFJmcz3Xkh7xWaW74LQb60V9xNghq
         le+gHWovZEXM+0zOU7iXpxSh0XQzzeG8QtPWGAyntBAbLKDqt/nouH6NYzMuys4bPzS7
         85D6QOHH6SbpRMF9pJ4bnPkEvSnP0JfZ/CmETeTm7cmKrcSKysdtSKYsGh/tV6MiBaYl
         QCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hNt79SEwyevHlCnNpQqVrGlo2a3i4FGi8Hmj5UsB0YU=;
        b=Swbr4mifZWkm3YWlRNo4D9e6shpzBintCWcrT9I/Xgcjs5p5D3+yUN7WFq//wpRUbS
         8loqi1yy09Zx2yJp96DVTk0uvTM9FLgcdmit1hFp+wGMUmmkXIBz057ZQkTNz+GST3VU
         eYKMsYDFnftJlybGgDnejXihjdBNugKEHaTcUoe46m68wz4OAisvhOiD9ResvC0GanZM
         FKZnjaIvqLsiGHEaLfnHN2VlUJodab8GguBvqJ1CS+Jn96jJ2E2uedWKJHvxj0ECnb9Q
         BZ9iXToUtgs98uzmSB+nC7iODtZhAzrWE4r2t44dlcTQ5Sch710fyIh+3Hvvw7mJsuSW
         L/1Q==
X-Gm-Message-State: AOAM533cDT4GCabXVwFpJLjZV6gKlmwXELGYnDG6ShjZ4fF3kmotN8Xm
        1fZQoOcg0n7DajC2RBAL+D79Cw==
X-Google-Smtp-Source: ABdhPJymaH4S/uzykkYB60csZ4w9HpANZ6MSS095a8XKFeEWTFyVP/MB4qAPITf+EkWkOBiUVCMXLg==
X-Received: by 2002:a5d:69ce:: with SMTP id s14mr17708926wrw.206.1612187795297;
        Mon, 01 Feb 2021 05:56:35 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u14sm20527162wml.19.2021.02.01.05.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 05:56:34 -0800 (PST)
Date:   Mon, 1 Feb 2021 13:56:33 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        IDE-ML <linux-ide@vger.kernel.org>
Subject: Re: [PATCH 01/20] ata: ahci_dm816: Ignore -Woverride-init
Message-ID: <20210201135633.GV4774@dell>
References: <20210128180239.548512-1-lee.jones@linaro.org>
 <20210128180239.548512-2-lee.jones@linaro.org>
 <20210128181903.GA2099675@infradead.org>
 <20210128182713.GM4774@dell>
 <CAK8P3a3XgqD_bDreG_SPCfrjqLaduEpiwiWFVf73eNkrrMoBtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a3XgqD_bDreG_SPCfrjqLaduEpiwiWFVf73eNkrrMoBtw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, 01 Feb 2021, Arnd Bergmann wrote:

> On Thu, Jan 28, 2021 at 7:32 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Thu, 28 Jan 2021, Christoph Hellwig wrote:
> >
> > > On Thu, Jan 28, 2021 at 06:02:20PM +0000, Lee Jones wrote:
> > > > Some ATA drivers use the SCSI host template, a series of interwoven
> > > > macros, to aid with initialisation.  Some of these macros conflict,
> > > > resulting in the over-writing of previously set values.
> > >
> > > Please just disable this warning globally.  This is a sensible
> > > patter and we should not sprinkle per-file options for something
> > > that fundamental.
> >
> > Will do.  Just as soon as I've figured out how. :)
> 
> I have a local patch series doing it like this

Can I leave this in your capable hands then?

I'll drop all my fixes for this if it can be replaced with just one.

> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 5f550eb27f81..4e4cc14a289e 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1390,6 +1390,8 @@ extern struct device_attribute *ata_common_sdev_attrs[];
>   * edge driver's module reference, otherwise the driver can be unloaded
>   * even if the scsi_device is being accessed.
>   */
> +__diag_ignore(GCC, 8, "-Woverride-init", "intentional override")
> +__diag_ignore(CLANG, 9, "-Winitializer-overrides", "intentional override")
>  #define __ATA_BASE_SHT(drv_name)                               \
>         .module                 = THIS_MODULE,                  \
>         .name                   = drv_name,                     \
> 
> I think this also requires a preparation patch to extend __diag_ignore to
> additional compiler versions, not sure if that was already merged.
> 
>          Arnd

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
