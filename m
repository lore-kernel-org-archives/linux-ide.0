Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9C1C433EF
	for <linux-ide@archiver.kernel.org>; Sun,  6 Mar 2022 11:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbiCFL4E (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Mar 2022 06:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiCFL4D (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Mar 2022 06:56:03 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890452A27A
        for <linux-ide@vger.kernel.org>; Sun,  6 Mar 2022 03:55:11 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1D6D83F61B
        for <linux-ide@vger.kernel.org>; Sun,  6 Mar 2022 11:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646567709;
        bh=M7HhdQnqg/99QgckiwYhOLXnbb7e+E0jF9L8MBDB2C0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=AbaHG6Rt5znP7tOPegHcHCcnn16dlKdecooNzXPWOMqoPKMPyx2kB6hS90f45EmUq
         +LPe/qmQuR73J3bPU0+iiNxAbjrDebs54v77nbikKuv3CwloO9XbYKxgMEZ5IJyRcN
         NT7F/rsLoDNvtVkB45Rg7M4BNsYW3zWcra+Grd0KU+aHzzqUcKQ9cUb+1JPh7tuNZR
         luDVqlcxdoRAtYz1Beet2bYkLZvOH27aRFLD5XIGZkpojTtJ1T0mAq31sdTjY5Fv6+
         pKAfL/FQjLb1M5WVo0bt3xcv0jiBmmVI8Zs1bLosomslZ6fKLkKe0xyho+ebDA/9rS
         vEkfx9188SUVA==
Received: by mail-ed1-f72.google.com with SMTP id da28-20020a056402177c00b00415ce4b20baso5882814edb.17
        for <linux-ide@vger.kernel.org>; Sun, 06 Mar 2022 03:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M7HhdQnqg/99QgckiwYhOLXnbb7e+E0jF9L8MBDB2C0=;
        b=VUtVtqLyIVRLbgF5ffgZjdmUx/RxPQ6KPZuWtP0mnALeEzZ6cyNZoz69KwA7UCSRXL
         +lS8RliDlXRDzW3oNb2gga0Z7mNXD+2OveV+RYL/VNuJTl8Vcqt9ukv7CZjHFhUfFqc+
         Z0J4YxBr0IfoipzDtScLLiOqKbGGH6qExqC7XMZp2FSikiuLlqFdqJ7eU6Apa9gyLsGV
         MxHUPYZlAiJt5184LMMpIEDO3Tjsw+Mqr4Dd93SqT/wzTaLv3b9GYTlBELSFULMbIC3p
         sUuG+F874Tb3UeMvSEob+ejJ3xF39jm/D7gYJW3l63pyybMuWsEb79+Ia/UZM5EoQbiZ
         pTWw==
X-Gm-Message-State: AOAM530nDWFUI637H4OACBk2Nuffza8VWIUeXGqNgt6EphN0ojiZXe3L
        ne/AUHR6nMkAfr3MPcsUh+DFoe0fBqNjgl81VLDIxA+XlzD/vzwlFecwvnV176uP2RlTsAmo5lU
        4KigbZnmZzbUMVDa7TwsR9pLEn9rL//EUOxiErg==
X-Received: by 2002:aa7:c7c4:0:b0:407:52cc:3b32 with SMTP id o4-20020aa7c7c4000000b0040752cc3b32mr6335736eds.397.1646567708099;
        Sun, 06 Mar 2022 03:55:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEqcWBPOeCVNUb/IWUj+A8DrXorGXUVAFBV0XM7Z0DdE7bS6WcOFGj7u+16JP6Qhb+rlqEpg==
X-Received: by 2002:aa7:c7c4:0:b0:407:52cc:3b32 with SMTP id o4-20020aa7c7c4000000b0040752cc3b32mr6335725eds.397.1646567707943;
        Sun, 06 Mar 2022 03:55:07 -0800 (PST)
Received: from [192.168.0.140] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id ce12-20020a170906b24c00b006da824011eesm3734626ejb.166.2022.03.06.03.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 03:55:07 -0800 (PST)
Message-ID: <c2e01b71-efbe-7d6f-5cdf-1340c5210798@canonical.com>
Date:   Sun, 6 Mar 2022 12:55:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Aw: Re: Re: Re: [PATCH v5 1/5] dt-bindings: ata: ahci-platform:
 Convert DT bindings to yaml
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
 <b8553651-3cd0-845c-efbf-d2341d5506b3@canonical.com>
 <trinity-d42352e1-d778-40dd-9464-90a145653f74-1646563315484@3c-app-gmx-bs46>
 <18f4dc19-b8a4-015e-48c8-923326cc7932@canonical.com>
 <trinity-955432eb-74c6-48f6-984e-d88a61854727-1646567165101@3c-app-gmx-bs64>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <trinity-955432eb-74c6-48f6-984e-d88a61854727-1646567165101@3c-app-gmx-bs64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 06/03/2022 12:46, Frank Wunderlich wrote:
> 
> i see it as requirement for last part
> 
> "arm64: dts: rockchip: Add sata nodes to rk356x"
> 
> if this can applied without the bindings conversion there is nothing to hurry :)

This actually depends more on Heiko, whether he is willing to take DTS
change even though the compatible was not yet merged. There is no strict
dependency here, so DTS change could go now...


Best regards,
Krzysztof
