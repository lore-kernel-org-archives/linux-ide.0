From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 3/4] ARM: dts: dm8168-evm: add SATA node
Date: Tue, 14 Mar 2017 12:00:52 +0300
Message-ID: <27f977e7-fbd7-8136-5420-f93875a5582b@cogentembedded.com>
References: <1489423399-3824-1-git-send-email-bgolaszewski@baylibre.com>
 <1489423399-3824-4-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34440 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdCNJAz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Mar 2017 05:00:55 -0400
Received: by mail-lf0-f48.google.com with SMTP id z15so51545492lfd.1
        for <linux-ide@vger.kernel.org>; Tue, 14 Mar 2017 02:00:54 -0700 (PDT)
In-Reply-To: <1489423399-3824-4-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Neil Armstrong <narmstrong@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On 3/13/2017 7:43 PM, Bartosz Golaszewski wrote:

> Add the SATA controller node to the dm8168-evm device tree.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
[...]
> diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
> index 276211e..6131081 100644
> --- a/arch/arm/boot/dts/dm816x.dtsi
> +++ b/arch/arm/boot/dts/dm816x.dtsi
> @@ -293,6 +293,13 @@
>  			phy-handle = <&phy1>;
>  		};
>
> +		sata: sata@4a140000 {
> +			compatible = "ti,dm816-ahci";
> +			reg = <0x4a140000 0xffff>;

    Again, 0x10000 for the size.

[...]

MBR, Sergei

