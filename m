Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD46CC7EE29
	for <linux-ide@archiver.kernel.org>; Tue, 13 Jun 2023 06:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240034AbjFMG4K (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 13 Jun 2023 02:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbjFMG4K (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 13 Jun 2023 02:56:10 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB2F10D4
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2023 23:56:08 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51480d3e161so7662761a12.3
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2023 23:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686639367; x=1689231367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WmDb0FqExseWIwOM+eDbd4Y0lzi/vx10EOXmxwOWe4M=;
        b=o0kkKmW2vSbCVd0ghUZmQJ5Tp5ku/bqKN/w9kbxWX6OwWUAKdaBZWKGPtp62VFTaQM
         vE68/3HXtlb7Ipiaz7LoGRMD4JusW0hVgsM9EGct+SpGJcOMHvc+S7r4SzpKkRHeVNOk
         KEaw10ZFBcKCUQScWVdlzv7ApNKm1ZgyVjMogr1nZJqvjtW+20NWX7wkTuqL+sxhRX3/
         IrwZhuz6dKj9XLK1dNNZoKoIluZAqFhSwdbFqAzE1bsX+PSxTY/sFfjQyNM8sqMvsISv
         hAJUrcAdeMVgFS+ZYMTK0CmFP2UnHfTzh6Hl/6XrM0cdboobGbzjXQH/gjseyfpR3z7E
         4TLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686639367; x=1689231367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmDb0FqExseWIwOM+eDbd4Y0lzi/vx10EOXmxwOWe4M=;
        b=SNwrcArvrYKbz/pMwjd5RJdMPXRKq2l9PxwXl7qkr7tGhEd8yVtvPHjwXuvxsjo8En
         jwUdZEJdDytJkpUaTpdeS4y/LgfROls2gwiwrgclPUuDMel1z2ZBOiUfXXYcXVRv2FQT
         T8qOhBg5SjflrA0pBl+L8vIrMY5MrI5mo1e4kT5GXaz7XbQBzQsWAcxDui/eabzvOG5l
         7pVBjQkJ2w1q/ngYAFE8IgEgHLvogESPCeuAiv2UymOSxOJjvWnWclB2SrNRzfXJeie+
         lKSNiR4VPdPvSRj6DDN6tN9XI0fkGfvZxZyAenwH39NT5NEjtnzXMjqjPy3JlTAzfffK
         gfYQ==
X-Gm-Message-State: AC+VfDwPjLzKSOTZREwo1OCt0hl3mHKnTDn5zqNLCU0EyBScwBUBFxJH
        v8U5ebzxVN8f9MGg/vLP9+SsTQ==
X-Google-Smtp-Source: ACHHUZ7KDHVjq84hd7jnAxZuW1GtZX7g9vEo3lmLlL3Z28G3faXdjwa6gLk/uRj3hbQBYDNJ/LiuiA==
X-Received: by 2002:a05:6402:1012:b0:518:72f1:8211 with SMTP id c18-20020a056402101200b0051872f18211mr856371edu.28.1686639367370;
        Mon, 12 Jun 2023 23:56:07 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id u13-20020a50eacd000000b005149b6ec1bdsm5945038edp.29.2023.06.12.23.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 23:56:06 -0700 (PDT)
Message-ID: <b72569a2-c101-e686-ad7f-3eefd41951ef@linaro.org>
Date:   Tue, 13 Jun 2023 08:56:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 2/5] dt-bindings: ata: dwc-ahci: add Rockchip RK3588
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
References: <20230612171337.74576-1-sebastian.reichel@collabora.com>
 <20230612171337.74576-3-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230612171337.74576-3-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/06/2023 19:13, Sebastian Reichel wrote:
> This adds Rockchip RK3588 AHCI binding. In order to narrow down the
> allowed clocks without bloating the generic binding, the description
> of Rockchip's AHCI controllers has been moved to its own file.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

