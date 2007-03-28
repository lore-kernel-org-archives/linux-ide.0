From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH pata-2.6] sl82c105: rework PIO support (take 2)
Date: Wed, 28 Mar 2007 22:06:29 +0400
Message-ID: <460AAEA5.40008@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com> <200703282147.41696.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:10780 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965578AbXC1SFt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Mar 2007 14:05:49 -0400
In-Reply-To: <200703282147.41696.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

Hello, I wrote:

> Index: linux-2.6/include/linux/ide.h
> ===================================================================
> --- linux-2.6.orig/include/linux/ide.h
> +++ linux-2.6/include/linux/ide.h
> @@ -613,7 +613,6 @@ typedef struct ide_drive_s {
>  
>          u8	quirk_list;	/* considered quirky, set for a specific host */
>          u8	init_speed;	/* transfer rate set at boot */
> -        u8	pio_speed;      /* unused by core, used by some drivers for fallback from DMA */
>          u8	current_speed;	/* current transfer rate set */
>          u8	dn;		/* now wide spread use */
>          u8	wcache;		/* status of write cache */

    Oops, forgot to pull the recent kernel before sending out, so this part 
won't apply bacause of the desired_speed nuisance. Do I need to resend?

MBR, Sergei
