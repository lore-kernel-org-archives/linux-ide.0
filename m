From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] 2.6.17-rc5: the latest consensus libata resume fix
Date: Sun, 28 May 2006 19:14:24 +0200
Message-ID: <20060528171424.GA12982@suse.de>
References: <200605272245.30108.axboe@suse.de> <Pine.LNX.4.64.0605271716030.5623@g5.osdl.org> <4478F681.8050607@garzik.org> <200605281128.00532.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:32105 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750806AbWE1ROv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 May 2006 13:14:51 -0400
Content-Disposition: inline
In-Reply-To: <200605281128.00532.liml@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@osdl.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Sun, May 28 2006, Mark Lord wrote:
> Okay, just to sum things up.
> 
> The patch below is the current "release candidate" for
> improving the libata/ata_piix resume functionality in 2.6.17-rc*.
> 
> It forces libata to wait for up to 2 seconds for BUSY|DRQ to clear
> on resume before continuing.  This is only for 2.6.17 at present.
> 
> We are waiting on Jens to test and report back for this specific version.
> 
> Signed-off-by:  Mark Lord <liml@rtr.ca>
> ---
> --- linux-2.6.17-rc5/drivers/scsi/libata-core.c
> +++ linux/drivers/scsi/libata-core.c
> @@ -4296,6 +4296,7 @@ static int ata_start_drive(struct ata_po
>   */
>  int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
>  {
>  	if (ap->flags & ATA_FLAG_SUSPENDED) {
> +		ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 200000);
>  		ap->flags &= ~ATA_FLAG_SUSPENDED;
>  		ata_set_mode(ap);

Sorry for the unresponsiveness, still away and internet connectivity
spotty. Just tested the above, and it works for me! I think Marks
analisys wrt DRQ is completely correct and this validates it.

Acked-by: Jens Axboe <axboe@suse.de>

-- 
Jens Axboe

