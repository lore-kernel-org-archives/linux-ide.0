Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB06C433E0
	for <linux-ide@archiver.kernel.org>; Tue, 30 Mar 2021 13:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3485461994
	for <linux-ide@archiver.kernel.org>; Tue, 30 Mar 2021 13:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhC3NVS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbhC3NU5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 30 Mar 2021 09:20:57 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7E5C061574
        for <linux-ide@vger.kernel.org>; Tue, 30 Mar 2021 06:20:57 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so8397631wmi.3
        for <linux-ide@vger.kernel.org>; Tue, 30 Mar 2021 06:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4R5KVV48OkZwnadM0hg2zgM+0geN2WtVTO0fIN99ocs=;
        b=kAPT41JdAEohBFvI434mfOzuu4YTlmsizuTrKt+arsZecsHiMzQSPbGkFnSYTzM+kY
         fTZ+2AYNLz3P9vqu8NNVelB30mT7mI5j/XTpgjD7qoH4Wqa2+DyOUdv3vgBVdyT1V/6Z
         TKLawlYjhH0s6K7avysz8QvTOa2AwK70yNIF5z2DhOtzV2dTJuV+q+MhCXMVRMxCED+P
         lAdwDTw82buEt6TBYrLL03inuCjx8xc+4vsTg5zg8JCtXsvJ71aBvdKp5Jxoe+9huuV9
         wdQC1ZGRl1h49R20OuKY4QRLJ1PJSSOCQ76i4KXKpLM6ipiH9MegjcxKGn1DNbxVxwDT
         kJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4R5KVV48OkZwnadM0hg2zgM+0geN2WtVTO0fIN99ocs=;
        b=Ar1EuGEZqJIRKjdO+i/ipLC+DHuhHxZn4HX/U+CMclze+PwgV5ywonu0saz33GSgqJ
         F37JFSDvCEdQf/bLfKU//6YM64Ap1llvsb8jqcO8d8NUbVTXNbSAhhhGIgDXW5I/jBTm
         MyRmxUqsbVTfeAInlA/md3rxayUOWNn9yYEym8EYMoNHtdoltDDuKN8HphEHy2qqw2NF
         9nisEQhaQHLVdPNQ0Z+pfCnszPVN6/fV9aMj4/ZDZ9qjQGv0K85E3fVtUlOrBklEtU6m
         ff65UZ899Uzn4/vQ9picNh3m5gsZBXF6N0/pyc2qnOTIiBPJ549Oy9aFRJcG6zMjpXT/
         LcIA==
X-Gm-Message-State: AOAM531SzVhYwZrwO9UAQTXxyOQRtlVz7TAnwZK2EQedug4E9BbX5FSk
        +k5nMPejpG06rbddeyaaRQ58Hw==
X-Google-Smtp-Source: ABdhPJx70J1PjQXA/+0hBzqnkw32wwk5cAZvIITwcyfaXeEQEQMrnUcpQJ5cfDCielW5ItIpwbnIuQ==
X-Received: by 2002:a05:600c:19ce:: with SMTP id u14mr4034923wmq.109.1617110456259;
        Tue, 30 Mar 2021 06:20:56 -0700 (PDT)
Received: from dell ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id s13sm2592291wrv.80.2021.03.30.06.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:20:55 -0700 (PDT)
Date:   Tue, 30 Mar 2021 14:20:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        ALWAYS copy <linux-ide@vger.kernel.org>,
        Andre Hedrick <andre@linux-ide.org>,
        Colten Edwards <pje120@cs.usask.ca>, Hat Inc <alan@redhat.com>,
        Jan Harkes <jaharkes@cwi.nl>, Jaromir Koutek <miri@punknet.cz>,
        Jens Axboe <axboe@kernel.dk>,
        "L.C. Chang" <lcchang@sis.com.tw>,
        Lionel Bouton <Lionel.Bouton@inet6.fr>,
        Mark Lord <mlord@pobox.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Torben Mathiasen <torben.mathiasen@hp.com>,
        Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 00/15] [Set 2] Rid W=1 warnings from ATA
Message-ID: <20210330132053.GJ2916463@dell>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, 18 Mar 2021, Lee Jones wrote:

> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> This is set 2 out of 2 sets required.
> 
> Lee Jones (15):
>   ata: pata_pdc202xx_old: Fix some incorrectly named functions
>   ata: pata_sil680: Add some missing function parameter docs
>   ata: pata_sis: Remove superfluous param description and supply another
>   ata: pata_triflex: Repair some misnamed functions and fix some param
>     descriptions
>   ata: pata_it821x: Fix possible doc-rotted function names
>   ata: pata_via: Fix a kernel-doc formatting issue
>   ata: pata_piccolo: 'ata_tosh_init()' is misnamed in its header
>   ata: pata_sl82c105: Fix potential doc-rot
>   ata: pata_opti: Fix spelling issue of 'val' in 'opti_write_reg()'
>   ata: ata_generic: Fix misspelling of 'ata_generic_init_one()'
>   ata: pata_legacy: Repair a couple kernel-doc problems
>   ata: pata_cs5530: Fix misspelling of 'cs5530_init_one()'s 'pdev' param
>   ata: sata_mv: Fix misnaming of 'mv_bmdma_stop()'
>   ata: libata-acpi: Fix function name and provide description for
>     'prev_gtf'
>   ata: pata_acpi: Fix some incorrect function param descriptions

Would you like me to resubmit these?

>  drivers/ata/ata_generic.c       | 2 +-
>  drivers/ata/libata-acpi.c       | 3 ++-
>  drivers/ata/pata_acpi.c         | 6 +++---
>  drivers/ata/pata_cs5530.c       | 2 +-
>  drivers/ata/pata_it821x.c       | 4 ++--
>  drivers/ata/pata_legacy.c       | 8 ++++----
>  drivers/ata/pata_opti.c         | 2 +-
>  drivers/ata/pata_pdc202xx_old.c | 4 ++--
>  drivers/ata/pata_piccolo.c      | 2 +-
>  drivers/ata/pata_sil680.c       | 2 ++
>  drivers/ata/pata_sis.c          | 2 +-
>  drivers/ata/pata_sl82c105.c     | 2 +-
>  drivers/ata/pata_triflex.c      | 7 +++----
>  drivers/ata/pata_via.c          | 2 +-
>  drivers/ata/sata_mv.c           | 2 +-
>  15 files changed, 26 insertions(+), 24 deletions(-)
> 
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: ALWAYS copy <linux-ide@vger.kernel.org>
> Cc: Andre Hedrick <andre@linux-ide.org>
> Cc: Colten Edwards <pje120@cs.usask.ca>
> Cc: Hat Inc <alan@redhat.com>
> Cc: Jan Harkes <jaharkes@cwi.nl>
> Cc: Jaromir Koutek <miri@punknet.cz>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: "L.C. Chang" <lcchang@sis.com.tw>
> Cc: linux-ide@vger.kernel.org
> Cc: Lionel Bouton <Lionel.Bouton@inet6.fr>
> Cc: Mark Lord <mlord@pobox.com>
> Cc: Red Hat <alan@redhat.com>
> Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Cc: Torben Mathiasen <torben.mathiasen@hp.com>
> Cc: Vojtech Pavlik <vojtech@suse.cz>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
