From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 17/21] ide: drop 'initializing' argument from ide_register_hw()
Date: Thu, 13 Dec 2007 16:02:24 +0300
Message-ID: <47612D60.4050408@ru.mvista.com>
References: <200711182331.23988.bzolnier@gmail.com> <475ED463.5050607@ru.mvista.com> <200712122236.46043.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:29045 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754978AbXLMNCF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Dec 2007 08:02:05 -0500
In-Reply-To: <200712122236.46043.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>

Bartlomiej Zolnierkiewicz wrote:

>>>* Rename init_hwif_data() to ide_init_port_data() and export it.

>>>* For all users of ide_register_hw() with 'initializing' argument set
>>>  hwif->present and hwif->hold are always zero so convert these host
>>>  drivers to use ide_find_port()+ide_init_port_data()+ide_init_port_hw()
>>>  instead (also no need for init_hwif_default() call since the setup
>>>  done by it gets over-ridden by ide_init_port_data() call).

>>    But init_hwif_default() gets called *after* ide_init_port_data() call, at 
>>least in ide_register_hw()...

> This is a mistake in the patch description:

> s/ide_init_port_data/ide_init_port_hw/

> [ I fixed it locally ]

>>>* Drop 'initializing' argument from ide_register_hw().

>>>Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

>>>Index: b/drivers/ide/ide.c
>>>===================================================================
>>>--- a/drivers/ide/ide.c
>>>+++ b/drivers/ide/ide.c
>>>@@ -116,7 +116,7 @@ EXPORT_SYMBOL(ide_hwifs);
>>> /*
>>>  * Do not even *think* about calling this!
>>>  */

>>    Isn't this comment being obsoleted by the patch?

> It is still valid because ide_init_port_data() destroys
> "hdx=" and "idex=" kernel parameters...

    But the drivers are now calling it nevertheless...

> Thanks,
> Bart

MBR, Sergei
