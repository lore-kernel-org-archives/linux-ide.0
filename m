Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C21BC678D5
	for <linux-ide@archiver.kernel.org>; Tue,  7 Mar 2023 08:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCGINK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 7 Mar 2023 03:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCGINI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 7 Mar 2023 03:13:08 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137011D92D
        for <linux-ide@vger.kernel.org>; Tue,  7 Mar 2023 00:13:07 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cw28so48964808edb.5
        for <linux-ide@vger.kernel.org>; Tue, 07 Mar 2023 00:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678176785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ebi9MqJM2rLRf0HSN4orh6m6hlkXC3F34t4OkD8rs5Y=;
        b=T/8LQ56A+DCv2G/Yqt6nlZ7Ong4A4WqREAUMpClvksBr0tW6ClJVjDxxYzAmHjeWiw
         puIZz+WKU/rUOHPvNuEQBeld2exBzfEgQ/sJFQ6MbTemwQeXjuoklaO1kSKmLR2EZ4Lx
         wC8HU/R+kBQBYje7LI2oq6g4KifmQnVARlQ7S6mjZdUFlIfa2KUyJJphSMZaxJSTNFeB
         +nK5UoF1lItnTCv0sK63mCq8qiOSAw+fJRRIgE7h2RKv8wDyU9zHW90bTUhLGp00m7kp
         8Utac6QY6gxH8qOQEjoDlrg7Aa0Q1rWabkw1kHbdzT8Mf+UI6UKSDb18U0CysscMIq2X
         BiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678176785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ebi9MqJM2rLRf0HSN4orh6m6hlkXC3F34t4OkD8rs5Y=;
        b=e4cFdGC8t98mvDzJFu2yxNMgpBEGxRuU1D0vaoXS2iA9yNJrWZXDaZebenRZGmY1We
         fP+X/r71n6k58TbkwKMAZWrQ/5CkXrrodudgCy4VqvZmAeojzUVeRfQchQumeFY3xKHr
         xc2lKVj8qjZRqpCnwbB7AjtCtMAGbF2nOdR7481ig5jf2onDFtpgjRI1yhjU9UTJo3Qv
         MN5dq09Ub0R2XxrDY5OHIOL8e6M5Dk5ljkbanOybzpzzgEj1e5eNtu7PuYpF6tPEhhQ8
         bDSk01+fwqXxdq2mfPbxeCcl7StIx4OzukgR4rjwYZIhMiu3hqfzWhJoo5we9dQZu8s0
         Mdhw==
X-Gm-Message-State: AO0yUKUx8PPSjmUjG1xkUvcwhM8d1lyqLTL9a1c2qkJl5mtCjtUkBC8Z
        mDa7aDWimSquE9phtvZza9vOfxKCjpeXKY4jnMw=
X-Google-Smtp-Source: AK7set+/dBFG4ZgrEGv+wZafXcyEgE0rxM7bbP+OzMVJLXtuh4vHOX5WFn5lvpAatboWhU1FUB804w==
X-Received: by 2002:a17:907:8b16:b0:8b1:2e7c:df49 with SMTP id sz22-20020a1709078b1600b008b12e7cdf49mr15401797ejc.7.1678176785582;
        Tue, 07 Mar 2023 00:13:05 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:5310:35c7:6f9e:2cd3? ([2a02:810d:15c0:828:5310:35c7:6f9e:2cd3])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709063b5900b008d0dbf15b8bsm5693956ejf.212.2023.03.07.00.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 00:13:05 -0800 (PST)
Message-ID: <a6425bde-5b6d-2fb2-2396-a35677b19e8f@linaro.org>
Date:   Tue, 7 Mar 2023 09:13:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] dt-bindings: ata: Add UniPhier controller binding
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230222155906.19403-1-hayashi.kunihiko@socionext.com>
 <9d36818f-3ce3-0fb6-1a3e-85e3879af08c@opensource.wdc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9d36818f-3ce3-0fb6-1a3e-85e3879af08c@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 06/03/2023 02:22, Damien Le Moal wrote:
> On 2/23/23 00:59, Kunihiko Hayashi wrote:
>> Add UniPhier SATA controller compatible string to the platform binding.
>> This controller needs three reset controls for Pro4 SoC, or two reset
>> controls for PXs2 and PXs3 SoCs.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> Rob,
> 
> Are you OK with this patch ? I can take it for 6.4.
> 

You got Review (which includes also "Ack"), what are you missing here?

Best regards,
Krzysztof

