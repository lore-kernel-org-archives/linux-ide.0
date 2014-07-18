From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v10 2/8] Documentation: bindings: add the Berlin SATA
 PHY
Date: Fri, 18 Jul 2014 21:27:28 +0400
Message-ID: <53C95900.9050200@cogentembedded.com>
References: <1405686607-8126-1-git-send-email-antoine.tenart@free-electrons.com> <1405686607-8126-3-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:33138 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932247AbaGRR11 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jul 2014 13:27:27 -0400
Received: by mail-la0-f43.google.com with SMTP id hr17so3085732lab.2
        for <linux-ide@vger.kernel.org>; Fri, 18 Jul 2014 10:27:25 -0700 (PDT)
In-Reply-To: <1405686607-8126-3-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?QW50b2luZSBUw6luYXJ0?= <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, tj@kernel.org, kishon@ti.com
Cc: alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 07/18/2014 04:30 PM, Antoine T=C3=A9nart wrote:

> The Berlin SATA PHY drives the PHY related to the SATA interface. Add
> the corresponding documentation.

> Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.com=
>
> ---
>   .../devicetree/bindings/phy/berlin-sata-phy.txt    | 34 +++++++++++=
+++++++++++
>   1 file changed, 34 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/phy/berlin-sat=
a-phy.txt

> diff --git a/Documentation/devicetree/bindings/phy/berlin-sata-phy.tx=
t b/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt
> new file mode 100644
> index 000000000000..88f8c23384c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt
> @@ -0,0 +1,34 @@
> +Berlin SATA PHY
> +---------------
> +
> +Required properties:
> +- compatible: should be "marvell,berlin2q-sata-phy"
> +- address-cells: should be 1
> +- size-cells: should be 0
> +- phy-cells: from the generic PHY bindings, must be 1

    It's "#address-cells", "#size-cells", and "#phy-cells".

> +- reg: address and length of the register
> +- clocks: reference to the clock entry
> +
> +Sub-nodes:
> +Each PHY should be represented as a sub-node.

    Then "#phy-cells" should also belong to the sub-nodes.

> +
> +Sub-nodes required properties:
> +- reg: the PHY number

WBR, Sergei

