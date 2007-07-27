From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ide: make CONFIG_IDE_GENERIC default to N
Date: Fri, 27 Jul 2007 08:39:51 -0400
Message-ID: <46A9E797.5010708@garzik.org>
References: <469E2F81.8080002@alcatel-lucent.com> <46A661C9.4010900@alcatel-lucent.com> <46A8393E.4040603@gmail.com> <200707262111.35691.bzolnier@gmail.com> <46A97014.9030608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57137 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756285AbXG0Mj6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Jul 2007 08:39:58 -0400
In-Reply-To: <46A97014.9030608@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, "P.C.Chan" <pc.chan@alcatel-lucent.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> These days, CONFIG_IDE_GENERIC causes more confusion and
> misconfiguration than it helps.  Especially so because libata is
> linked after the generic driver.  Default to N.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ide/Kconfig |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
> index b1a9b81..8113909 100644
> --- a/drivers/ide/Kconfig
> +++ b/drivers/ide/Kconfig
> @@ -304,9 +304,9 @@ comment "IDE chipset support/bugfixes"
>  
>  config IDE_GENERIC
>  	tristate "generic/default IDE chipset support"
> -	default y
> +	default n
>  	help
> -	  If unsure, say Y.
> +	  If unsure, say N.

I don't know if we want to get this nit-picky, but you could probably 
just delete the "default y" line for the same effect.

	Jeff



