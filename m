From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH 2/2] libata: disable preemption during PIO copy
Date: Tue, 23 Mar 2010 18:49:04 +0900
Message-ID: <20100323184836W.fujita.tomonori@lab.ntt.co.jp>
References: <20100321215308.GB27709@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:53950 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753781Ab0CWJup (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Mar 2010 05:50:45 -0400
In-Reply-To: <20100321215308.GB27709@Chamillionaire.breakpoint.cc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sebastian@breakpoint.cc
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Sun, 21 Mar 2010 22:53:08 +0100
Sebastian Andrzej Siewior <sebastian@breakpoint.cc> wrote:

> If the request has been made in user context it could be moved to a
> different CPU on a SMP machine between the copy and cache flush. Thus we
> could flush the dcache on the wrong CPU.

This issue should be addressed in flush_dcache_page() inside?


> Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> ---
>  drivers/ata/libata-sff.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 83ecf48..dca9f90 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -874,6 +874,9 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
>  
>  	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
>  
> +#ifdef CONFIG_SMP
> +	preempt_disable();
> +#endif
>  	if (PageHighMem(page)) {
>  		unsigned long flags;
>  
> @@ -896,6 +899,9 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
>  	if (!do_write && !PageSlab(page))
>  		flush_dcache_page(page);
>  
> +#ifdef CONFIG_SMP
> +	preempt_enable();
> +#endif
>  	qc->curbytes += qc->sect_size;
>  	qc->cursg_ofs += qc->sect_size;
>  
> -- 
> 1.6.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
