From: Jens Axboe <axboe@suse.de>
Subject: Re: PATCH (for comment): ide-cd possible race in PIO mode
Date: Wed, 17 Nov 2004 21:56:02 +0100
Message-ID: <20041117205602.GO26240@suse.de>
References: <1100697589.32677.3.camel@localhost.localdomain> <20041117153706.GH26240@suse.de> <1100708728.420.68.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:34177 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262528AbUKQU4b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Nov 2004 15:56:31 -0500
Content-Disposition: inline
In-Reply-To: <1100708728.420.68.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Nov 17 2004, Alan Cox wrote:
> On Mer, 2004-11-17 at 15:37, Jens Axboe wrote:
> > > -		HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
> > > +		spin_lock_irqsave(&ide_lock, flags);
> > > +		HWIF(drive)->OUTBSYNC(WIN_PACKETCMD, IDE_COMMAND_REG);
> > > +		ndelay(400);
> > > +		spin_unlock_irqsave(&ide_lock, flags);
> > >  		return (*handler) (drive);
> > >  	}
> > >  }
> > 
> > What good does the lock do?
> 
> The same as in ide_execute_command - make sure we don't take an IDE
> interrupt that tries to read the state during the delay. That is the old
> 2.4 "may drives shared IRQ random fails" fix and why the lock is taken
> in ide_execute_command.

Ah I see, makes sense. I didn't think about the shared irq case.

-- 
Jens Axboe

