From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/4] libata: if condition fix for __atapi_pio_bytes()
Date: Fri, 10 Jun 2005 09:56:59 +0200
Message-ID: <58cb370e050610005628a5706a@mail.gmail.com>
References: <42A3FF7B.3040201@tw.ibm.com> <42A7ED91.4090008@pobox.com>
	 <42A9436E.9090906@tw.ibm.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.197]:55930 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262512AbVFJH5C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Jun 2005 03:57:02 -0400
Received: by wproxy.gmail.com with SMTP id 68so531407wra
        for <linux-ide@vger.kernel.org>; Fri, 10 Jun 2005 00:56:59 -0700 (PDT)
In-Reply-To: <42A9436E.9090906@tw.ibm.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

n 6/10/05, Albert Lee <albertcc@tw.ibm.com> wrote:
> Hi Jeff,
> 
> Resend the patch #2 against the linux-2.6.git tree (0086b5ec7834b78358dea3f713275a9ae2b229ec).
> 
> Problem:
>     In __atapi_pio_bytes(), when (bytes > qc->nbytes) or (qc->cursg_ofs > sg->length) or
> (count > bytes), the if condition is not handled properly.

Only (bytes > qc->nbytes) can happen now.

> Changes:
> - Fix the "if conditions" to make the "if conditions" more robust.
> 
> 
> Albert
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> 
> 
> 
> --- 11_atapi_pio_sg_fix/drivers/scsi/libata-core.c      2005-06-10 14:51:51.000000000 +0800
> +++ 12_atapi_pio_if_condition_fix/drivers/scsi/libata-core.c    2005-06-06 13:52:11.000000000 +0800
> @@ -2571,7 +2571,7 @@
>         unsigned char *buf;
>         unsigned int offset, count;
> 
> -       if (qc->curbytes == qc->nbytes - bytes)
> +       if (qc->curbytes + bytes >= qc->nbytes)
>                 ap->pio_task_state = PIO_ST_LAST;
> 
>  next_sg:
> @@ -2592,11 +2592,10 @@
> 
>         buf = kmap(page) + offset;
> 
> -       bytes -= count;
>         qc->curbytes += count;
>         qc->cursg_ofs += count;
> 
> -       if (qc->cursg_ofs == sg->length) {
> +       if (qc->cursg_ofs >= sg->length) {
>                 qc->cursg++;
>                 qc->cursg_ofs = 0;
>         }
> @@ -2608,7 +2607,9 @@
> 
>         kunmap(page);
> 
> -       if (bytes) {
> +       if (bytes > count) {
> +               bytes -= count;
> +
>                 goto next_sg;
>         }
>  }
> 
> 
>
