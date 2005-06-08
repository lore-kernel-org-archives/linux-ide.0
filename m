From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/1] libata: Handle ATAPI interrupt before CDB is sent
Date: Wed, 8 Jun 2005 12:01:10 +0200
Message-ID: <58cb370e05060803014046ef0b@mail.gmail.com>
References: <4271FE02.1080009@tw.ibm.com> <427200B4.4050308@tw.ibm.com>
	 <4287D1E3.9070606@pobox.com> <428877F4.5050405@tw.ibm.com>
	 <42A6A60D.7020807@tw.ibm.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.204]:62437 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262149AbVFHKBL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Jun 2005 06:01:11 -0400
Received: by wproxy.gmail.com with SMTP id 67so238742wri
        for <linux-ide@vger.kernel.org>; Wed, 08 Jun 2005 03:01:10 -0700 (PDT)
In-Reply-To: <42A6A60D.7020807@tw.ibm.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

Hi Albert,
Hi Jeff,

On 6/8/05, Albert Lee <albertcc@tw.ibm.com> wrote:

> @@ -3457,6 +3461,32 @@
>  {
>         u8 status, host_stat;
> 
> +       /* ATAPI: Handle the interrupt before CDB is sent */
> +       if (is_atapi_taskfile(&qc->tf) &&
> +           ap->pio_task_state != PIO_ST_CDB_SENT) {
> +               /* check whether it's our irq */
> +               host_stat = ap->ops->bmdma_status(ap);
> +
> +               if (host_stat & ATA_DMA_INTR) {
> +                       /* Some pre-ATAPI-4 devices assert INTRQ here
> +                        * if nIEN is zero. qc->dev->id[0] bits 5-6 can
> +                        * be used to identify such devices.
> +                        */
> +                       DPRINTK("ata%u: atapi interrupt handled\n", ap->id);

This looks wrong for ATA_PROT_ATAPI_[NODATA],
we can't expect host to support DMA.

> +
> +                       /* clear INTRQ */
> +                       status = ata_chk_status(ap);
> +
> +                       /* clear bmdma status irq bit */
> +                       ap->ops->irq_clear(ap);
> +
> +                       return 1;       /* irq handled */
> +               } else {
> +                       DPRINTK("ata%u: not my atapi interrupt\n", ap->id);
> +                       goto idle_irq;
> +               }
> +       }
> +
>         switch (qc->tf.protocol) {
> 
>         case ATA_PROT_DMA:

	case ATA_PROT_DMA:
	case ATA_PROT_ATAPI_DMA:
	case ATA_PROT_ATAPI:
		/* check status of DMA engine */
		host_stat = ap->ops->bmdma_status(ap);
		VPRINTK("ata%u: host_stat 0x%X\n", ap->id, host_stat);

		/* if it's not our irq... */
		if (!(host_stat & ATA_DMA_INTR))
			goto idle_irq;

		/* before we do anything else, clear DMA-Start bit */
		ap->ops->bmdma_stop(ap);

		/* fall through */

ditto (vanilla libata-core.c)

Bartlomiej
