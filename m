From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/4] if condition fix for __atapi_pio_bytes()
Date: Mon, 6 Jun 2005 11:32:54 +0200
Message-ID: <58cb370e050606023238eeecba@mail.gmail.com>
References: <42A3FF7B.3040201@tw.ibm.com> <42A40214.5080006@tw.ibm.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.203]:2679 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261254AbVFFJdx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Jun 2005 05:33:53 -0400
Received: by wproxy.gmail.com with SMTP id 68so1788968wra
        for <linux-ide@vger.kernel.org>; Mon, 06 Jun 2005 02:33:49 -0700 (PDT)
In-Reply-To: <42A40214.5080006@tw.ibm.com>
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
>    In __atapi_pio_bytes(), when (bytes > qc->nbytes) or (qc->cursg_ofs > sg->length) or
> (count > bytes), the if condition is not handled properly.

(bytes > qc->nbytes) condition can happen and this part of the patch
is fine with me
but I fail to see how (qc->cursg_ofs > sg->length) or (count > bytes)
can happen...

	count = min(sg->length - qc->cursg_ofs, bytes);

	/* don't cross page boundaries */
	count = min(count, (unsigned int)PAGE_SIZE - offset);

Bartlomiej

> Changes:
> - Fix the "if conditions" to make the "if conditions" more robust.
> 
>    Attached please find the patch against the linux-2.6.git tree for your review. Thanks.
> 
> Albert
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> 
> 
> --- 11_atapi_pio_sg_fix/drivers/scsi/libata-core.c      2005-06-06 13:45:33.000000000 +0800
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
