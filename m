Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B4AC433FE
	for <linux-ide@archiver.kernel.org>; Wed,  2 Mar 2022 09:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240616AbiCBJsr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Mar 2022 04:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240670AbiCBJsp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Mar 2022 04:48:45 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0B744746
        for <linux-ide@vger.kernel.org>; Wed,  2 Mar 2022 01:48:02 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 633E83F223
        for <linux-ide@vger.kernel.org>; Wed,  2 Mar 2022 09:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646214480;
        bh=YDwov9hZPxOfFvFJ4bntrUYDDCSZQA6/kiFH4/f2u8U=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=pAp4jYAVXSV9cYnxGGscuBFHI6KzBvB2b3MPeOtbSkJbpRy+VBdrYbOqaBgnZYThQ
         Jr0fyBdKL+Rp4xQYng+CUIuE/K9y3fB6eNdd/qn6fmWFlWukr9B2LbwOmNLIz2Yt/1
         aucanrNoYRpN0IBjeLtTjfLeAQCpb61/Lg7VxfKuhjVMg4ikdEvHxLiRp0H0SGgmU1
         X9pxzhve/+LiV2/suiu9QiFlMTzRwxbTRDYYmdVaTc2GDa/vGTQW9Soo7pLFjXIHdH
         TF/qvUPbzJe2K/2xaWE1CnZfKHAoPy/HdB53vS9GU6YsW0zSuM7AR0nvwKPOpvfeGJ
         UtN2o9/UX7tcw==
Received: by mail-ej1-f72.google.com with SMTP id hq34-20020a1709073f2200b006d677c94909so713245ejc.8
        for <linux-ide@vger.kernel.org>; Wed, 02 Mar 2022 01:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YDwov9hZPxOfFvFJ4bntrUYDDCSZQA6/kiFH4/f2u8U=;
        b=2tNAh0AolrLzSHYi6fC6AuZlrN2+GJIuVw+Ed4cQyw0/HVzQgmWNPS+N+jAC04PW+i
         jedxtBvyJgrWlz4TLXZ7KlDyQWkvU567FAfQNHU9HkI+RRWAeaitXemGHQ6JDdyXIDPk
         QPJm6rabqKHMs/PF6SkUBLZGo0vUNbPJ3RudRR96VdPNhj8iarpGtUciGvTeRVM4OuP4
         l60M+wPpcpdndO+NUpw5kz5tGx3QxKAoLjZuov76l7ZAHAT9ByEK91ptXeTVNp7WFlym
         YPGKfXOi6PZPDxbhVDWbn0/VJtjizV8hySw74u3QnJR9rPES8xgovAdwQzj6mEQI5jZO
         BfKg==
X-Gm-Message-State: AOAM532w2rp726fvDZ62jqegxHn+3qbFOJJNMQZ7bCY45WzYwsQwcn9G
        R7CQ/J1KX89eczV7fUQ2zZTMS+pFQUi+VvFSkVVHV258tB8Jeih/wyZ0gF5+MKmQ6xDo51l2Cg+
        E3rk7VxOPqOnWmP3OdA0um3HycDLFr/EjsZQZkA==
X-Received: by 2002:a17:906:b2c6:b0:6cf:e599:6b81 with SMTP id cf6-20020a170906b2c600b006cfe5996b81mr21825559ejb.578.1646214480095;
        Wed, 02 Mar 2022 01:48:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwO8JN6K/qUNTGO/ulb3ap2nw6FIqgubS/vcKSkfPUzgYCmSRSQ7dXnf8ZAZnCeWE8ssUrhNA==
X-Received: by 2002:a17:906:b2c6:b0:6cf:e599:6b81 with SMTP id cf6-20020a170906b2c600b006cfe5996b81mr21825547ejb.578.1646214479935;
        Wed, 02 Mar 2022 01:47:59 -0800 (PST)
Received: from [192.168.0.136] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id si13-20020a170906cecd00b006cded0c5ee2sm6241313ejb.61.2022.03.02.01.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 01:47:59 -0800 (PST)
Message-ID: <cb654f98-3b4f-0b1c-77e6-22fe03bbed85@canonical.com>
Date:   Wed, 2 Mar 2022 10:47:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 4/5] dt-bindings: Add rk3568-dwc3-ahci compatible
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20220301152421.57281-1-linux@fw-web.de>
 <20220301152421.57281-5-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220301152421.57281-5-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 01/03/2022 16:24, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add SoC specific compatible for rk3568 ahci controller
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v4: new Patch
>  Documentation/devicetree/bindings/ata/ahci-platform.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Here and in previous bindings patches - you have wrong subject. I
already said it with v3. I gave you exact subject prefix to use.


Best regards,
Krzysztof
