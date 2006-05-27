From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)  fails: libata issue
Date: Sat, 27 May 2006 22:45:29 +0200
Message-ID: <200605272245.30108.axboe@suse.de>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:43352 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964960AbWE0Urr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 16:47:47 -0400
In-Reply-To: <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Saturday 27 May 2006 20:47, Linus Torvalds wrote:
> On Sat, 27 May 2006, Mark Lord wrote:
> > The original "bad layering" patch still works perfectly in it's place.
> > Repeated below for Linus's benefit.
>
> Why isn't the right fix the minimal one?
>
> What's the layering violation in just having ATA resume make sure it's not
> ATA_BUSY?
>
> Why are you guys fighting over this?
>
> And why the hell is Mark's patch not being accepted if it fixes something,
> and the alternate patches do not?
>
> 		Linus
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

This is fine with me, Jeff originally complained it was a layering violation. 
Unless he really objects, I'd say go for that for 2.6.17 - well actually 
moving it inside the ATA_FLAG_SUSPENDED case is clearly better.

I'll test it on my notebook right away.

Jens
