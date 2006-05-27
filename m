From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
    fails: libata issue
Date: Sat, 27 May 2006 14:50:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605271444200.5623@g5.osdl.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com>
 <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org>
 <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org>
 <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org>
 <20060527212011.GA31551@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:60819 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964964AbWE0Vu7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 17:50:59 -0400
In-Reply-To: <20060527212011.GA31551@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org



On Sat, 27 May 2006, Jens Axboe wrote:
> > hardware, since the current suspend resumes to silicon defaults rather 
> > than BIOS defaults (and ata_piix doesn't have a controller reset).
> 
> Definitely, and we need to cover a lot more controllers than just piix
> and ahci. Being the selfish bastard that I am, I didn't care much about
> other devices...
> 
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index fa476e7..28878f4 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -4297,6 +4297,7 @@ static int ata_start_drive(struct ata_po
>  int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
>  {
>  	if (ap->flags & ATA_FLAG_SUSPENDED) {
> +		ata_busy_wait(ap, ATA_BUSY, 200000);

Btw, it might not be enough to wait for ATA_BUSY to clear.

I think you should wait for ATA_DRDY to be set too.

What does it say if you change that "ata_busy_wait()" to

	u8 status = ata_wait_idle(ap);
	if (!ata_ok(status))
		printk("ATA status %02x\n", status);

instead? That should print out the status (unless it works, which it 
apparently won't do for you without the msleep), and maybe give us some 
clues about what the f* is going on with the device status thing.

		Linus
