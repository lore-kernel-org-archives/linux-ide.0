From: James Cloos <cloos@jhcloos.com>
Subject: Re: [BK PATCHES] ide-2.6 update
Date: Sun, 24 Oct 2004 13:51:53 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <m3u0sjon4m.fsf@lugabout.cloos.reno.nv.us>
References: <58cb370e04102405081d62bf40@mail.gmail.com>
	<m3zn2boq1h.fsf@lugabout.cloos.reno.nv.us>
	<58cb370e04102413156543b72e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ore.jhcloos.com ([64.240.156.239]:19210 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S261605AbUJXUwD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Oct 2004 16:52:03 -0400
In-Reply-To: <58cb370e04102413156543b72e@mail.gmail.com> (Bartlomiej
 Zolnierkiewicz's message of "Sun, 24 Oct 2004 22:15:26 +0200")
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

>>>>> "BZ" == Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> writes:

BZ> All these data can be obtained from user-space, no need for
BZ> bloating sysfs.

Cool.

BZ> http://home.elka.pw.edu.pl/~bzolnier/atapci/

BZ> released > 2 years ago :)

BZ> works fine but probably needs some cut'n'paste updates

Now to get the distributions to pick it up.  I've checked gentoo and
debian (sid); neither has it.

BZ> Most of these /proc files were buggy / inaccurate and keeping them
BZ> had real maintenance cost (hpt366 bug, triflex bug etc.) with
BZ> absolutely no added gain in debugging problems (raw PCI config
BZ> gives much more info).

I always went their first for a quick overview, but since your
atapci(8) provides all of that -- and more, of course -- lspci(8)-
style ubiquity for it is enough. :)

-JimC


