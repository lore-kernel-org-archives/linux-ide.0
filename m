From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH v2 3/3] ep93xx: Add IDE support to edb93xx boards
Date: Tue, 3 Apr 2012 12:44:16 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F0020698409DFA@AUSP01VMBX24.collaborationhost.net>
References: <4F7B0C54.8010804@metasoft.pl> <4F7B0DA5.6080703@metasoft.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail131.messagelabs.com ([216.82.242.99]:65123 "EHLO
	mail131.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046Ab2DCRo3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Apr 2012 13:44:29 -0400
In-Reply-To: <4F7B0DA5.6080703@metasoft.pl>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rafal Prylowski <prylowski@metasoft.pl>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "joao.ramos@inov.pt" <joao.ramos@inov.pt>, "rmallon@gmail.com" <rmallon@gmail.com>, Sergei Shtylyov <sshtylyov@mvista.com>, "bzolnier@gmail.com" <bzolnier@gmail.com>

On Tuesday, April 03, 2012 7:48 AM, Rafal Prylowski wrote:
>
> Signed-off-by: Rafal Prylowski <prylowski@metasoft.pl>
> Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>

Again, there should probably be a commit blurb here.

> ---
>  arch/arm/mach-ep93xx/edb93xx.c |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> Index: linux-2.6/arch/arm/mach-ep93xx/edb93xx.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-ep93xx/edb93xx.c
> +++ linux-2.6/arch/arm/mach-ep93xx/edb93xx.c
> @@ -233,6 +233,29 @@ static void __init edb93xx_register_fb(v
>  }
>  
>  

The extra whitespace line here and below is not needed... But, it exists in
other places in this file so it's fine.

> +/*************************************************************************
> + * EDB93xx IDE
> + *************************************************************************/
> +static int __init edb93xx_has_ide(void)
> +{
> +	/*
> +	 * Although EDB9312 and EDB9315 do have IDE capability, they have
> +	 * INTRQ line wired as pull-up, which makes using IDE interface
> +	 * problematic.
> +	 */
> +	return machine_is_edb9312() || machine_is_edb9315 ||
> +	       machine_is_edb9315a();
> +}
> +
> +static void __init edb93xx_register_ide(void)
> +{
> +	if (!edb93xx_has_ide())
> +		return;
> +
> +	ep93xx_register_ide();
> +}
> +
> +
>  static void __init edb93xx_init_machine(void)
>  {
>  	ep93xx_init_devices();
> @@ -243,6 +266,7 @@ static void __init edb93xx_init_machine(
>  	edb93xx_register_i2s();
>  	edb93xx_register_pwm();
>  	edb93xx_register_fb();
> +	edb93xx_register_ide();
>  }

Looks good. Thanks!
 
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
 
