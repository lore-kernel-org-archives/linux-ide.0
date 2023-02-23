Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F92C61DA4
	for <linux-ide@archiver.kernel.org>; Thu, 23 Feb 2023 09:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbjBWJeg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 23 Feb 2023 04:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbjBWJec (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 23 Feb 2023 04:34:32 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F216D2823F
        for <linux-ide@vger.kernel.org>; Thu, 23 Feb 2023 01:34:04 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id l25so9723017wrb.3
        for <linux-ide@vger.kernel.org>; Thu, 23 Feb 2023 01:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yRGvRiQrnJ7Ah069Gjrz9HaQKOK7yK4lBz1abTvHCXo=;
        b=zwRRZ/jZTfvMd3ebQZs9T0mZg7lxzMzGfi3o4bR4gagPAOiWjTptyzl/bMnmxWbFdy
         eRlW3Wt3nLM6h1PGkaDg0PBXV0++MB4LeXA2xUENVaZBtrWmytHT/tT2WvjFGF90QjDd
         SylEnLiCNx9ULEjbOL+tt+Gd2bTtBtA4oUrABHe8HjnRtlIyqjSwo6/7ukjpUzWdSu95
         zixt/IZIHy1oiBpXdeeTYhrDJNy5ZqnnwveZEsK9ys/ez6sR4CPp0filblDIfxBFqHHE
         9BFLkLZ0VmtDUw6cgZWlBWL2BB5UZpVdkx95TNCTO1KzNtSPJbJkCoAsFOXRpJvgARXR
         1qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRGvRiQrnJ7Ah069Gjrz9HaQKOK7yK4lBz1abTvHCXo=;
        b=WzQh0zMbPX8Dpr9hrkdInGBudIyx9OGNXAfwLtnvW0Uv7gJ/tOFIqzElo5gbXqRqJi
         rLDE+zVH0uNBDsDuzQTItsdY2hy3Ea54mqfTw5ssull2u/OuB7U12JMqjaxrJ/GHsdRn
         8pcVf51OR13IAjAufO83ZSiNeboLzZtKKyBQUsf4o1vqfXw8f2TwYxB7wcyqY4YjowhP
         9YtVy9BIUgG/rHtO6QgMtVts9YKcIglDk8bYBWaIeWlUvnOGKa/VdIC7w4+zqtcWim2d
         iMYUxK4hq9bwoRorFmSRn7lLx/yfxpc8A/PLVRZGxZ4RRnmpwQoCYzSCh4f+0kvB/IiZ
         uN0w==
X-Gm-Message-State: AO0yUKX1Qwt0a2M9OhQcyrnoAQeVMpeNtbgmINwxDt+hXoPVWQfWm7dw
        HYG8pDyIsQseY5bwJSKCygktELb4WsMa1Q8N
X-Google-Smtp-Source: AK7set9xwLh8QxbJXwMkNa8KYIKNfj0jHIEo/JHmoagcg2LS2ioehtQqrPIq3vvkgO/RTWpLYfaASQ==
X-Received: by 2002:a5d:6150:0:b0:2c5:63df:1171 with SMTP id y16-20020a5d6150000000b002c563df1171mr10849484wrt.19.1677144842779;
        Thu, 23 Feb 2023 01:34:02 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d4312000000b002be0b1e556esm10400247wrq.59.2023.02.23.01.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 01:33:59 -0800 (PST)
Message-ID: <a7fdffc5-14e2-5cbd-6fe4-c6412a57e13f@linaro.org>
Date:   Thu, 23 Feb 2023 10:33:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] dt-bindings: ata: Add UniPhier controller binding
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230222155906.19403-1-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230222155906.19403-1-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 22/02/2023 16:59, Kunihiko Hayashi wrote:
> Add UniPhier SATA controller compatible string to the platform binding.
> This controller needs three reset controls for Pro4 SoC, or two reset
> controls for PXs2 and PXs3 SoCs.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/ata/ahci-platform.yaml           | 49 +++++++++++++++++--
>  1 file changed, 45 insertions(+), 4 deletions(-)
> 
> Changes since v3:


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

