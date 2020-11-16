Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E65C8256D
	for <linux-ide@archiver.kernel.org>; Mon, 16 Nov 2020 15:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C41E120578
	for <linux-ide@archiver.kernel.org>; Mon, 16 Nov 2020 15:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbgKPPAi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 16 Nov 2020 10:00:38 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38065 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731147AbgKPPAY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 16 Nov 2020 10:00:24 -0500
Received: by mail-ot1-f66.google.com with SMTP id a15so16276689otf.5;
        Mon, 16 Nov 2020 07:00:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mmkzgNSoeEUQq9ZJSPSCkP5fe2eYf8fnvdnTvX3FQ9o=;
        b=SiPxBCi3i/uY0jIYI/T1JMFd1eJw2nNv10aG4fz03bQdYA+Z9YYCeHWkSM8bz7OioF
         +DE5l92nsP2b58tRHNEH/Y1mAJkeM26Hu/rmxthmRU4/LF07opvZp3i8CW19/bN435VP
         mQLBBRmcySv6LD/myVcPwB/0v78zgJapOjWxW7RyjUlhENVmMZ0pNZKk/1TA2VtAyhYK
         yf0i0wZ5VtT+AYyh7sgODV/LGT5O+0YWRF/v/WhXkrbLexcnWcJn1XzRNp+JeGdoSbE3
         13Zpm0ItO71hebc44KyuwDh1K+ZMbbXtrpEHElkzDAvyI6FVJ5PbLt7+aD2TskvO/4Tr
         mgiA==
X-Gm-Message-State: AOAM5312UmnHLe81O69/culHfRseuex/APPPVMGZuu2oVBLJ172ycfxw
        0KsIa36ngvQvO1hANlclOA==
X-Google-Smtp-Source: ABdhPJwvG0kAayLRkygCXMCLVdZADmD40ITyYLucvzOzIYkakNUFC8ID4apKoUygBywvx1BB4tJteQ==
X-Received: by 2002:a9d:12b2:: with SMTP id g47mr10353352otg.354.1605538823702;
        Mon, 16 Nov 2020 07:00:23 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h8sm4872162otm.72.2020.11.16.07.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 07:00:22 -0800 (PST)
Received: (nullmailer pid 1643194 invoked by uid 1000);
        Mon, 16 Nov 2020 15:00:22 -0000
Date:   Mon, 16 Nov 2020 09:00:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-ide@vger.kernel.org, thierry.reding@gmail.com,
        devicetree@vger.kernel.org, jonathanh@nvidia.com,
        robh+dt@kernel.org
Subject: Re: [PATCH v2 3/6] dt-bindings: ata: tegra: Convert binding
 documentation to YAML
Message-ID: <20201116150022.GA1642318@bogus>
References: <1605296218-2510-1-git-send-email-skomatineni@nvidia.com>
 <1605296218-2510-4-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605296218-2510-4-git-send-email-skomatineni@nvidia.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, 13 Nov 2020 11:36:55 -0800, Sowjanya Komatineni wrote:
> This patch converts text based dt-binding document to YAML based
> dt-binding document.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 137 +++++++++++++++++++++
>  .../bindings/ata/nvidia,tegra124-ahci.txt          |  44 -------
>  2 files changed, 137 insertions(+), 44 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
>  delete mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.example.dts:27.31-32 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1364: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1400065

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

