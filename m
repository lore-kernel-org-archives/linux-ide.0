Return-Path: <SRS0=nNvH=YY=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33894CA9ECE
	for <linux-ide@archiver.kernel.org>; Thu, 31 Oct 2019 20:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0823320862
	for <linux-ide@archiver.kernel.org>; Thu, 31 Oct 2019 20:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="u0ihDxay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbfJaUmJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 31 Oct 2019 16:42:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37035 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729779AbfJaUmJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 31 Oct 2019 16:42:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id t1so1793829wrv.4
        for <linux-ide@vger.kernel.org>; Thu, 31 Oct 2019 13:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ewVs5CtQ7DC3g05WS9zawrxD8UKXFocxlzIj1rs+CGo=;
        b=u0ihDxayWOgyQVQJ0HnyyQV8MdcVTSlc9z0upUFnL4td3Vz2c+ZDBdgZV+FbOVvTKB
         KyicvBpvnE+gPjSNYOdE42ZCZimvwATHdZ0sREgteu4D1Vy2P/PLH1EujlUy3uU2YH0u
         Ql87qI3xi74tVhTE2Hp4tNZOA4nforHEDVnKL9xidnEv7OBTGuOmJHfp4ki++RQYnJ62
         tA9BsUqpb8FG3LxSLtnA4zsIBkAnANjIV0eO+jIbKTda3Uef/jtfp1arlnLoCUZB+KAJ
         o8N+NHjrKPbc0yHkNaX1jlHHZGT85UoMEFRIt0LymlKx7Xk9kyvCM9LMMFF95+MSZi2i
         2ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ewVs5CtQ7DC3g05WS9zawrxD8UKXFocxlzIj1rs+CGo=;
        b=X8kiA0ZWEh0HvI2m1tQgrF774EOYVXbcf0y/nNK0Ng566iXDJ5lPZ43ba7QT1iOXR5
         H+EjF3JqnbfzmPDrVRCgAQt1/CeDUGCNzjAIX+BivGv4hwEJgJknpBYuu8gJCkd8iOK1
         NMX7hSKEABYi2GLg8TSoTf+deJWjDE8BSnrMcYjb/Tqkgpjszoh8OMaDFb6M9IfrdT1t
         GTG8Kbfj/a1eJznOR6Bpn+2jqr7EVXtMUtzmgMNKkqPgapd/WK6VdJfOHlFENj+RXG/A
         wOUOxw/iLLgT6+o7PN6bT+bmSzZNO7PH9L6Z30HrR2QKywc0reFKufL/vbW0fPwMdrwx
         peDg==
X-Gm-Message-State: APjAAAXBkYnpusADmmAqrGi/veuG5IoS/bK8FNBcDKIlmXbQXdcYl+Yn
        Hv7AqYiEovEZqMhau5UBaD6ylg==
X-Google-Smtp-Source: APXvYqytoC1inlbhKyAShJk2vZ4/FrApDyUfeDB8ENq8oN9Tzf1PWk1mBfwKPUqV/Nn6LHUv3NjgQg==
X-Received: by 2002:adf:9044:: with SMTP id h62mr7744773wrh.91.1572554525976;
        Thu, 31 Oct 2019 13:42:05 -0700 (PDT)
Received: from netronome.com (fred-musen.rivierenbuurt.horms.nl. [2001:470:7eb3:404:a2a4:c5ff:fe4c:9ce9])
        by smtp.gmail.com with ESMTPSA id l4sm7047929wrf.46.2019.10.31.13.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 13:42:05 -0700 (PDT)
Date:   Thu, 31 Oct 2019 21:42:03 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, davem@davemloft.net,
        robh+dt@kernel.org, mark.rutland@arm.com, axboe@kernel.dk,
        peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, bhelgaas@google.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: net: document loongson.pci-gmac
Message-ID: <20191031204202.GB30739@netronome.com>
References: <20191030135347.3636-1-jiaxun.yang@flygoat.com>
 <20191030135347.3636-5-jiaxun.yang@flygoat.com>
 <20191031083509.GA30739@netronome.com>
 <a93eedb9-8863-3802-a563-fe4955d846c3@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a93eedb9-8863-3802-a563-fe4955d846c3@flygoat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, Oct 31, 2019 at 06:57:16PM +0800, Jiaxun Yang wrote:
