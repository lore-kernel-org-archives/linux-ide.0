From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: PATCH libata-2.6 4/5] Prevent the device from overrunning the buffer in __atapi_pio_bytes()
Date: Fri, 18 Mar 2005 09:31:16 +0100
Message-ID: <58cb370e0503180031d40b0a3@mail.gmail.com>
References: <423A8AA4.5040601@tw.ibm.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.195]:6071 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261497AbVCRIbT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Mar 2005 03:31:19 -0500
Received: by wproxy.gmail.com with SMTP id 68so103188wra
        for <linux-ide@vger.kernel.org>; Fri, 18 Mar 2005 00:31:16 -0800 (PST)
In-Reply-To: <423A8AA4.5040601@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

On Fri, 18 Mar 2005 16:00:36 +0800, Albert Lee <albertcc@tw.ibm.com> wrote:
> Hi Jeff,
> 
> Problem:
>    Some bad behaved CD-ROM drives will return more data than ask to.
> (I have such CD-RW drive and it crashed the kernel.)

These devices are compliant with original ATAPI spec.

Such condition shouldn't be treated as an error
- extra data should be read and dumped.

> Changes:
> - Add additional check in __atapi_pio_bytes() to prevent the device from overrunning the buffer.
> 
> Attached please find the patch against the libata-2.6 tree for your review. Thanks.
> 
> Albert
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---------------------------------------
> --- libata-2.6-reorder/drivers/scsi/libata-core.c       2005-03-18 12:56:44.000000000 +0800
> +++ libata-2.6-extrabytes/drivers/scsi/libata-core.c    2005-03-18 14:00:34.000000000 +0800
> @@ -2338,6 +2338,14 @@
>                 ap->pio_task_state = PIO_ST_LAST;
> 
>   next_sg:
> +       /* check whether qc->sg is full */
> +       if (unlikely(qc->cursg >= qc->n_elem)) {
> +               printk(KERN_WARNING "ata%u: qc->sg full, %u bytes trailing\n", ap->id, bytes);
> +
> +               ap->pio_task_state = PIO_ST_ERR;
> +               return;
> +       }
> +
>         sg = &qc->sg[qc->cursg];
> 
>         page = sg->page;
> 
> 
> --- libata-2.6-reorder/drivers/scsi/libata-core.c       2005-03-18 12:56:44.000000000 +0800
> +++ libata-2.6-extrabytes/drivers/scsi/libata-core.c    2005-03-18 14:00:34.000000000 +0800
> @@ -2338,6 +2338,14 @@
>                 ap->pio_task_state = PIO_ST_LAST;
> 
>  next_sg:
> +       /* check whether qc->sg is full */
> +       if (unlikely(qc->cursg >= qc->n_elem)) {
> +               printk(KERN_WARNING "ata%u: qc->sg full, %u bytes trailing\n", ap->id, bytes);
> +
> +               ap->pio_task_state = PIO_ST_ERR;
> +               return;
> +       }
> +
>         sg = &qc->sg[qc->cursg];
> 
>         page = sg->page;
> 
> 
>
