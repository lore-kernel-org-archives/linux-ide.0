Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BB3C3E8C5
	for <linux-ide@archiver.kernel.org>; Sun, 29 Nov 2020 11:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75AFA206CA
	for <linux-ide@archiver.kernel.org>; Sun, 29 Nov 2020 11:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgK2L0S (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 29 Nov 2020 06:26:18 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57865 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgK2L0R (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 29 Nov 2020 06:26:17 -0500
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id B0F8460003;
        Sun, 29 Nov 2020 11:25:31 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     sven.auhagen@voleatech.de, axboe@kernel.dk, hdegoede@redhat.com,
        robh+dt@kernel.org, tglx@linutronix.de, maz@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: Re: [PATCH v3 9/9] arm64: dts: marvell: armada-cp110: Switch to
 per-port SATA interrupts
In-Reply-To: <20201109173948.96663-10-sven.auhagen@voleatech.de>
References: <20201109173948.96663-1-sven.auhagen@voleatech.de>
 <20201109173948.96663-10-sven.auhagen@voleatech.de>
Date:   Sun, 29 Nov 2020 12:25:31 +0100
Message-ID: <87pn3wjtg4.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Sven,

> From: Sven Auhagen <sven.auhagen@voleatech.de>
>
> There are two SATA ports per CP110. Each of them has a dedicated
> interrupt. Describe the real hardware by adding two SATA ports to the
> CP110 SATA node.
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> index 9dcf16beabf5..ec27294f097b 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> @@ -300,11 +300,9 @@
>  		};
>  
>  		CP11X_LABEL(sata0): sata@540000 {
> -			compatible = "marvell,armada-8k-ahci",
> -			"generic-ahci";
> +			compatible = "marvell,armada-8k-ahci";
>  			reg = <0x540000 0x30000>;
>  			dma-coherent;
> -			interrupts = <107 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&CP11X_LABEL(clk) 1 15>,
>  				 <&CP11X_LABEL(clk) 1 16>;
>  			#address-cells = <1>;
> @@ -312,10 +310,12 @@
>  			status = "disabled";
>  
>  			sata-port@0 {
> +				interrupts = <109 IRQ_TYPE_LEVEL_HIGH>;
>  				reg = <0>;
>  			};
>  
>  			sata-port@1 {
> +				interrupts = <107 IRQ_TYPE_LEVEL_HIGH>;
>  				reg = <1>;
>  			};
>  		};
> -- 
> 2.20.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
