Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D52C4321A
	for <linux-ide@archiver.kernel.org>; Wed,  3 Mar 2021 22:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD88B64EED
	for <linux-ide@archiver.kernel.org>; Wed,  3 Mar 2021 22:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390248AbhCCWBi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 3 Mar 2021 17:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383232AbhCCObE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 3 Mar 2021 09:31:04 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F50C061756
        for <linux-ide@vger.kernel.org>; Wed,  3 Mar 2021 06:26:20 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o7-20020a05600c4fc7b029010a0247d5f0so2940199wmq.1
        for <linux-ide@vger.kernel.org>; Wed, 03 Mar 2021 06:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BZV/Cdq0DO3sKoCM3TrKO5/xI+KhNrMUizFmwVikGAs=;
        b=LJ+l6O6O9ytQenmemfN5t2jZ/gHf7tAj46d6IQaVTEPQ10hVXwqC6aLIKv3h5HgXnu
         do29RT9WxreANwRBM8OraTMVyIC3KARYiun8/zoLJ2vqm+6knL/ky5Uy5DG6zfllJxaM
         9jFo089RFcCObnkW/ut3Re1N0gHnKeOZcGYPi7wfqzSrHiWam6+uCTmvId6puZjXLjgD
         TucrVb1txQQXNQoG0m33cH8H8o08cKULogfCW3fDZ3oBtQ5jwtddJSCyamz17HVbeMGA
         zL/4ZkJ/bVmVqv7yNo5PdrblASUITM1QB0LedM6I6KAU8BYGtm8PwBi8jjRp+YeDpCyr
         NXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BZV/Cdq0DO3sKoCM3TrKO5/xI+KhNrMUizFmwVikGAs=;
        b=tJ+/BTXBst8py1UWmRfufKQTJoE4QkR+/JI1yLJhvJUMMqbj8oeODVbao04XFVK8Qp
         NqEdNuJQUPW0ksHv+MTBeE+ov2mPzAW2T//zbCW8zoZoDetFEFSfDUc4Bd6qDaONy+Ur
         JegQ51BusT9ud2t9EWMGVPdUOoZgsLE+q/WT2CUAkjZkz1nNgU9ebPqqG10c0NuEuFeL
         N3ZO9MIhxpolGURCWOW2AiXdMunVoGHBZhczHs8SnU5ENZcniFf1o/JiPZuU4rS2sMva
         pgSN93nksbcPk4hKFe5QtrJlGFvMbtX3nX2yIwAijLjCWoBCj+CyYTkzFjA4ebQce0LO
         cW/w==
X-Gm-Message-State: AOAM533sAtcqu73GcwYVMGniWN496MIEyJ+kxktMBrdKB67BT1QTcoLd
        h62uTJ3YnDWougEjrE8eIC/kaw==
X-Google-Smtp-Source: ABdhPJyUjleXUsqjAqlsTnHTP8Zqyk5qA8CJ1JQfDSwkqv/FRUf3bLVRH7L1XFcAoNlyDt92O8ePjQ==
X-Received: by 2002:a1c:195:: with SMTP id 143mr9350991wmb.147.1614781579185;
        Wed, 03 Mar 2021 06:26:19 -0800 (PST)
Received: from dell ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id s20sm6001814wmj.36.2021.03.03.06.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:26:18 -0800 (PST)
Date:   Wed, 3 Mar 2021 14:26:16 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
        Albert Lee <albertcc@tw.ibm.com>,
        Alessandro Zummo <alessandro.zummo@towertech.it>,
        ALWAYS copy <linux-ide@vger.kernel.org>,
        and cc <htejun@gmail.com>, Andre Hedrick <andre@linux-ide.org>,
        ATI Inc <hyu@ati.com>, CJ <cjtsai@ali.com.tw>,
        Clear Zhang <Clear.Zhang@ali.com.tw>,
        Frank Tiernan <frankt@promise.com>,
        Jens Axboe <axboe@kernel.dk>, Loc Ho <lho@apm.com>,
        Mark Lord <mlord@pobox.com>,
        Suman Tripathi <stripathi@apm.com>, Tejun Heo <teheo@suse.de>,
        Thibaut VARENE <varenet@parisc-linux.org>,
        Tuan Phan <tphan@apm.com>
