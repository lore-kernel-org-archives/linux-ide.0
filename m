Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A4FC7EE25
	for <linux-ide@archiver.kernel.org>; Thu,  8 Jun 2023 12:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbjFHMft (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 8 Jun 2023 08:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbjFHMfr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 8 Jun 2023 08:35:47 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901482115;
        Thu,  8 Jun 2023 05:35:43 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-33c37f62e24so1640915ab.3;
        Thu, 08 Jun 2023 05:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686227743; x=1688819743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/csj1p1/i9/Uv2jIjcn4J7tpvO0wFG79OIA7RaS7C6E=;
        b=ZWyiYSDPICeja9StSLWNDL8fBu99JyqAsbr8eOUBaVWj4Gff5EhjWpTfjry32UHFMM
         fCnGc/6EMqeyf37IRyYm5XQzkKJYtTJtLWJu8SBBD9eiDTTyOTDJoBcXBKGTavjxEi2P
         eBcimEoTVm4f/bA+Vf9KL+OqxiMgXtKBupvs+gLM0i1a1zLWmYe2sAamT60O7zfG8myI
         lceoJqV/0ttNLPL+B/WXCVq4Oo4+VRx3weSu67gKT0fnl+IgCsXelg0eaOfILY3lLApY
         DqtdmGiW0b8t5x7M4LCVi7RmkFZDEedZDhueYXvEKcVVp43MQhaabPtnk+71x3qLINHA
         rnQw==
X-Gm-Message-State: AC+VfDy1dZ+EOjbahK+at7Cxii5uUJKgRwJD+cnos/QKO+fWH2DUbXmc
        hTT0/4+uiFhuSThbafm8xQ==
X-Google-Smtp-Source: ACHHUZ6Xe7FrsdGcfEVF9N5cm60s4Dmr7lpdn0u3iNPOKITzhRtmezvsaGC+eW+1oGdsw9cqV2wCXA==
X-Received: by 2002:a05:6e02:4c8:b0:33e:7b40:18b7 with SMTP id f8-20020a056e0204c800b0033e7b4018b7mr1255443ils.0.1686227742713;
        Thu, 08 Jun 2023 05:35:42 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id r4-20020a92d984000000b0033079f435f7sm380583iln.65.2023.06.08.05.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 05:35:41 -0700 (PDT)
Received: (nullmailer pid 2144446 invoked by uid 1000);
        Thu, 08 Jun 2023 12:35:39 -0000
Date:   Thu, 8 Jun 2023 06:35:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-ide@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Change documentation contact email
Message-ID: <168622773529.2144329.4452345538163814722.robh@kernel.org>
References: <20230514222614.115299-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230514222614.115299-1-dlemoal@kernel.org>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On Mon, 15 May 2023 07:26:14 +0900, Damien Le Moal wrote:
> Change my email address to dlemoal@kernel.org.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  Documentation/devicetree/bindings/ata/ahci-common.yaml          | 2 +-
>  Documentation/devicetree/bindings/clock/canaan,k210-clk.yaml    | 2 +-
>  Documentation/devicetree/bindings/mfd/canaan,k210-sysctl.yaml   | 2 +-
>  .../devicetree/bindings/pinctrl/canaan,k210-fpioa.yaml          | 2 +-
>  Documentation/devicetree/bindings/reset/canaan,k210-rst.yaml    | 2 +-
>  Documentation/devicetree/bindings/riscv/canaan.yaml             | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 

Applied, thanks!

