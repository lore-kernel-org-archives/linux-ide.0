From: "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: kernel bugzilla is FPOS (was: Re: "buggy cmd640" message followed by soft lockup)
Date: Sun, 25 Nov 2007 20:08:00 +0000
Message-ID: <20071125200800.GA9808@gallifrey>
References: <200711222007.12497.elendil@planet.nl> <200711251411.16034.rjw@sisk.pl> <20071125134945.GB14171@stusta.de> <200711252107.23926.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756672AbXKYUI2@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200711252107.23926.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Adrian Bunk <bunk@kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Natalie Protasevich <protasnb@gmail.com>
List-Id: linux-ide@vger.kernel.org

* Rafael J. Wysocki (rjw@sisk.pl) wrote:

<snip>
 (many levels of quote)

> > > > * Bugs that sit in NEEDINFO state for more than i.e. one month should be
> > > >   automatically closed.
> > > 
> > > I agree that we probably should do something like this.
> >  
> > Not automatically.
> 
> OK, say "as a rule".

The only thing I would say is that a reporter can be in a situation
after a while where they no longer have access to the original
machine; if the bug was originally believed to be real and triaged
then it seems to make sense to differentiate that from a bug that is
just closed, just so people can know there is an issue with
a configuration.

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
