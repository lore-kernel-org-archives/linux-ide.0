From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH 05/07] sata_mv: mv_fill_sg fixes
Date: Sun, 1 Feb 2009 12:55:08 -0800
Message-ID: <da824cf30902011255s52878598v5f1e98746865bcab@mail.gmail.com>
References: <49839107.2040603@rtr.ca> <4983915F.7090705@rtr.ca>
	 <498391A7.1090209@rtr.ca> <498391D9.2000403@rtr.ca>
	 <49839209.9010602@rtr.ca> <49839256.7090402@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:51897 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919AbZBAUzR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Feb 2009 15:55:17 -0500
Received: from spaceape7.eur.corp.google.com (spaceape7.eur.corp.google.com [172.28.16.141])
	by smtp-out.google.com with ESMTP id n11KtDjw000838
	for <linux-ide@vger.kernel.org>; Sun, 1 Feb 2009 12:55:14 -0800
Received: from wf-out-1314.google.com (wfc25.prod.google.com [10.142.3.25])
	by spaceape7.eur.corp.google.com with ESMTP id n11Kt95Y000685
	for <linux-ide@vger.kernel.org>; Sun, 1 Feb 2009 12:55:09 -0800
Received: by wf-out-1314.google.com with SMTP id 25so1231723wfc.6
        for <linux-ide@vger.kernel.org>; Sun, 01 Feb 2009 12:55:08 -0800 (PST)
In-Reply-To: <49839256.7090402@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Fri, Jan 30, 2009 at 3:50 PM, Mark Lord <liml@rtr.ca> wrote:
> Fix mv_fill_sg() to zero out the reserved word (required for ATAPI),
> and to include a memory barrier.  This may also help with problems
> reported by Jens on the PPC platform.
>
> Signed-off-by: Mark Lord <mlord@pobox.com>
>
> --- old/drivers/ata/sata_mv.c   2009-01-30 18:31:03.000000000 -0500
> +++ linux/drivers/ata/sata_mv.c 2009-01-30 18:32:08.000000000 -0500
> @@ -1364,12 +1364,13 @@
>                        u32 offset = addr & 0xffff;
>                        u32 len = sg_len;
>
> -                       if ((offset + sg_len > 0x10000))
> +                       if ((offset + len > 0x10000))

Why the double parens?

>                                len = 0x10000 - offset;
>
>                        mv_sg->addr = cpu_to_le32(addr & 0xffffffff);
>                        mv_sg->addr_hi = cpu_to_le32((addr >> 16) >> 16);
>                        mv_sg->flags_size = cpu_to_le32(len & 0xffff);
> +                       mv_sg->reserved = 0;
>
>                        sg_len -= len;
>                        addr += len;
> @@ -1381,6 +1382,7 @@
>
>        if (likely(last_sg))
>                last_sg->flags_size |= cpu_to_le32(EPRD_FLAG_END_OF_TBL);
> +       mb(); /* ensure data structure is visible to the chipset */

It's not obvious to me what you are racing against here.
Normally the mb() is to prevent the above store from getting executed
*after* some MMIO read or write that would tell the chip to read the
flags_size field (or anything recently stored in that data structure).

I guess I'm asking for the comment to indicate which MMIO write it's
racing with.

thanks,
grant

> }
>
> static void mv_crqb_pack_cmd(__le16 *cmdw, u8 data, u8 addr, unsigned last)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
