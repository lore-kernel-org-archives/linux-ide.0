Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F24EC4332F
	for <linux-ide@archiver.kernel.org>; Mon, 17 Oct 2022 03:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiJQDG5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 16 Oct 2022 23:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiJQDGm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 16 Oct 2022 23:06:42 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63054B987
        for <linux-ide@vger.kernel.org>; Sun, 16 Oct 2022 20:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665975989; x=1697511989;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xdELnJJexhL8yWqz/OoEfdlgLu6DNFfGugQqaoZToj4=;
  b=U4PIztU/BHvD2xcPkn2PIbxNI4HGtmqavKhnFNq5ManaV2Gmv9B3+m48
   a24ecwvpiF6HKpcLKx++XDL4VH4yY+RPGQFSX1lE9t/sVTTGzdKmEuzp1
   em6MyJNbynSAbV58UIgewVrIoEh8J8WNRzkAh82h7eKOD9hxOPeAaS9Ie
   gsYaLmcmMlpERv9UBNBRHyC3DvV+DJpgofOUD8QBrNTAwDtSTQrcFkmOr
   pvqIzOvAtRk5w7WsL2u4Y/Rzk9twKwGqyVZ+s2NEHmCjt8PmuTi4IbdOI
   HEUrjU4txUYJS+lXapDEC/AThGyq7CwLZzF329iaIR1cN9BDurRdaL/vI
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,190,1661788800"; 
   d="scan'208";a="214364779"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 11:06:19 +0800
IronPort-SDR: yfy18c9YHZ10eIAqu1i0BYb/mOXpoSyo+jFK2k8KEspL70nAvG83GkhMmzRVzDC6u+hllJd2ho
 jZHdie6RaIimTkQitEA3L3oip12tB+SGcgc2Cfrz0BiM7A/s0xkaBMRwFkOgzTPPuhA3v8w0//
 LbusdRNnUU21bDPwlfQ1UnLG9eEYuHQYML1IOWsDE7wg6PR5DyPr77+7HPeo3dTf3cgiszJmW/
 bEn6J/eHAmFlVGdINfe4MCpGBVcyARlucmTU2n+Ccfg+xu/4VgEnAVj2+jPrnpuC9mFtNbujZV
 MNqTDQCv96bk30/8Cv54ga93
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 19:25:52 -0700
IronPort-SDR: wIbxeNT8hyPxl+7Rg4bgUym8EB9P4j6OphfsATBqywa+4ahmyJUrjGGFBSQ8XGPuJBPrGKiRWV
 losSniZ7OIW7MX+nZjLxQky5ftSBceZNq5DMVpTUGTjaT8ypVB4F7kljGCPGTcwNV7qD3/HuK4
 SRMVKygQBbJrycreg5tkSNZpVJGE8CAmdVakQE4VCaA7xpAaj2fWDh/XY3LCKkaMvpsXXQzWBO
 pa2kW/Tl5Henae8sq/Kh3KB1B16PyEDgjcLiXkvjiSFavqRPeLrIrVs6s3djYiznkD+2Db06Jl
 id0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 20:06:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MrMMZ5H08z1Rwrq
        for <linux-ide@vger.kernel.org>; Sun, 16 Oct 2022 20:06:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665975978; x=1668567979; bh=xdELnJJexhL8yWqz/OoEfdlgLu6DNFfGugQ
        qaoZToj4=; b=P2rY1boatCbL1fMRSR2oTyi7HWkdW4fEzEB9PaMMFmES8VlU1LG
        FRngwMd2S2CNm4cGxlgSC16fCOi6ySznlkfmqTfp/GAI/bLWsVn0f1jXbCwcwclg
        wgDAIbK4a0C0W/axrTWg0KxI9zjNV5WdYm8uVjxWzvcj1GOIld9orwu9R/93BbqZ
        0BfVmC3VBxu5UPe3yboDCV+caAeARNLYPlb8qG1aG3Bg8F13iW76VJwCfzzQBu7u
        tGxbuQFV8QjsQVhn3nbv7d//HbHTJOf9R1zQF+k2kDA8q7jbVM9k6lRq5NuCzbVo
        NrvOyTRzNFFzWNruCGPI2aslk6toU2/pusA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uAZVb-Eaz1Gw for <linux-ide@vger.kernel.org>;
        Sun, 16 Oct 2022 20:06:18 -0700 (PDT)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MrMMX6VCsz1RvLy;
        Sun, 16 Oct 2022 20:06:16 -0700 (PDT)
Message-ID: <0f330b8a-b4c3-3dcb-2754-2c95d8c85037@opensource.wdc.com>
Date:   Mon, 17 Oct 2022 12:06:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] dt-bindings: ata: Add 'ata-generic' binding
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexander Shiyan <shc_work@mail.ru>, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221011135849.2785834-1-robh@kernel.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221011135849.2785834-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/11/22 22:58, Rob Herring wrote:
> The 'ata-generic' binding has been around since 2008, but never
> documented.
> 
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> AFAICT, the ata-generic,use16bit property has no effect in Linux. The
> 32-bit transfers fallback to 16-bit if ATA_PFLAG_PIO32 flag is not set
> which it doesn't appear to ever be set. Looking at the history, the
> driver always used 16-bit mode.
> 
> Linus, Okay with being maintainer here?

If Linus reply is positive, feel free to add:

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

I can take this one through the libata tree also if you prefer.

> 
> ---
>  .../devicetree/bindings/ata/ata-generic.yaml  | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/ata-generic.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/ata-generic.yaml b/Documentation/devicetree/bindings/ata/ata-generic.yaml
> new file mode 100644
> index 000000000000..0697927f3d7e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/ata-generic.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/ata-generic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic Parallel ATA Controller
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description:
> +  Generic Parallel ATA controllers supporting PIO modes only.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - arm,vexpress-cf
> +          - fsl,mpc8349emitx-pata
> +      - const: ata-generic
> +
> +  reg:
> +    items:
> +      - description: Command interface registers
> +      - description: Control interface registers
> +
> +  reg-shift:
> +    enum: [ 1, 2 ]
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ata-generic,use16bit:
> +    type: boolean
> +    description: Use 16-bit accesses instead of 32-bit for data transfers
> +
> +  pio-mode:
> +    description: Maximum ATA PIO transfer mode
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 6
> +    default: 0
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    compact-flash@1a000 {
> +        compatible = "arm,vexpress-cf", "ata-generic";
> +        reg = <0x1a000 0x100>,
> +              <0x1a100 0xf00>;
> +        reg-shift = <2>;
> +    };
> +...

-- 
Damien Le Moal
Western Digital Research

