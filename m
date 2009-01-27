From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/5] pata-rb532-cf: replace rb532_pata_finish_io()
Date: Tue, 27 Jan 2009 02:14:00 -0500
Message-ID: <497EB438.5070807@garzik.org>
References: <20081128194607.93677386B1A7@mail.ifyouseekate.net> <1232469660-22335-1-git-send-email-n0-1@freewrt.org> <1232469660-22335-2-git-send-email-n0-1@freewrt.org> <20090120164259.54630400E125@mail.nwl.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59793 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752794AbZA0HOD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jan 2009 02:14:03 -0500
In-Reply-To: <20090120164259.54630400E125@mail.nwl.cc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Sutter <n0-1@freewrt.org>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com, florian@openwrt.org

Phil Sutter wrote:
> Since the delay used internally is just the same as ata_sff_pause()
> uses, rb532_pata_finish_io() does exactly the same as ata_sff_pause()
> and thus can be replaced by the later one.
> 
> Signed-off-by: Phil Sutter <n0-1@freewrt.org>
> ---
>  drivers/ata/pata_rb532_cf.c |   15 ++-------------
>  1 files changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
> index cd2eecd..9305eee 100644
> --- a/drivers/ata/pata_rb532_cf.c
> +++ b/drivers/ata/pata_rb532_cf.c
> @@ -54,22 +54,11 @@ struct rb532_cf_info {
>  
>  /* ------------------------------------------------------------------------ */
>  
> -static inline void rb532_pata_finish_io(struct ata_port *ap)
> -{
> -	struct ata_host *ah = ap->host;
> -	struct rb532_cf_info *info = ah->private_data;
> -
> -	/* FIXME: Keep previous delay. If this is merely a fence then
> -	   ata_sff_sync might be sufficient. */
> -	ata_sff_dma_pause(ap);
> -	ndelay(RB500_CF_IO_DELAY);
> -}

ACK patches 2-5, but they don't apply to upstream (plus patch #1)

