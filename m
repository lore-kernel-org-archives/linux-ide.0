Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC3EC7EE2E
	for <linux-ide@archiver.kernel.org>; Mon, 12 Jun 2023 08:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjFLI0v (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 12 Jun 2023 04:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbjFLIZG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jun 2023 04:25:06 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8FA10EB
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2023 01:24:11 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-977d6aa3758so752591566b.0
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2023 01:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686558249; x=1689150249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n6FRK4HFfgPWBirVfYDPjb6CoRt7wCHoD3lKJRadNg8=;
        b=BcAOefkle/LHxvI52wscsD1HqlHwY9cHn03i0Pabfkmt86hqe0+VxKBNAR76O5qI4U
         oLqb8BKDueIqWm4GSNHhEGDfoNaQbexuP1m7eBPGb8a2Uxj21DbG+GEMJ1BVRGNrnshz
         eQZYMbseNSJgiAwZtB4UBKG/1G/8A+CBIuekb3tKyIP3UfzSSE4azrwQuqMhArBrH+Tw
         2Snlj34SSBqT1VBYFj9ybvAo3gdaOviM2VsT4VqqoNaMfR1nr8P58VEisOVy9Thf79wo
         TZc2mycYXjO1khtlD2A4o+g2VT2kYFhviWnFmxhUt7L/aHKCUVjl9DZpSoXTsSMzogDO
         ri2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686558249; x=1689150249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6FRK4HFfgPWBirVfYDPjb6CoRt7wCHoD3lKJRadNg8=;
        b=a+L9qN6fbNj/qynn1EbikqaoxtZNvhXTnoNn+NmIik620hqyTTEIsArYCDHDxsTVaH
         9PfZuQq6L7SRYu8gdZa3XmFQGPBWCbuT5NLhOpd30R2jGpZLDMV2dTOgTb3tsGBYAqWR
         cAQxBhp9lla4+ZDaCiyMbXmmUoXdxZURnBXL+QrW4xygEy/NhKJQBSKE0cYc4UL/2jeI
         werkvC0pRR1Xn8V7cv8/zqz+8AuQAco3XAtDNKrRdNZ6s88PQquJXGSGfJS6lubc4cLP
         rRC8Mc/UC4ViLwMbUsgRlkT88LCazjwoqWlL3itglpNA7umFxYmKbyhd4+I73ytPUuDS
         VQYA==
X-Gm-Message-State: AC+VfDw+PBGV0mn1uqJureSQKFUa3SfOIS/YzKfgZJTL1bz0cTR9CVma
        FY7zBpps42ZTVTGD1Dtvm7P+7g==
X-Google-Smtp-Source: ACHHUZ6Pww7aFvpQWCcMrF5FzzrD5cGi0zKemQAOXPVxhZItaOEvFniBweIG13CsZzvJN+qjGnAFjA==
X-Received: by 2002:a17:907:9710:b0:96a:ff7f:692 with SMTP id jg16-20020a170907971000b0096aff7f0692mr11003551ejc.68.1686558249516;
        Mon, 12 Jun 2023 01:24:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id pv12-20020a170907208c00b0096b4ec45e10sm4824008ejb.139.2023.06.12.01.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 01:24:08 -0700 (PDT)
Message-ID: <4c914503-c2e5-a5d8-97af-daaee0b4ec7c@linaro.org>
Date:   Mon, 12 Jun 2023 10:24:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 2/5] dt-bindings: ata: dwc-ahci: add Rockchip RK3588
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230608162238.50078-1-sebastian.reichel@collabora.com>
 <20230608162238.50078-3-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230608162238.50078-3-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 08/06/2023 18:22, Sebastian Reichel wrote:
> This adds Rockchip RK3588 AHCI binding. In order to narrow down the
> allowed clocks without bloating the generic binding, the description
> of Rockchip's AHCI controllers has been moved to its own file.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

...

> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - rockchip,rk3568-dwc-ahci
> +          - rockchip,rk3588-dwc-ahci
> +      - const: snps,dwc-ahci
> +
> +  ports-implemented:
> +    const: 1
> +
> +patternProperties:
> +  "^sata-port@[0-9a-e]$":
> +    $ref: /schemas/ata/snps,dwc-ahci-common.yaml#/$defs/dwc-ahci-port
> +
> +    unevaluatedProperties: false

You should be able to skip this patternProperties entirely, because it
comes from dwc-ahci-common -> ahci-common schema. Did you try the patch
without it?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - ports-implemented
> +


Best regards,
Krzysztof

