From: Chisato Yamauchi <cyamauch@plamo.linet.gr.jp>
Subject: Re: [PATCH] sata_sil24: lengthen softreset timeout
Date: Sat, 11 Mar 2006 15:21:21 +0900 (JST)
Message-ID: <20060311.152121.74747632.cyamauch@plamo.linet.gr.jp>
References: <20060308.143306.74747174.cyamauch@plamo.linet.gr.jp>
	<20060310072527.GB7510@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from PPPbf446.hyogo-ip.dti.ne.jp ([210.170.214.196]:38274 "EHLO
	plamo.linet.gr.jp") by vger.kernel.org with ESMTP id S1752342AbWCKGVh
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 11 Mar 2006 01:21:37 -0500
In-Reply-To: <20060310072527.GB7510@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org


  Hi, Tejun

  Your patch also works fine with my ARAID99!
  Thanks!!

> Jeff, this patch is against the current #linus-git.  This doesn't
> really count as regression but I think this should go upstream ASAP.
> However, if that's not an option, this patch also applies to #upstream
> with some offsets.
> 
> Chisato, thanks a lot for spotting it and sending fix.  :-)
> 
>  drivers/scsi/sata_sil24.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
> index 9231301..13cdd22 100644
> --- a/drivers/scsi/sata_sil24.c
> +++ b/drivers/scsi/sata_sil24.c
> @@ -433,8 +433,8 @@ static int sil24_issue_SRST(struct ata_p
>  	struct sil24_port_priv *pp = ap->private_data;
>  	struct sil24_prb *prb = &pp->cmd_block[0].ata.prb;
>  	dma_addr_t paddr = pp->cmd_block_dma;
> +	unsigned long timeout = jiffies + 5 * HZ;
>  	u32 irq_enable, irq_stat;
> -	int cnt;
>  
>  	/* temporarily turn off IRQs during SRST */
>  	irq_enable = readl(port + PORT_IRQ_ENABLE_SET);
> @@ -451,7 +451,7 @@ static int sil24_issue_SRST(struct ata_p
>  
>  	writel((u32)paddr, port + PORT_CMD_ACTIVATE);
>  
> -	for (cnt = 0; cnt < 100; cnt++) {
> +	do {
>  		irq_stat = readl(port + PORT_IRQ_STAT);
>  		writel(irq_stat, port + PORT_IRQ_STAT);		/* clear irq */
>  
> @@ -459,8 +459,8 @@ static int sil24_issue_SRST(struct ata_p
>  		if (irq_stat & (PORT_IRQ_COMPLETE | PORT_IRQ_ERROR))
>  			break;
>  
> -		msleep(1);
> -	}
> +		msleep(100);
> +	} while (time_before(jiffies, timeout));
>  
>  	/* restore IRQs */
>  	writel(irq_enable, port + PORT_IRQ_ENABLE_SET);

==  Chisato Yamauchi  =================================
