From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_mv: add RocketRaid 1720 PCI ID to driver
Date: Fri, 05 Sep 2008 09:32:07 -0400
Message-ID: <48C134D7.9040903@rtr.ca>
References: <48C05E4E.6090407@rtr.ca> <48C05F53.2020709@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:45572 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752888AbYIENcK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Sep 2008 09:32:10 -0400
In-Reply-To: <48C05F53.2020709@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>
Cc: Petr Jelen <petr.jelen@gmail.com>

Mark Lord wrote:
> Add PCI ID for RocketRAID 1720 to sata_mv.
> 
> Signed-off-by: Petr Jelen <petr.jelen@gmail.com>
> Signed-off-by: Mark Lord <mlord@pobox.com>
> ---
> Resending, with fixed whitespace and a colon on the subject line.  :)
> This is for 2.6.27.  Pretty harmless.
> 
> --- linux-2.6.27-rc4/drivers/ata/sata_mv.c    2008-08-29 
> 21:35:45.000000000 +0200
> +++ linux/drivers/ata/sata_mv.c    2008-08-29 21:36:38.000000000 +0200
> @@ -667,7 +667,8 @@
>     { PCI_VDEVICE(MARVELL, 0x5041), chip_504x },
>     { PCI_VDEVICE(MARVELL, 0x5080), chip_5080 },
>     { PCI_VDEVICE(MARVELL, 0x5081), chip_508x },
> -    /* RocketRAID 1740/174x have different identifiers */
> +    /* RocketRAID 1720/174x have different identifiers */
> +    { PCI_VDEVICE(TTI, 0x1720), chip_6042 },
>     { PCI_VDEVICE(TTI, 0x1740), chip_508x },
>     { PCI_VDEVICE(TTI, 0x1742), chip_508x },
> 
..

Jeff, this is a patch that failed to be picked  up during the 2.6.26 cycle,
so can we please get it into 2.6.27 now?

Even Linus says this kind of trivial driver stuff is okay during -rc:

  Principal Penguin wrote:
  >  - but as a special case, we relax that for totally new drivers (and that 
  >    includes things like just adding a new PCI or USB ID's to old drivers), 
  >    because (a) it can't really regress and (b) support for a specific 
  >    piece of hardware can often be critical.

Thanks
