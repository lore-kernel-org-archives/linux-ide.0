From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
      fails: libata issue
Date: Sat, 27 May 2006 20:53:24 -0400
Message-ID: <4478F484.4080908@garzik.org>
References: <200605272245.30108.axboe@suse.de> <4478D2B4.2000500@rtr.ca> <20060527223607.GE364@suse.de> <200605271848.53680.liml@rtr.ca> <20060527225316.GA1075@suse.de> <4478DC67.6050800@rtr.ca> <Pine.LNX.4.64.0605271716030.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56215 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964999AbWE1Axa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 20:53:30 -0400
In-Reply-To: <Pine.LNX.4.64.0605271716030.5623@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mark Lord <liml@rtr.ca>, Jens Axboe <axboe@suse.de>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Linus Torvalds wrote:
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index fa476e7..6ccfbc9 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -4296,6 +4296,13 @@ static int ata_start_drive(struct ata_po
>   */
>  int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
>  {
> +	/*
> +	 * Wait for BUSY to go away for up to 2 seconds,
> +	 * and then try to wait for idle (up to 1 msec)
> +	 */
> +	ata_busy_wait(ap, ATA_BUSY, 200000);
> +	ata_wait_idle(ap);

I don't object, but ata_wait_idle() is completely pointless.

ata_wait_idle() has nothing to do with DRDY.  It waits until both BSY 
and DRQ are clear.  See:
> u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);

Regards,

	Jeff



