From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH (for comment): ide-cd possible race in PIO mode
Date: Wed, 17 Nov 2004 16:25:30 +0000
Message-ID: <1100708728.420.68.camel@localhost.localdomain>
References: <1100697589.32677.3.camel@localhost.localdomain>
	 <20041117153706.GH26240@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:43493 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262456AbUKQR2i (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Nov 2004 12:28:38 -0500
In-Reply-To: <20041117153706.GH26240@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mer, 2004-11-17 at 15:37, Jens Axboe wrote:
> > -		HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
> > +		spin_lock_irqsave(&ide_lock, flags);
> > +		HWIF(drive)->OUTBSYNC(WIN_PACKETCMD, IDE_COMMAND_REG);
> > +		ndelay(400);
> > +		spin_unlock_irqsave(&ide_lock, flags);
> >  		return (*handler) (drive);
> >  	}
> >  }
> 
> What good does the lock do?

The same as in ide_execute_command - make sure we don't take an IDE
interrupt that tries to read the state during the delay. That is the old
2.4 "may drives shared IRQ random fails" fix and why the lock is taken
in ide_execute_command.


