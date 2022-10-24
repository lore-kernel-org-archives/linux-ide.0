Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8E5FA3744
	for <linux-ide@archiver.kernel.org>; Mon, 24 Oct 2022 13:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbiJXNmR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 24 Oct 2022 09:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236789AbiJXNlP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Oct 2022 09:41:15 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB864B44BF
        for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2022 05:38:38 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id n18so1047442qvt.11
        for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2022 05:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oppr3g1kldcRr/h0YX8+D6gvN1LuMqBrF3TdUSXw7uw=;
        b=Mqnv6SQRHYxqDSvqFOM3ZLYqWYMqHSgRR9NfD4WFyHINegNpyafEjGcaUUfZSq4ZU6
         2AhhXXa6KgZtAutXORalVNP4KopcVzsydgD6rAJsecH2Lfhw9Y2AcdIppkoLskWmbAon
         dxnp1p2thqWjVVGAzqT3QbdJNLylwGPtqD2e8ZR/eHfvfmtMDLIlHANZuGUMT6DOcT0c
         BB5nu/7Xxnzb8khN/Y2fXNvEZXhekWtbb1Nbf9hbK3kCE6wNUNw1lIeAiwBfyIEWC+aI
         F3T99QX1FdCugoXtj2vLzHPCY5e5unpKACQlqLOFUD0b01NZQQe/fplvHlEvZhW6OSoP
         0+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oppr3g1kldcRr/h0YX8+D6gvN1LuMqBrF3TdUSXw7uw=;
        b=r5Mt2Va0JLJuFigHBDi1vxaCBJ2SrCCNWC+bNsLH/puYkUQUx2tD/Hek6F0sfG78+n
         tySj9nd1+g5V4lrpflRkbFxmUPcl5K9geySNqFQ8jr7gYatFBE+Vkhz/J1LgRwNMeFNE
         wqurhEzpGRSnHLYg9fpoC1z7a+Bw2N8oBVHIFn25dZg5vsS7SxcclDPPvD0rQIGKTpWL
         Ytro8db+xvN2dPMUxSMrALk4roe8dWCRadsrON3/qpiGywTxkjxNeLPtfFoVsmZOimlO
         CBpnbS6ziJmubf7Bv8WvdcdlU+wNaxDo4pdmEZrcOosjHwqxcjJlab7YnPW9d6glzRF5
         xZ/A==
X-Gm-Message-State: ACrzQf1CY/J0WBW0VEC3Esx1waY2uZRovn4Mhp9uZdpJS8DD1Rbs0anF
        FQvrjopghGpwKvMv/v2nIYGIzQ==
X-Google-Smtp-Source: AMsMyM4iLxX3UBiGciYkAbas+DN289cPrqWsUgLbLsnCVUvii+FKgBK9L/GjErEZT6DwfcUBdiBuDg==
X-Received: by 2002:a0c:b3da:0:b0:4b4:a3d6:fa27 with SMTP id b26-20020a0cb3da000000b004b4a3d6fa27mr27199126qvf.14.1666614897485;
        Mon, 24 Oct 2022 05:34:57 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id bm30-20020a05620a199e00b006e42a8e9f9bsm14638163qkb.121.2022.10.24.05.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:34:56 -0700 (PDT)
Message-ID: <a5b300e3-97aa-0166-82d0-87049a87b1bf@linaro.org>
Date:   Mon, 24 Oct 2022 08:34:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 09/21] pata: remove samsung_cf driver
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-9-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021203329.4143397-9-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 21/10/2022 16:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This device was only used by the smdk6410 board file that is now
> gone, so the driver can be removed as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/ata/Kconfig                          |  10 -
>  drivers/ata/Makefile                         |   1 -
>  drivers/ata/pata_samsung_cf.c                | 662 -------------------
>  include/linux/platform_data/ata-samsung_cf.h |  31 -
>  4 files changed, 704 deletions(-)
>  delete mode 100644 drivers/ata/pata_samsung_cf.c
>  delete mode 100644 include/linux/platform_data/ata-samsung_cf.h
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 6b446cfc3455..3b8cb7a29efd 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -1136,16 +1136,6 @@ config PATA_RZ1000
>  
>  	  If unsure, say N.
>  
> -config PATA_SAMSUNG_CF
> -	tristate "Samsung SoC PATA support"
> -	depends on SAMSUNG_DEV_IDE || COMPILE_TEST
> -	select PATA_TIMINGS
> -	help
> -	  This option enables basic support for Samsung's S3C/S5P board
> -	  PATA controllers via the new ATA layer
> -

This driver is present and somehow usable on newer platform: S5PV210.
It's not converted to DT, but someone might want to do it. OTOH, if no
one added DT for all this time, I doubt anyone will.
Postmarket/Lineage-folks target smartphones, so don't use it.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

