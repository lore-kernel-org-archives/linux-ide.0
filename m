From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/5] ide-generic: use ide_find_port()
Date: Tue, 19 Feb 2008 15:33:00 +0300
Message-ID: <47BACC7C.6030305@ru.mvista.com>
References: <20080217185105.16210.26582.sendpatchset@localhost.localdomain> <20080217185133.16210.73293.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:4257 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751773AbYBSMb7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Feb 2008 07:31:59 -0500
In-Reply-To: <20080217185133.16210.73293.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> There should be no functional changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/drivers/ide/ide-generic.c
> ===================================================================
> --- a/drivers/ide/ide-generic.c
> +++ b/drivers/ide/ide-generic.c
> @@ -90,18 +90,27 @@ static int __init ide_generic_init(void)
>  	int i;
>  
>  	for (i = 0; i < MAX_HWIFS; i++) {
> -		ide_hwif_t *hwif = &ide_hwifs[i];
> +		ide_hwif_t *hwif;
>  		unsigned long io_addr = ide_default_io_base(i);
>  		hw_regs_t hw;
>  
> -		if (hwif->chipset == ide_unknown && io_addr) {
> -			u8 oldnoprobe = hwif->noprobe;
> +		if (io_addr) {
> +			u8 oldnoprobe;
> +
> +			/*
> +			 * Skip probing if the corresponding
> +			 * slot entry is already occupied.

    IMHO, it's either "slot" or "entry", else it sounds superfluous. :-)

MBR, Sergei
