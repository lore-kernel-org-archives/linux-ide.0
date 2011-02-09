From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Wed, 9 Feb 2011 21:13:51 +0000
Message-ID: <20110209211351.3d7eff85@lxorguk.ukuu.org.uk>
References: <4D51A648.20707@cfl.rr.com>
	<20110209085935.GE6558@htj.dyndns.org>
	<4D52B0B3.40900@cfl.rr.com>
	<20110209153714.558133d7@lxorguk.ukuu.org.uk>
	<4D52ECB6.4010408@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44718 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752716Ab1BIVKY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2011 16:10:24 -0500
In-Reply-To: <4D52ECB6.4010408@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Tejun Heo <tj@kernel.org>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Wed, 09 Feb 2011 14:36:22 -0500
Phillip Susi <psusi@cfl.rr.com> wrote:

> On 2/9/2011 10:37 AM, Alan Cox wrote:
> > Unlocking the HPA is actually necessary for sanity on a lot of systems
> 
> Right.. ones that were partitioned using an older kernel with the buggy
> behavior of unlocking it by default.

It would be constructive to take a more general view of the situation
than trying to assign blame and complaints.

> The ATA spec describes the HPA saying:
> 
> A reserved area for data storage outside the normal operating system
> file system is required for several
> specialized applications.

Correct. The vendors however primarily used it for completely different
things. Also trusting the BIOS is generally not a good idea.

> ubuntu forums and bug tracker each year of people with HPA problems and
> it always seems to be a small area, as opposed to hiding everything
> above 128 MB or something.

Possibly because we unlock them in the distro cases.

> > "Should we unlock" is almost an academic debate given we are the OS and
> > control the commands sent to the drive anyway.
> 
> Again, Linus's tree does not unlock, and should not since the bios
> presumably had a reason for locking it in the first place ( it stores
> something there ).

I think you miss the point.

If you always unlock the drive then the software behaviour can be to
either honour or ignore the HPA. The HPA is a combination of two things

1.	An indication from the drive that there are two sets of
geometry patterns

2.	A crude hack from the proprietary "we know better" world.

So the best option from a kernel point of view appears to be to unlock
the drive but to remember and enable user space to retrieve the
parameters.

In essence "what geometry do I care about" is policy for application code
like dmraid, and it can be better refined there. However we can't refine
it there if we don't unlock.

