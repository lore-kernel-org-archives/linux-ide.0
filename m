Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04853C433ED
	for <linux-ide@archiver.kernel.org>; Mon,  3 May 2021 20:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0E5661159
	for <linux-ide@archiver.kernel.org>; Mon,  3 May 2021 20:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhECUC4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 3 May 2021 16:02:56 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:33519 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhECUC4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 3 May 2021 16:02:56 -0400
Received: by mail-ot1-f51.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso6256205otl.0;
        Mon, 03 May 2021 13:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kWg3PkvprIRl1989GGxwaXoDVsJNgvJfLQ4Vx1aPGkw=;
        b=WlE6ckIdjzl0ElkbJfg3SA1uSHgBXAJFkyOoTPMokjEafm0qCC7y37n3r304w2nMbu
         dj40Zyh5aYi90/rz6HZfWWdvJGIwMlNi5YB6qd2CqVHKWgTpRkQei0JqdaHMdn864lk+
         EFm3K2qSNBYijUZ+3MJMZPWxTfHtw/zxmnV28GGkiptmnzN68fKO87Ui1tBPCzU8K1w7
         nng4Vbq4IRu6LgPRG+PR5VU412hDZQ+PnvVXJ6X++8ml3OCwY+iMPTySpzESEYQLxAAX
         kbV2zJ0edwBs1f41R1CB7jhf2OEXlp1bdfyyGL/X6Iu6mJ9FlVpDSWy9apPMqkSHtuLI
         GKYg==
X-Gm-Message-State: AOAM532H/l06hYvvo+McWKSoTcdrrUxGH3Ph86mqEDUSKpC8N3l/5ieV
        1vsy6jwD/Mtz+Ik6aGu+QFNppgxFOA==
X-Google-Smtp-Source: ABdhPJwooxVaig3i6ssN4kqOmxglN14cggEKYKVRa5omS/mHDIbmb9UuiQIPW5I2LiMGTA48PMTIOg==
X-Received: by 2002:a9d:6d1a:: with SMTP id o26mr16706055otp.122.1620072121268;
        Mon, 03 May 2021 13:02:01 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o20sm169595oos.19.2021.05.03.13.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 13:02:00 -0700 (PDT)
Received: (nullmailer pid 2297113 invoked by uid 1000);
        Mon, 03 May 2021 20:01:59 -0000
Date:   Mon, 3 May 2021 15:01:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ata: renesas,rcar-sata: Make power-domains
 and resets required
Message-ID: <20210503200159.GA2297031@robh.at.kernel.org>
References: <ca35d7d837b155c69232a1c25060737b4c87720f.1619700260.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca35d7d837b155c69232a1c25060737b4c87720f.1619700260.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, 29 Apr 2021 14:45:03 +0200, Geert Uytterhoeven wrote:
> The "power-domains" property is present on all supported platforms.
> The "resets" property is present on all but R-Car H1.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../devicetree/bindings/ata/renesas,rcar-sata.yaml    | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Applied, thanks!
