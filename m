From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [patch 10/50] libata: force hardreset if link is in
	powersave mode
Date: Fri, 6 Jun 2008 18:57:30 -0700
Message-ID: <20080607015730.GA15123@kroah.com>
References: <20080607010215.358296706@sous-sol.org> <20080607010555.470605116@sous-sol.org> <alpine.LFD.1.10.0806061826420.3473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760647AbYFGCBc@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806061826420.3473@woody.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Tejun Heo <htejun@gmail.com>, Theodore Ts'o <tytso@mit.edu>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Jeff Garzik <jeff@garzik.org>, Greg Kroah-Hartman <gregkh@suse.de>, Justin Forbes <jmforbes@linuxtx.org>, linux-kernel@vger.kernel.org, Chris Wedgwood <reviews@ml.cw.f00f.org>, Domenico Andreoli <cavokz@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Randy Dunlap <rdunlap@xenotime.net>, Michael Krufky <mkrufky@linuxtv.org>, matthieu.castet@parrot.com, Chuck Ebbert <cebbert@redhat.com>, Dave Jones <davej@redhat.com>, akpm@linux-foundation.org, Chuck Wolber <chuckw@quantumlinux.com>, stable@kernel.org, alan@lxorguk.ukuu.org.uk
List-Id: linux-ide@vger.kernel.org

On Fri, Jun 06, 2008 at 06:27:15PM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 6 Jun 2008, Chris Wright wrote:
> >
> > -stable review patch.  If anyone has any objections, please let us know.
> > ---------------------
> > 
> > From: Tejun Heo <htejun@gmail.com>
> > 
> > Inhibiting link PM mode doesn't bring the link back online if it's
> > already in powersave mode.  If SRST is used in these cases, libata EH
> > thinks that the link is offline and fails detection.  Force hardreset
> > if link is in powersave mode.
> 
> This isn't upstream. Maybe there's some reason it's not needed upstream, 
> but it would be nice to know.

To quote Tejun when he sent this patch:
	---
	Patch for -stable only.  Devel branch now uses hardreset by
	default so this type of promotion logic isn't necessary anymore.


thanks,

greg k-h
