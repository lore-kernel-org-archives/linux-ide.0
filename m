Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCF3C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 10 Feb 2022 16:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244066AbiBJQMj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:12:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244071AbiBJQMi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2022 11:12:38 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF98C4C
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2022 08:12:38 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 909AA3F324
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2022 16:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644509551;
        bh=UqplXcK8UtxJT/txE7jNL0wD1nuJxIhREgfiQibRdZg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=fnAGvyUoTS7wiEXyAzrfbET7HNcVxYvQtwmJnYIujG4x4GuknspW2alVl1dh90fPS
         k1jvrNcISgOrOz+VmgLK6dz8v13O+Wq/kV+XgnWVkjP4UomDKmOqT4ZWBnRu9ldakL
         +O8YdmbawCBdg4lDuz8Qc35EnutQklk+lEZtOLjPbFLz6hn9Cc07Wn9ceHfNxgyH2m
         P0TW3LBDRTM9JiOqoVkQhrAXHuUEUiYs9yzo9L2Ke4xuDCtLRCllvY2md/QWAR/mHK
         nOs2rlvvPMwjnymxu3nFNmpfIEmW+CrMA5G949vlkm/iZ6XxL+ZKC4BKZVHdXRztpl
         Z+BckMBwylAXg==
Received: by mail-ej1-f69.google.com with SMTP id la22-20020a170907781600b006a7884de505so2959911ejc.7
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2022 08:12:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UqplXcK8UtxJT/txE7jNL0wD1nuJxIhREgfiQibRdZg=;
        b=2oV2sR1NFNvDWoETud18vai64Wgl3wK2GQZlEGLIEUArix/nmWEGCFDXFSmx3Qj/Pu
         pJTcNjOlkYF8r1yW9XZyzQ87ro3PTSJn2I2iHtMsfPrlWcg79EwP/B4bsLmM71wNKLen
         y2hCvF3cqyk0K0tGCbQWpmb/ouh6TlxCxOpiWOZofcOYB0lMboKAOZwNZ4U1nOXm9WUb
         IulENxzjPyAmf890TaoBUm4Xow+SRY3fMrKJX/LuL6DCO5M5Ts6a19n/G1wNQLT4QKbz
         MQhD9/+CRFxroqwaqqjT5o+Uv4QPlh/S+4lyTfucM25HQPmly3ARHi/ZcVr0I48aAYPa
         DnAQ==
X-Gm-Message-State: AOAM531kT1m0qoo+5kQxYDFGRv5ggYGzndqq2Mw8lQ57709vkBFqIWPy
        M9j8KAFhdokqOyytPsHGoja0kMrIdgs/EL50wDUivenOv4ZAG2FweuU2QjlNjWGqxQ788/QcfNn
        BESmoPUvsgDe0f7ahjbOBaGXLdddW1aC3reakPA==
X-Received: by 2002:aa7:c04e:: with SMTP id k14mr9006662edo.131.1644509550938;
        Thu, 10 Feb 2022 08:12:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWpMYTLzQraEPVvwNMVUaVC0aP/A+UTcgF1OpK8OGFsd9WgRVlZDhDMlFIxuCpnawuKs8OkQ==
X-Received: by 2002:aa7:c04e:: with SMTP id k14mr9006643edo.131.1644509550680;
        Thu, 10 Feb 2022 08:12:30 -0800 (PST)
Received: from [192.168.0.99] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id cn15sm4513144edb.37.2022.02.10.08.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 08:12:30 -0800 (PST)
Message-ID: <838394d2-bc47-1a8b-56dd-320d0df39dfe@canonical.com>
Date:   Thu, 10 Feb 2022 17:12:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4] dt-bindings: convert ata/cortina,gemini-sata-bridge to
 yaml
Content-Language: en-US
To:     Corentin Labbe <clabbe@baylibre.com>,
        damien.lemoal@opensource.wdc.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
