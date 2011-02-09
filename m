From: Tejun Heo <tj@kernel.org>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Wed, 9 Feb 2011 22:41:18 +0100
Message-ID: <20110209214118.GA7196@atj.dyndns.org>
References: <4D51A648.20707@cfl.rr.com>
 <20110209085935.GE6558@htj.dyndns.org>
 <4D52B0B3.40900@cfl.rr.com>
 <20110209153714.558133d7@lxorguk.ukuu.org.uk>
 <4D52ECB6.4010408@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57046 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875Ab1BIVlZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2011 16:41:25 -0500
Received: by bwz15 with SMTP id 15so1438973bwz.19
        for <linux-ide@vger.kernel.org>; Wed, 09 Feb 2011 13:41:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D52ECB6.4010408@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Wed, Feb 09, 2011 at 02:36:22PM -0500, Phillip Susi wrote:
> On 2/9/2011 10:37 AM, Alan Cox wrote:
> > Unlocking the HPA is actually necessary for sanity on a lot of systems
> 
> Right.. ones that were partitioned using an older kernel with the buggy
> behavior of unlocking it by default.

Claiming it a bug doesn't really make it a bug.  Please drop it.

> > too, and there are really no standards. Remember the primary use of HPA
> > has actually been to hide most of the disk from buggy BIOSen so that the
> > OS can then unlock it after the BIOS has stopped looking.
> 
> The ATA spec describes the HPA saying:
> 
> A reserved area for data storage outside the normal operating system
> file system is required for several
> specialized applications.

Heh, yeah, ATA spec says a lot of shit.

> This tells me that it is intended for the bios to reserve an area of the
> disk that the OS should NOT access.  So far the only use of it that I
> have seen is by bioses to hide a small area, presumably to store
> platform specific information.  I see about a dozen reports on the
> ubuntu forums and bug tracker each year of people with HPA problems and
> it always seems to be a small area, as opposed to hiding everything
> above 128 MB or something.

Yeah, nowadays.  It's not how it started tho.

> > "Should we unlock" is almost an academic debate given we are the OS and
> > control the commands sent to the drive anyway.
> 
> Again, Linus's tree does not unlock, and should not since the bios
> presumably had a reason for locking it in the first place ( it stores
> something there ).

libata didn't have HPA unlocking support at the beginning so it was
only natural to make the default to not unlock when the feature was
added.  For distros, the story is different because they migrated from
ide to libata.  ide unlocked by default so it was also natural for
them to make liata unlock it by default; otherwise, they could end up
with situation where upgrading to newer distro could break an
installation.

So, no, the situation has always been quite muddy with HPA and if you
ask me it is an inherently stupid feature bound to cause problems.
The setting is not even bound to the hard drive.  You move a hard
drive to a different machine, the size changes, hooray!  Oh right,
suspend/resume cycle can accidentally lock or unlock HPA areas on some
BIOSen and we have workaround for that in libata, yuck.

I think ide had it right all along.  We should just have unlocked
things by default when HPA unlock feature was added.  A lot of BIOSen
configure HPA for no reason anyway.  To continue the rant, I think
it's pretty silly to use fakeraid to begin with but maybe we should
just printk big ugly message to scare people away.  Ah well.

To sum up, no, not unlocking HPA by default was not a conscious
decision and neither was some distros defaulting to unlocking it.
Those decisions are all made by inertia, so please stop bringing them
up.  They don't mean much.

I think all we can do now is just let block layer publish before and
after sizes and adapt the tools accordingly.  I remember bringing the
idea quite a while ago with dmraid folks but IIRC nobody responded.  I
guess I'll make the change and hope others to take care of the rest.

I frankly don't care that much whether some silly fakeraids are broken
or not.  Maybe I should but they're so braindamanged and I just can't.

Thanks.

--
tejun