> 
> 在 2019/10/31 下午4:35, Simon Horman 写道:
> > Hi Jiaxun,
> > 
> > thanks for your patch.
> > 
> > On Wed, Oct 30, 2019 at 09:53:46PM +0800, Jiaxun Yang wrote:
> > > This binding will provide extra information for PCI enabled
> > > device.
> > > 
> > > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Please verify the bindings using dtbs_check as described in
> > Documentation/devicetree/writing-schema.rst
> > 
> > > ---
> > >   .../net/wireless/loongson,pci-gmac.yaml       | 71 +++++++++++++++++++
> > >   1 file changed, 71 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/net/wireless/loongson,pci-gmac.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/net/wireless/loongson,pci-gmac.yaml b/Documentation/devicetree/bindings/net/wireless/loongson,pci-gmac.yaml
> > > new file mode 100644
> > > index 000000000000..5f764bd46735
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/net/wireless/loongson,pci-gmac.yaml
> > > @@ -0,0 +1,71 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/net/allwinner,sun7i-a20-gmac.yaml#
> > The id does not match the filename of the schema.
> > 
> > i.e. the above should be:
> > 
> > 	$id: http://devicetree.org/schemas/net/wireless/loongson,pci-gmac.yaml#
> > 
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Loongson PCI GMAC Device Tree Bindings
> > > +
> > > +allOf:
> > > +  - $ref: "snps,dwmac.yaml#"
> > snps,dwmac.yaml# is in the parent directory relative to loongson,pci-gmac.yaml.
> > So I think the above needs to be:
> > 
> > 	$ref: "../snps,dwmac.yaml#"
> > 
> > > +
> > > +maintainers:
> > > +  - Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: loongson,pci-gmac
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    minItems: 1
> > > +    maxItems: 3
> > > +    items:
> > > +      - description: Combined signal for various interrupt events
> > > +      - description: The interrupt to manage the remote wake-up packet detection
> > > +      - description: The interrupt that occurs when Rx exits the LPI state
> > > +
> > > +  interrupt-names:
> > > +    minItems: 1
> > > +    maxItems: 3
> > > +    items:
> > > +      - const: macirq
> > > +      - const: eth_wake_irq
> > > +      - const: eth_lpi
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: GMAC main clock
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: stmmaceth
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - interrupts
> > > +  - interrupt-names
> > > +  - clocks
> > > +  - clock-names
> > > +  - phy-mode
> > > +
> > > +examples:
> > > +  - |
> > > +    gmac: ethernet@ {
> > I would have expected a bus address here, f.e.:
> > 
> > 	gmac: ethernet@0x00001800
> > 
> > > +        compatible = "loongson,pci-irq";
> > > +        reg = <0x00001800 0 0 0 0>;
> > I think there is one to many cell in the above, perhaps it should be.
> > 
> > 	reg = <0x00001800 0 0 0>;
> > 
> > Also, I would expect the registers to be wider than 0, i.e. no registers.
> 
> Hi Simon,
> 
> Thanks for your suggestions above, will fix in v1.
> 
> Here, the reg domain is a standard 5-cell representing a PCI device,
> 
> See: Documentation/devicetree/bindings/pci/pci.txt and IEEE Std 1275-1994,<https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/pci/pci.txt>
> 
> Should I add some description?

Thanks, sorry for missing that.
As that is the case I think you need something like the following
as an example that compiles.

examples:
  - |
    pcie@0 {
        reg = <0 0 0 0>;
        #size-cells = <2>;
        #address-cells = <3>;
        ranges = <0 0 0 0 0 0>;
        device_type = "pci";

        gmac: ethernet@1800 {
            compatible = "loongson,pci-irq";
            reg = <0x00001800 0 0 0 0>;
            interrupts = <12>, <13>;
            interrupt-names = "macirq", "eth_lpi";
            clocks =  <&clk_pch_gmac>;
            clock-names = "stmmaceth";
            phy-mode = "rgmii";
        };
    };