References: <20220210160712.2962810-1-clabbe@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220210160712.2962810-1-clabbe@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/02/2022 17:07, Corentin Labbe wrote:
> This patch converts ata/cortina,gemini-sata-bridge binding to yaml
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Change since v1:
> - fixed cosmetic nits reported by Damien Le Moal
> Changes since v2:
> - Added blank lines between properties
> - Removed useless quotes and label
> - Re-indented description
> Change since v3:
> - fixed all min/maxitems reported by Krzysztof Kozlowski
> 
>  .../ata/cortina,gemini-sata-bridge.txt        |  55 ---------
>  .../ata/cortina,gemini-sata-bridge.yaml       | 109 ++++++++++++++++++
>  2 files changed, 109 insertions(+), 55 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
> deleted file mode 100644
> index 1c3d3cc70051..000000000000
> --- a/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
> +++ /dev/null
> @@ -1,55 +0,0 @@
> -* Cortina Systems Gemini SATA Bridge
> -
> -The Gemini SATA bridge in a SoC-internal PATA to SATA bridge that
> -takes two Faraday Technology FTIDE010 PATA controllers and bridges
> -them in different configurations to two SATA ports.
> -
> -Required properties:
> -- compatible: should be
> -  "cortina,gemini-sata-bridge"
> -- reg: registers and size for the block
> -- resets: phandles to the reset lines for both SATA bridges
> -- reset-names: must be "sata0", "sata1"
> -- clocks: phandles to the compulsory peripheral clocks
> -- clock-names: must be "SATA0_PCLK", "SATA1_PCLK"
> -- syscon: a phandle to the global Gemini system controller
> -- cortina,gemini-ata-muxmode: tell the desired multiplexing mode for
> -  the ATA controller and SATA bridges. Values 0..3:
> -  Mode 0: ata0 master <-> sata0
> -          ata1 master <-> sata1
> -          ata0 slave interface brought out on IDE pads
> -  Mode 1: ata0 master <-> sata0
> -          ata1 master <-> sata1
> -          ata1 slave interface brought out on IDE pads
> -  Mode 2: ata1 master <-> sata1
> -          ata1 slave  <-> sata0
> -          ata0 master and slave interfaces brought out
> -               on IDE pads
> -  Mode 3: ata0 master <-> sata0
> -          ata0 slave  <-> sata1
> -          ata1 master and slave interfaces brought out
> -               on IDE pads
> -
> -Optional boolean properties:
> -- cortina,gemini-enable-ide-pins: enables the PATA to IDE connection.
> -  The muxmode setting decides whether ATA0 or ATA1 is brought out,
> -  and whether master, slave or both interfaces get brought out.
> -- cortina,gemini-enable-sata-bridge: enables the PATA to SATA bridge
> -  inside the Gemnini SoC. The Muxmode decides what PATA blocks will
> -  be muxed out and how.
> -
> -Example:
> -
> -sata: sata@46000000 {
> -	compatible = "cortina,gemini-sata-bridge";
> -	reg = <0x46000000 0x100>;
> -	resets = <&rcon 26>, <&rcon 27>;
> -	reset-names = "sata0", "sata1";
> -	clocks = <&gcc GEMINI_CLK_GATE_SATA0>,
> -		 <&gcc GEMINI_CLK_GATE_SATA1>;
> -	clock-names = "SATA0_PCLK", "SATA1_PCLK";
> -	syscon = <&syscon>;
> -	cortina,gemini-ata-muxmode = <3>;
> -	cortina,gemini-enable-ide-pins;
> -	cortina,gemini-enable-sata-bridge;
> -};
> diff --git a/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml
> new file mode 100644
> index 000000000000..77af2559b097
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml
> @@ -0,0 +1,109 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/cortina,gemini-sata-bridge.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cortina Systems Gemini SATA Bridge
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description: |
> +    The Gemini SATA bridge in a SoC-internal PATA to SATA bridge that
> +    takes two Faraday Technology FTIDE010 PATA controllers and bridges
> +    them in different configurations to two SATA ports.
> +
> +properties:
> +  compatible:
> +    const: cortina,gemini-sata-bridge
> +
> +  reg:
> +    maxItems: 1
> +
> +  resets:
> +    minItems: 2
> +    maxItems: 2
> +    description: phandles to the reset lines for both SATA bridges
> +
> +  reset-names:
> +    items:
> +      - const: sata0
> +      - const: sata1
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 2
> +    description: phandles to the compulsory peripheral clocks
> +
> +  clock-names:
> +    items:
> +      - const: SATA0_PCLK
> +      - const: SATA1_PCLK
> +
> +  syscon:
> +    maxItems: 1

My bad, I am sorry for misleading you earlier, this is just a phandle,
so should be without any min/maxItems.

> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: a phandle to the global Gemini system controller
> +

With maxItems removed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
