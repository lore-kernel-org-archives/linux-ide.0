From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM) fails:
  libata issue
Date: Sat, 27 May 2006 02:36:19 -0400
Message-ID: <4477F363.7080105@garzik.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <20060526230534.GA3640@suse.de> <4477C60E.1070106@rtr.ca> <Pine.LNX.4.64.0605262028460.5623@g5.osdl.org> <20060527062950.GC23315@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:8937 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751006AbWE0GgZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 02:36:25 -0400
In-Reply-To: <20060527062950.GC23315@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Mark Lord <liml@rtr.ca>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jens Axboe wrote:
> There was no real discussion on this issue yet. I think we all agree
> that the functionality of the patch (waiting for BSY clear on resume) is
> the right thing to do. This posted patch moved SCSI stuff into ata_piix,
> which isn't really very nice. Jeff wants to do it from the pci resume,
> which just seems wrong to me since it's a device (disk) condition not a

Wrong.  It is a _bus_ condition, not a device condition.


> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index fa476e7..ae7fac1 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -4298,6 +4298,8 @@ int ata_device_resume(struct ata_port *a
>  {
>  	if (ap->flags & ATA_FLAG_SUSPENDED) {
>  		ap->flags &= ~ATA_FLAG_SUSPENDED;
> +		if (ap->ops->port_resume)
> +			ap->ops->port_resume(ap);

This is even MORE broken!

A port can have multiple devices hanging off of it.  With this 
silliness, you will be calling ->port_resume() for both master and slave 
devices...  or all devices attached to a port multiplier.

Control flow is top-down, not bottom-up.

	Jeff


