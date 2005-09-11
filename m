From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
Date: Sat, 10 Sep 2005 17:02:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509101658080.30958@g5.osdl.org>
References: <Pine.LNX.4.44L0.0509101655520.7081-100000@netrider.rowland.org>
 <Pine.LNX.4.58.0509101410300.30958@g5.osdl.org> <43235707.7050909@pobox.com>
 <20050910153110.36a44eba.akpm@osdl.org> <Pine.LNX.4.58.0509101548230.30958@g5.osdl.org>
 <43236FD2.6010501@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:1256 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932457AbVIKACJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Sep 2005 20:02:09 -0400
In-Reply-To: <43236FD2.6010501@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>



On Sat, 10 Sep 2005, Jeff Garzik wrote:
> 
> I -do- want to use iomap.  The problem is that no one has yet come up 
> with a few that does all the proper resource reservation.  Everybody 
> (including myself) did the ioread/iowrite part, but gave up before 
> handling all cases of (a) legacy ISA iomap, (b) native PCI IDE iomap, 
> and (c) non-standard MMIO iomap.

It should all be trivial. The only ugly issue in the patch I just sent out 
is that it needs to save the "legacy_mode" bits that were calculated at 
initialization time somewhere in the ap structure. Then the 
release_regions should match the request_regions.

That's a cleanup, the current code is literally buggy. It may end up
releasing IO address 0x1f0 twice, if somebody wasn't marked legacy, but
actually had 0x1f0 in the PCI resource pointers (maybe that doesn't ever
happen, but still.. Relying on the legacy-value of the IO port instead of
relying on whether you did a legacy request_region() is definitely at
least conceptually wrong).

			Linus
