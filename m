From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] tx4938ide: Fix build error due to read_sff_dma_status
 moving
Date: Sat, 10 Jan 2009 20:25:47 +0300
Message-ID: <4968DA1B.2020702@ru.mvista.com>
References: <1231608019-28679-1-git-send-email-anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:65506 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752638AbZAJRZN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Jan 2009 12:25:13 -0500
In-Reply-To: <1231608019-28679-1-git-send-email-anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Atsushi Nemoto wrote:

> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> diff --git a/drivers/ide/tx4938ide.c b/drivers/ide/tx4938ide.c
> index b4ef218..d909534 100644
> --- a/drivers/ide/tx4938ide.c
> +++ b/drivers/ide/tx4938ide.c
> @@ -202,7 +202,6 @@ static const struct ide_tp_ops tx4938ide_tp_ops = {
>  	.exec_command		= ide_exec_command,
>  	.read_status		= ide_read_status,
>  	.read_altstatus		= ide_read_altstatus,
> -	.read_sff_dma_status	= ide_read_sff_dma_status,
>  
>  	.set_irq		= ide_set_irq,
>  

    Oops. Don;t know how I managed to miss this one...

MBR, Sergei
