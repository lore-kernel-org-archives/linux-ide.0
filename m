Return-Path: <SRS0=A6T3=EM=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB26C4741F
	for <linux-ide@archiver.kernel.org>; Fri,  6 Nov 2020 16:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BBA82064C
	for <linux-ide@archiver.kernel.org>; Fri,  6 Nov 2020 16:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604679088;
	bh=GzgooOezVTJxSV4EgOXNJMv/zxt1Zk20rWu6FcWtaAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VrNbkziXsDWvpT2h8opnrJcSR49ugLdbH01gr8KmQodKC0NNuKj+ZAGOEu55dAwAR
	 FmDOWipvsx+L6GandyTdeG0Uu2XiGDCqeicGjN160+0Iv+pallztFzTu/VvB2YLLI9
	 XlpqBGrocWB7eE30CtFbHh+pwoc/p+bPOO7gVdX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgKFQLZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 6 Nov 2020 11:11:25 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33724 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgKFQLY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 6 Nov 2020 11:11:24 -0500
Received: by mail-ot1-f66.google.com with SMTP id i18so1711636ots.0;
        Fri, 06 Nov 2020 08:11:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DJzE/KuQ7K18CVtvfLEE+6QUXG1ivVfOIAlgwQBM+y8=;
        b=inujDl+uhv27tFXmACrXP+ePcSKwFTDwSOYJ7PkYJt37ZCQyF4UIBctpQ25rwogz4f
         HD1JwevsCWl1fMr5C0eKB6BgCO4W9i/rDXgv+iWxZ+XAL5jqBm/1ysMDKoo9/RCn9G+l
         sGGSdUvPkjSPAsj43vjZxyWFA6asSuTjs+dT6Uz38e3J9IDUI6AS8js5QNzci6pJN26T
         aWfD6OUoMoUyOWmQmw5WFFKaeFkRxc2CYOgIflvN8MbLu0qGaH7dxljwu5IIoDMh0t1/
         4kGOb7q7dXdjTmz/HgvJtVRKVBv6d3Fmbpqt0StkNkVE1hgdlsRO4Ym/MI9G+HM1hbJu
         6lpA==
X-Gm-Message-State: AOAM532riGEg+NMRdhFhrWBVxZCp7KN5Q1wDwPcSiGqdoAUytRUVpySC
        pYrrxXAiKpzbe1mgzzV61CokDKxgLw==
X-Google-Smtp-Source: ABdhPJzQHAadyaK/sIwKmkNCidTdXTmvxMhCRlyHwqCQusqvJ2wj1rC3GxJuI1keQwv3C+JdqT0+7A==
X-Received: by 2002:a05:6830:60a:: with SMTP id w10mr1635072oti.104.1604679083780;
        Fri, 06 Nov 2020 08:11:23 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w8sm377300otm.64.2020.11.06.08.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 08:11:23 -0800 (PST)
Received: (nullmailer pid 3290341 invoked by uid 1000);
        Fri, 06 Nov 2020 16:11:22 -0000
Date:   Fri, 6 Nov 2020 10:11:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux-tegra@vger.kernel.org,
        linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        jonathanh@nvidia.com
Subject: Re: [PATCH v1 1/4] dt-bindings: ata: tegra: Convert binding
 documentation to YAML
Message-ID: <20201106161122.GB3289870@bogus>
References: <1604628968-1501-1-git-send-email-skomatineni@nvidia.com>
 <1604628968-1501-2-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604628968-1501-2-git-send-email-skomatineni@nvidia.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, 05 Nov 2020 18:16:05 -0800, Sowjanya Komatineni wrote:
> This patch converts text based dt-binding document to YAML based
> dt-binding document.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 152 +++++++++++++++++++++
>  .../bindings/ata/nvidia,tegra124-ahci.txt          |  44 ------
>  2 files changed, 152 insertions(+), 44 deletions(-)
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


See https://patchwork.ozlabs.org/patch/1395390

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

