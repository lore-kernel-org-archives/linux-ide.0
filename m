From: Jens Axboe <axboe@suse.de>
Subject: Re: PATCH (for comment): ide-cd possible race in PIO mode
Date: Mon, 22 Nov 2004 08:58:02 +0100
Message-ID: <20041122075802.GL26240@suse.de>
References: <1100697589.32677.3.camel@localhost.localdomain> <20041117153706.GH26240@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:13235 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261967AbUKVH6a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Nov 2004 02:58:30 -0500
Content-Disposition: inline
In-Reply-To: <20041117153706.GH26240@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Nov 17 2004, Jens Axboe wrote:
> On Wed, Nov 17 2004, Alan Cox wrote:
> > Working on tracing down Fedora bug #115458
> > (https://bugzilla.redhat.com/bugzilla/process_bug.cgi) I found what
> > appears to be a race between the IDE CD driver and the hardware status.
> > It doesn't appear to explain the bug at all but it does look like a bug
> > of itself
> > 
> > When we issue an ide command the status bits don't become valid for
> > 400nS. In the DMA case ide_execute_command handles this but in the PIO
> > case we don't do the needed locking, use OUTBSYNC to avoid posting or
> > delay. This means that in some situations we can execute the command
> > handler in PIO mode before the command status bits are valid and the
> > handler may read and act wrongly.
> > 
> > --- drivers/ide/ide-cd.c~	2004-11-17 14:08:42.950485320 +0000
> > +++ drivers/ide/ide-cd.c	2004-11-17 14:08:42.951485168 +0000
> > @@ -897,7 +897,10 @@
> >  		return ide_started;
> >  	} else {
> >  		/* packet command */
> > -		HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
> > +		spin_lock_irqsave(&ide_lock, flags);
> > +		HWIF(drive)->OUTBSYNC(WIN_PACKETCMD, IDE_COMMAND_REG);
> > +		ndelay(400);
> > +		spin_unlock_irqsave(&ide_lock, flags);
> >  		return (*handler) (drive);
> >  	}

btw alan, have you attempted to compile this? It averages 2 errors out
of 4 lines :)

-- 
Jens Axboe

