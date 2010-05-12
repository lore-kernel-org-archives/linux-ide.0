From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [BUG] bug when enabling VM DEBUG
Date: Tue, 11 May 2010 20:41:29 -0600
Message-ID: <4BEA1559.9000107@gmail.com>
References: <AANLkTikkSRI6u_mp6mNQReECB84t3oh-_MPVzAYEQULN@mail.gmail.com> <AANLkTikoNc6oAY5JthYX1jWx1w2KeJ1fGab72Z-OvIVG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47302 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950Ab0ELCle (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 May 2010 22:41:34 -0400
In-Reply-To: <AANLkTikoNc6oAY5JthYX1jWx1w2KeJ1fGab72Z-OvIVG@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, DE/ATA development list <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On 05/11/2010 09:27 AM, saeed bishara wrote:
> Jeff,
> seems that the libata do pio to buffer which was allocated with
> kmalloc, and under arm arch, the flush_dcache_page() is needed to
> prevent cache aliasing, the later function calls the page_mapping
> which falls on PageSlab(page)
>
> as the flush_dcache_page() is needed to prevent aliasing, it can be
> skipped if the page is Slab as such pages are used only by the kernel.
> here a suggested patch:
>
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -894,7 +894,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
>                                         do_write);
>          }
>
> -       if (!do_write)
> +       if (!do_write&&  !PageSlab(page))
>                  flush_dcache_page(page);
>
> saeed

I would think that check belongs inside flush_dcache_page itself, rather 
than forcing every driver to include it..
