Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF22C7EE25
	for <linux-ide@archiver.kernel.org>; Mon, 12 Jun 2023 08:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjFLIkf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 12 Jun 2023 04:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbjFLIkE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jun 2023 04:40:04 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5F29F
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2023 01:40:01 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-97467e06511so670006466b.2
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2023 01:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686559200; x=1689151200;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=02uq97znLW4jmjI8z3bfmKNKoaY1pURh+uCJ5ILlpl4=;
        b=r3TsQrkeAGuvV2odOjldtDHX2T+L/m8a6yRAR6lIrc1jRs/1Pi7KK6zsjHLQaR8cFi
         SxaiTckU4XCvA2DPqjaaReqb+/Ae0hBbsLNK5bvqVBAI2no9Okt7LkqEigfQIl88nkDa
         w7wumWQefYsGZSbmJ1MQso5m0yw6SrQjAHkcXfTMBztqlxs+oQbcCNSNhRQ49gBbDecK
         3ULlREI4GhYIh6OYo/CtkDRCa61kLyeP5IohYjEoxQaXLHbRuB93Jam2vFM/NLuA9yk9
         eOoNeqarG51IqFkVglJ+aCHvRNBS7EBfpFXnulWi3Erhu2A6GnEgPgDwE7YVB48i9yIX
         SLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686559200; x=1689151200;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02uq97znLW4jmjI8z3bfmKNKoaY1pURh+uCJ5ILlpl4=;
        b=QCn7a/O+B9r5or/QqpFeEq/RqBLRAkSOMeXVzQfL4NrqaJgffBCT6ku6N9egFcJWz1
         0/deKUe6nSOdm8IFc8vG9CLLwXPFMTVn9BeDRCiheKD9RCDRIMxsXb9ltXJqPLiPnCAB
         2ERIUa2iGo8qUg26sClIzGXDeZOdi76MiF1Jl77kDT5+HgjMo7ZTrLKx1ojtWNtjGN5+
         09XhatpHf7+pLagnEjJ3gRs4x/prb9s65TRpdO0DtyDs8DGNwZ6wrpkvj/a8WuztgsKq
         eoSrVsZWE7G8EO8Tl64MwXN/Vf+JEtICVTvoHMtdwL5o1VdjdBlbLqcl9SRzIl4AZ2BC
         DAng==
X-Gm-Message-State: AC+VfDzkiG+qKrWMM21TWqaCR5xNsgO84qqhIfI0MwK4vEVWn/MxKYNL
        X4mD8vJDx4LjlIYKVH83O4AmKQ==
X-Google-Smtp-Source: ACHHUZ4xrQwuUVb3h5HfV5TapbFL6CRyh+HdmkFi6c1IQyUy5wmGPCLKe5LhyIoZ9pNqf/4ghHn8Qg==
X-Received: by 2002:a17:907:9617:b0:974:1ef7:1e88 with SMTP id gb23-20020a170907961700b009741ef71e88mr9928825ejc.13.1686559200150;
        Mon, 12 Jun 2023 01:40:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id m3-20020a170906258300b00977d194bf42sm4851790ejb.161.2023.06.12.01.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 01:39:59 -0700 (PDT)
Message-ID: <838ed0e6-985d-9a45-7ece-c607bda15871@linaro.org>
Date:   Mon, 12 Jun 2023 10:39:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 2/5] dt-bindings: ata: dwc-ahci: add Rockchip RK3588
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230608162238.50078-1-sebastian.reichel@collabora.com>
 <20230608162238.50078-3-sebastian.reichel@collabora.com>
 <4c914503-c2e5-a5d8-97af-daaee0b4ec7c@linaro.org>
 <20230612083536.q3sq7w6cyiuxaqtv@mobilestation>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230612083536.q3sq7w6cyiuxaqtv@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/06/2023 10:35, Serge Semin wrote:
> On Mon, Jun 12, 2023 at 10:24:06AM +0200, Krzysztof Kozlowski wrote:
>> On 08/06/2023 18:22, Sebastian Reichel wrote:
>>> This adds Rockchip RK3588 AHCI binding. In order to narrow down the
>>> allowed clocks without bloating the generic binding, the description
>>> of Rockchip's AHCI controllers has been moved to its own file.
>>>
>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>>> ---
>>
>> ...
>>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - rockchip,rk3568-dwc-ahci
>>> +          - rockchip,rk3588-dwc-ahci
>>> +      - const: snps,dwc-ahci
>>> +
>>> +  ports-implemented:
>>> +    const: 1
>>> +
>>> +patternProperties:
>>> +  "^sata-port@[0-9a-e]$":
>>> +    $ref: /schemas/ata/snps,dwc-ahci-common.yaml#/$defs/dwc-ahci-port
>>> +
>>> +    unevaluatedProperties: false
>>
> 
>> You should be able to skip this patternProperties entirely, because it
>> comes from dwc-ahci-common -> ahci-common schema. Did you try the patch
>> without it?
> 
> Please see my message about this. The "sata-port@[0-9a-e]$" sub-node
> bindings could be updated with the "reg" property constraint which,
> based on the "ports-implemented" property value, most likely is
> supposed to be always set to const: 1.

Then anyway the pattern is wrong as it should be @1 always.

Best regards,
Krzysztof

