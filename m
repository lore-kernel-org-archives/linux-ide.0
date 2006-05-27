From: Mark Lord <liml@rtr.ca>
Subject: Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM) fails:
  libata issue
Date: Sat, 27 May 2006 14:46:17 -0400
Message-ID: <44789E79.4060005@rtr.ca>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <20060526230534.GA3640@suse.de> <4477C60E.1070106@rtr.ca> <Pine.LNX.4.64.0605262028460.5623@g5.osdl.org> <20060527062950.GC23315@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:6103 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964931AbWE0SqT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 14:46:19 -0400
In-Reply-To: <20060527062950.GC23315@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, "zhao, forrest" <forrest.zhao@intel.com>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jens Axboe wrote:
..
> There was no real discussion on this issue yet. I think we all agree
> that the functionality of the patch (waiting for BSY clear on resume) is
> the right thing to do. This posted patch moved SCSI stuff into ata_piix,
> which isn't really very nice. Jeff wants to do it from the pci resume,
> which just seems wrong to me since it's a device (disk) condition not a
> "host" condition. FWIW, here's what I had in mind as suggested in the
> original reply. Not tested at all for functionality, but it compiles.
> 
> diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
> index 6dc8814..103afc3 100644
> --- a/drivers/scsi/ata_piix.c
> +++ b/drivers/scsi/ata_piix.c
> @@ -151,6 +151,7 @@ static int piix_pata_probe_reset(struct 
>  static int piix_sata_probe_reset(struct ata_port *ap, unsigned int *classes);
...

That patch, like Jeff's, does nothing (good) on my system.
It still pauses for a longish timeout on resume, and then fails
with a zillion "read errors", and leaves the drive inaccessible.

I'm will y'all on the poor layering, but non-functionality is worse.

Cheers
