Return-Path: <SRS0=b2kW=2V=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0ECC2D0C2
	for <linux-ide@archiver.kernel.org>; Tue, 31 Dec 2019 17:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC269205ED
	for <linux-ide@archiver.kernel.org>; Tue, 31 Dec 2019 17:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="10RtHqBF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfLaRq4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 31 Dec 2019 12:46:56 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35622 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLaRqz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 31 Dec 2019 12:46:55 -0500
Received: by mail-lf1-f68.google.com with SMTP id 15so27398814lfr.2
        for <linux-ide@vger.kernel.org>; Tue, 31 Dec 2019 09:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3fTDdhLi1IOKP9I0hbX5TWBA0qDWLDQvrRlWQlcOtq8=;
        b=10RtHqBF5lBxwbvD2uSgcXpsDW/ubqiM/5wkw3R8xH1L5e7xlKEk9NrD8QxtTLYAzk
         qwo3Wi4pachA6Q5iz0966j+dj9uDynIenvc9GDRgE9533GqqhAkt6GICA+nsbiAEr+00
         l0noo0DZCTrXkWh7UILFMvdaTWwvFtQ36zkcfpTS9deVhg+v9AGRtfgC02yjOPWaKOna
         Bikchmy8NxJDau2cBNxBqrZCnS4SKBSxW19osA0IP7mibwpThaYZXd9bi9a55xRMz/gE
         KO9NkezXMuCIxrIGpWexhNQz14+LBRFsEXCcJOoj75lGkXzIf57OCFfXSdw1UZszz93j
         cbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3fTDdhLi1IOKP9I0hbX5TWBA0qDWLDQvrRlWQlcOtq8=;
        b=Q3+4Mny6MsWkJEN0CANclT1ccqmYjRW7BJmgLW1ssD7nG9knfHQgoKkBdSWz9L1Yev
         tZ7gG5oNRZNFqqw7bLNBoot0qO6RXvpyTBvCn9HK6LVZBe8zyuClFWsQdPLMCzBzV0k0
         zpgleeqabHnLqXFzKOr32Dm9rFue0aftokkB2QF4ARuhHN1VUysn8IiDY05z3KbBVQKJ
         IpgIndzSmvBbwzswc5R8jpSWqsiDY213m06hayVnfV84Tc8ESSnQELwJAjGnLtYb6bhN
         XlL/B6NlI+62clNCNzFdiSLmgJQigHWVvRGlUO7HIs32KvjgZ7I6XNhdR132uM9bQn/F
         m1MA==
X-Gm-Message-State: APjAAAWV14u10pbIenmPBdIqeBonK3UMYGQllnV1GbkvfwjauLXiyYfV
        9ZIJXWc6LqE1D9YfBFOGt1Y8VqRDBK9y3Q==
X-Google-Smtp-Source: APXvYqymB4BjR6axudSAtiLveX48fUBKnrk5NTKARe+yKnx6TPJotX2dYZnRGIs5cCmqWUjMzNJSrg==
X-Received: by 2002:ac2:52a5:: with SMTP id r5mr42540399lfm.19.1577814411813;
        Tue, 31 Dec 2019 09:46:51 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:278:b572:bf70:f2c5:7a0b:f05])
        by smtp.gmail.com with ESMTPSA id 78sm19602629ljj.28.2019.12.31.09.46.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Dec 2019 09:46:51 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: Create DT bindings for [PS]ATA
 controllers
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org
References: <20191231172458.25984-1-linus.walleij@linaro.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <41b527ba-003d-425b-5e59-43cdd8c778e2@cogentembedded.com>
Date:   Tue, 31 Dec 2019 20:46:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20191231172458.25984-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 12/31/2019 08:24 PM, Linus Walleij wrote:

> I need to create subnodes for drives connected to PATA
> or SATA host controllers, and this needs to be supported
> generally, so create a common YAML binding for
> "pata-controller" or "sata-controller" that will support
> subnodes with drives.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/ata/pata-sata-common.yaml        | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/pata-sata-common.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/pata-sata-common.yaml b/Documentation/devicetree/bindings/ata/pata-sata-common.yaml
> new file mode 100644
> index 000000000000..d94aa20a29e3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/pata-sata-common.yaml
> @@ -0,0 +1,47 @@
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
> +  (PATA) and Serial (SATA) AT attachment storage devices. It doesn't
> +  constitue a device tree binding specification by itself but is meant to
> +  be referenced by device tree bindings.
> +
> +  The PATA/SATA controller device tree bindings are responsible for
> +  defining whether each property is required or optional.
> +
> +properties:
> +  $nodename:
> +    pattern: "^[ps]ata-controller(@.*)?$"

   I thought the DT spec has long ago standardized the node name as "ide" and "sata"?

> +    description:
> +      Specifies the host controller node.
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
[...]

MBR, Sergei
