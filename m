From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [git patches] IDE updates (part 2)
Date: Wed, 24 Oct 2007 14:12:43 +0100
Message-ID: <20071024131243.GC32333@flint.arm.linux.org.uk>
References: <200710131825.24768.bzolnier@gmail.com> <20071014001238.GP8181@ftp.linux.org.uk> <4713C568.2060708@garzik.org> <20071015195807.GF8759@flint.arm.linux.org.uk> <4713C893.3050200@garzik.org> <20071024123851.GB32333@flint.arm.linux.org.uk> <471F4035.4030507@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51034 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbXJXNR6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Oct 2007 09:17:58 -0400
Content-Disposition: inline
In-Reply-To: <471F4035.4030507@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Oct 24, 2007 at 08:53:09AM -0400, Jeff Garzik wrote:
> Russell King wrote:
> >On Mon, Oct 15, 2007 at 04:07:47PM -0400, Jeff Garzik wrote:
> >>Russell King wrote:
> >>>On Mon, Oct 15, 2007 at 03:54:16PM -0400, Jeff Garzik wrote:
> >>>>Al Viro wrote:
> >>>>>Proposed addition to icside part, provided that ARM folks ACK it - gets
> >>>>>icside to build and AFAICS it's correct:
> >>>>ACK from me too...  ARM folks?
> >>>Will test tomorrow/Wednesday.
> >>Thanks.  Sorry about missing your CC on the libata-wide ata_link 
> >>changes.  We should have poked the maintainers on that, for the drivers 
> >>we cannot build ourselves.
> >
> >I think Viro's patch got an ack from everyone.  Who's dealing with getting
> >this regression fix into mainline?  It seems at the moment the patch is in
> >limbo.
> 
> I was waiting on you, who last said "Will test tomorrow/Wednesday" (with 
> presumably an ACK forthcoming after test results)
> 
> If it now has your ACK, it's ready and waiting in my mbox queue to be 
> merged upstream.

Looks like it got my ack more than a week ago:

| Date: Tue, 16 Oct 2007 16:55:07 +0100
| From: Russell King <rmk+lkml@arm.linux.org.uk>
| To: Al Viro <viro@ftp.linux.org.uk>
| Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
|         Linus Torvalds <torvalds@linux-foundation.org>,
|         linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
| Subject: Re: [git patches] IDE updates (part 2)
| 
| On Sun, Oct 14, 2007 at 01:12:39AM +0100, Al Viro wrote:
| > Proposed addition to icside part, provided that ARM folks ACK it - gets
| > icside to build and AFAICS it's correct:
| 
| Booted and tested as working.
| 
| Whatever-tag-that-is: Russell King <rmk+kernel@arm.linux.org.uk>

which I gave to the _initial_ message asking for my ack.  And no, before
you whinge and moan, I didn't drop any CC's.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
