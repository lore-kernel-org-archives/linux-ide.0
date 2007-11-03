From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Bart's efforts?
Date: Sat, 3 Nov 2007 14:10:22 +0000
Message-ID: <20071103141022.7a6c0209@the-village.bc.nu>
References: <87f94c370711030535r73846d45y2ef08a14ad94a78b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47343 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753970AbXKCOJQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Nov 2007 10:09:16 -0400
In-Reply-To: <87f94c370711030535r73846d45y2ef08a14ad94a78b@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

> My question is if the drivers/ide infrastructure is slowly moving in
> the direction of being leverageable by libata when/if it moves out of
> scsi.  Or does the drivers/ide code simply have the wrong kind of
> plumbing for libata to ever use.

I don't think there is anything useful in old IDE that isn't in the new.
However libata PATA support is not all new code, its built on and from
the old IDE driver code. Similarly there is stuff recently going on in
drivers/ide that is then going into drivers/ata (eg the IVB blacklists).

The big issue with drivers/ide is the core code which simply can't cope
with SMP or modern hardware designs.   don't consider drivers/ide
anything but "legacy" but lots of older systems use it and its important
it stays maintained. Bart is doing whats actually a pretty thankless job
- working on maintaining stuff for the short term knowing it has no real
future.

Alan
