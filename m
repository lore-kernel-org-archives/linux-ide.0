From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/4] sg traverse fix for __atapi_pio_bytes()
Date: Mon, 6 Jun 2005 11:24:26 +0200
Message-ID: <58cb370e05060602241afa7175@mail.gmail.com>
References: <42A3FF7B.3040201@tw.ibm.com> <42A40193.3090500@tw.ibm.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.197]:25307 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261245AbVFFJZI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Jun 2005 05:25:08 -0400
Received: by wproxy.gmail.com with SMTP id 68so1785059wra
        for <linux-ide@vger.kernel.org>; Mon, 06 Jun 2005 02:25:08 -0700 (PDT)
In-Reply-To: <42A40193.3090500@tw.ibm.com>
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
>    Incorrect md5sum when using ATAPI PIO mode to verify a distro CD.
> 
> Root cause:
>    sg traverse problem.
> In __atapi_pio_bytes(), if qc->cursg++ is increased and "goto next_page" is executed,
> then sg is not updated to the new qc->cursg and the old sg is overwritten with the new data.
> 
> Changes:
> - Replace "goto next_page" with "goto next_sg" to make sg updated.
> 
>    Attached please find the patch against the linux-2.6.git tree for your review. Thanks.
> 
> Albert
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> 
> 
> 
> --- 10_atapi_pio_fix/drivers/scsi/libata-core.c 2005-06-06 13:37:50.000000000 +0800
> +++ 11_atapi_pio_sg_fix/drivers/scsi/libata-core.c      2005-06-06 13:45:33.000000000 +0800
> @@ -2577,7 +2577,6 @@
>  next_sg:
>         sg = &qc->sg[qc->cursg];
> 
> -next_page:
>         page = sg->page;
>         offset = sg->offset + qc->cursg_ofs;
> 
> @@ -2585,6 +2584,7 @@
>         page = nth_page(page, (offset >> PAGE_SHIFT));
>         offset %= PAGE_SIZE;
> 
> +       /* don't overrun current sg */
>         count = min(sg->length - qc->cursg_ofs, bytes);
> 
>         /* don't cross page boundaries */
> @@ -2609,8 +2609,6 @@
>         kunmap(page);
> 
>         if (bytes) {
> -               if (qc->cursg_ofs < sg->length)
> -                       goto next_page;
>                 goto next_sg;
>         }
>  }
> 

Looks good.  Jeff, please apply.

Ack-ed by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

Minor CodingStyle nitpick - braces can be dropped:

        if (bytes)
                goto next_sg;

Bartlomiej
