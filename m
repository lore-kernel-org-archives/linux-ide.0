From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: ATA bus error with external hd on esata
Date: Mon, 17 Dec 2007 12:09:17 -0500
Message-ID: <87f94c370712170909y691dc2e3rf7f23c64eff8da22@mail.gmail.com>
References: <47642D9A.4080600@softmonsters.com>
	 <476434C7.6040307@softmonsters.com>
	 <20071217025321.2f7507db.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756657AbXLQRJa@vger.kernel.org>
In-Reply-To: <20071217025321.2f7507db.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Zsolt Barat <zsolt@softmonsters.com>, lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Dec 17, 2007 5:53 AM, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Sat, 15 Dec 2007 21:10:47 +0100 Zsolt Barat <zsolt@softmonsters.com> wrote:
>
> > Zsolt Barat schrieb:
> > > hi list,
>
> Let's cc the IDE development list.
>
> > > i just bought a "MyBook" called external HD with a fixed enclosure, from
> > > WD. Connected to the SATA port i constantly get "ATA bus error" messages
> > > in the kernel log. Is this a known issue?
> > >

As an FYI: I've had a lot of problems with the big prepackaged drives
in the last 6 months even from Windows, so I would not be too quick to
blame Linux.

ie.
I bought several 500GB / 1000GB Buffalo Drives last month with plans
to use them from Windows via USB.

I attempted to do a lot of heavy file copying to/from them.  I was
getting a bunch of "Delayed Write Failures",

I finally gave up.

The 500GB drives had a single hard drive internally, so I opened the
case, removed the drive and connected them via standalone external
carriers I had around.  In that mode the drives worked fine (from
Windows).  I've used both standalone eSata external carriers and
standalone USB external carriers with these same physical drives with
no issues.

My conclusion is that the electronics in the prepackaged external
units is just not up to the job if your doing heavy i/o.

Greg
-- 
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
First 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.pdf

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
