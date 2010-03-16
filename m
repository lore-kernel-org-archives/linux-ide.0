From: Tejun Heo <tj@kernel.org>
Subject: Re: ATA 4 KiB sector issues.
Date: Tue, 16 Mar 2010 11:30:45 +0900
Message-ID: <4B9EED55.10201@kernel.org>
References: <4B947393.2050002@kernel.org> <201003100046.24695.arnd@arndb.de> <1158166a1003100114j6ea329fbh84bfad65dcac90bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41204 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937358Ab0CPCbj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Mar 2010 22:31:39 -0400
In-Reply-To: <1158166a1003100114j6ea329fbh84bfad65dcac90bf@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de

Hello,

On 03/10/2010 06:14 PM, Denys Vlasenko wrote:
> 63s/255h is more or less "standard" now.
> 
> Alignment issues can be solved by picking a good multiple of
> _heads_ or _cylinders_:

I've got a couple of comments stating that picking a good geometry
parameters can resolve the whole issue but I simply fail to see how it
could.  We can pick any parameter we wish, but there is no reliable
way to communicate the custom geometry parameters to others.

Geometry is determined by two parameters sec/trk and heads/cyl.  You
can punch in those numbers if the BIOS has a menu for it (many don't
these days).  Or hope that BIOS can somehow figure it out from the
partition table which some BIOSs actually try to do.  The problem is
that to determine the two parameters you need to equations matching
CHSs and LBAs and that's available iff the first partition ends before
CHS addressing limit according to the custom geometry, which usually
is not the case.

So, custom geometry is only useful to trick partitioners which align
using cylinders into using better alignments but doesn't help anything
for compatibility as no one can determine the used geometry reliably
after the partitioning is complete.  With compatibility benefit gone,
there simply is no reason to stick to the cylinder abstraction at all.

Am I missing something?

Thanks.

-- 
tejun
