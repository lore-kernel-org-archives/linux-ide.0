Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA7BC433DB
	for <linux-ide@archiver.kernel.org>; Fri, 26 Mar 2021 03:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1164619B4
	for <linux-ide@archiver.kernel.org>; Fri, 26 Mar 2021 03:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhCZDLj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 25 Mar 2021 23:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhCZDLd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 25 Mar 2021 23:11:33 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303C9C06174A
        for <linux-ide@vger.kernel.org>; Thu, 25 Mar 2021 20:11:33 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id l1so227365plg.12
        for <linux-ide@vger.kernel.org>; Thu, 25 Mar 2021 20:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cg0XR2dgI1yFqK2ibwtLxzMcJuoaRWctAsKBNX21wxM=;
        b=eFPEFTtmACktHym6dQqbnxeU1YYhWqnNFyTKvQsyqDw7S6qA5EWMG2nlU8KuEhDQrI
         a7h7V35lkoiw9IX2Z4lKIXwYzMZLyT+uuAhyxuqR9ZqYXo4ASJxnt6eYEcCIsowJeVEV
         90qUtzOsX5ULvh4YU+xts8b1jU/Frm0y/CXSPp/KVz+iCIP17/jW6Pl2YoCf0TzU9hBU
         q10KQW7niewkvB80gpRuyGmClBHb95rpJb2D07IbEYWO4dqbu2L4+qXokFV2MW9UBFhB
         3Z5frZ4qD95STA+DMIMu5CqMIOmgLjCIPGpZQa1y9t4pnb3NnxAT4Yig8ExNQQ5FZiEX
         w83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cg0XR2dgI1yFqK2ibwtLxzMcJuoaRWctAsKBNX21wxM=;
        b=YQb7Peq5fGmHYQS4m/BHkPV645HlwCUfClqk1SUz6Xa9JnKOsuZX9xR/AA/d2zgY98
         P+66g8H2GKIZQUzHDWPN70P1AqfjyP9i72xnxf/zoHrY+P08EP6xTIJFyU2U1ykKnD81
         Oqm/pfLegKA09eUImzpGQnVYbSkgXynGugVDpqQDBzNZiZJfvN98WIvDf7OGfBrofQdK
         H48lZjkeMspEgBcDm66Qp6eynJueWtETdy3oyZ5vO+xYqOy5G+QJw/tyJ0nqdgeRtwxR
         f8iqkckjuqG4wdiqsVbm9IMEH/IGhF059FrArx5CfvxQ2tHrU2f3hC1Fu8ZDq0qUDZAX
         uK1Q==
X-Gm-Message-State: AOAM530TprMMr3IFdaltnL8bbBzx+I97xk156Kr4YZKQk9wx2IT2i+Mq
        fGIUEC8J3mn8A7YQtbaJv9os4YeZM/HHiQ==
X-Google-Smtp-Source: ABdhPJzBgJYBiLF8hkItEJQdE7ZSk17rzGM2FzhfzrkCVveCWLRjB19EDTBdpRfBc51M13tVPUbuJw==
X-Received: by 2002:a17:903:18a:b029:e6:7fc1:1c2a with SMTP id z10-20020a170903018ab02900e67fc11c2amr12827117plg.5.1616728292661;
        Thu, 25 Mar 2021 20:11:32 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id y4sm6964797pfn.67.2021.03.25.20.11.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Mar 2021 20:11:26 -0700 (PDT)
Date:   Fri, 26 Mar 2021 08:41:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sergey Shtylyov <s.shtylyov@omprussia.ru>
Cc:     Jens Axboe <axboe@kernel.dk>, Viresh Kumar <vireshk@kernel.org>,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH 1/2] pata_arasan_cf: fix IRQ check
Message-ID: <20210326031124.73rixrtpj3wgt3d2@vireshk-i7>
References: <7ba924c1-8c94-b0e7-6361-5e060746e839@omprussia.ru>
 <be289a3d-b230-be2c-c367-d9a42b1cde82@omprussia.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be289a3d-b230-be2c-c367-d9a42b1cde82@omprussia.ru>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 25-03-21, 23:50, Sergey Shtylyov wrote:
> The driver's probe() method is written as if platform_get_irq() returns 0
> on error, while actually it returns a negative error code (with all the
> other values considered valid IRQs). Rewrite the driver's IRQ checking code
> to pass the positive IRQ #s to ata_host_activate(), propagate upstream
> -EPROBE_DEFER, and set up the driver to polling mode on (negative) errors
> and IRQ0 (libata treats IRQ #0 as a polling mode anyway)...
> 
> Fixes: a480167b23ef ("pata_arasan_cf: Adding support for arasan compact flash host controller")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>
> 
> ---
> This patch is against the 'master' branch of Jens Axboe's 'linux-block.git'
> repo.
> 
>  drivers/ata/pata_arasan_cf.c |   15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> Index: linux-block/drivers/ata/pata_arasan_cf.c
> ===================================================================
> --- linux-block.orig/drivers/ata/pata_arasan_cf.c
> +++ linux-block/drivers/ata/pata_arasan_cf.c
> @@ -818,12 +818,19 @@ static int arasan_cf_probe(struct platfo
>  	else
>  		quirk = CF_BROKEN_UDMA; /* as it is on spear1340 */
>  
> -	/* if irq is 0, support only PIO */
> -	acdev->irq = platform_get_irq(pdev, 0);
> -	if (acdev->irq)
> +	/*
> +	 * If there's an error getting IRQ (or we do get IRQ0),
> +	 * support only PIO
> +	 */
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret > 0) {
> +		acdev->irq = ret;
>  		irq_handler = arasan_cf_interrupt;
> -	else
> +	} else	if (ret == -EPROBE_DEFER) {
> +		return ret;
> +	} else	{
>  		quirk |= CF_BROKEN_MWDMA | CF_BROKEN_UDMA;
> +	}
>  
>  	acdev->pbase = res->start;
>  	acdev->vbase = devm_ioremap(&pdev->dev, res->start,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
