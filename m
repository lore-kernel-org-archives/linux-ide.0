From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [v6 1/3] ARM: dtsi: enable ahci sata on imx6q platforms
Date: Sat, 13 Jul 2013 00:40:48 +0400
Message-ID: <51E069D0.7030204@cogentembedded.com>
References: <1373622078-18723-1-git-send-email-Hong-Xing.Zhu@freescale.com> <1373622078-18723-2-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:47747 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965331Ab3GLUkw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jul 2013 16:40:52 -0400
Received: by mail-la0-f48.google.com with SMTP id lx15so8086800lab.35
        for <linux-ide@vger.kernel.org>; Fri, 12 Jul 2013 13:40:50 -0700 (PDT)
In-Reply-To: <1373622078-18723-2-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhuhongxing@gmail.com>
Cc: shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, tj@kernel.org, rob.herring@calxeda.com, s.hauer@pengutronix.de, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

On 07/12/2013 01:41 PM, Richard Zhu wrote:

> From: Richard Zhu <r65037@freescale.com>

> Only imx6q has the ahci sata controller, enable
> it on imx6q platforms.

> Signed-off-by: Richard Zhu <r65037@freescale.com>
[...]

> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index e7dd2c4..93b65d9 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -424,6 +424,15 @@
>   			};
>   		};
>
> +		ahci: ahci@02200000 {

    According to ePAPR [1] section 2.2.2, "the name of the node should 
be somewhat generic, reflecting the function of the device and not its
precise programming model. If appropriate, the name should be one of the 
following choices:
[...]
- sata;
[...]"

[1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

WBR, Sergei

