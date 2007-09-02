From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/4] hpt366: MWDMA filter for SATA cards
Date: Mon, 03 Sep 2007 00:25:52 +0400
Message-ID: <46DB1C50.2020205@ru.mvista.com>
References: <200709030019.22732.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:54548 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750816AbXIBUXF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Sep 2007 16:23:05 -0400
In-Reply-To: <200709030019.22732.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, I wrote:

    The patch was 4/4 of course. :-<
     Probably I was too esctatic about the code. ;-)

> The Marvell bridge chips used on HighPoint SATA cards do not seem to support
> the MWDMA modes (at least that caould be seen in their so-called drivers :-),
> so the driver needs to account for this -- to achieve this:

> - add mdma_filter() method from the original patch by Bartlomiej Zolnierkewicz
>   with his consent, also adding the method callout to ide_rate_filter();

> - installed the method for all chips to only return empty mask if a SATA drive
>   is detected onHPT372{AN]/374 chips...

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> ---
> This patch against the current Linus' tree and unfortunately I was able to only
> compile test it since that tree gives MODPOST warning and dies early on bootup.
> Will hopefully try to test if/when I have time... :-)

> Index: linux-2.6/drivers/ide/pci/hpt366.c
> ===================================================================
> --- linux-2.6.orig/drivers/ide/pci/hpt366.c
> +++ linux-2.6/drivers/ide/pci/hpt366.c
> @@ -1,5 +1,5 @@
>  /*
> - * linux/drivers/ide/pci/hpt366.c		Version 1.12	Aug 25, 2007
> + * linux/drivers/ide/pci/hpt366.c		Version 1.13	Aug 22, 2007

    Errr... and version shuold Aug 02 -- thought I've fixed that. :-/

MBR, Sergei
