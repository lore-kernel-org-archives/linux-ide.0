From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pata_cmd64x: Correct the speed ranges
Date: Thu, 26 Jul 2007 21:52:20 +0400
Message-ID: <46A8DF54.9040201@ru.mvista.com>
References: <20070726184301.4677ee46@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:36139 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761238AbXGZRuT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jul 2007 13:50:19 -0400
In-Reply-To: <20070726184301.4677ee46@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

Hello.

Alan Cox wrote:

> I must have been half asleep when doing the original code

> Signed-off-by: Alan Cox <alan@redhat.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc1-mm1/drivers/ata/pata_cmd64x.c linux-2.6.23rc1-mm1/drivers/ata/pata_cmd64x.c
> --- linux.vanilla-2.6.23rc1-mm1/drivers/ata/pata_cmd64x.c	2007-07-26 15:01:52.915752536 +0100
> +++ linux-2.6.23rc1-mm1/drivers/ata/pata_cmd64x.c	2007-07-26 15:18:38.486882488 +0100
[...]
> @@ -397,7 +397,7 @@
>  			.flags = ATA_FLAG_SLAVE_POSS,
>  			.pio_mask = 0x1f,
>  			.mwdma_mask = 0x07,

    Note that MWDMA programming is still borken in the libata driver (fixed 
now in the IDE driver).

> -			.udma_mask = ATA_UDMA1,
> +			.udma_mask = ATA_UDMA2,
>  			.port_ops = &cmd64x_port_ops
>  		},
>  		{	/* CMD 646 rev 1  */

MBR, Sergei
