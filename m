From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/4] odd length data handling for __atapi_pio_bytes()
Date: Mon, 6 Jun 2005 11:39:43 +0200
Message-ID: <58cb370e05060602392cfb6ca3@mail.gmail.com>
References: <42A3FF7B.3040201@tw.ibm.com> <42A402C5.3050704@tw.ibm.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.202]:22001 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261255AbVFFJkZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Jun 2005 05:40:25 -0400
Received: by wproxy.gmail.com with SMTP id 68so1791798wra
        for <linux-ide@vger.kernel.org>; Mon, 06 Jun 2005 02:40:25 -0700 (PDT)
In-Reply-To: <42A402C5.3050704@tw.ibm.com>
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
> - When odd length data is transfered, the last byte of data is lost.
> 
> Changes:
> - When an odd length data transfer is seen, round it to the next even length.
>    (The same as atapi_input_bytes() does in the ide-iops.)
> 
> Attached please find the patch against the linux-2.6.git tree for your review. Thanks.
> 
> Albert
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> 
> 
> --- 13_atapi_pio_trailing_data_handling/drivers/scsi/libata-core.c      2005-06-06 13:57:18.000000000 +0800
> +++ 14_atapi_pio_odd_handling/drivers/scsi/libata-core.c        2005-06-06 14:54:36.000000000 +0800
> @@ -2607,6 +2607,13 @@
>         /* don't cross page boundaries */
>         count = min(count, (unsigned int)PAGE_SIZE - offset);
> 
> +       /* handle the odd condition */
> +       if (unlikely(count & 0x01)) {
> +               DPRINTK("ata%u: odd count %u rounded: qc->nbytes %u, bytes %u\n",
> +                       ap->id, count, qc->nbytes, bytes);
> +               count++;
> +       }
> +
>         buf = kmap(page) + offset;
> 
>         qc->curbytes += count;
> 

Looks good.  Jeff, please apply.
[ Hm, I'm not very creative... ]

Ack-ed by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

Bartlomiej
