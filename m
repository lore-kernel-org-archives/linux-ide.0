From: Andy Warner <andyw@pobox.com>
Subject: Re: [t13] RE: comment on T10 ATA-passthru
Date: Fri, 29 Oct 2004 15:39:53 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041029153953.B29944@florence.linkmargin.com>
References: <A9B8FF43A76C0D42A80DDD73CF99BEC80548967B@azsmsx407> <20041029142539.A29944@florence.linkmargin.com> <20041029194311.GA27218@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-02.rdc-kc.rr.com ([24.94.166.122]:408 "EHLO
	ms-smtp-02.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S263522AbUJ2Ulm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Oct 2004 16:41:42 -0400
Content-Disposition: inline
In-Reply-To: <20041029194311.GA27218@havoc.gtf.org>; from jgarzik@pobox.com on Fri, Oct 29, 2004 at 03:43:11PM -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linville@redhat.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> BTW, can you send me a patch that filters out
> SET FEATURES - XFER MODE ?
> 
> That should not be executed without driver intervention /
> synchronization.

There are _so_ many commands that can be terminal for
continued communication with the drive, do we really want to
start filtering commands ?

I don't really have a dog in this fight; my personal end
goal is for a drive-test-vehicle, so I'll need to be able
to circumvent any blacklist anyway. I'll happily add a
blacklist, but I'll just as happily add a way around it.

Would it be important/useful to make the pass-thru
stuff a config option ?

Plus, rev 5 of the spec is out now, and rev 6 may be
along soon. We're currently at rev 3 - I'll be wanting
to play catch-up soon. The changes are pretty intrusive,
so heads-up to anyone using it.

> P.S.  Any news on hotplug?

Err. It's got pushed down on my task stack, I have to
pop at least two things off that stack before I can get
back to it.

However, in working through recovery scenarios for
aborted PIO/DMA transfers, it looks like I need to
reset the port, which will interact with hotplug
because I lose drive phy status when I issue reset
via the SATA control regs. Hotplug looks like it
is going to be non-trivial, even though it's not
horribly complicated. My plan is to continue down
the route of seperating HBA init and drive probe.
For adapters that support hotplug (shouldn't all
SATA ?), I plan to just let the hotplug code take
care of drive probing. For HBAs that are brain
dead somehow (perhaps a PATA port ?), I plan to
provide some easy hook that the hba driver can
call during xxx_add_one()[or whatever.] Issues
already identified include flagging a drive that's
absent, and failing any subsequent requests, so
that we don't hang trying to sync a disk that's
not there any more.

Thoughts and advice wrt possible use of outboard
SATA switches and how that will need to interact
with hotplug would be gratefully received.

Post-hotplug, I'm going to be looking at NCQ, care
to share any high-level design decisions that you
(or others) have already taken in that area ?
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
