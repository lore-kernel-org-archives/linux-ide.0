Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9992EC56202
	for <linux-ide@archiver.kernel.org>; Fri, 20 Nov 2020 20:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43E2C2245F
	for <linux-ide@archiver.kernel.org>; Fri, 20 Nov 2020 20:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7YZqLn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgKTUO3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 20 Nov 2020 15:14:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:52010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbgKTUO2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 20 Nov 2020 15:14:28 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A08B2245F;
        Fri, 20 Nov 2020 20:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605903267;
        bh=0nud5UudYzSYvDSjDSOinOA5/um3v/zH6Z3ObsR97t0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X7YZqLn81wr4ibPUvpJWPzA3kGKLbasHaVS4KtSQmYUQnH68lLC7ujEc5DjefZsaW
         +m1xZUVK8iLR7Gzbu2YLCTVhc+BFyifNYAoRwxopZ3LpX/a//pC2yV6B3uIGSxO2PS
         +XdiVjSJCWLkwUFueS1fXEJfmoLeSAgZC4bz8cTE=
Received: by mail-oo1-f48.google.com with SMTP id f8so2493447oou.0;
        Fri, 20 Nov 2020 12:14:27 -0800 (PST)
X-Gm-Message-State: AOAM531JiQqiLNPDlQUg/S4DDidhC/jOEMhxO6LExQRLvbEaMI12O9Xh
        GqXumnDo8IrURRJC9pnQ0osdk4aqfYeU+EkQRA==
X-Google-Smtp-Source: ABdhPJxDvHVEata44WRWpNmiCQnyKriXlGsKwYVrArhwm4ftDB2DYLVCk4f1155CAu3m4tuYyebCjMNfsVT0OAY28Yw=
X-Received: by 2002:a4a:c4c7:: with SMTP id g7mr14542347ooq.50.1605903266545;
 Fri, 20 Nov 2020 12:14:26 -0800 (PST)
MIME-Version: 1.0
References: <1605296218-2510-1-git-send-email-skomatineni@nvidia.com>
 <1605296218-2510-4-git-send-email-skomatineni@nvidia.com> <20201116150022.GA1642318@bogus>
 <4b1d90b7-63e7-8b32-16f8-a1020827f207@nvidia.com>
In-Reply-To: <4b1d90b7-63e7-8b32-16f8-a1020827f207@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 20 Nov 2020 14:14:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLga9TDm_9g6gO54Upzcw8rwqFm-9E1K05FqPHB43kbkg@mail.gmail.com>
Message-ID: <CAL_JsqLga9TDm_9g6gO54Upzcw8rwqFm-9E1K05FqPHB43kbkg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] dt-bindings: ata: tegra: Convert binding
 documentation to YAML
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Nov 17, 2020 at 10:15 AM Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
>
> On 11/16/20 7:00 AM, Rob Herring wrote:
> > On Fri, 13 Nov 2020 11:36:55 -0800, Sowjanya Komatineni wrote:
> >> This patch converts text based dt-binding document to YAML based
> >> dt-binding document.
> >>
> >> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> >> ---
> >>   .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 137 +++++++++++++++++++++
> >>   .../bindings/ata/nvidia,tegra124-ahci.txt          |  44 -------
> >>   2 files changed, 137 insertions(+), 44 deletions(-)
> >>   create mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
> >>   delete mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
> >>
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > Error: Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.example.dts:27.31-32 syntax error
> > FATAL ERROR: Unable to parse input tree
> > make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.example.dt.yaml] Error 1
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [Makefile:1364: dt_binding_check] Error 2
> >
> >
> > See https://patchwork.ozlabs.org/patch/1400065
> >
> > The base for the patch is generally the last rc1. Any dependencies
> > should be noted.
> >
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> >
> > pip3 install dtschema --upgrade
> >
> > Please check and re-submit.
>
> Hi Rob,
>
> make dt_binding_check shows other yaml warmings and didn't go thru
> tegra-ahci.yaml even with specifying DT_SHHEMA_FILES

rc1 and rc3 were broken, so you need to use rc2.

> But, When I do dtbs_check, I see
> Documentation/devicetree/bindings/processed-schema.json generated and
> also it passes for tegra-ahci.yaml
>
>
> In v1 feedback discussion, you mentioned it should be good if dtbs_check
> passes.

dt_binding_check must pass without introducing errors/warnings. That's
not yet a requirement for dtbs_check, but it is a good idea to run
that and make sure any warnings are things that should be fixed in dts
files rather than the binding schema.

Rob
