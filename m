From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Asynchronous scan support for libata
Date: Sat, 8 Sep 2007 19:48:35 +0100
Message-ID: <20070908194835.03f1e39f@the-village.bc.nu>
References: <20070906210505.GF27404@parisc-linux.org>
	<46E258F3.20805@gmail.com>
	<20070908171917.GC6809@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34985 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754137AbXIHSk0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 14:40:26 -0400
In-Reply-To: <20070908171917.GC6809@parisc-linux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Sat, 8 Sep 2007 11:19:17 -0600
Matthew Wilcox <matthew@wil.cx> wrote:

> On Sat, Sep 08, 2007 at 05:10:27PM +0900, Tejun Heo wrote:
> > I think it's generally okay although it would need to spend quite some
> > time in -mm and we'll need to exclude several drivers which require
> > host-wide silence for mode programming (the current code is buggy but
> > sequential probing hides it pretty well) till host-wide exclusion is
> > implemented.
> 
> Can you tell me a bit more about these drivers?  Would it be possible to
> convert them to one host/many channels, which would give us the exclusion
> we want?

That would be a more natural way to do it and it would help for the cases
we don't support which are one command per controller not one per
channel. The PMP code has removed the two devices per channel assumption
so in theory we could already fake such a controller as a PMP setup but
obviously should expose the two things seperately.

Alan
