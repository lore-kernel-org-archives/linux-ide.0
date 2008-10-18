From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC PATCH] falconide: remove needless ST-DMA locking
Date: Sat, 18 Oct 2008 12:25:48 +0200
Message-ID: <200810181225.48329.bzolnier@gmail.com>
References: <200810172041.17191.bzolnier@gmail.com> <alpine.DEB.1.00.0810180023010.22248@zirkon.biophys.uni-duesseldorf.de> <Pine.LNX.4.64.0810181043550.11796@anakin>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0810181043550.11796@anakin>
Content-Disposition: inline
Sender: linux-m68k-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Schmitz <schmitz@biophys.uni-duesseldorf.de>, linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org, Michael Schmitz <schmitz@debian.org>, Stephen R Marenka <stephen@marenka.net>
List-Id: linux-ide@vger.kernel.org

On Saturday 18 October 2008, Geert Uytterhoeven wrote:
> On Sat, 18 Oct 2008, Michael Schmitz wrote:
> > > While working on ide_do_request() improvements I stumbled upon
> > > mismatched ide_get_lock() / ide_release_lock() calls.
> > > 
> > > [ It seems to be known issue:
> > >  http://marc.info/?l=linux-m68k&m=121423752829622&w=2 ]
> > 
> > It is a known issue, and I submitted a simple fix to Geert a month or so ago.
> > It involves moving the ide_get_lock call inside the request loop instead of
> > doing it once at the start of the function.
> 
> See http://marc.info/?l=linux-ide&m=121473433631934&w=2
> 
> In response to this patch, I wondered:
> 
> > > If hwgroup->busy serves a similar purpose to falconide_intr_lock, what
> > > about
> > > moving the setting/clearing of hwgroup->busy into
> > > ide_{get,release}_lock()
> > > (and possibly renaming ide_{get,release}_lock() to e.g.
> > > ide_hwgroup_{set,clear}_busy())?
> > > 
> > > What about the other places where hwgroup->busy is set/cleared?
> 
> And Michael responsed:
> 
> > Uh - that's where it gets a bit sticky again. hwgroup->busy is set and
> > cleared quite a lot 'preemptively' all over ide-io.c, f.e. in timeout
> > handling. I'm not sure
> > whether this would just reintroduce the bug message.
> > 
> > The lock must be held as long as there are any interrupts to be expected
> > from IDE. If the hwgroup->busy semantics reflects just that, it's worth
> > a try.
> 
> Bart, can you shed a light on the hwgroup->busy semantics?

hwgroup->busy means that hwgroup is busy ;-)

It protects against any access to the underlying hardware so it is
also used when device is accessed in polling mode (without waiting
for IRQ).  However your proposal still sounds fine.  We can treat
hwgroup->busy as "waiting for IRQ" flag on Falcon and it would be
correct (we will just hold the lock needlessly sometimes but we're
already doing exactly that).

[ The one thing that we have to watch out is not to leak IDE core
  specific things to <asm/ide.h> and host/platform specific ones to
  IDE core so some new abstraction level may be needed for handling
  ST-DMA lock itself (->[un]lock_host methods in struct ide_port_ops
  or something along the lines)... ]

Thanks,
Bart
