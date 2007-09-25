From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: 2.6.23-rc7-mm1 AHCI ATA errors -- won't boot
Date: Tue, 25 Sep 2007 20:21:23 +0200
Message-ID: <20070925182123.GC2367@kernel.dk>
References: <46F7FBCB.4030803@gmail.com> <46F8665A.4000206@garzik.org> <46F94FF3.1000400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757064AbXIYSUX@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46F94FF3.1000400@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Berck E. Nash" <flyboy@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-ide@vger.kernel.org

On Tue, Sep 25 2007, Berck E. Nash wrote:
> Jeff Garzik wrote:
> 
> > The first step would be to clone the "upstream" branch of
> > git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> > 
> > and see if the problem is reproducible there.  If yes, then you have
> > narrowed down the problem to something my ATA devel tree has introduced
> > into -mm.
> 
> Nope, you're off the hook.  The libata tree works great, so it must be
> something else in -mm conflicting.

Can you try 2.6.23-rc8 plus this patch:

http://brick.kernel.dk/git-block.patch.bz2

and see if that works?

-- 
Jens Axboe
