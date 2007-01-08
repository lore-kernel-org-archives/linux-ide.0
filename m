From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH libata #promise-sata-pata] sata_promise: 2037x PATAPI
 support
Date: Sun, 07 Jan 2007 20:47:35 -0500
Message-ID: <45A1A2B7.8000601@garzik.org>
References: <200701072239.l07Mdju7028895@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51518 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030431AbXAHBrh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Jan 2007 20:47:37 -0500
In-Reply-To: <200701072239.l07Mdju7028895@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> @@ -789,8 +789,14 @@ static void pdc_exec_command_mmio(struct
>  static int pdc_check_atapi_dma(struct ata_queued_cmd *qc)
>  {
>  	u8 *scsicmd = qc->scsicmd->cmnd;
> +	struct ata_port *ap = qc->ap;
> +	struct pdc_host_priv *hp = ap->host->private_data;
>  	int pio = 1; /* atapi dma off by default */
>  
> +	/* First generation chips cannot use ATAPI DMA on SATA ports */
> +	if (!(hp->flags & PDC_FLAG_GEN_II) && sata_scr_valid(ap))
> +		return 1;
> +
>  	/* Whitelist commands that may use DMA. */
>  	switch (scsicmd[0]) {
>  	case WRITE_12:


IMO creating a new check_atapi_dma function for first-gen chips would be 
the preferred way to add this check.

	Jeff


