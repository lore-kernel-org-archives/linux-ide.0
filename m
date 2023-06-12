Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8ABC7EE43
	for <linux-ide@archiver.kernel.org>; Mon, 12 Jun 2023 08:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjFLIVA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 12 Jun 2023 04:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbjFLIUs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jun 2023 04:20:48 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B18115
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2023 01:20:46 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5147f4bbfdaso5671616a12.0
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2023 01:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686558045; x=1689150045;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YuaFtQBhTySWcwWuBPWolxBfBrmsW/EltaLg5KhduEM=;
        b=prYV4Vfp+twLytv23bFpM/12uJ6o15SuH+KBCBEGZup97xeepSjtAAvrTD944DaozP
         dCjjc9Ujk6QS+CQF86cl3MlHaFd5UN5kuHsSWjm4vXGlHVc98S6yQt5ZO28R8vq4WPys
         ihK3woQF+UTH2aZsmhsFj/2qo41/3UH27bQTAGAcJTy+wCNJh1SNneIfI5ouoCjXxz+p
         59gTP01LhXBhWowWJMccPaFA70F8edGy5v1/j5ztzutzZJh6+SRIOTNumpVbECOYmCeG
         v2oIk9ltHs6P5LtcA5oGycO1Qpc4+Cx2+bPqcDqSQRPvAMRG6wk+98bjnDeq7G4fJjKC
         SWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686558045; x=1689150045;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YuaFtQBhTySWcwWuBPWolxBfBrmsW/EltaLg5KhduEM=;
        b=SFTmA6YSA7qAfE20Vr+a10VIiGJ4futyM0vuyxykjYLGUDdLo2jcs3pAcEleK2kqPR
         w5bn0NS3NYK6V8AqrKnTc63OmAr7LYfzL9oUW/adpQsY3e7SL0oMekTJ5jOPqRFi5fbY
         pUyUI1HcsV33i4m85n3z6LiEUyV7i1X3u5M7tQtsypJLJ1Bb3oPz3vF+SPNpj+N8DSKE
         Ixsl4sqp3a/aHsCMtu8sazv9Or3jUXs5ZLdILbOTNe9M8MzcupnIUrymlS93XgUGqNhR
         7VXAAQspARBW6bKG90OvJEI5m3H8RM9gn1ifjixiv579RCWp4/cS6uQP+iipgOwBYTjC
         OYRg==
X-Gm-Message-State: AC+VfDx/I7hOA0rf16hv0R+2dk48Sw3IDzQsxnNPiGHHI6RKpOSdjz7o
        fzooMwQdNeeUds5o6EcZnMeTXg==
X-Google-Smtp-Source: ACHHUZ7CqvoolRP6p9vsNBwdjEzm/1deg6tIoE5CeBdTRO5Vjig2Mx8w6tz8HJgvL11K7BItxZRBYg==
X-Received: by 2002:a17:907:985:b0:94e:e5fe:b54f with SMTP id bf5-20020a170907098500b0094ee5feb54fmr8999595ejc.23.1686558045382;
        Mon, 12 Jun 2023 01:20:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ot25-20020a170906ccd900b00965f5d778e3sm4800684ejb.120.2023.06.12.01.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 01:20:44 -0700 (PDT)
Message-ID: <b5201498-f61b-c431-536d-6cfdce8c731f@linaro.org>
Date:   Mon, 12 Jun 2023 10:20:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 1/5] dt-bindings: ata: dwc-ahci: add PHY clocks
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
 <2e6caba1-3781-156f-4e55-e261f56a10cb@linaro.org>
In-Reply-To: <2e6caba1-3781-156f-4e55-e261f56a10cb@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/06/2023 10:18, Krzysztof Kozlowski wrote:
> On 08/06/2023 18:22, Sebastian Reichel wrote:
>> Add PHY transmit and receive clocks as described by the
>> DW SATA AHCI HW manual.
>>
>> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>> ---
>>  .../devicetree/bindings/ata/snps,dwc-ahci-common.yaml     | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
>> index c1457910520b..34c5bf65b02d 100644
>> --- a/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
>> +++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
>> @@ -31,11 +31,11 @@ properties:
>>        PM-alive clock, RxOOB detection clock, embedded PHYs reference (Rx/Tx)
>>        clock, etc.
>>      minItems: 1
>> -    maxItems: 4
>> +    maxItems: 6
>>  
>>    clock-names:
>>      minItems: 1
>> -    maxItems: 4
>> +    maxItems: 6
>>      items:
>>        oneOf:
>>          - description: Application APB/AHB/AXI BIU clock
>> @@ -48,6 +48,10 @@ properties:
>>            const: pmalive
>>          - description: RxOOB detection clock
>>            const: rxoob
>> +        - description: PHY Transmit Clock
>> +          const: asic
>> +        - description: PHY Receive Clock
>> +          const: rbc
> 
> Conor's comment was not resolved. Adding entries in the middle breaks
> existing users and commit msg does not explain this.

Wait, this is oneOf, not a list. Damn context.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

