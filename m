From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Re: 2.6.19.1, sata_sil: sata dvd writer doesn't work
Date: Thu, 24 May 2007 23:23:53 -0400
Message-ID: <465656C9.4020209@garzik.org>
References: <46362672.7080103@gmx.net> <4636DCA9.9050803@gmail.com> <4636FBB7.3030605@gmx.net> <463AE631.9030701@gmail.com> <463B7903.4070206@gmx.net> <463EE239.8060709@gmail.com> <463F634E.2070103@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50828 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795AbXEYDX5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 May 2007 23:23:57 -0400
In-Reply-To: <463F634E.2070103@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Beichl <daniel_beichl@gmx.net>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Daniel Beichl wrote:
> +static int sil_check_atapi_dma(struct ata_queued_cmd *qc)
> +{
> +	/* limit atapi commands less than 60bytes to pio as certain sil */
> +	/* chips seem to have trouble to perform dma for these commands */
> +	if ( (qc->scsicmd != NULL) &&
> +	     (qc->scsicmd->sc_data_direction == DMA_TO_DEVICE) &&
> +	     (qc->scsicmd->request_bufflen < 60) )
> +	{
> +		ata_dev_printk( qc->dev, KERN_INFO, "reducing cmd %02x (direction=%d, len=%d) to pio\n", 
> +			qc->cdb[0], 
> +			qc->scsicmd->sc_data_direction, 
> +			qc->scsicmd->request_bufflen );
> +		/* do not allow dma */
> +		return -1;
> +	}
> +
> +	/* allow dma */
> +	return 0;


Comments:

1) Return values are zero or one for this hook

2) There are two data bundling methods in SCSI:  single-buffer and 
scatterlist.  Further, SCSI is deprecating single-buffer method in favor 
of always using a scatterlist.  Your patch needs to support scatterlist. 
  Here is an example test found in libata-scsi.c that illustrates how 
SCSI-aware code tests for and uses this:

         if (cmd->use_sg) {
                 qc->__sg = (struct scatterlist *) cmd->request_buffer;

3) You need to always include a signoff line: 
http://linux.yyz.us/patch-format.html

	Jeff


