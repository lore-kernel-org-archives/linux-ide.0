From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
      fails: libata issue
Date: Sat, 27 May 2006 18:52:30 -0400
Message-ID: <4478D82E.4030704@garzik.org>
References: <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org> <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org> <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org> <20060527212011.GA31551@suse.de> <Pine.LNX.4.64.0605271444200.5623@g5.osdl.org> <4478CD4E.4000506@rtr.ca> <20060527221131.GA364@suse.de> <Pine.LNX.4.64.0605271519250.5623@g5.osdl.org> <20060527223523.GD364@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33685 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964989AbWE0Wwg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 18:52:36 -0400
In-Reply-To: <20060527223523.GD364@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Mark Lord <liml@rtr.ca>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jens Axboe wrote:
> index b80d2e7..80fb1f9 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -742,7 +742,7 @@ static inline u8 ata_busy_wait(struct at
>  
>  static inline u8 ata_wait_idle(struct ata_port *ap)
>  {
> -	u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
> +	u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 200000);


Ouch.  That will slow down boot for a lot of otherwise-untouched users, 
if that makes it in...  :(

	Jeff


