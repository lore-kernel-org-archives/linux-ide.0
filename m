From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ide: make CONFIG_IDE_GENERIC default to N
Date: Sat, 28 Jul 2007 14:06:38 -0400
Message-ID: <46AB85AE.8070105@garzik.org>
References: <469E2F81.8080002@alcatel-lucent.com> <46A661C9.4010900@alcatel-lucent.com> <46A8393E.4040603@gmail.com> <200707262111.35691.bzolnier@gmail.com> <46A97014.9030608@gmail.com> <46A9E797.5010708@garzik.org> <46AAF193.1050203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36682 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752709AbXG1SGs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Jul 2007 14:06:48 -0400
In-Reply-To: <46AAF193.1050203@gmail.com>
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
> Aye, aye.
> 
>  drivers/ide/Kconfig |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
> index b1a9b81..0a801c6 100644
> --- a/drivers/ide/Kconfig
> +++ b/drivers/ide/Kconfig
> @@ -304,9 +304,8 @@ comment "IDE chipset support/bugfixes"
>  
>  config IDE_GENERIC
>  	tristate "generic/default IDE chipset support"
> -	default y
>  	help
> -	  If unsure, say Y.
> +	  If unsure, say N.

ACK


