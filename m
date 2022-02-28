Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE48C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 28 Feb 2022 09:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiB1JzI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 28 Feb 2022 04:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbiB1JzG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 28 Feb 2022 04:55:06 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1E41C92D
        for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2022 01:54:28 -0800 (PST)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D15A74031B
        for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2022 09:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646042066;
        bh=mna9J1nBg6HOMnow2P6fMcSmE8VXg1IqnH2FURdKmp0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=KtI8RzRNkh73o6/0HDmpns4ouVwXYqF7A9kzAsJA1QiE2bSPj7Y0VKSeCj75IycZB
         NG6oeor85JLhiFihMpktc4XJMXKAZ50uhVUetUGC54mObySw4VNgmHk0vLXwvVPNqd
         Ug7NWcBBnnSTlWasQegW4QF6heGYPbmtS2B43nJC1bO7aBO5vfnichTF5CRpKgZc/A
         ds7WXGGmY/rKStYU/uMxaUSKBfcdyeoQy0GC71bNRN+EKPmtN8F2rGgjIg+/g+YqaJ
         k5svaAfQMnnmxtUY8AqKeVPuhwcMHo0DLcGtfuhgMdHrYKmPPQbgqBRSRta0KNqk3j
         cah7Qg8HfiD2g==
Received: by mail-wm1-f69.google.com with SMTP id 7-20020a1c1907000000b003471d9bbe8dso3966451wmz.0
        for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2022 01:54:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mna9J1nBg6HOMnow2P6fMcSmE8VXg1IqnH2FURdKmp0=;
        b=1SdQPnuR+qr14EgJdFfi9n0F4mPo+zyqdPpQ77YG1AqJruk9enHvR7Q881UyeDpRBe
         NCqYjhWIDtiNTcnVyk6OPZchjbCJS8PYNGxm1gUJB3x2vkUertCZnowlU+XY54MmcczA
         2T3Z4LE6yoibMv0uHrRgviccOkeVi6dndeQ7g5Ik6GFn740fEuDKP47Qdr2GwgUCBGbR
         TZ4q6oRobfS4rMJeEqF4tvctt+HHSh1E81oWXLhCshGZ7iim9v6AHVzGmssqBrkbIDvp
         CoXeIzZm19HoVhjo4ykuYthU8XDM/4A61aQcgcnvHbTmRBHdXmSe4GZwBiBaCwJfAGdV
         hLhw==
X-Gm-Message-State: AOAM533tQmH17yksaoXxXmS2KThv7JLoGE6ILKika2vRnsbQb4kgeR9s
        JVnotpO73VqCDBkwD7qFtatH7kqRDVy6zDdMs2U4E/10e2Lklib7xMUltKYJDO5FCVnFytLcoiH
        04+fFt4u4Iv6FMzXrRoyFKfAXctMAX1m63pf3Aw==
X-Received: by 2002:a05:6000:162f:b0:1ed:bbef:f7b9 with SMTP id v15-20020a056000162f00b001edbbeff7b9mr15608209wrb.379.1646042064786;
        Mon, 28 Feb 2022 01:54:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwF4VDklq4C5zzM72nwt08X01T/IfVu/GQ6QrQbbkJljUbB9HduFrRm9IjGHQBgzq6rkjLXyQ==
X-Received: by 2002:a05:6000:162f:b0:1ed:bbef:f7b9 with SMTP id v15-20020a056000162f00b001edbbeff7b9mr15608187wrb.379.1646042064370;
        Mon, 28 Feb 2022 01:54:24 -0800 (PST)
Received: from [192.168.0.133] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d598a000000b001efab095615sm4434539wri.29.2022.02.28.01.54.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 01:54:23 -0800 (PST)
Message-ID: <fc3186ce-f731-a7c1-e958-b0071125b32c@canonical.com>
Date:   Mon, 28 Feb 2022 10:54:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: Add sata nodes to rk356x
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        "devicetree @ vger . kernel . org Damien Le Moal" 
        <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>
References: <20220227182800.275572-1-linux@fw-web.de>
 <20220227182800.275572-4-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220227182800.275572-4-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 27/02/2022 19:28, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> RK356x supports up to 3 sata controllers which were compatible with the
> existing snps,dwc-ahci binding.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> changes in v3:
>   - fix combphy error by moving sata0 to rk3568.dtsi
>   - remove clock-names and interrupt-names
> changes in v2:
>   - added sata0 + 1, but have only tested sata2
> ---
>  arch/arm64/boot/dts/rockchip/rk3568.dtsi | 14 +++++++++++++
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 26 ++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> index 5b0f528d6818..2a2f65899d47 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> @@ -8,6 +8,19 @@
>  / {
>  	compatible = "rockchip,rk3568";
>  
> +	sata0: sata@fc000000 {
> +		compatible = "snps,dwc-ahci";
> +		reg = <0 0xfc000000 0 0x1000>;
> +		clocks = <&cru ACLK_SATA0>, <&cru CLK_SATA0_PMALIVE>,
> +			 <&cru CLK_SATA0_RXOOB>;
> +		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
> +		phys = <&combphy0 PHY_TYPE_SATA>;
> +		phy-names = "sata-phy";
> +		ports-implemented = <0x1>;
> +		power-domains = <&power RK3568_PD_PIPE>;
> +		status = "disabled";
> +	};
> +
>  	pipe_phy_grf0: syscon@fdc70000 {
>  		compatible = "rockchip,rk3568-pipe-phy-grf", "syscon";
>  		reg = <0x0 0xfdc70000 0x0 0x1000>;
> @@ -114,3 +127,4 @@ power-domain@RK3568_PD_PIPE {
>  		#power-domain-cells = <0>;
>  	};
>  };
> +

No need for new line here,

> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index 7cdef800cb3c..484c5ace718a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -230,6 +230,32 @@ scmi_shmem: sram@0 {
>  		};
>  	};
>  
> +	sata1: sata@fc400000 {
> +		compatible = "snps,dwc-ahci";
> +		reg = <0 0xfc400000 0 0x1000>;
> +		clocks = <&cru ACLK_SATA1>, <&cru CLK_SATA1_PMALIVE>,
> +			 <&cru CLK_SATA1_RXOOB>;

clock-names should be added. Also to bindings.


Best regards,
Krzysztof
