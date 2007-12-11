From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 17/21] ide: drop 'initializing' argument from ide_register_hw()
Date: Tue, 11 Dec 2007 21:18:11 +0300
Message-ID: <475ED463.5050607@ru.mvista.com>
References: <200711182331.23988.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:64845 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750905AbXLKSRw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Dec 2007 13:17:52 -0500
In-Reply-To: <200711182331.23988.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>

Bartlomiej Zolnierkiewicz wrote:

> * Rename init_hwif_data() to ide_init_port_data() and export it.

> * For all users of ide_register_hw() with 'initializing' argument set
>   hwif->present and hwif->hold are always zero so convert these host
>   drivers to use ide_find_port()+ide_init_port_data()+ide_init_port_hw()
>   instead (also no need for init_hwif_default() call since the setup
>   done by it gets over-ridden by ide_init_port_data() call).

    But init_hwif_default() gets called *after* ide_init_port_data() call, at 
least in ide_register_hw()...

> * Drop 'initializing' argument from ide_register_hw().

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> Index: b/drivers/ide/ide.c
> ===================================================================
> --- a/drivers/ide/ide.c
> +++ b/drivers/ide/ide.c
> @@ -116,7 +116,7 @@ EXPORT_SYMBOL(ide_hwifs);
>  /*
>   * Do not even *think* about calling this!
>   */

    Isn't this comment being obsoleted by the patch?

MBR, Sergei
