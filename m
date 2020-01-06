Return-Path: <SRS0=GUab=23=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB72C33C8C
	for <linux-ide@archiver.kernel.org>; Mon,  6 Jan 2020 22:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B87214D8
	for <linux-ide@archiver.kernel.org>; Mon,  6 Jan 2020 22:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578350429;
	bh=zEjg60b8UbprMH/aBQ9z3IQetPpLk8aSRgbjocYpZnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OC6A+BgmUq6yMG/y6KRARp81i+FpVyFYn0/xisPkXzkGqNTqvwxXgEDmFRVgmD31F
	 yA3Uj56hAkZMOOuv2+bOt42SGUGW8sDTF9IIeRH6fBuPMYcdMqDPwprhMn6/66sZsd
	 L+ENFwL1fxZEPgT3mf69gsbR+CIgwwh5VkrMpnm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgAFWkZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:40:25 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39028 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgAFWkZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 6 Jan 2020 17:40:25 -0500
Received: by mail-ot1-f68.google.com with SMTP id 77so73615824oty.6
        for <linux-ide@vger.kernel.org>; Mon, 06 Jan 2020 14:40:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4xRmuseBXBvXecEvchHMqQ1KbIr+16qRs88/qPH/zRs=;
        b=MTlh+uDWWQzrP8EQaxpZI+EfQKg+9nRbAffZeuC7w4MuYFJKHOOMfDr8Pda7wL0KOH
         UjtZR6tfFq11eVt850hPZhHCBETjgYXR3zU8tw+/HouGl6zs2vI5l6kfuP0PqQqJsFFT
         /hO7yNQ7IWxDss8A93euDRUeYydS/2cKVii326FMvtzPlXUAKakRE9YrD0+SVK/YlBMw
         OeEoRaLcJszgjq36hu5UHtuMTEiI95QwvQynP2CCIq4BzPJH2llu3ReMLHG+nCLg4LMn
         L+hRnaS07TWiUuTM5+Qs40vWQ4D9E54ejTZkksWjlArEtbU8yOL3Y5ucHEXnVIpHeD1U
         liUg==
X-Gm-Message-State: APjAAAXrjwyuLPcs2neWC5TE1tQnmcRWREXreivcAWKPHYbqIx19dlaX
        YSVwl3aYvXv/cU5Vi4KHyAEz3mM=
X-Google-Smtp-Source: APXvYqx/R8NR26OvU2/ook73nCIlZzBpoObgKtxBkQThCiu5iwKmOlnpiL0FhGNisD4aDmrtXGVrqg==
X-Received: by 2002:a9d:7c90:: with SMTP id q16mr102210684otn.191.1578350424629;
        Mon, 06 Jan 2020 14:40:24 -0800 (PST)
Received: from rob-hp-laptop (ip-70-5-121-225.ftwttx.spcsdns.net. [70.5.121.225])
        by smtp.gmail.com with ESMTPSA id f142sm21871220oig.48.2020.01.06.14.40.22
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 14:40:24 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22043f
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 06 Jan 2020 16:40:20 -0600
Date:   Mon, 6 Jan 2020 16:40:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2 v2] dt-bindings: Convert Faraday FTIDE010 to DT schema
Message-ID: <20200106224020.GA5136@bogus>
References: <20200106015256.13194-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106015256.13194-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon,  6 Jan 2020 02:52:56 +0100, Linus Walleij wrote:
> This uses the new pata-sata-controller.yaml schema to
> convert the Faraday FTIDE010 to DT schema.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Rename the node for the example controller to "ide@"
> - Rename the drives to ports, so ide-port@0 etc instead of
>   drive@0.
> ---
>  .../bindings/ata/faraday,ftide010.txt         | 38 --------
>  .../bindings/ata/faraday,ftide010.yaml        | 89 +++++++++++++++++++
>  2 files changed, 89 insertions(+), 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/faraday,ftide010.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/faraday,ftide010.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
