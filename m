From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)       fails: libata issue
Date: Sun, 28 May 2006 01:06:30 +0200
Message-ID: <20060527230630.GA1390@suse.de>
References: <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org> <20060527212011.GA31551@suse.de> <Pine.LNX.4.64.0605271444200.5623@g5.osdl.org> <4478CD4E.4000506@rtr.ca> <20060527221131.GA364@suse.de> <Pine.LNX.4.64.0605271519250.5623@g5.osdl.org> <20060527223523.GD364@suse.de> <4478D82E.4030704@garzik.org> <20060527225440.GB1075@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:28746 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S965013AbWE0XGi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 19:06:38 -0400
Content-Disposition: inline
In-Reply-To: <20060527225440.GB1075@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Mark Lord <liml@rtr.ca>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Sun, May 28 2006, Jens Axboe wrote:
> On Sat, May 27 2006, Jeff Garzik wrote:
> > Jens Axboe wrote:
> > >index b80d2e7..80fb1f9 100644
> > >--- a/include/linux/libata.h
> > >+++ b/include/linux/libata.h
> > >@@ -742,7 +742,7 @@ static inline u8 ata_busy_wait(struct at
> > > 
> > > static inline u8 ata_wait_idle(struct ata_port *ap)
> > > {
> > >-	u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
> > >+	u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 200000);
> > 
> > 
> > Ouch.  That will slow down boot for a lot of otherwise-untouched users, 
> > if that makes it in...  :(
> 
> Not proposing it for inclusion, just posted what I had in entirety to
> avoid confusion. I made that change to potentially avoid recompiling
> again for retesting. I can test without that too, I guess I will now
> because we have no clear results so far.

With that hunk restored to normal, no change. Resume still works, status
is still 80/50/50.

-- 
Jens Axboe

