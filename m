From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch 0/4] ide: Break ide_lock to per-hwgroup lock
Date: Tue, 27 Sep 2005 15:36:40 +0200
Message-ID: <58cb370e050927063674bb47a7@mail.gmail.com>
References: <20050906233322.GA3642@localhost.localdomain>
	 <20050907091923.GE4785@suse.de>
	 <20050907192747.GC3769@localhost.localdomain>
	 <20050907193422.GS4785@suse.de>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964942AbVI0Ngm@vger.kernel.org>
In-Reply-To: <20050907193422.GS4785@suse.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>, Alok Kataria <alokk@calsoftinc.com>
List-Id: linux-ide@vger.kernel.org

On 9/7/05, Jens Axboe <axboe@suse.de> wrote:
> On Wed, Sep 07 2005, Ravikiran G Thirumalai wrote:
> > On Wed, Sep 07, 2005 at 11:19:24AM +0200, Jens Axboe wrote:
> > > On Tue, Sep 06 2005, Ravikiran G Thirumalai wrote:
> > > > The following patchset breaks down the global ide_lock to per-hwgroup lock.
> > > > We have taken the following approach.
> > >
> > > Curious, what is the point of this?
> > >
> >
> > On smp machines with multiple ide interfaces, we take per-group lock instead
> > of a global lock, there by breaking the lock to per-irq hwgroups.
>
> I realize the theory behind breaking up locks, I'm just wondering about
> this specific case. Please show actual contention data promoting this
> specific case, we don't break up locks "just because".
>
> I'm asking because I've never heard anyone complain about IDE lock
> contention and a proper patch usually comes with analysis of why it is
> needed.

Since ide_lock spinlock is used for all drives as queue lock and for all
controllers as IDE lock I guess that with multiple controllers there is a lot
contention on it...

Breaking ide_lock is fine with me however seeing numbers would
greatly help in getting wider acceptance for this change, Ravikiran?

Bartlomiej
