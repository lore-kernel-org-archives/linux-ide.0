From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] pata_bf54x: fix return type of bfin_set_devctl
Date: Thu, 21 Oct 2010 21:45:10 +0400
Message-ID: <4CC07C26.5090508@mvista.com>
References: <1287648040-19759-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61333 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab0JUTrf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Oct 2010 15:47:35 -0400
Received: by fxm16 with SMTP id 16so484811fxm.19
        for <linux-ide@vger.kernel.org>; Thu, 21 Oct 2010 12:47:34 -0700 (PDT)
In-Reply-To: <1287648040-19759-1-git-send-email-vapier@gentoo.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, uclinux-dist-devel@blackfin.uclinux.org

Hello.

On 21-10-2010 12:00, Mike Frysinger wrote:

> The new devctl func added for us to the driver has the wrong return
> type.  Which is to say there shouldn't be any.  This fixes compile
> time warnings as there shouldn't be any runtime difference.

> Signed-off-by: Mike Frysinger<vapier@gentoo.org>
[...]

> diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
> index 9cae65d..5eeb922 100644
> --- a/drivers/ata/pata_bf54x.c
> +++ b/drivers/ata/pata_bf54x.c
> @@ -826,7 +826,7 @@ static void bfin_dev_select(struct ata_port *ap, unsigned int device)
>    *	@ctl: value to write
>    */
>
> -static u8 bfin_set_devctl(struct ata_port *ap, u8 ctl)
> +static void bfin_set_devctl(struct ata_port *ap, u8 ctl)

    Sorry about that. Don't know how 'u8' crawled in...

MBR, Sergei
