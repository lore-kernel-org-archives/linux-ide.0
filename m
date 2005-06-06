From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/4] trailing data handling fix for __atapi_pio_bytes()
Date: Mon, 6 Jun 2005 11:37:07 +0200
Message-ID: <58cb370e05060602372f242691@mail.gmail.com>
References: <42A3FF7B.3040201@tw.ibm.com> <42A4027D.9070007@tw.ibm.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.196]:26306 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261254AbVFFJiA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Jun 2005 05:38:00 -0400
Received: by wproxy.gmail.com with SMTP id 68so1790619wra
        for <linux-ide@vger.kernel.org>; Mon, 06 Jun 2005 02:37:58 -0700 (PDT)
In-Reply-To: <42A4027D.9070007@tw.ibm.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

Hi,

On 6/6/05, Albert Lee <albertcc@tw.ibm.com> wrote:
> Hi Jeff,
> 
> Problem:
>    Sometimes CD-ROM drives will ask/return more data than expected.
> 
> Changes:
> - Handle the trailing data if the end of qc->sg has been reached.
> 
> Attached please find the patch against the linux-2.6.git tree for your review. Thanks.
> 
> Albert
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> 
> 
> --- 12_atapi_pio_if_condition_fix/drivers/scsi/libata-core.c    2005-06-06 13:52:11.000000000 +0800
> +++ 13_atapi_pio_trailing_data_handling/drivers/scsi/libata-core.c      2005-06-06 13:57:18.000000000 +0800
> @@ -2575,6 +2575,23 @@
>                 ap->pio_task_state = PIO_ST_LAST;
> 
>  next_sg:
> +       /* check whether qc->sg is full */
> +       if (unlikely(qc->cursg >= qc->n_elem)) {
> +               unsigned char pad_buf[2];
> +               unsigned int words = (bytes+1) >> 1; /* pad to word boundary */
> +               unsigned int i;
> +
> +               DPRINTK("ata%u: padding %u bytes\n", ap->id, bytes);
> +
> +               memset(&pad_buf, 0, sizeof(pad_buf));
> +               for (i = 0; i < words; i++) {
> +                       ata_data_xfer(ap, pad_buf, sizeof(pad_buf), do_write);
> +               }
> +
> +               ap->pio_task_state = PIO_ST_LAST;
> +               return;
> +       }
> +
>         sg = &qc->sg[qc->cursg];
> 
>         page = sg->page;
> 

Looks good.  Jeff, please apply.

Ack-ed by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

Bartlomiej
