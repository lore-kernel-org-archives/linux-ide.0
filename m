From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/3] libata - PIO error handling fix
Date: Fri, 17 Dec 2004 20:42:48 +0100
Message-ID: <58cb370e041217114221f774f5@mail.gmail.com>
References: <003901c4e28b$95c00f20$f17a4109@tw.ibm.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.202]:7634 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262142AbULQTmt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Dec 2004 14:42:49 -0500
Received: by wproxy.gmail.com with SMTP id 68so98984wra
        for <linux-ide@vger.kernel.org>; Fri, 17 Dec 2004 11:42:48 -0800 (PST)
In-Reply-To: <003901c4e28b$95c00f20$f17a4109@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

On Wed, 15 Dec 2004 17:50:59 +0800, Albert Lee <albertcc@tw.ibm.com> wrote:
> Hi, Jeff:
> 
>   Tested burning CD-RW with libata-dev-2.6 and cdrecord:
> 1. ATAPI DMA mode - tested OK
> 2. ATAPI PIO mode - test failed when cdrecord finishes burning and issues MODE_SELECT to the device.
> 
>   After checking the log, it showed that MODE_SELECT caused ata_pio_complete() to return error.
> However, the error is not handled by ata_pio_task().
> 
> Attached please find the patch for ata_pio_task() error handling for your review.
> (The patch is against the libata-dev-2.6 tree. )
> 
> Changes in the patch:
> 1. End the PIO task when PIO_ST_IDLE state is entered
> 2. End the PIO task after PIO_ST_TMOUT and PIO_ST_ERR state handled by ata_pio_error()
> 3. Remove the first "if" statement to handle the error condition returned from
>   ata_pio_block(), ata_pio_complete() and ata_pio_poll().

Jeff, 3. is the same issue + fix that was reported earlier by Tim.
It seems that we have both somehow forgot about it. :-|

>   Change #2  is not so necessary since ata_pio_error() will put the cmd to  PIO_ST_IDLE state
> after the error condition is handled. The change just saves a function call to queue_work().
> 
> Tested OK on on my machine with pdc20275 and ASUS CD-RW drive.

Patch looks fine for me.

Bartlomiej
