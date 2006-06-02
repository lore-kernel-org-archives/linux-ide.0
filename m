From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 2/6] The definition of ahci_start_fis_rx() and   ahci_stop_fis_rx()
Date: Fri, 2 Jun 2006 11:26:26 +0200
Message-ID: <20060602092626.GE4400@suse.de>
References: <1149234295.13451.54.camel@forrest26.sh.intel.com> <20060602091544.GA4400@suse.de> <1149239367.29552.9.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:1383 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751352AbWFBJYQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Jun 2006 05:24:16 -0400
Content-Disposition: inline
In-Reply-To: <1149239367.29552.9.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jeff@garzik.org, hare@suse.de, htejun@gmail.com, jeremy@goop.org, lkml@rtr.ca, linux-ide@vger.kernel.org

On Fri, Jun 02 2006, zhao, forrest wrote:
> On Fri, 2006-06-02 at 11:15 +0200, Jens Axboe wrote:
> > On Fri, Jun 02 2006, zhao, forrest wrote:
> > > +	/*
> > > +	 * Disable FIS reception
> > > +	 *
> > > +	 * AHCI Rev 1.1 Section 10.1.2:
> > > +	 * If PxCMD.FRE is set to '1', software should clear it
> > > +	 * to '0' and wait at least 500 milliseconds for PxCMD.FR
> > > +	 * to return '0' when read. If PxCMD.FR does not clear
> > > +	 * '0' correctly, then software may attempt a port reset
> > > +	 * of a full HBA reset to recover.
> > > +	 */
> > > +	tmp &= ~(PORT_CMD_FIS_RX);
> > > +	writel(tmp, port_mmio + PORT_CMD);
> > > +
> > > +	mdelay(500);
> > > +	work = 1000;
> > 
> > The spec states that you should wait up to 500msec for this condition to
> > happen, not wait 500msec before looking at it! So please rework this
> > bit, a half second potentially wasted busy loop is quite nasty.
> 
> The spec says If PxCMD.FRE is set to '1', software should clear it to
> '0' and wait *at least* 500 milliseconds for PxCMD.FR to return '0' when
> read.
> 
> It's "at least", not "up to".

That still doesn't make the code right. So make it wait 1 seconds max,
but don't delay 500msec at the beginning. That's my problem.

-- 
Jens Axboe

