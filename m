From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/21] ide: move CONFIG_IDE_ETRAX to drivers/ide/Kconfig
Date: Mon, 19 Nov 2007 22:04:19 +0300
Message-ID: <4741DE33.3000904@ru.mvista.com>
References: <200711182317.04300.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:30249 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751313AbXKSTEF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2007 14:04:05 -0500
In-Reply-To: <200711182317.04300.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Mikael Starvik <starvik@axis.com>

Bartlomiej Zolnierkiewicz wrote:

> * Move ETRAX_IDE and friends from arch/cris/arch-{v10,v32}/drivers/Kconfig
>   to drivers/ide/Kconfig.

> * Don't force selecting ide-disk and ide-cd device drivers
>   (please handle this through defconfig if necessary).

> * Make ETRAX_IDE depend on BROKEN for the time being
>   (it doesn't even compile currently).

> Cc: Mikael Starvik <starvik@axis.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> Index: b/drivers/ide/Kconfig
> ===================================================================
> --- a/drivers/ide/Kconfig
> +++ b/drivers/ide/Kconfig
> @@ -870,6 +870,41 @@ config BLK_DEV_IDE_BAST
>  	  Say Y here if you want to support the onboard IDE channels on the
>  	  Simtec BAST or the Thorcom VR1000
>  
> +config ETRAX_IDE
> +	bool "ETRAX IDE support"
> +	depends on CRIS && BROKEN
> +	select BLK_DEV_IDEDMA

    Shouldn't it be the other way around, i.e. BLK_DEV_IDEDMA is enabled by 
ETRAX_IDE as is the case with this option otherwise?

MBR, Sergei
