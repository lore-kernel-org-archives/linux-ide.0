Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C137EE6455
	for <linux-ide@archiver.kernel.org>; Fri, 15 Sep 2023 11:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbjIOLDL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 15 Sep 2023 07:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjIOLDK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 15 Sep 2023 07:03:10 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935D42700
        for <linux-ide@vger.kernel.org>; Fri, 15 Sep 2023 04:00:44 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31ff2ce9d4cso469894f8f.0
        for <linux-ide@vger.kernel.org>; Fri, 15 Sep 2023 04:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694775643; x=1695380443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tn60yuwsayKteemX+yt8gQbT1B0GE4xqlU7FtFJOVyI=;
        b=pHjVyAdlE/UnfKmeakTcOQK5uisN2JPLdKyTTYA7+LEQUOKHl/VahJNxLVrjqbJ80G
         SlerwynD9v53IvMggO91FcvzsD4LoYQe/e9kOeBfGzjB8Jct7BBiZojv0xyKUuwhw8Ks
         JKTN7mFMYa3NcQoS3O7LsWp7/XLCeb8U+tq+ubtZZP+46PrYyE6doZlxRkJ6eokBHT4c
         pZpf/Glar2MdxndByT8aG0p5HV6dNvDBBosYom+7GlsScHOzW5+sI41STWCinKSo/lXd
         2HNUbDO334rf6B3+006cYh1rCbxGn4RIcCOM+ic4aXY6JDt7TpLqz7ALg+e7EMjsW5TM
         HkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694775643; x=1695380443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tn60yuwsayKteemX+yt8gQbT1B0GE4xqlU7FtFJOVyI=;
        b=BrDpptMNVChqBjhO76MGKM/y9CFlu2jD2KyrFnyScjLAUNWNimQ6NuS7wFcllO+6Oh
         UgHGkwZrKrDPMgFO7eoaxguI5cybf/FWrNoRRhbPQXJEX3ORQgvcqf3RcFGKEAwteb/N
         xLv/h0lExHqHymdQxuWwshDNKa7VSIMVip72TvT9/3hBjVgTevpg/oFnYt8lKs5NqTtY
         evWZIRPo1VA71ngGqGoottl5rypsbZDd8WLLCk37LsPS8AGah/vZKZAhN1eNUyOL+f/3
         +fJFBpuISgHqpFnvAu5GlLwE8iFi6blGkoSL48nDeN4Xo9w3OCS5DhQdVHd47KyKOtXC
         EXCw==
X-Gm-Message-State: AOJu0YyvxOb1JcOM0Mqrngdbx+BrZf+BfsMPbm5ck0C7bhPNJWcFvCYh
        Rxh8gwccCvJKGQNFYOFrVqTRdg==
X-Google-Smtp-Source: AGHT+IF2SgxJ6JGOtiwKnxlhWSHGpIPuG1WwYWykJZPi/uWFBQSqGjYzCnn6sFTt4SrDQ0mUPVvqCw==
X-Received: by 2002:a5d:4dc4:0:b0:31f:a256:4bbb with SMTP id f4-20020a5d4dc4000000b0031fa2564bbbmr1093708wru.71.1694775642865;
        Fri, 15 Sep 2023 04:00:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id i11-20020a0560001acb00b0031fa870d4b3sm3358133wry.60.2023.09.15.04.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 04:00:42 -0700 (PDT)
Message-ID: <82261cdd-3db9-c79f-9286-d49a81338b22@linaro.org>
Date:   Fri, 15 Sep 2023 13:00:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 27/42] dt-bindings: ata: Add Cirrus EP93xx
Content-Language: en-US
To:     nikita.shubin@maquefel.me, Damien Le Moal <dlemoal@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
 <20230915-ep93xx-v4-27-a1d779dcec10@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915-ep93xx-v4-27-a1d779dcec10@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 15/09/2023 10:11, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Add YAML bindings for ep93xx SoC PATA.
> 
> Acked-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

