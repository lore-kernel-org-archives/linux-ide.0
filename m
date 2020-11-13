Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0633DC388F7
	for <linux-ide@archiver.kernel.org>; Fri, 13 Nov 2020 13:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B40B12222F
	for <linux-ide@archiver.kernel.org>; Fri, 13 Nov 2020 13:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuM3bbMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgKMN7n (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 13 Nov 2020 08:59:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbgKMN7n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 13 Nov 2020 08:59:43 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DD3420797;
        Fri, 13 Nov 2020 13:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605275982;
        bh=5zh5U6QQTfrb1zJ1Qx6ri3/VJb6vcNkANMos1Y8u4Yk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AuM3bbMr1Y8rDFBUhaaWssTCj0V8b0g406jdEEsSbegNHXbcomzAKdFvFtY9pE+Jm
         asDr3mJLRtlQM52OXAe9BuYUrtqVd75lkT7xtn2oY9hZyKRQtAOIfYc+C3eYCOFGHV
         0wLy4TAWYo162p9Ev7CCTe0GcIXi8/GDKbSXsVK4=
Received: by mail-ot1-f52.google.com with SMTP id g19so8940647otp.13;
        Fri, 13 Nov 2020 05:59:42 -0800 (PST)
X-Gm-Message-State: AOAM530PDLXA8cXJx83/jsJVnCDnhGl4whnPMHm07Uni9BG8CxYIaL2e
        ywURLtIr4kLgl1QUZRi6cqMgxlG/J32LdJU8fQ==
X-Google-Smtp-Source: ABdhPJxBUIJ2lKibMEAtB+Y6lMxOKxXu95T92jIViUP4LWwGjEKihU7Jf+EZChksfqcYHoyBhuXZQIfesQ+odI9lj/0=
X-Received: by 2002:a05:6830:2259:: with SMTP id t25mr1630402otd.192.1605275981804;
 Fri, 13 Nov 2020 05:59:41 -0800 (PST)
MIME-Version: 1.0
References: <1604628968-1501-1-git-send-email-skomatineni@nvidia.com>
 <1604628968-1501-2-git-send-email-skomatineni@nvidia.com> <20201106161122.GB3289870@bogus>
 <f8ba33f1-90fa-a9f0-5834-9de23fc8ad31@nvidia.com> <d0a42b1c-8ddc-fc97-c675-70a5b7601580@nvidia.com>
 <f7ccb10e-e375-d6a9-78b3-21a9f85a0148@nvidia.com>
In-Reply-To: <f7ccb10e-e375-d6a9-78b3-21a9f85a0148@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 13 Nov 2020 07:59:30 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+g_sXp4t9dPq5LOrhKrsXyu+3-ZCRFqw-AZJs_S=6M=A@mail.gmail.com>
Message-ID: <CAL_Jsq+g_sXp4t9dPq5LOrhKrsXyu+3-ZCRFqw-AZJs_S=6M=A@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] dt-bindings: ata: tegra: Convert binding
 documentation to YAML
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>, devicetree@vger.kernel.org,
        Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, Nov 12, 2020 at 9:54 PM Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> Hi Rob,
>
> Updated yamllint and dt-schema as well.
>
> When I do make dt_binding_check, I see it failed as
> processed-schema-examples.json is not generated.
> Any idea of what I may be missing?
>
> Also it did not go thru bindings/ata path. Tried with DT_SCHEMA_FILES to
> tegra-ahci.yaml as well and I see same.
> make dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
>
> LINT    Documentation/devicetree/bindings
> ./Documentation/devicetree/bindings/mmc/mtk-sd.yaml:20:9: [warning]
> wrong indentation: expected 10 but found 8 (indentation)
> ./Documentation/devicetree/bindings/mmc/mtk-sd.yaml:30:9: [warning]
> wrong indentation: expected 10 but found 8 (indentation)
> ./Documentation/devicetree/bindings/mmc/mtk-sd.yaml:33:9: [warning]
> wrong indentation: expected 10 but found 8 (indentation)
> ./Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml:37:2:
> [error] syntax error: expected <block end>, but found '<scalar>' (syntax)

I believe this error only occurred on linux-next. linux-next is not a
base you should develop on (usually). rc2 is good. Unfortunately
someone broke rc3.

