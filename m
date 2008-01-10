From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata and starting/stopping ATAPI floppy devices
Date: Thu, 10 Jan 2008 17:21:49 -0500
Message-ID: <47869A7D.2020703@pobox.com>
References: <200801051647.58866.linux@rainbow-software.org> <4784344C.5060208@gmail.com> <200801091853.15601.linux@rainbow-software.org> <47855B99.3080302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55244 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116AbYAJWVz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Jan 2008 17:21:55 -0500
In-Reply-To: <47855B99.3080302@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Ondrej Zary <linux@rainbow-software.org>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

Tejun Heo wrote:
> From: Ondrej Zary <linux@rainbow-software.org>
> 
> Prevent libata from starting/stopping non-ATA devices (like ATAPI floppy 
> drives) as they don't seem to like it:
> 
> sd 1:0:1:0: [sdb] Starting disk
> ata2.01: configured for PIO2
> sd 1:0:1:0: [sdb] Result: hostbyte=0x00 driverbyte=0x08
> sd 1:0:1:0: [sdb] Sense Key : 0x2 [current]
> sd 1:0:1:0: [sdb] ASC=0x3a ASCQ=0x0
> 
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Trimmed message body and reformatted such that it's script friendly.
> 
>  drivers/ata/libata-scsi.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- linux-2.6.23-orig/drivers/ata/libata-scsi.c	2007-10-09 22:31:38.000000000 +0200
> +++ linux-2.6.23-pentium/drivers/ata/libata-scsi.c	2008-01-05 15:50:16.000000000 +0100
> @@ -802,7 +802,8 @@
>  
>  	blk_queue_max_phys_segments(sdev->request_queue, LIBATA_MAX_PRD);
>  
> -	sdev->manage_start_stop = 1;
> +	if (dev->class == ATA_DEV_ATA)
> +		sdev->manage_start_stop = 1;
>  
>  	if (dev)

applied #upstream-fixes manually.  not sure why git-am didn't like it, 
but patch(1) did.


