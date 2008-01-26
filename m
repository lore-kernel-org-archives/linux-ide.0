From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 13/14] sata_mv No soft resets
Date: Fri, 25 Jan 2008 23:28:14 -0500
Message-ID: <479AB6DE.1020304@pobox.com>
References: <4798FB68.70400@rtr.ca> <4798FD3F.2050807@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57369 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752776AbYAZE2Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Jan 2008 23:28:16 -0500
In-Reply-To: <4798FD3F.2050807@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> sata_mv No soft resets.
> 
> Soft resets rarely have significant effect with these chips,
> so always do a hard reset instead.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> 
> --- old/drivers/ata/sata_mv.c    2008-01-24 14:49:28.000000000 -0500
> +++ new/drivers/ata/sata_mv.c    2008-01-24 14:51:53.000000000 -0500
> @@ -2414,8 +2414,7 @@
> 
> static void mv_error_handler(struct ata_port *ap)
> {
> -    ata_do_eh(ap, mv_prereset, ata_std_softreset,
> -          mv_hardreset, mv_postreset);
> +    ata_do_eh(ap, mv_prereset, NULL, mv_hardreset, mv_postreset);
> }

Can you give a bit more explanation?

In general I agree, but SRST delivery does seem to work as intended from 
a device perspective, so I would like to narrow down the conditions 
where SRST must be avoided


