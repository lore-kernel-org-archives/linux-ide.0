From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] IDE TCQ #2
Date: Fri, 3 May 2002 22:56:35 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <aautqf$kvd$2@main.gmane.org>
References: <20020503110652.GF839@suse.de> <20020503163248.633c8358.sebastian.droege@gmx.de> <20020503164555.GQ839@suse.de> <20020503185744.7f4e192f.sebastian.droege@gmx.de> <20020503170118.GV839@suse.de> <20020503193006.6b4b9094.sebastian.droege@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20020503193006.6b4b9094.sebastian.droege@gmx.de>
List-Id: linux-ide@vger.kernel.org
To: Sebastian Droege <sebastian.droege@gmx.de>
Cc: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Fri, May 03 2002, Sebastian Droege wrote:
> On Fri, 3 May 2002 19:01:18 +0200
> Jens Axboe <axboe@suse.de> wrote:
> 
> > > > > ide_tcq_intr_timeout: timeout waiting for interrupt...
> > > > > ide_tcq_intr_timeout: hwgroup not busy
> > > > 
> > > > We timed out waiting for an interrupt for service or dma completion.
> > > > Damn, I forgot to print which one. Please change that printk in
> > > > drivers/ide/ide-tcq.c:ide_tcq_intr_timeout() to:
> > > > 
> > > > 	printk("ide_tcq_intr_timeout: timeout waiting for %s interrupt...\n",
> > > > 		hwgroup->rq ? "completion" : "service");
> > > > 
> > > > and reproduce!
> > > Is this printk enough or should I handcopy the oops again? ;)
> > 
> > The oops is pretty irrelevant here, the fact that it triggers is enough
> > to know. I already know the backtrace :-)
> 
> It's a service interrupt....

Ok thanks, what were the other messages this time? Just the ones before
the oops.

Jens

