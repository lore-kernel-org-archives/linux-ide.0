Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764F8C388F9
	for <linux-ide@archiver.kernel.org>; Sat, 21 Nov 2020 14:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49A1D22210
	for <linux-ide@archiver.kernel.org>; Sat, 21 Nov 2020 14:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgKUOEw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 21 Nov 2020 09:04:52 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41996 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbgKUOEw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 21 Nov 2020 09:04:52 -0500
Received: by mail-qk1-f195.google.com with SMTP id z188so422624qke.9;
        Sat, 21 Nov 2020 06:04:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wwSyffURhFDeBnrx6J6OeK2E2lbKIqJMz9PrJJH/RC0=;
        b=KfF7C+61OQ5acci9uhIeITn7Weo+a5/kN9rT0EMmmEJYpPpwt4bl07YfvpR6TVqdK5
         Vex0/MsDI1SDKChWwHxTm/bDgcvYuo9HRgPvP696PGWTEFgs7VpUuVvzisysJGYMT1hB
         gTRDZMXPlAlAxtFNgpM6huLkzAmELID9m7HD8tdFirLNKFG4KIZmf5GJuBHtXJD0uCK6
         70ii5Y5nuGKqFNbWapLpiaxinN5hpp0RI5GmHjdJFxU6He2RaNfS6S26pVrGd1RL7ud6
         6bjgpBJj149ZCEWWgo/isb9O3+eK+nh9eru/PfAmWno/enZpKDfHyxAQGlSLPXwKACfQ
         h+JQ==
X-Gm-Message-State: AOAM530x7OAiDQ0cb2V56mC4JyHTNwnk/xdklh5cwukh8eRJNo+aHL7m
        lsCQLXlNOF/XEsYKrpj99Q==
X-Google-Smtp-Source: ABdhPJynrIKv2Ye3GvsMlDEoJ/XAMOUbvNz3bmZkSg/xPEZNu9UzBQz8diHoAS1DsNu0usRPer7Pbw==
X-Received: by 2002:a37:5242:: with SMTP id g63mr22162778qkb.317.1605967491394;
        Sat, 21 Nov 2020 06:04:51 -0800 (PST)
Received: from xps15 ([172.58.99.230])
        by smtp.gmail.com with ESMTPSA id w192sm4131343qka.68.2020.11.21.06.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 06:04:50 -0800 (PST)
Received: (nullmailer pid 2173568 invoked by uid 1000);
        Sat, 21 Nov 2020 14:04:47 -0000
Date:   Sat, 21 Nov 2020 08:04:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, thierry.reding@gmail.com,
        linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 4/6] dt-binding: ata: tegra: Add dt-binding
 documentation for Tegra186
Message-ID: <20201121140447.GA2173518@robh.at.kernel.org>
References: <1605296218-2510-1-git-send-email-skomatineni@nvidia.com>
 <1605296218-2510-5-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605296218-2510-5-git-send-email-skomatineni@nvidia.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, 13 Nov 2020 11:36:56 -0800, Sowjanya Komatineni wrote:
> This patch adds dt-bindings documentation for Tegra186 AHCI
> controller.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