Subject: Re: [PATCH v2 00/20] [Set 1] Rid W=1 warnings from ATA
Message-ID: <20210303142616.GF2690909@dell>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, 01 Feb 2021, Lee Jones wrote:

> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> This is set 1 out of 2 sets required.

Would you like me to [RESEND] this set?

> v2:
>  - Removed "Ignore -Woverride-init" patches
>  - Back-filled them with others
> 
> Lee Jones (20):
>   ata: libata-transport: Fix some potential doc-rot issues
>   ata: libata-sata: Fix function names in header comments
>   ata: libata-pmp: Fix misspelling of 'val'
>   ata: pata_ali: Repair some misnamed kernel-doc issues
>   ata: pata_artop: Fix a function name and parameter description
>   ata: pata_amd: Remove superfluous, add missing and fix broken params
>   ata: pata_hpt366: Provide missing description for 'hpt366_filter()'s
>     'mask' param
>   ata: pata_hpt37x: Fix some function misnaming and missing param issues
>   ata: ahci_xgene: Fix incorrect naming of
>     'xgene_ahci_handle_broken_edge_irq()'s 'host' param
>   ata: sata_mv: Fix worthy headers and demote others
>   ata: pata_ali: Supply description for 'ali_20_filter()'s 'mask' param
>   ata: pata_amd: Fix incorrectly named function in the header
>   ata: pata_artop: Repair possible copy/paste issue in
>     'artop_6210_qc_defer()'s header
>   ata: pata_atiixp: Fix a function name and supply description for 'pio'
>   ata: pata_cs5520: Add a couple of missing param descriptions
>   ata: pata_hpt3x2n: Fix possible doc-rotted function name
>   ata: pata_marvell: Fix incorrectly documented function parameter
>   ata: pata_jmicron: Fix incorrectly documented function parameter
>   ata: pata_optidma: Fix a function misnaming, a formatting issue and a
>     missing description
>   ata: pata_pdc2027x: Fix some incorrect function names and parameter
>     docs
> 
>  drivers/ata/ahci_xgene.c       |  2 +-
>  drivers/ata/libata-pmp.c       |  2 +-
>  drivers/ata/libata-sata.c      |  4 ++--
>  drivers/ata/libata-transport.c |  6 +++---
>  drivers/ata/pata_ali.c         |  6 +++---
>  drivers/ata/pata_amd.c         |  6 +++---
>  drivers/ata/pata_artop.c       |  4 ++--
>  drivers/ata/pata_atiixp.c      |  3 ++-
>  drivers/ata/pata_cs5520.c      |  2 ++
>  drivers/ata/pata_hpt366.c      |  1 +
>  drivers/ata/pata_hpt37x.c      |  6 ++++--
>  drivers/ata/pata_hpt3x2n.c     |  2 +-
>  drivers/ata/pata_jmicron.c     |  2 +-
>  drivers/ata/pata_marvell.c     |  2 +-
>  drivers/ata/pata_optidma.c     |  5 +++--
>  drivers/ata/pata_pdc2027x.c    | 10 +++++-----
>  drivers/ata/sata_mv.c          | 12 ++++++------
>  17 files changed, 41 insertions(+), 34 deletions(-)
> 
> Cc: Alan Cox <alan@redhat.com>
> Cc: Albert Lee <albertcc@tw.ibm.com>
> Cc: Alessandro Zummo <alessandro.zummo@towertech.it>
> Cc: ALWAYS copy <linux-ide@vger.kernel.org>
> Cc: and cc <htejun@gmail.com>
> Cc: Andre Hedrick <andre@linux-ide.org>
> Cc: ATI Inc <hyu@ati.com>
> Cc: CJ <cjtsai@ali.com.tw>
> Cc: Clear Zhang <Clear.Zhang@ali.com.tw>
> Cc: Frank Tiernan <frankt@promise.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-ide@vger.kernel.org
> Cc: Loc Ho <lho@apm.com>
> Cc: Mark Lord <mlord@pobox.com>
> Cc: Suman Tripathi <stripathi@apm.com>
> Cc: Tejun Heo <htejun@gmail.com>
> Cc: Tejun Heo <teheo@suse.de>
> Cc: Thibaut VARENE <varenet@parisc-linux.org>
> Cc: Tuan Phan <tphan@apm.com>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
