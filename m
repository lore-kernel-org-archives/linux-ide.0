Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6E9C433FE
	for <linux-ide@archiver.kernel.org>; Wed,  2 Mar 2022 09:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240638AbiCBJrQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Mar 2022 04:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240640AbiCBJrN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Mar 2022 04:47:13 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5052CB8212
        for <linux-ide@vger.kernel.org>; Wed,  2 Mar 2022 01:46:28 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AD7553F609
        for <linux-ide@vger.kernel.org>; Wed,  2 Mar 2022 09:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646214387;
        bh=/i/Tl5JDYxHy1DfeqPaVUUr4WPXCyRWi21gK1tt8oLA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=h4VG4EUq7gTTjNBOvCWZtZFxSWcYdzE/vIXT9IS+ITbtwYdBMni04AFRP2jFVy2FN
         AuzG8qa/8/ud0pz/GVbCLLAUiAtFObw/HtFFF6WUYs6vXgoNN1xYJPyDa7UKWrsLvL
         LBpRkh7x8ErPOyIktIW/QGpV1AncdrDrII2nZm0XSkmBag7YrBblc4xO1V7Mbreg6N
         moQDiVi86nMZnhJIM+pLEQywWdxwFAzvs8w8XoVLzyB1nqmrDsqMeum+mL6kYORUCD
         8bVqst5Vv4Leq61WMBd4eHdEXu+cULuxSQ/2LeP8qEz3kZWIU7L5ArHEQR0eERHw/V
         JXp8N55meGM1Q==
Received: by mail-ed1-f70.google.com with SMTP id h17-20020a05640250d100b004133863d836so712253edb.0
        for <linux-ide@vger.kernel.org>; Wed, 02 Mar 2022 01:46:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/i/Tl5JDYxHy1DfeqPaVUUr4WPXCyRWi21gK1tt8oLA=;
        b=XIs0kDIyim75h9zMjeVxEC25fI2BF2rnx9VkxEswLOrVnobEEdmgP7v4i3PikPFvcb
         EsmyBPyfOabcoXzGiu6RVp+pfwcy23m0DT27OUpfZ8rV+D1/vF1Z9tqVGYeSTi40rWHv
         WZIZKPB27Je24N6CbuLs0yEnw/VmmON02EYJzzXTgLrjQyloIiHoOTSnSKcygTUkUHPw
         KYHsXRu+yyTPAsFHCudp11/mZ/wfzBDeblUVHksMHfN8rKHyO0P4JtUTxS69mDPm9C53
         uPnNtmEfDOnOAQ9JM3+872E5tJHv+XqbDg2wX1XAOq2BjjLGau1FXkmXn431ZoaWnriD
         ToPA==
X-Gm-Message-State: AOAM530ETqzPoFwt3/RY9UuEqHmA9ymTHgOtjlBvVh8umI7nelXLAhVJ
        YKZD2SM9olNIsJH48qy2eh1UqHe3z8lek5XyUTxrQkxsDv6cds6hpbqf4KyvvKRo/0VbfPZj2oL
        ZerkzZEfyKA2XtjVDOlhJOPmXvf+vYfh55uFAIA==
X-Received: by 2002:a17:907:3fa8:b0:6d3:477a:efe with SMTP id hr40-20020a1709073fa800b006d3477a0efemr23515494ejc.401.1646214387407;
        Wed, 02 Mar 2022 01:46:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyPOkiH4a9QCn+Wd7L5hlKw9lulPSI6MAqtbvWliZVQXaUWpoXaMt7gC/299TK5aFIrth7zTg==
X-Received: by 2002:a17:907:3fa8:b0:6d3:477a:efe with SMTP id hr40-20020a1709073fa800b006d3477a0efemr23515473ejc.401.1646214387252;
        Wed, 02 Mar 2022 01:46:27 -0800 (PST)
Received: from [192.168.0.136] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id ho12-20020a1709070e8c00b006ce3f158e87sm6159767ejc.2.2022.03.02.01.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 01:46:26 -0800 (PST)
Message-ID: <16c07205-cd2d-fb9a-771e-7874a568026c@canonical.com>
Date:   Wed, 2 Mar 2022 10:46:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 3/5] dt-bindings: Add power-domains property to
 ahci-platform
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20220301152421.57281-1-linux@fw-web.de>
 <20220301152421.57281-4-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220301152421.57281-4-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 01/03/2022 16:24, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Some SoC using power-domains property so add it here
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> changes in v4: none
> changes in v3:
>   - new patch
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
