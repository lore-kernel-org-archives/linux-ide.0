Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEEFC433FE
	for <linux-ide@archiver.kernel.org>; Sun,  6 Mar 2022 10:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiCFK2H (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Mar 2022 05:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbiCFK2H (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Mar 2022 05:28:07 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD55240A7
        for <linux-ide@vger.kernel.org>; Sun,  6 Mar 2022 02:27:14 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 94B743F61B
        for <linux-ide@vger.kernel.org>; Sun,  6 Mar 2022 10:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646562433;
        bh=6KkTN0LeArjXAcefIpdLmm7qeM+MQdTOUpPRHb6gxxw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=YxeGsVkaRHIk6qcVjMnRU+7g5+LBiDRkBKMIxI1h16qdNvDOziJSSqeLAxYF7p+5/
         h/58CeJKxqAc1Rg+UVjVKDcXakrcVrS1me8gFkI8vs2j8MPEPaHpPmIqXmtQybExDi
         KOFGFkaj/m7X0BOT0LU7qVegmjWa7ycQ8qutsLTAlLGqSXGk/IxuYG3jNXqx95ikH8
         pZRtQDLiZsa3btvlsIHz4oap6CvvGhUiSnyIuDUQhwN9f9xHH9Qrw6DrKJHqKo+4ql
         vtRYu4HWLqmfY1bKdeEWnzICiqMGkFDgG0i4PGngdLRCwDecIEh4fDHl2xssQMgff2
         eAhUmQfYm06Aw==
Received: by mail-ed1-f72.google.com with SMTP id da28-20020a056402177c00b00415ce4b20baso5804552edb.17
        for <linux-ide@vger.kernel.org>; Sun, 06 Mar 2022 02:27:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6KkTN0LeArjXAcefIpdLmm7qeM+MQdTOUpPRHb6gxxw=;
        b=U3nHj9DrP7pOayMUAoL9QEVe+ZfcaxkB6T3c7NqLNiYjjbknMrdDir9xAH9zsqFVj9
         HTWT2LBGrjapsDbTCE+oIRp0hkTWrFzCcgEIMCUqMlEfq3mpozjOZec7N/q8+zw7N8f9
         +YKFxnFLCm5nFtQY8C3KFlyQADQRWmXmNmgWTDX/MyUA/lSxKQ7utcdPo5WnkXUWQO5G
         22ne9Uhz25hC5d8FD4UcMjYVm5Co0kHx6x9voCmufKJUV8l7e6clGreuiCccN9SyVNLT
         mwEeX54CViUT5KCoEJ44ygX+RKeZixtcWrGk7pbOEMB9xiZACH+WPWa/t5zrVwg7vC6G
         0wGQ==
X-Gm-Message-State: AOAM531y8wpR1t3UOoBSO4Lfaz64T0QNpXX+w5FJfvVrARvSrjgzSHWp
        IlmTa7XkwScQJIWhWYRsvQ2LEWSHihoTZkbI89R+hwvoTcFOyBPpvAZz5aB+E1O06TGuArnj9g/
        34n1tD6CI9gJaXXOX6TIhTJtTRHMlS7qPfXK8bg==
X-Received: by 2002:aa7:c6d7:0:b0:415:a0fc:1dcd with SMTP id b23-20020aa7c6d7000000b00415a0fc1dcdmr6450190eds.266.1646562432668;
        Sun, 06 Mar 2022 02:27:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyrMAcoAWXRgn7hEJ+8qeDd+XTUIfibTrmckOKcKkYM9sj7Odn7MupwEm9OyZsbxgGfqv/5+w==
X-Received: by 2002:aa7:c6d7:0:b0:415:a0fc:1dcd with SMTP id b23-20020aa7c6d7000000b00415a0fc1dcdmr6450173eds.266.1646562432464;
        Sun, 06 Mar 2022 02:27:12 -0800 (PST)
Received: from [192.168.0.140] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id v10-20020a170906380a00b006a68610908asm3692555ejc.24.2022.03.06.02.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 02:27:11 -0800 (PST)
Message-ID: <b8553651-3cd0-845c-efbf-d2341d5506b3@canonical.com>
Date:   Sun, 6 Mar 2022 11:27:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Aw: Re: [PATCH v5 1/5] dt-bindings: ata: ahci-platform: Convert
 DT bindings to yaml
Content-Language: en-US
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20220305112607.257734-1-linux@fw-web.de>
 <20220305112607.257734-2-linux@fw-web.de>
 <a2839b00-d195-131f-b2a7-d2f030a5bd95@canonical.com>
 <trinity-9ef9e0d3-e70c-45d9-bdd8-e43d1c89a8c9-1646560070497@3c-app-gmx-bs46>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <trinity-9ef9e0d3-e70c-45d9-bdd8-e43d1c89a8c9-1646560070497@3c-app-gmx-bs46>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 06/03/2022 10:47, Frank Wunderlich wrote:
> Hi Krzysztof,
> 
> have seen some warnings in Robs bot for arm.
> 
> imho have fixed them (and the indention you've mentioned already squashed) in my tree [1].
> 
>     add compatibles used together with generic-ahci
>       - marvell,berlin2-ahci

This is fine, just mention it in commit msg.

>       - qcom,apq8064-ahci
>       - qcom,ipq806x-ahci

These you need to consult with qcom-sata.txt. This could be a following
commit which will integrate qcom-sata.txt and remove it. Either you have
binding document for all devices or you create a common part, like for UFS:
https://lore.kernel.org/linux-devicetree/20220222145854.358646-1-krzysztof.kozlowski@canonical.com/
https://github.com/krzk/linux/commits/n/dt-bindings-ufs-v2

The choice depends more or less on complexity of bindings, IOW, how big
and complicated bindings would be if you combine everything to one YAML.

In the case of UFS, the devices differ - by clocks, resets, phys and
sometimes supplies. Therefore it easier to have one common shared part
and several device bindings.

AHCI looks more consistent - except that Qualcomm - so maybe better to
have one document.

>     increase reg-count to 2 (used in omap5-l4.dtsi)
>     increase clock-count to 5 (used in qcom-apq8064.dtsi)

This would need allOf+if.

> 
> can i still add you reviewed-by to v6?

Keeping reviewed-by would be fine when adding compatibles and bumping
maxItems, but in your case you need to rework these bindings. Either by
growing document with several "if:" or by splitting them, so it will be
significant change. Skip my review then.

> 
> [1] https://github.com/frank-w/BPI-R2-4.14/commits/5.17-next-20220225
> 
> regards Frank
> 
> 
>> Gesendet: Samstag, 05. März 2022 um 18:43 Uhr
>> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>
>>
>> Thanks for the changes, all look good except now I noticed that
>> indentation of example is unusual. It's not consistent. Starts with four
>> space (correct) but then goes to 7 spaces. Please adjust entire example
>> to use 4 spaces indentation.
>>
>> With that:
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> 


Best regards,
Krzysztof
