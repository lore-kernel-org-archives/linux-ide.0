Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070F1C4338F
	for <linux-ide@archiver.kernel.org>; Tue, 17 Aug 2021 21:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D76E361042
	for <linux-ide@archiver.kernel.org>; Tue, 17 Aug 2021 21:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbhHQVMP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Aug 2021 17:12:15 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:41601 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhHQVMP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Aug 2021 17:12:15 -0400
Received: by mail-oi1-f173.google.com with SMTP id be20so1156247oib.8;
        Tue, 17 Aug 2021 14:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uo8/GQr5kF4Tc+UFhmx+P7qRykZn/k4P2BgnvucjonA=;
        b=UIaLvCl71RE78ZGcAcI1kgCqvJtN05udl6FWNi/8SDZ43vs2jnk9JV6PXvf40jqocB
         ejHend73Y26wYUANtbABrqqtrMNPo0U3mVzlNEOsULv7hQEvBFVPPG9T4SwggsNGIg/m
         csAZKR5NLjLw4u8Itt591mVlD5KbQW4TkbMjri/iJuHREaWXjKoYcEnB1zpOE8rzzT06
         nc4DOboblr/xuWiEN7t4JdSyA6XS5zoAphXHEFPf91GhQjsfJ1dB4VNrNQMJ9Z4GEWOS
         kHzLJTAzzQ6OuLydDleEcIWKpqUEqWCGdSlAw8vWtNcq7boiVRN0pv9rN1CfFhFalGaT
         4evQ==
X-Gm-Message-State: AOAM532/7uRrZQrqjs7j25MpQz47u3WJ4JcbetAtKyrU6G6X0AmzcVID
        AlWsk9IihOM0ziDJUk6wHg==
X-Google-Smtp-Source: ABdhPJwMweLbkDH+VHkWi4RAQV2VO7NAiXJZDF79sqEPRr2nu0XSHfTshWKYq2c3rrFalToqkdFdwA==
X-Received: by 2002:aca:afc3:: with SMTP id y186mr3967353oie.65.1629234701205;
        Tue, 17 Aug 2021 14:11:41 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k8sm653339oom.20.2021.08.17.14.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:11:40 -0700 (PDT)
Received: (nullmailer pid 846984 invoked by uid 1000);
        Tue, 17 Aug 2021 21:11:39 -0000
Date:   Tue, 17 Aug 2021 16:11:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: ata: drop unused Exynos SATA bindings
Message-ID: <YRwmCyppx3InBR+1@robh.at.kernel.org>
References: <20210811083859.28234-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811083859.28234-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, 11 Aug 2021 10:38:58 +0200, Krzysztof Kozlowski wrote:
> The Samsung Exynos SoC SATA bindings are not implemented in the kernel,
> not used and superseded by generic
> Documentation/devicetree/bindings/ata/ahci-platform.txt bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/ata/exynos-sata.txt   | 30 -------------------
>  1 file changed, 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/exynos-sata.txt
> 

Applied, thanks!
