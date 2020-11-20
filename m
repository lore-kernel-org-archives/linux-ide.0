Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802F9C2D0E4
	for <linux-ide@archiver.kernel.org>; Fri, 20 Nov 2020 20:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17F6322464
	for <linux-ide@archiver.kernel.org>; Fri, 20 Nov 2020 20:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5BLtccF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbgKTURs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 20 Nov 2020 15:17:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:52682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728863AbgKTURs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 20 Nov 2020 15:17:48 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C9DC22470;
        Fri, 20 Nov 2020 20:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605903467;
        bh=uWTGUzgFAc+UqdPUOqq1dMU2NKZmh/ALeOWAOSfEWxo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o5BLtccF0lkEAzS1H/+TaidpLCrlIhMB4mk3NIRkCobB7ZXX1/e1r8kbnCDO6dxF2
         xUNsPhZmoTGMm3tIq28WywQIt8LarTUTfDzYrmw6KNZf8/f5tAShYmTEDqzqukCSRE
         qOpC9/imkVc83nUeoRRWwMqi4lRO1Zy6DOh0tLws=
Received: by mail-ot1-f44.google.com with SMTP id l36so9925979ota.4;
        Fri, 20 Nov 2020 12:17:47 -0800 (PST)
X-Gm-Message-State: AOAM531hM9mBjvTKboX93Ed3BWdyXSptmlI+ShHVe+ajmVAt1Db+gewC
        rtjuSTu7R4LqxNOoKCic1Y7d+MkltcJDTU8KoA==
X-Google-Smtp-Source: ABdhPJxVGntrT4U2oBT5LKIQMam1ZvVfO8lKUlhSLLMDZ45/h9Pq8b8ZF6Zy4lAbMpdzw0rEpS/DIgfqekUVwN3w7xk=
X-Received: by 2002:a05:6830:2259:: with SMTP id t25mr15315926otd.192.1605903466581;
 Fri, 20 Nov 2020 12:17:46 -0800 (PST)
MIME-Version: 1.0
References: <1605296218-2510-1-git-send-email-skomatineni@nvidia.com> <1605296218-2510-4-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1605296218-2510-4-git-send-email-skomatineni@nvidia.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 20 Nov 2020 14:17:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKkGmRwsv48xdX7xMSEaTSqdEnWuy0E19eohBxJKMywJg@mail.gmail.com>
Message-ID: <CAL_JsqKkGmRwsv48xdX7xMSEaTSqdEnWuy0E19eohBxJKMywJg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] dt-bindings: ata: tegra: Convert binding
 documentation to YAML
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Nov 13, 2020 at 1:36 PM Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
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
> diff --git a/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml b/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
> new file mode 100644
> index 0000000..dbbe460
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
> @@ -0,0 +1,137 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/nvidia,tegra-ahci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Tegra AHCI SATA Controller
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Jonathan Hunter <jonathanh@nvidia.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nvidia,tegra124-ahci
> +      - nvidia,tegra132-ahci
> +      - nvidia,tegra210-ahci
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 3
> +    items:
> +      - description: AHCI registers
> +      - description: SATA configuration and IPFS registers
> +      - description: SATA AUX registers
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: sata
> +      - const: sata-oob
> +
> +  clocks:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: sata
> +      - const: sata-cold
> +      - const: sata-oob
> +
> +  resets:
> +    maxItems: 3
> +
> +  phy-names:
> +    items:
> +      - const: sata-0
> +
> +  phys:
> +    maxItems: 1
> +
> +  hvdd-supply:
> +    description: SATA HVDD regulator supply.
> +
> +  vddio-supply:
> +    description: SATA VDDIO regulator supply.
> +
> +  avdd-supply:
> +    description: SATA AVDD regulator supply.
> +
> +  target-5v-supply:
> +    description: SATA 5V power regulator supply.
> +
> +  target-12v-supply:
> +    description: SATA 12V power regulator supply.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clock-names
> +  - clocks
> +  - reset-names
> +  - resets
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra124-ahci
> +              - nvidia,tegra132-ahci
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 2
> +        reset-names:
> +          minItems: 3
> +        resets:
> +          minItems: 3
> +      required:
> +        - phys
> +        - phy-names
> +        - hvdd-supply
> +        - vddio-supply
> +        - avdd-supply
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra210-ahci
> +    then:
> +      properties:
> +        reg:
> +          minItems: 3
> +        reset-names:
> +          minItems: 3
> +        resets:
> +          minItems: 3
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/tegra210-car.h>
> +    #include <dt-bindings/reset/tegra210-car.h>
> +
> +    sata@70020000 {
> +            compatible = "nvidia,tegra210-ahci";
> +            reg = <0x0 0x70027000 0x0 0x00002000>, /* AHCI */
> +                  <0x0 0x70020000 0x0 0x00007000>, /* SATA */
> +                  <0x0 0x70001100 0x0 0x00010000>; /* SATA AUX */

The default sizes are 1 cell for address and size, so this will give
you warnings. You either need to adjust the entries here or add a
parent node setting the sizes to 2 cells.

> +            interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;

The error is because you need the include files for these defines.

> +            clocks = <&tegra_car TEGRA210_CLK_SATA>,
> +                     <&tegra_car TEGRA210_CLK_SATA_OOB>;
> +            clock-names = "sata", "sata-oob";
> +            resets = <&tegra_car 124>,
> +                     <&tegra_car 129>,
> +                     <&tegra_car 123>;
> +            reset-names = "sata", "sata-cold", "sata-oob";
> +    };
