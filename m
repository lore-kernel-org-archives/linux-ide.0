Return-Path: <SRS0=GUab=23=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1C6C33C8C
	for <linux-ide@archiver.kernel.org>; Mon,  6 Jan 2020 22:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00211207FF
	for <linux-ide@archiver.kernel.org>; Mon,  6 Jan 2020 22:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578350338;
	bh=Hg8RXrsR//eLu04pEcg1Y9FharwlyzxmW+3Mc7f3YDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mTlRz1tVcABCDoqQr+QIG/bxrjKSJbaiZkKsfxNq82LyuS+ncOEZ60gt35CIE8g0K
	 GAJkHtniNMKDkkp9nCH2LOwpcduv0ra4uRRDWX5ZVRQ+Kz+a5CXNiSO/f2p59G10oQ
	 bH0pu+20HZFOoF3qfPbdxVYD18tqj/Ki+x2Q0uD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgAFWi5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:38:57 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41282 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgAFWi5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 6 Jan 2020 17:38:57 -0500
Received: by mail-oi1-f196.google.com with SMTP id i1so17003391oie.8
        for <linux-ide@vger.kernel.org>; Mon, 06 Jan 2020 14:38:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kZ+Ud8XKt/EhgwoYA3rPp+LLhcTcpCeTH542z7c1ZoM=;
        b=qS/BP4tCqk2HIG8Seqc8z/VxKhWvX9qL8RsbeRALMRyhjf/E/ZAePFgntia4wb3l8T
         c+8g5j7edwN0hfOotnDp+4brpDZgB5EaUXKzJOxpUdBQLIMRnN3NPhG1VM8S1LNZT3Ia
         c+OZsEuVc0s6Ot69mkBAt+7fP2loYubAu1rTsMgAIkhXJ0PZQOHqjVXvWKO8SfmiGZb2
         EG7JzJQDQhOx/34jw5wX5FfTIQ0yDT5FTkq6fYSmGRU12JYHu4gRVJQBqALEdYYoqcuE
         YstdRApZVjiCylFv/84MpeEn5IdwUqX9SUx1lHikFUal2Xi7GrIjsfHeG76dbZYgGCQp
         Yo3w==
X-Gm-Message-State: APjAAAW7/zJLt7ZBaIGtYmpiRrgoNt15oZASbup+0HZNoNPayYkrd/S5
        v9q1ifBqs4PnxZrlY7VeEN2L84g=
X-Google-Smtp-Source: APXvYqwYAWG5kcdSE5e8uYsHueJhBkp4ikW0Pnt0h4lOCRRMAumqfB8/Spuv8YfTdkQUZ9s/tctQYg==
X-Received: by 2002:a05:6808:8d5:: with SMTP id k21mr6656477oij.121.1578350336389;
        Mon, 06 Jan 2020 14:38:56 -0800 (PST)
Received: from rob-hp-laptop (ip-70-5-121-225.ftwttx.spcsdns.net. [70.5.121.225])
        by smtp.gmail.com with ESMTPSA id s145sm21874599oie.44.2020.01.06.14.38.53
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 14:38:55 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22043f
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 06 Jan 2020 16:38:51 -0600
Date:   Mon, 6 Jan 2020 16:38:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] dt-bindings: Create DT bindings for [PS]ATA
 controllers
Message-ID: <20200106223851.GA1923@bogus>
References: <20200106014224.12791-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106014224.12791-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Jan 06, 2020 at 02:42:23AM +0100, Linus Walleij wrote:
> I need to create subnodes for drives connected to PATA
> or SATA host controllers, and this needs to be supported
> generally, so create a common YAML binding for
> "ide" or "sata" that will support subnodes with ports.
> 
> This has been designed as a subset of
> ata/pata-sata-common.yaml with the bare essentials and
> should be possible to extend or superset to cover the
> common bindings.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Use ide@ and sata@ as node names.
> - Use ide-port@ and sata-port@ for the ports toward the
>   drives, rather than letting the subnodes be the drives
>   themselves.
> ---
>  .../bindings/ata/pata-sata-common.yaml        | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/pata-sata-common.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/pata-sata-common.yaml b/Documentation/devicetree/bindings/ata/pata-sata-common.yaml
> new file mode 100644
> index 000000000000..f46f04446607
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/pata-sata-common.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/pata-sata-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common Properties for Parallel and Serial AT attachment controllers
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description: |
> +  This document defines device tree properties common to most Parallel
> +  (PATA, also known as IDE) and Serial (SATA) AT attachment storage devices.
> +  It doesn't constitue a device tree binding specification by itself but is
> +  meant to be referenced by device tree bindings.
> +
> +  The PATA/SATA controller device tree bindings are responsible for
> +  defining whether each property is required or optional.
> +
> +properties:
> +  $nodename:
> +    pattern: "^(ide|sata)(@.*)?$"
> +    description:
> +      Specifies the host controller node. PATA host controller nodes are named
> +      "ide" and SATA controller nodes are named "sata"
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^(ide|sata)-port@[0-1]$":

This would allow ide@... to have sata-port@... as a child node.

> +    description: |
> +      DT nodes for ports connected on the PATA or SATA host. The master drive
> +      will have ID number 0 and the slave drive will have ID number 1.
> +      The PATA port nodes will be named "ide-port" and the SATA port nodes will
> +      be named "sata-port".
> +    type: object
> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 1

For SATA, we can have more than 2.

Given both of the above, probably this should be split into 2 files.

Rob
