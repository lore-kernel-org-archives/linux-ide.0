Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD08C433EF
	for <linux-ide@archiver.kernel.org>; Wed, 13 Oct 2021 07:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52A7B60241
	for <linux-ide@archiver.kernel.org>; Wed, 13 Oct 2021 07:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238813AbhJMH6U (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 13 Oct 2021 03:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39341 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238597AbhJMH6T (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 13 Oct 2021 03:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634111776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iYCx6QA03aEfkBFxuhO6FE77UExJaIFiU4NvMPhxTrk=;
        b=X9MrH82PGjeDeeeNcyyYCiimLwJOpm6Va3lyD60crV04Df+Tjr2RotYVdp2tknBUsDDfqy
        ErluwbVUSgHl6H4qVGsPrFJ+HngYCS5pHL8nQVICurp2XhcF/9oabAgxrfRZV372M/9nBK
        8MSTk/V6wrcKOO9wxIQjwQl2OlCye0o=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-s4eCvxwlMv6hiv53sBZiRQ-1; Wed, 13 Oct 2021 03:56:15 -0400
X-MC-Unique: s4eCvxwlMv6hiv53sBZiRQ-1
Received: by mail-ed1-f71.google.com with SMTP id f4-20020a50e084000000b003db585bc274so1456587edl.17
        for <linux-ide@vger.kernel.org>; Wed, 13 Oct 2021 00:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iYCx6QA03aEfkBFxuhO6FE77UExJaIFiU4NvMPhxTrk=;
        b=eGewNsLl4+WcpoZ6HOnFpvkUIWk8GWtttGeeO81L/pCRQ21DXWLHMQRHDBraR25us1
         bPx7OwtDb92gLkWJey0Owls4dOmhr/AcH5yYNpTRGJqCdNCYg32ZeRSybMX/yX8x4uQc
         gd6nLsp6KYV+lA3rxwGZfv+sIb4PLOgvTFTHuQqo64DM70Vjx/js1thTdKKaGDSALXlN
         cAZo7f2MxK7LVz3tJlWDIzhDM6EoOzZGl1ybLOQ1YA5djnIbIqk0eP33eUrdbh2fCaz/
         c6v2QSqjfeQCKR6+cF+Yn+w+ZZrA8VXEXRgFfVJ7vJNGyvRQFkPAk5HhoSbXIbUAVZdA
         +0Gg==
X-Gm-Message-State: AOAM5336qQ/IgJTngO1tAoCohT9FTh3blaW2kOHWPpwRsGovaUppJ3zC
        neisTZf5RVcFmP5PB+qiHJsBiqZUmQB9vl0B0Eho9y31p+tlOak0JhPcaygwjb7GGblWDUwhEzh
        0XAoQ9SMSODTg+XAOZjCD
X-Received: by 2002:a17:906:4fc7:: with SMTP id i7mr8588478ejw.236.1634111774410;
        Wed, 13 Oct 2021 00:56:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0Xl6LIWOme9HIaIrTzGrLU+Kom/tJW5QrUAH3bcc0NiuoM/wm2WjlaCKxRAVx2KODUt1GWA==
X-Received: by 2002:a17:906:4fc7:: with SMTP id i7mr8588453ejw.236.1634111774084;
        Wed, 13 Oct 2021 00:56:14 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id m9sm7475858edl.66.2021.10.13.00.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 00:56:13 -0700 (PDT)
Subject: Re: [PATCH] ata: ahci_platform: fix null-ptr-deref in
 ahci_platform_enable_regulators()
To:     Wang Hai <wanghai38@huawei.com>, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211013061631.2958938-1-wanghai38@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e5beb06d-7f75-b123-a14b-7a2f447e8eb5@redhat.com>
Date:   Wed, 13 Oct 2021 09:56:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211013061631.2958938-1-wanghai38@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 10/13/21 8:16 AM, Wang Hai wrote:
> I got a null-ptr-deref report:
> 
> KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]
> ...
> RIP: 0010:regulator_enable+0x84/0x260
> ...
> Call Trace:
>  ahci_platform_enable_regulators+0xae/0x320
>  ahci_platform_enable_resources+0x1a/0x120
>  ahci_probe+0x4f/0x1b9
>  platform_probe+0x10b/0x280
> ...
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> If devm_regulator_get() in ahci_platform_get_resources() fails,
> hpriv->phy_regulator will point to NULL, when enabling or disabling it,
> null-ptr-deref will occur.
> 
> ahci_probe()
> 	ahci_platform_get_resources()
> 		devm_regulator_get(, "phy") // failed, let phy_regulator = NULL
> 	ahci_platform_enable_resources()
> 		ahci_platform_enable_regulators()
> 			regulator_enable(hpriv->phy_regulator) // null-ptr-deref
> 
> commit 962399bb7fbf ("ata: libahci_platform: Fix regulator_get_optional()
> misuse") replaces devm_regulator_get_optional() with devm_regulator_get(),
> but PHY regulator omits to delete "hpriv->phy_regulator = NULL;" like AHCI.
> Delete it like AHCI regulator to fix this bug.
> 
> Fixes: commit 962399bb7fbf ("ata: libahci_platform: Fix regulator_get_optional() misuse")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/ata/libahci_platform.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index b2f552088291..0910441321f7 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -440,10 +440,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  	hpriv->phy_regulator = devm_regulator_get(dev, "phy");
>  	if (IS_ERR(hpriv->phy_regulator)) {
>  		rc = PTR_ERR(hpriv->phy_regulator);
> -		if (rc == -EPROBE_DEFER)
> -			goto err_out;
> -		rc = 0;
> -		hpriv->phy_regulator = NULL;
> +		goto err_out;
>  	}
>  
>  	if (flags & AHCI_PLATFORM_GET_RESETS) {
> 

