Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02824C433F5
	for <linux-ide@archiver.kernel.org>; Wed,  2 Mar 2022 11:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbiCBLAu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Mar 2022 06:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbiCBLAs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Mar 2022 06:00:48 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7DA6E540
        for <linux-ide@vger.kernel.org>; Wed,  2 Mar 2022 03:00:04 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4CACA3F5FA
        for <linux-ide@vger.kernel.org>; Wed,  2 Mar 2022 11:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646218802;
        bh=fYiIm7cAYvvcwgs5d23+mNowBlqk+U3OOhYGtWE4nhQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=uqky5bIBiFBBnmiWr/UTe6WPHVXtiKa09uL6Vjc35Gxx8ermCM9u8546ItQBmHPyd
         BHn+n1uFB2SBSgv8RTmjOKu6sPfspgnCX14E1sCkVqrGS2HK/OgPOOqTBioYBAMNGw
         Gx+iNxjZfIdb0rqPEJCaSyTR4B59E0A4vPQdzkvVljxnQ1JyMNuwRa1232lNztUP2r
         rYB6Bg7XhvtVNngjHPaR9hSN+G38/w9GmNqGB25AMv4GbA0VVkcAPzLM3u52DlGp1h
         l82GzGUiEmnygpcplJGA8diF2FUV4e5PWEvPThAi+rFSlmLG/G7N+cC15auS8CElrq
         zrh3536Yuyx5g==
Received: by mail-ed1-f72.google.com with SMTP id m12-20020a056402510c00b00413298c3c42so767041edd.15
        for <linux-ide@vger.kernel.org>; Wed, 02 Mar 2022 03:00:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fYiIm7cAYvvcwgs5d23+mNowBlqk+U3OOhYGtWE4nhQ=;
        b=bSxHWxBJhq5nwpDzRv30gqvv3lptfZY8qyNqJvDGujUrmazacICHmKvup9rL1YB9sP
         jxslngo+nwkNMtDtQKIMfGGrMfUmutUBmv9xkfK5pn0la8p5Qilvjm9fdIknkAS3BGVz
         NAnjFSlxqOnUp1cx1SEkHBMYoNCsdMkLmJHqI/CHV+WfAzrrtBsuHrraMf19gr3PXMbQ
         ohngKzYqU1mpjA5R3hyUMC5Fc8/2clq1RcwiNIwRC3vcXtrSFEeaPmVBEiGAQJzYRBDz
         YE3gBBF0E19E8V+sqH1WKQbKDhk2UOXUnvwZsceq1CAqWCPbL/6Aw8f9KXdRn01t8crP
         44Mg==
X-Gm-Message-State: AOAM532Dcqp+0TVGWh+awrq8xgJVAIVzXRAOj83VItcK4Ws1CbmVnlpe
        sfP91XRPSpjyW3lMAzL8re2gqeZ3LgYKbbQpSyJNtcykDaz3XYdF4n4MA2XQPotjjvQiy58nf9B
        vzcPapywO8tO20Jq3C6Il9c85RNpOsw2KTgoIsg==
X-Received: by 2002:a17:906:af79:b0:6cf:6b3f:5b3b with SMTP id os25-20020a170906af7900b006cf6b3f5b3bmr22477709ejb.14.1646218800156;
        Wed, 02 Mar 2022 03:00:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwERV6fTesKj9iO1fvVCbS8f7t6+HOQi7nNSbBRmJKjBddmSjWjb4ufnflgk2FauT1UX0gr+w==
X-Received: by 2002:a17:906:af79:b0:6cf:6b3f:5b3b with SMTP id os25-20020a170906af7900b006cf6b3f5b3bmr22477682ejb.14.1646218799941;
        Wed, 02 Mar 2022 02:59:59 -0800 (PST)
Received: from [192.168.0.136] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id ey10-20020a1709070b8a00b006d1cb2eb221sm6274372ejc.170.2022.03.02.02.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 02:59:59 -0800 (PST)
Message-ID: <468d1c64-b954-dcdf-6660-74f51e29807c@canonical.com>
Date:   Wed, 2 Mar 2022 11:59:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Aw: Re: [PATCH v4 1/5] dt-bindings: Convert ahci-platform DT
 bindings to yaml
Content-Language: en-US
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org,
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
 <20220301152421.57281-2-linux@fw-web.de>
 <6dae47c3-6083-782e-ecab-7be3f0bca0e1@canonical.com>
 <trinity-80a229fb-42dd-4705-9c55-fe6f3a381a40-1646217098213@3c-app-gmx-bap21>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <trinity-80a229fb-42dd-4705-9c55-fe6f3a381a40-1646217098213@3c-app-gmx-bap21>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 02/03/2022 11:31, Frank Wunderlich wrote:
> 
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +    #include <dt-bindings/clock/berlin2q.h>
>>> +    sata@f7e90000 {
>>> +            compatible = "marvell,berlin2q-ahci", "generic-ahci";
>>> +            reg = <0xe90000 0x1000>;
>>
>> You still have wrong address.
> 
> only took the example from the txt, but i guess reg should be <0xf7e90000 0x1000>; ?
> 

Yes.


Best regards,
Krzysztof
