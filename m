From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] sata_inic162x: enable LED blinking
Date: Sat, 13 Sep 2008 16:43:40 -0400
Message-ID: <48CC25FC.2030806@garzik.org>
References: <962320.92633.qm@web902.biz.mail.mud.yahoo.com> <48C8E9CB.7040605@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46393 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752852AbYIMUnp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Sep 2008 16:43:45 -0400
In-Reply-To: <48C8E9CB.7040605@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Bob Stewart <bob@evoria.net>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> From: Bob Stewart <bob@evoria.net>
> 
> Enable LED blinking.
> 
> Signed-off-by: Bob Stewart <bob@evoria.net>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> The patch was wrapped.  I reformatted a little bit.
> 
>  drivers/ata/sata_inic162x.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
> index 3ead02f..5032c32 100644
> --- a/drivers/ata/sata_inic162x.c
> +++ b/drivers/ata/sata_inic162x.c
> @@ -96,6 +96,7 @@ enum {
>  	PORT_SCR		= 0x20,
>  
>  	/* HOST_CTL bits */
> +	HCTL_LEDEN		= (1 << 3),  /* enable LED operation */
>  	HCTL_IRQOFF		= (1 << 8),  /* global IRQ off */
>  	HCTL_FTHD0		= (1 << 10), /* fifo threshold 0 */
>  	HCTL_FTHD1		= (1 << 11), /* fifo threshold 1*/
> @@ -540,7 +541,7 @@ static unsigned int inic_qc_issue(struct ata_queued_cmd *qc)
>  	void __iomem *port_base = inic_port_base(ap);
>  
>  	/* fire up the ADMA engine */
> -	writew(HCTL_FTHD0, port_base + HOST_CTL);
> +	writew(HCTL_FTHD0 | HCTL_LEDEN, port_base + HOST_CTL);
>  	writew(IDMA_CTL_GO, port_base + PORT_IDMA_CTL);
>  	writeb(0, port_base + PORT_CPB_PTQFIFO);

applied


