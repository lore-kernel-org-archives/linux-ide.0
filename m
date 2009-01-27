From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/5] pata-rb532-cf: remove set_irq_type from finish_io
Date: Tue, 27 Jan 2009 02:13:35 -0500
Message-ID: <497EB41F.1070202@garzik.org>
References: <20081128194607.93677386B1A7@mail.ifyouseekate.net> <1232469660-22335-1-git-send-email-n0-1@freewrt.org> <20090120164253.C5D59400E106@mail.nwl.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59783 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750AbZA0HNl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jan 2009 02:13:41 -0500
In-Reply-To: <20090120164253.C5D59400E106@mail.nwl.cc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Sutter <n0-1@freewrt.org>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com, florian@openwrt.org

Phil Sutter wrote:
> The driver has been tested without the call to set_irq_type at this
> point and occurs to work fine, so it should be safe to remove it.
> 
> Signed-off-by: Phil Sutter <n0-1@freewrt.org>
> ---
>  drivers/ata/pata_rb532_cf.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
> index 362af11..cd2eecd 100644
> --- a/drivers/ata/pata_rb532_cf.c
> +++ b/drivers/ata/pata_rb532_cf.c
> @@ -63,8 +63,6 @@ static inline void rb532_pata_finish_io(struct ata_port *ap)
>  	   ata_sff_sync might be sufficient. */
>  	ata_sff_dma_pause(ap);
>  	ndelay(RB500_CF_IO_DELAY);
> -
> -	set_irq_type(info->irq, IRQ_TYPE_LEVEL_HIGH);

applied


