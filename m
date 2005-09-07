From: Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: Re: [patch 0/4] ide: Break ide_lock to per-hwgroup lock
Date: Wed, 7 Sep 2005 12:27:47 -0700
Message-ID: <20050907192747.GC3769@localhost.localdomain>
References: <20050906233322.GA3642@localhost.localdomain> <20050907091923.GE4785@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932189AbVIGT1t@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050907091923.GE4785@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>, Alok Kataria <alokk@calsoftinc.com>
List-Id: linux-ide@vger.kernel.org

On Wed, Sep 07, 2005 at 11:19:24AM +0200, Jens Axboe wrote:
> On Tue, Sep 06 2005, Ravikiran G Thirumalai wrote:
> > The following patchset breaks down the global ide_lock to per-hwgroup lock.
> > We have taken the following approach.
> 
> Curious, what is the point of this?
> 

On smp machines with multiple ide interfaces, we take per-group lock instead
of a global lock, there by breaking the lock to per-irq hwgroups.

Thanks,
Kiran
