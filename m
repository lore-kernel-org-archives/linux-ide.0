From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] libata-2.6: Prevent the interrupt handler from completing
 a command twice
Date: Sun, 15 May 2005 18:47:11 -0400
Message-ID: <4287D16F.7080602@pobox.com>
References: <4271FE02.1080009@tw.ibm.com> <4271FFC3.5070403@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:54168 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261304AbVEOWr2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 May 2005 18:47:28 -0400
In-Reply-To: <4271FFC3.5070403@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Jens Axboe <axboe@suse.de>, Linux IDE <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Hi Jeff,
> 
> Problem:
>   During the libata CD-ROM stress test, sometimes the "BUG: timeout 
> without command" error is seen.
> 
> Root cause:
>  Unexpected interrupt occurs after the ata_qc_complete() is called, but 
> before the SCSI error handler.
> The interrupt handler is invoked before the SCSI error handler, and it 
> clears the command by calling ata_qc_complete() again.
> Later when the SCSI error handler is run, the ata_queued_cmd is already 
> gone, causing the "BUG: timeout without command" error.
> 
> Changes:
>  - Use the ATA_QCFLAG_ACTIVE flag to prevent the interrupt handler from 
> completing the command twice,
>    before the scsi_error_handler.

patch applied


