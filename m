From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [2.6 patch] SCSI_SATA has to be a tristate
Date: Sat, 9 Jul 2005 01:36:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0507090134040.3743@scrub.home>
References: <20050708214802.GK3671@stusta.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from scrub.xs4all.nl ([194.109.195.176]:33462 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262928AbVGHXjq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jul 2005 19:39:46 -0400
In-Reply-To: <20050708214802.GK3671@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi,

On Fri, 8 Jul 2005, Adrian Bunk wrote:

> --- linux-2.6.13-rc1-mm1/drivers/scsi/Kconfig.old	2005-07-02 21:57:40.000000000 +0200
> +++ linux-2.6.13-rc1-mm1/drivers/scsi/Kconfig	2005-07-02 21:58:06.000000000 +0200
> @@ -447,7 +447,7 @@
>  source "drivers/scsi/megaraid/Kconfig.megaraid"
>  
>  config SCSI_SATA
> -	bool "Serial ATA (SATA) support"
> +	tristate "Serial ATA (SATA) support"
>  	depends on SCSI
>  	help
>  	  This driver family supports Serial ATA host controllers

Did you verify that this works?
Overwise "depends on SCSI=y" might also be correct.

bye, Roman
