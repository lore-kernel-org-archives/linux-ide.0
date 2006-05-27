From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
 fails: libata issue
Date: Sat, 27 May 2006 15:01:50 -0400
Message-ID: <4478A21E.9070602@rtr.ca>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <Pine.LNX.4.64.0605262028460.5623@g5.osdl.org> <4477CEF5.9000908@garzik.org> <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:29164 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964936AbWE0TBw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 15:01:52 -0400
In-Reply-To: <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, Jens Axboe <axboe@suse.de>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 27 May 2006, Mark Lord wrote:
>> The original "bad layering" patch still works perfectly in it's place.
>> Repeated below for Linus's benefit.
> 
> Why isn't the right fix the minimal one?
..
> ---
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index fa476e7..0ef4cf4 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -4296,6 +4296,7 @@ static int ata_start_drive(struct ata_po
>   */
>  int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
>  {
> +	ata_busy_wait(ap, ATA_BUSY, 200000);
>  	if (ap->flags & ATA_FLAG_SUSPENDED) {
>  		ap->flags &= ~ATA_FLAG_SUSPENDED;
>  		ata_set_mode(ap);

Bingo!  Linus wins:  that one-liner is not only "obviously correct",
but it works, too!

Great!
