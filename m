Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAFBC61DA4
	for <linux-ide@archiver.kernel.org>; Thu,  9 Feb 2023 08:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjBIIvT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Feb 2023 03:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjBIIvS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Feb 2023 03:51:18 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6FF47EF2
        for <linux-ide@vger.kernel.org>; Thu,  9 Feb 2023 00:51:17 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so923712wmb.5
        for <linux-ide@vger.kernel.org>; Thu, 09 Feb 2023 00:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eUi0+pogx97QXn9Rou5pDGb9vpsF0M/z1DxS9OrlVt8=;
        b=D0xWK2k4J17lzN1JTnVZZLkR/zBiywl6ZILZC+DlL6jrOlWFbSXF6oZb80PMMOR8fQ
         YtaYePUeL5CDLM3hFUn0aPZ3Lt8CmWSRXKTSNGcaaIbajfbHAXUmwLgsoPMcPsv9+kG5
         S5mZvVutg91cRWcVJqxqZfJlTtpCLiE9+7YPJ/zkDcI1icQQe3a+u+N41ugvaskBQ4hZ
         j4nheCT1W1EDNRZGAzMfkX3gBF3Cw8eC8izpcalohsgh8VPeaJ6c4bE8tFz9gHbuehwV
         PRnBj4QakLPvD6nRRPeSJ/o7Ef3cZXKPDeLJnZQRIXYCKJbyxyThBLY0Lrixq8i/d1Tv
         +NhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eUi0+pogx97QXn9Rou5pDGb9vpsF0M/z1DxS9OrlVt8=;
        b=mvNY1qR7XhJ2bEKSmOKNT5F7Ubr5BTKyUOVeqZmfKslVqoSXlbMrw3RPbTmEMrprIA
         geNKdJ9u1VCRrl6qo20ogpCH0ZY43fVKhldQPKgJ2bTybhxdEvIBd0fCTV+DJ0doxr0/
         6OyLEqwO0z8pYM8KG4aCiJrxm01ohipJWZP4I1FWFM/JbfJo95mimlXwI5932YRlo2sr
         fXyiNR5R94EJiy+tXIrY0d/d1oylGf76de86dPNQptexm3Ovp2f+3xlGoD+aXMlFfPfR
         bu8YQjJ4PSUhyry6prww5W6UP2LqZ9d5934TbV1bkrt35LNfTbEDgaIzuYvosM5fnL5k
         r2fw==
X-Gm-Message-State: AO0yUKXO9Fj+u6kBflSvMiKEMQ9SBLBIQzV9P+21AcD8Ehp6V3NU1yzC
        QWsdXWvLG/n9iQtEBxYZqFfbvw==
X-Google-Smtp-Source: AK7set8JFBpCe5jDMzxfhVcIA++GWsEDtFaCTKiFFNZALmRqoMovDG1mXJo0c8dvi4wiqVRsMb7qrA==
X-Received: by 2002:a05:600c:91e:b0:3db:331b:bd57 with SMTP id m30-20020a05600c091e00b003db331bbd57mr9153036wmp.23.1675932676186;
        Thu, 09 Feb 2023 00:51:16 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a3-20020a05600c224300b003db01178b62sm4287082wmm.40.2023.02.09.00.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 00:51:15 -0800 (PST)
Message-ID: <cbf10de1-ba6a-8e5a-6222-25f2322995c9@linaro.org>
Date:   Thu, 9 Feb 2023 09:51:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: ata: Add UniPhier controller binding
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230209014052.17654-1-hayashi.kunihiko@socionext.com>
Content-Language: en-US
In-Reply-To: <20230209014052.17654-1-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 09/02/2023 02:40, Kunihiko Hayashi wrote:
> Add UniPhier SATA controller compatible string to the platform binding.
> This controller needs two reset controls.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> index 7dc2a2e8f598..3f6b21032d02 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> @@ -45,6 +45,9 @@ properties:
>                - marvell,armada-8k-ahci
>                - marvell,berlin2-ahci
>                - marvell,berlin2q-ahci
> +              - socionext,uniphier-pro4-ahci
> +              - socionext,uniphier-pxs2-ahci
> +              - socionext,uniphier-pxs3-ahci
>            - const: generic-ahci
>        - enum:
>            - cavium,octeon-7130-ahci
> @@ -74,7 +77,8 @@ properties:
>      maxItems: 1
>  
>    resets:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2

You now allow two resets for each other platform, which is not justified
in commit msg. Constrain it per device/compatible.

Best regards,
Krzysztof

