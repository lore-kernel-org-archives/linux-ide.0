From: Jens Axboe <axboe@suse.de>
Subject: Re: ide cdrom performance issue
Date: Wed, 8 Oct 2003 17:32:02 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031008153202.GD1584@suse.de>
References: <1065375332.1355.9.camel@server> <20031006073732.GV966@suse.de> <1065626920.1641.24.camel@server>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:47049 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261670AbTJHPcI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Oct 2003 11:32:08 -0400
Content-Disposition: inline
In-Reply-To: <1065626920.1641.24.camel@server>
List-Id: linux-ide@vger.kernel.org
To: Yossi Down-Under <fcp@pop.co.za>
Cc: linux-ide@vger.kernel.org

On Wed, Oct 08 2003, Yossi Down-Under wrote:
> On Mon, 2003-10-06 at 09:37, Jens Axboe wrote:
> > On Sun, Oct 05 2003, Yossi Down-Under wrote:
> > > Running RH9 with xcdroast and three recorders each on its own ide
> > > channel configured for ide-scsi. Having trouble with buffer underruns.
> > > Am told by xcdroast author that it is a kernel ide driver issue,
> > > specifically not using dma for transfers and recommended I try a newer
> > > kernel.
> > > 
> > > My question is whether the 2.5.75 kernel is going to improve this
> > > situation before going to the trouble to install it?
> > 
> > 2.5.75?! That kernel is ancient, you should download 2.6-test6 and give
> > that a try. Note that you should not then use ide-scsi (don't config it
> > in), and you need to give -dev=/dev/hdc as device argument to cdrecord.
> > Replace hdc with whatever is your cd-r drive.
> 
> OK, I did this. There must be some new package for module management
> required that is not in RH9 as it failed to load the network module when
> booted so I just compiled it into the kernel instead.
> 
> The problem I have now is that without using ide-scsi, xcdroast
> 0.98alpha14 doesn't see the drive. Will the ide-scsi driver also gain
> the use of dma transfers or should I go back to the xcdroast author to
> modify the program to use ide drives without scsi emulation?

ide-scsi is deprecated for cd burning, so yes you should probably talk
to him about updating xcdroast.

-- 
Jens Axboe

