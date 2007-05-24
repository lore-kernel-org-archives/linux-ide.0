From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.22-rc2: known regressions with patches
Date: Thu, 24 May 2007 09:54:16 -0700
Message-ID: <20070524095416.d3371632.akpm@linux-foundation.org>
References: <46559B62.5040903@googlemail.com>
	<20070524161116.047c55e9@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752075AbXEXQz1@vger.kernel.org>
In-Reply-To: <20070524161116.047c55e9@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, viro@zeniv.linux.org.uk, Uwe Bugla <uwe.bugla@gmx.de>, Ken Chen <kenchen@google.com>, xfs-masters@oss.sgi.com, Jeremy Fitzhardinge <jeremy@goop.org>, David Chinner <dgc@sgi.com>, Andrea Righi <righiandr@users.sourceforge.net>, Christoph Lameter <clameter@sgi.com>, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, Francis Russell <francisrussell@btopenworld.com>, Alan Cox <alan@redhat.com>, Andi Kleen <ak@suse.de>, discuss@x86-64.org, Ben Collins <ben.collins@ubuntu.com>
List-Id: linux-ide@vger.kernel.org

On Thu, 24 May 2007 16:11:16 +0100 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > Subject    : pata_via appears to incorrectly detects 40-pin cable
> > References : http://lkml.org/lkml/2007/5/17/273
> >              http://bugzilla.kernel.org/show_bug.cgi?id=8142
> > Submitter  : Francis Russell <francisrussell@btopenworld.com>
> > Status     : Not really a regression. Alan seems to have a general fix.
> >              (Tejun Heo)
> 
> The laptop one has been resolved, tested and fired at Andrew.

Do you recall the Subject: on that patch?

> Note btw that the bugzilla and email refer to two differing bugs. The
> SATA one (bugzilla ref) has gone to Jeff and is a different fix.

And that?

Thanks.
