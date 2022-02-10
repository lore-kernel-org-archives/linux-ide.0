Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89781C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 10 Feb 2022 09:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbiBJJ6l (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:58:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbiBJJ6k (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2022 04:58:40 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386EEBAA
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2022 01:58:42 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 01E863F1B4
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2022 09:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644487121;
        bh=QVjWVo4q1GQDHRafCv7HdVFRi4TY/Fg/yK2d0li5IAU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=GYgqB5eqplpYz09bTDignBNkOw7AJwTrjEYgRcFjS6VXnBiiD/oxN9UPF66nwCJM0
         jzqnDgFZorjOvxT4rT8KIfqGoJkYOIFVkuszizZRyu+h2ieJah+NmxAmSoibRRC5u+
         1OcZsrfxbX18WsHnsMCsriiQX8BhRyVN+AcxKhXbEdPNgl/FQt2vCatCQnhl24Uw3P
         t0AvomxliOel4J1Bnus0WALCoSDIJZZXkanLCPnKXQmUeF7ME2mrTfGC2cmTm+KGl3
         i7P3V+xsNa2eQNTc1YyDb8wttHlOjDkhjSGedk8fGML323j5ESHyW5lw3QFOZ9yw7L
         7HoAGiHcoRiog==
Received: by mail-ed1-f69.google.com with SMTP id g5-20020a056402090500b0040f28e1da47so3064241edz.8
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2022 01:58:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QVjWVo4q1GQDHRafCv7HdVFRi4TY/Fg/yK2d0li5IAU=;
        b=pabRZcNGOlnX6pg8lLHLmZbYJOeN6utJIvbOCXpSYnz9csugM22Hfi8SVG6z7DEY5L
         xXPc4iz5ewVx5cc1geM/H4aH7KH2rloAaHhJ5pZKcOl+e9cNvrIeBTjCYtByFnspsNbF
         daKHhMO1nTaltxQHrl5R8WIhbE43cold7m2w7VOT2SYa/V4f7+Jnijg38QLEBduzbng1
         JpSkWw4eHcUnJMnhH2I+gfaQsZPgl8sqBt9ITE+iM+1+18rdXXKOHhTCBdt8ykQ9ZUR+
         VHVhB/R6DxUGRwCeaVXul5nW9HPet/Fdrrglpv4WHKYyYSfa2ZZvZ7BC8F6j4WmfzJ36
         KRLQ==
X-Gm-Message-State: AOAM532vP1N4w02yFGK/Zb/t9Hce8+z52tlSgzw800sR64UtNVUIKpzX
        ImV8kgPqtxsu7QemqRXK0gxf6FqlMZVu5yJv8tGhO6Phaa5icxWlwlpNEnh7vJ2w2cuAOLvgd3t
        GCJ2KvpO5WY5r3K+l6xqa67tj8Sjkw+V7x4pE5Q==
X-Received: by 2002:a17:906:4f16:: with SMTP id t22mr5663886eju.413.1644487120645;
        Thu, 10 Feb 2022 01:58:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxgTuz7GR1Tb+hH0mgjyDwXJlDMVpwZtl0H/pA/cQgp2TZegrbiDgjRzZahIarS9kQQNVWX8w==
X-Received: by 2002:a17:906:4f16:: with SMTP id t22mr5663869eju.413.1644487120426;
        Thu, 10 Feb 2022 01:58:40 -0800 (PST)
Received: from [192.168.0.97] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id h1sm4357445eja.201.2022.02.10.01.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 01:58:39 -0800 (PST)
Message-ID: <50d3bef2-82af-325e-72e9-15af5794ce12@canonical.com>
Date:   Thu, 10 Feb 2022 10:58:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] dt-bindings: convert ata/cortina,gemini-sata-bridge to
 yaml
Content-Language: en-US
To:     Corentin Labbe <clabbe@baylibre.com>,
        damien.lemoal@opensource.wdc.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
References: <20220210094414.2815616-1-clabbe@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220210094414.2815616-1-clabbe@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/02/2022 10:44, Corentin Labbe wrote:
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
> 
>  .../ata/cortina,gemini-sata-bridge.txt        |  55 ---------
>  .../ata/cortina,gemini-sata-bridge.yaml       | 107 ++++++++++++++++++
>  2 files changed, 107 insertions(+), 55 deletions(-)
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
> index 000000000000..f0fad63bb1af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml
> @@ -0,0 +1,107 @@
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
> +    minItems: 1

maxItems? Why min?

> +
> +  resets:
> +    minItems: 2
> +    description: phandles to the reset lines for both SATA bridges

min+maxItems

> +
> +  reset-names:
> +    items:
> +      - const: sata0
> +      - const: sata1
> +
> +  clocks:
> +    minItems: 2
> +    description: phandles to the compulsory peripheral clocks

min+maxItems

> +
> +  clock-names:
> +    items:
> +      - const: SATA0_PCLK
> +      - const: SATA1_PCLK
> +
> +  syscon:
> +    minItems: 1

maxItems


Best regards,
Krzysztof
