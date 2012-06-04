From: Ryan Mallon <rmallon@gmail.com>
Subject: Re: [PATCH v3 3/3] ep93xx: Add IDE support to edb93xx boards
Date: Mon, 04 Jun 2012 15:01:52 +1000
Message-ID: <4FCC4140.6000500@gmail.com>
References: <4F86C63C.6030908@metasoft.pl> <4F86C753.3020200@metasoft.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39366 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab2FDFB6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jun 2012 01:01:58 -0400
Received: by dady13 with SMTP id y13so5324611dad.19
        for <linux-ide@vger.kernel.org>; Sun, 03 Jun 2012 22:01:57 -0700 (PDT)
In-Reply-To: <4F86C753.3020200@metasoft.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rafal Prylowski <prylowski@metasoft.pl>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "bzolnier@gmail.com" <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@mvista.com>, hsweeten@visionengravers.com, "joao.ramos@inov.pt" <joao.ramos@inov.pt>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 12/04/12 22:15, Rafal Prylowski wrote:

> 
> Add IDE support to edb93xx boards.
> 
> Signed-off-by: Rafal Prylowski <prylowski@metasoft.pl>
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>

Applied to ep93xx-devel. Sorry for the delay. Note, I fixed a minor
build error, see below.

~Ryan

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


  machine_is_edb9315()

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
>  
>  
> 