> ./Documentation/devicetree/bindings/soc/aspeed/xdma.yaml:10:2: [warning]
> wrong indentation: expected 2 but found 1 (indentation)
> ./Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml:10:4:
> [warning] wrong indentation: expected 2 but found 3 (indentation)
> ./Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml:18:7:
> [warning] wrong indentation: expected 4 but found 6 (indentation)
> ./Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml:10:4:
> [warning] wrong indentation: expected 2 but found 3 (indentation)
> ./Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml:15:7:
> [warning] wrong indentation: expected 4 but found 6 (indentation)
> ./Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml:25:10:
> [warning] wrong indentation: expected 10 but found 9 (indentation)
> ./Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml:52:9:
> [warning] wrong indentation: expected 6 but found 8 (indentation)
> ./Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml:32:13:
> [warning] wrong indentation: expected 14 but found 12 (indentation)
> ./Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml:35:9:
> [warning] wrong indentation: expected 10 but found 8 (indentation)
> Documentation/devicetree/bindings/Makefile:59: recipe for target
> 'Documentation/devicetree/bindings/processed-schema-examples.json' failed
> make[1]: ***
> [Documentation/devicetree/bindings/processed-schema-examples.json] Error 123
> Makefile:1362: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2

Use 'make -k' if there are unrelated errors.

>
> When I do dtbs_check, I see
> Documentation/devicetree/bindings/processed-schema.json generated and
> also it passes for tegra-ahci.yaml

Then it should be good.

Rob

>
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
>
> Regards,
>
> Sowjanya
>
>
> On 11/6/20 9:18 AM, Sowjanya Komatineni wrote:
> >
> > On 11/6/20 8:41 AM, Sowjanya Komatineni wrote:
> >>
> >> On 11/6/20 8:11 AM, Rob Herring wrote:
> >>> On Thu, 05 Nov 2020 18:16:05 -0800, Sowjanya Komatineni wrote:
> >>>> This patch converts text based dt-binding document to YAML based
> >>>> dt-binding document.
> >>>>
> >>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> >>>> ---
> >>>>   .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 152
> >>>> +++++++++++++++++++++
> >>>>   .../bindings/ata/nvidia,tegra124-ahci.txt          |  44 ------
> >>>>   2 files changed, 152 insertions(+), 44 deletions(-)
> >>>>   create mode 100644
> >>>> Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
> >>>>   delete mode 100644
> >>>> Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
> >>>>
> >>>
> >>> My bot found errors running 'make dt_binding_check' on your patch:
> >>>
> >>> yamllint warnings/errors:
> >>>
> >>> dtschema/dtc warnings/errors:
> >>> Error:
> >>> Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.example.dts:27.31-32
> >>> syntax error
> >>> FATAL ERROR: Unable to parse input tree
> >>> make[1]: *** [scripts/Makefile.lib:342:
> >>> Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.example.dt.yaml]
> >>> Error 1
> >>> make[1]: *** Waiting for unfinished jobs....
> >>> make: *** [Makefile:1364: dt_binding_check] Error 2
> >>>
> >>>
> >>> See https://patchwork.ozlabs.org/patch/1395390
> >>>
> >>> The base for the patch is generally the last rc1. Any dependencies
> >>> should be noted.
> >>>
> >>> If you already ran 'make dt_binding_check' and didn't see the above
> >>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> >>> date:
> >>>
> >>> pip3 install dtschema --upgrade
> >>>
> >>> Please check and re-submit.
> >> Thanks Rob. Will re-try after installing up-to-date.
> >
> > Somehow running 'make dt_binding_check' gives below error.
> >
> > I have yamllint newest version (1.2.1-1). Any specific version of
> > yamllint is needed?
> >
> >  LINT    Documentation/devicetree/bindings
> > invalid config: unknown option "max-spaces-inside-empty" for rule
> > "braces"
> > xargs: /usr/bin/yamllint: exited with status 255; aborting
> > Documentation/devicetree/bindings/Makefile:59: recipe for target
> > 'Documentation/devicetree/bindings/processed-schema-examples.json' failed
> > make[1]: ***
> > [Documentation/devicetree/bindings/processed-schema-examples.json]
> > Error 124
> > Makefile:1362: recipe for target 'dt_binding_check' failed
> > make: *** [dt_binding_check] Error 2
> >
