Return-Path: <SRS0=yvY0=3C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5C1C33CA9
	for <linux-ide@archiver.kernel.org>; Mon, 13 Jan 2020 23:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB2B207FF
	for <linux-ide@archiver.kernel.org>; Mon, 13 Jan 2020 23:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578956531;
	bh=ZVJCKcmluivQaj5X7FSCb0b0MTOmY3kKJZnoxwSa5eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L+VZpS557wyCw8OzhCZNpWudZ1YsqD9y7DIJLzGL03caYaAKQWikLJkkSwVM+UUQC
	 6KkRCBikxYoRzSZ8hK/nzgYHZBYgPVFBCS1D4krGLUNB4PBBHpEX0i1DiHGhzJ/A9D
	 53jO+iGA4ka6XGO5SJu0DrfhkXN4Bc/sI5COOKv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgAMXCK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 13 Jan 2020 18:02:10 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40066 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgAMXCK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Jan 2020 18:02:10 -0500
Received: by mail-ot1-f67.google.com with SMTP id w21so10661470otj.7
        for <linux-ide@vger.kernel.org>; Mon, 13 Jan 2020 15:02:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tx39+4MJaLHivIxZTseGmPGOiWsM4jlyAIk8H9s0Snw=;
        b=W+TJwmtEhJPT9uh8JzAOeqZUWYyvT/8befpRSze+lzTHel8u/RHMXn8f9kERH+dznM
         A3RbsEt8yUT7FWxPJEdJPNjN+XDcyECToSJP6qVC3RDaobRtpGFbOR5bc6j0HzqOrXB1
         JiBBY/0Uo+U4fgd4e5iDKtUTZcP/BVuwgt2yjb0pm/YvFGMghw177LLRoxi6xbU2tzRh
         EF9O2ZydxbbVaPzXrgV65SQJdCuwkUesKbDf8eYZnWq+tVXbxs/5uCZtv1x8zAz+LKGE
         X9PhK60erKfbHOfleSVBCAztfT4BqF2Z1ZnG8j5vHFXpf8hBawRR0BSRIWoHjoIAYWh1
         HLrw==
X-Gm-Message-State: APjAAAUz/sqb9o2TkUGAmdMY1IpG6nXtL2E6UFnnoHeJBMNpJpAn/AU3
        NmGbQQW7Sdfk4dfEyqysrJaFF2E=
X-Google-Smtp-Source: APXvYqxueWtoALt7NFvtrz6+/OPSgarnAuhfLTk6xMJGkQqBy6Zg2jqe/zcTEbcL0/mAU5sVW7Z6Eg==
X-Received: by 2002:a05:6830:194:: with SMTP id q20mr15423107ota.92.1578956529085;
        Mon, 13 Jan 2020 15:02:09 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j26sm4713999otq.18.2020.01.13.15.02.08
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 15:02:08 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22198d
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 17:02:07 -0600
Date:   Mon, 13 Jan 2020 17:02:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2 v3] dt-bindings: Create DT bindings for PATA
 controllers
Message-ID: <20200113230207.GA31662@bogus>
References: <20200110081411.9806-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110081411.9806-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, 10 Jan 2020 09:14:10 +0100, Linus Walleij wrote:
> I need to create subnodes for drives connected to PATA
> host controllers, and this needs to be supported generally,
> so create a common YAML binding for "ide" that will support
> subnodes with ports.
> 
> This has been designed as a subset of
> ata/ahci-platform.txt with the bare essentials and
> should be possible to extend or superset to cover the
> common bindings.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Only support PATA controllers for now since it is all I
>   need right now. SATA controller have complex topology and
>   might need more elaborate subnodes, possibly a subnode for
>   the multiplier itself, so I will split that off into its
>   own RFC patch.
> ChangeLog v1->v2:
> - Use ide@ and sata@ as node names.
> - Use ide-port@ and sata-port@ for the ports toward the
>   drives, rather than letting the subnodes be the drives
>   themselves.
> ---
>  .../devicetree/bindings/ata/pata-common.yaml  | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/pata-common.yaml
> 

Applied, thanks.

Rob
