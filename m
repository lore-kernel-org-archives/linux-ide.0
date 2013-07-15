From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: [v6 1/3] ARM: dtsi: enable ahci sata on imx6q platforms
Date: Mon, 15 Jul 2013 02:13:17 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D33BCFF@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1373622078-18723-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1373622078-18723-2-git-send-email-Hong-Xing.Zhu@freescale.com>
 <51E069D0.7030204@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:38930
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753815Ab3GOCN0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 14 Jul 2013 22:13:26 -0400
In-Reply-To: <51E069D0.7030204@cogentembedded.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Richard Zhu <richard.zhuhongxing@gmail.com>
Cc: "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "tj@kernel.org" <tj@kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi Sergei:
Thanks for your comments.


Best Regards
Richard Zhu


-----Original Message-----
From: Sergei Shtylyov [mailto:sergei.shtylyov@cogentembedded.com] 
Sent: Saturday, July 13, 2013 4:41 AM
To: Richard Zhu
Cc: shawn.guo@linaro.org; linux-arm-kernel@lists.infradead.org; jgarzik@pobox.com; tj@kernel.org; rob.herring@calxeda.com; s.hauer@pengutronix.de; linux-ide@vger.kernel.org; Zhu Richard-R65037
Subject: Re: [v6 1/3] ARM: dtsi: enable ahci sata on imx6q platforms

On 07/12/2013 01:41 PM, Richard Zhu wrote:

> From: Richard Zhu <r65037@freescale.com>

> Only imx6q has the ahci sata controller, enable it on imx6q platforms.

> Signed-off-by: Richard Zhu <r65037@freescale.com>
[...]

> diff --git a/arch/arm/boot/dts/imx6q.dtsi 
> b/arch/arm/boot/dts/imx6q.dtsi index e7dd2c4..93b65d9 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -424,6 +424,15 @@
>   			};
>   		};
>
> +		ahci: ahci@02200000 {

    According to ePAPR [1] section 2.2.2, "the name of the node should be somewhat generic, reflecting the function of the device and not its precise programming model. If appropriate, the name should be one of the following choices:
[...]
- sata;
[...]"

[1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf
[Richard] Ok, ahci would be replaced by sata.

WBR, Sergei



