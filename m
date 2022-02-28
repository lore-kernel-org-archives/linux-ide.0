Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A6BC433EF
	for <linux-ide@archiver.kernel.org>; Mon, 28 Feb 2022 10:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiB1KK2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 28 Feb 2022 05:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiB1KK1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 28 Feb 2022 05:10:27 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E561F38D95
        for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2022 02:09:48 -0800 (PST)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A0D8F3FCA7
        for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2022 10:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646042987;
        bh=kIx+raZUijStrCGB7mdJrowRwtVAuHPRA5AhR/2Nd0I=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Fpxwv+d1WVw5y3w8tLciDyDxJgARNZFSl0XdrEqXrIJx4NO3ZWZOJnjhXFW4BKu9D
         GMBauAFJqmUYJVmyXI+BdT2KJ34qumldvA8YgaXf9hjWN/0wWp4vwvlKQzEzeZTgD3
         USFKvV97pk6+IrHj7JmllpLKxRnuDJ8s8njuNJDIKXVmAaeWxhTV1E3IH0n7ChdYKq
         8hsWMW8n55FBvL1rABW85qgYX6a8/XQESz6EkSFTurvBQiC8aTo9Mer+ie/WUJsTru
         7zRdUJpx5TTYwhljEWWsPcaJl+OkYT6uvFP2tBQo7EWAQk2G/u/xcDNNhSZaNRfOaB
         9PtyB5KgScZag==
Received: by mail-wr1-f72.google.com with SMTP id c16-20020adfa310000000b001ed9cd8f4c7so1877073wrb.6
        for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2022 02:09:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kIx+raZUijStrCGB7mdJrowRwtVAuHPRA5AhR/2Nd0I=;
        b=VNxWvythkFppnov5lNRntQVTbkLyR+XUfADIHJAcriZj7yASz9lnUOc6SJvRCoWRZp
         25jGXT8THW0IGhjgUvIp5IZvzrsx1m1I8pOjLUqAj6qyvF4hSHIrMeN7jkveItUz/wGr
         ceX+WPzK7L6tjDjIcIIUe10GghE9kZugYkWHtZWM2cBOsz1P7IQmWAM0QyKfDXkjuuVO
         jVS07k41/KZgbHB3Z1eIZLnmVCMFBYMCtmvFJmvzb9BTIe+YV5ZIDW6WiSjerIoML7Dq
         lKVDlVsTRhi2f386gjMhtHs1s0D5F+cMjt+724GnL1dceHyFcG1MwZx+6bS/99iwGEUZ
         dpYQ==
X-Gm-Message-State: AOAM531yQLa4cIdZF4yYp1SEJIY/vhEazaZmPi3+Fo18YK3y1+oBOH/A
        PhC+xKuqfxR/38Id2TRO/bQMYfFcY1uiiJuUA4kaZYdDab+0XsuYMuk39rHih4QMrWmbL3Ke6uc
        DG2cD95QxZ1CydqF5orOWmuu6N+W53B2jIcMLdQ==
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id y1-20020adfd081000000b001ef9378b7ccmr6526406wrh.407.1646042987421;
        Mon, 28 Feb 2022 02:09:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwt5qm49T+l3aWQPrCdhZj4vQvOAlvEwnYbWhxw24cBValwEqncUUoWR+qNsHkBBdWdo63G6A==
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id y1-20020adfd081000000b001ef9378b7ccmr6526391wrh.407.1646042987208;
        Mon, 28 Feb 2022 02:09:47 -0800 (PST)
Received: from [192.168.0.133] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id x2-20020a7bc762000000b00380fd1ba4ebsm22228541wmk.9.2022.02.28.02.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 02:09:46 -0800 (PST)
Message-ID: <cbca5f7a-de4f-1559-92fc-45c6d037a6d1@canonical.com>
Date:   Mon, 28 Feb 2022 11:09:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/3] dt-bindings: Add power-domains property to
 ahci-platform
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        "devicetree @ vger . kernel . org Damien Le Moal" 
        <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>
References: <20220227182800.275572-1-linux@fw-web.de>
 <20220227182800.275572-3-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220227182800.275572-3-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 27/02/2022 19:27, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Some SoC using power-domains property so add it here

Full stop.

Subject: "dt-bindings: ata: ahci-platform: Add power-domains property"

> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> changes in v3:
>   - new patch
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> index cc246b312c59..cc3710fe4fd4 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> @@ -67,6 +67,9 @@ properties:
>        some embedded SoCs.
>      minItems: 1
>  
> +  power-domains:
> +    maxItems: 1
> +
>    resets:
>      minItems: 1
>  


Best regards,
Krzysztof
