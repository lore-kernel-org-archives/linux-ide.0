From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: 2.9.29.2: ide-tape: panic when probing device at boot
Date: Mon, 4 Jan 2010 11:45:12 +1030 (CST)
Message-ID: <201001040115.o041FCEA025051@turbo.physics.adelaide.edu.au>
References: <4A062702.8020404@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752895Ab0ADBQJ@vger.kernel.org>
In-Reply-To: <4A062702.8020404@kernel.org> from "Tejun Heo" at May 10, 2009 09:59:46 AM
Sender: linux-kernel-owner@vger.kernel.org
Cc: petkovbb@gmail.com, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>
List-Id: linux-ide@vger.kernel.org

Hi

> Borislav Petkov wrote:
> > Hi,
> > 
> > On Sat, May 09, 2009 at 05:57:49PM +0200, Bartlomiej Zolnierkiewicz wrote:
> >> [ cc:ing linux-ide and knowledgeable people ]
> >>
> >> Borislav/Tejun:
> >>
> >> Is the 2.6.29 problem the same thing that was fixed recently?
> > 
> > I'll let Tejun answer that one since I don't get an oops. However, now
> > that I have an ide-tape hardware here, I do get something DMA-related
> > failing during boot:
> > 
> > [    1.677012] hdb: Seagate STT8000A, ATAPI TAPE drive
> > 
> > ..
> > 
> > [    1.701097] hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
> > [    1.708289] hdb: bad DMA info in identify block
> > [    1.712872] hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
> > 
> > ..
> > 
> > [    3.450381] Uniform CD-ROM driver Revision: 3.20
> > [    5.467347] ide-tape: hdb <-> ht0: Seagate STT8000A rev 5.44
> > [    5.484852] ide-tape: hdb <-> ht0: 88KBps, 14*26kB buffer, 400ms tDS
> > 
> > and more specifically the bad DMA info in identify block thing above. I
> > haven't looked into it yet but its next on my TODO.
> 
> Yeah, I've been seeing that too (before and after my changes).
> Haven't investigated it yet.  Good that it's on your todo list.  :-)
> 
> >> Should I just push commit 1e75540ec5202cae63cd238c86bd880e3d496546
> >> ("ide-tape: remove back-to-back REQUEST_SENSE detection") to Linus
> >> or there is more needed to bring ide-tape to the world of living?
> > 
> > ... and I'm afraid we'll have to do some serious bugfixing since this
> > driver is behaving really funny :). Stay tuned, I'm on it.
> 
> Cool.

Has there been any movement on this in recent months?  I gave 2.6.30 a whirl
on the machine when that was released but it still gave major problems with
the ide-tape driver.  Is 2.6.32 likely to be improved?  If so I'll make
arrangements to test that version.

Presently I'm stuck with 2.6.24.x on this system since ide-tape holds
together enough on this version to work.  I really want to upgrade to a more
recent kernel but obviously I can't until ide-tape is functional again.

Regards
  jonathan
