From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 0/2] libata: ata_pio_task() accessing 'ap->pio_task_state'
 fix
Date: Wed, 07 Sep 2005 20:43:08 -0400
Message-ID: <431F891C.6050000@pobox.com>
References: <43187433.9080204@tw.ibm.com> <431E7D76.60003@pobox.com> <431EBAD7.40801@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:22657 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932408AbVIHAnN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Sep 2005 20:43:13 -0400
In-Reply-To: <431EBAD7.40801@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Tejun Heo <htejun@gmail.com>

Albert Lee wrote:
> Only one minor addition for your review:
> 
> * ata_pio_block() changed to go to PIO_ST_LAST state, instead of
>   going to PIO_ST_IDLE state directly and calling ata_poll_qc_complete().
> 
> i.e.
> @@ -2845,9 +2852,7 @@
>     if (is_atapi_taskfile(&qc->tf)) {
>         /* no more data to transfer or unsupported ATAPI command */
>         if ((status & ATA_DRQ) == 0) {
> -            ap->pio_task_state = PIO_ST_IDLE;
> -
> -            ata_poll_qc_complete(qc, status);
> +            ap->pio_task_state = PIO_ST_LAST;
>             return;
>         }

hmmmm.  I think that should be PIO_ST_ERR not PIO_ST_LAST.  Comments?

	Jeff



