From: Declan Moriarty <declan.moriarty@iol.ie>
Subject: Re: IDE Problem with old Gateway laptop -SOLVED
Date: Mon, 05 Nov 2007 15:23:10 +0000
Message-ID: <1194276190.2633.137.camel@localhost.localdomain>
References: <884696.96067.qm@web54404.mail.yahoo.com>
	 <1193830965.2347.66.camel@turtle-25895.iol.ie>
	 <20071031175812.7dc9cc8f@the-village.bc.nu>
Reply-To: declan.moriarty@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail2.mail.iol.ie ([193.95.141.54]:37193 "EHLO
	mail2.mail.iol.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbXKEPX3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Nov 2007 10:23:29 -0500
In-Reply-To: <20071031175812.7dc9cc8f@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Kevin Day <thekevinday@gmail.com>
Cc: Vlad Codrea <vladc6@yahoo.com>, linux-ide <linux-ide@vger.kernel.org>

On Wed, 2007-10-31 at 17:58 +0000, Alan Cox wrote:
> > 	kjournald starting Commit interval 5 seconds
> > 	VFS: Mounted root (ext3 filesystem) readonly
> > 	Freeing unused kernel memory: 168k freed
> > (keyboard still echoed onscreen, disk parked)
> > 
> > Adding init=/bin/bash is no better.
> 
> So its the user space which is broken. Make sure the user space has the
> right /dev etc - and is for the right CPU - a 200MHz pentium means you
> need i386 or i586 binaries. i686/athlon binaries would produce the effect
> you report.

Remember this? The problem appears to have been uClibc-0.9.29.

Dropping the system to uClibc-0.9.28.3 and building the minimum as a
proof of concept, I'm running with init=/bin/bash. This is using the
same 2 kernels, one compiled under uClibc-0.9.29, and one under glibc
(not installed there) which seems to indicate that the kernel is fairly
libc independent. I have both systems on that laptop currently.
Hda3(with uClibc-0.9.28.3) boots whereas the same system on hda4
(uClibc-0.9.29)does not.

It's actually quite audible whether it works or not, as you barely hear
the hard disk on the dodgy one at all, while the good one gives it a
thrashing before coming up with. It's either that libc or some i686 code
sneaked through to the old pentium. If I knew a handy way to check that,
I'd do for it.


-- 
        With Best Regards,

        Declan Moriarty

