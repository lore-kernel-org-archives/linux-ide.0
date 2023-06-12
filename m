Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1170CC7EE2E
	for <linux-ide@archiver.kernel.org>; Mon, 12 Jun 2023 08:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjFLITF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 12 Jun 2023 04:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjFLISu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jun 2023 04:18:50 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49F630CA
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2023 01:18:16 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51458e3af68so7003553a12.2
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2023 01:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686557895; x=1689149895;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bRmQUrzTWRgLw4kBQU5+LQ3tcVlba7PtHtkomNLzIII=;
        b=vexVIZ0dp8B8C1j+Lo+Kidr/5DKSmQtsmBdj1pB3rMiyA8LG85cEbYhHb7camdfB1U
         6KGQWKvrlf4K5+GjgDi/KVqhaUHphTdkJLC0/c2v0l4CHGTCU/Pl3xPYdFVfOuMUfG9L
         EqXwZySBXtkw15EvmTds6DDbx2TkchmJ02hhmbUaEDsjmdwaDxTFLD4Z9W1UoJBnJ9Y0
         W5vm6i+T+iwhRdNWwUioXKBypP2lS98E8eRLUgciktT6YCX0QXHfrGATZNXZb8lHZEV7
         y2YuX2Qek1ZrFguNQpg4KT8DQGzTJDns7LwpFARWGgHqNQI7MZFYSjF6rcMCBZuxMOHm
         S/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686557895; x=1689149895;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bRmQUrzTWRgLw4kBQU5+LQ3tcVlba7PtHtkomNLzIII=;
        b=kq3wCmr8RPMyGW/Gg3pMAb9Afxdz01/XHQpk+tmI4Cx8sz6ZdOJI/45UovfZtqADET
         638sW8V25G6JXrs5v+wdYzKuoS4DCvXslDUNK447q4heAjvSdKpdktvI6gR+jP7CYRN3
         bV6CJp6SRO7pzfspQkr7mgmrUZvMwdO5AZU+5rtxFuSbAHTha53Kdu8xzqu/pphJv6W+
         zYlLoqKc1Uk3XomYHTg8gv8EnL6JfBwffBzSsz84UdT2HfMdDbmppTipPTKGJ0PnuzHS
         CDBepvPE4qftThnn8glnLJ/CSi2wSiWJwo9e/GOS4biRhNPh8RwIqvkXfyFGpbQj2YYS
         asWw==
X-Gm-Message-State: AC+VfDz8a8wZJF7dk6AEG6stP2Sdr/Gdt7GnfkIKWm0eq/FTkUGx1LmF
        rA8ub3zVGVq6mz90KlPxO/px1w==
X-Google-Smtp-Source: ACHHUZ71VvzowsyBKiDCq7DWYBS4cDksMCv4kT0NQarqHtz70SmAMxEqCnkYbWF+lAwBlVADz6Je8w==
X-Received: by 2002:a17:907:6288:b0:973:903c:35a4 with SMTP id nd8-20020a170907628800b00973903c35a4mr10130123ejc.65.1686557895276;
        Mon, 12 Jun 2023 01:18:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ks27-20020a170906f85b00b00977eec5bb2csm4821357ejb.156.2023.06.12.01.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 01:18:14 -0700 (PDT)
Message-ID: <2e6caba1-3781-156f-4e55-e261f56a10cb@linaro.org>
Date:   Mon, 12 Jun 2023 10:18:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 1/5] dt-bindings: ata: dwc-ahci: add PHY clocks
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
 <20230608162238.50078-2-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230608162238.50078-2-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 08/06/2023 18:22, Sebastian Reichel wrote:
> Add PHY transmit and receive clocks as described by the
> DW SATA AHCI HW manual.
> 
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../devicetree/bindings/ata/snps,dwc-ahci-common.yaml     | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
> index c1457910520b..34c5bf65b02d 100644
> --- a/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
> +++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
> @@ -31,11 +31,11 @@ properties:
>        PM-alive clock, RxOOB detection clock, embedded PHYs reference (Rx/Tx)
>        clock, etc.
>      minItems: 1
> -    maxItems: 4
> +    maxItems: 6
>  
>    clock-names:
>      minItems: 1
> -    maxItems: 4
> +    maxItems: 6
>      items:
>        oneOf:
>          - description: Application APB/AHB/AXI BIU clock
> @@ -48,6 +48,10 @@ properties:
>            const: pmalive
>          - description: RxOOB detection clock
>            const: rxoob
> +        - description: PHY Transmit Clock
> +          const: asic
> +        - description: PHY Receive Clock
> +          const: rbc

Conor's comment was not resolved. Adding entries in the middle breaks
existing users and commit msg does not explain this.

Best regards,
Krzysztof

