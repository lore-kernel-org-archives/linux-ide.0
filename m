Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0281EC77B78
	for <linux-ide@archiver.kernel.org>; Tue,  2 May 2023 20:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjEBUPj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 2 May 2023 16:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjEBUPi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 2 May 2023 16:15:38 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258332D68
        for <linux-ide@vger.kernel.org>; Tue,  2 May 2023 13:15:11 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bc070c557so6499027a12.0
        for <linux-ide@vger.kernel.org>; Tue, 02 May 2023 13:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683058510; x=1685650510;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/KLvyC81W8m9NJpaowQEHEMWM8a470rAz1HMvMhlnSI=;
        b=uBWuYMNnph/lp62Lb4iuFrIV3TjQSvMkekAb5DkQg7UYerz2I4eiXC6ZuQFJZaGnz0
         4pDCAw6YJe8VSOcOXxQ7Vrk9EsveN5xEX9m1yokB2kxb8SsbRkzv48zrWW8gZFElNI2V
         iMKszlwEq//6EkBRDpQRNnJOS8/dMPzr3OxqC/1ztVF9t3X4G+qGzQKongKdr07KJK+J
         SYcHPvL23yh6QlerdsjauAA5o5+qavfMOcSk+9Kccfn0NNZPJxJZlxMgVPgDOAJxV5TW
         sVTFwNdWdHG5k4rwOUYdIFzTxEIvt+Tc5I0stO8GJBJ+CTKSH2QOirkawMDuzYswhR2d
         HGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683058510; x=1685650510;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/KLvyC81W8m9NJpaowQEHEMWM8a470rAz1HMvMhlnSI=;
        b=TvjzT1VfZAWDWVjwuVmWtIHwI1gEggZZan0gfYvAatqB+P0wkDLdefJhPbrJjuMkvb
         voHQHeumCvFInJNI3GuZfZAIYzSYZHQZprvGUAnw48sRmCtxUz1+co9dQxwD/a5zn94/
         Sh7w6JafDb64ggyTaS0zSM3SLYnFmAzaKRYbYGQuchRTM9bGCUSkEI4J2hO5xOiv2zjN
         Wrs4tBsmyrgvFUPHMhHwdRsFWYcr8YQvxgTa37StJJpWPJk9n+MjWarxYLd0chH/sTmA
         QqJOKGiPakpMYSqTcgZ9q9wtiA7II3FlgguJRZbdytjTSaN1wvW/emQNx2oVoLvhqQvX
         aoxA==
X-Gm-Message-State: AC+VfDzu6Fy3ujg3tIA1FL5AucectaErXf17X1MhxFB8e46HZygqUe3B
        q6r/Kl7zvkogA9Rx6bvr/np0+w==
X-Google-Smtp-Source: ACHHUZ75XYjMT2liIEfOfGXw9D16p0bgc/kYeublTs7bzpZ2DIZSyNFYoC/zTIAyuVbAzneeJbWWOQ==
X-Received: by 2002:a17:907:98e:b0:93d:ae74:fa9e with SMTP id bf14-20020a170907098e00b0093dae74fa9emr1257619ejc.7.1683058509818;
        Tue, 02 May 2023 13:15:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:37be:eda5:e303:19e0? ([2a02:810d:15c0:828:37be:eda5:e303:19e0])
        by smtp.gmail.com with ESMTPSA id gj19-20020a170906e11300b0095ec8dfc439sm9643360ejb.166.2023.05.02.13.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 13:15:09 -0700 (PDT)
Message-ID: <7579c353-13a6-adb6-fbd8-8deaeeaaef34@linaro.org>
Date:   Tue, 2 May 2023 22:15:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] dt-bindings: ata: ahci-ceva: Cover all 4 iommus entries
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <76a2bbd9fb944dbefdb8d429d0a85937d56a3d6f.1683035327.git.michal.simek@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <76a2bbd9fb944dbefdb8d429d0a85937d56a3d6f.1683035327.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 02/05/2023 15:48, Michal Simek wrote:
> Current only one entry is enabled but IP itself is using 4 different IDs
> which are already listed in zynqmp.dtsi.
> 
> sata: ahci@fd0c0000 {
> 	compatible = "ceva,ahci-1v84";
> 	...
> 	iommus = <&smmu 0x4c0>, <&smmu 0x4c1>,
> 		 <&smmu 0x4c2>, <&smmu 0x4c3>;
> };
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

