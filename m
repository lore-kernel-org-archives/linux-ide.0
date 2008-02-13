From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata/sata_sil24 cache alignment problem?
Date: Wed, 13 Feb 2008 20:21:51 +0000
Message-ID: <20080213202151.34b7e5bc@core>
References: <20080212180254.GA28237@postdiluvian.org>
	<20080212221257.12eeab13@core>
	<20080213184702.GA13458@postdiluvian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47889 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757263AbYBMUaF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 15:30:05 -0500
In-Reply-To: <20080213184702.GA13458@postdiluvian.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Mason <mason@postdiluvian.org>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

O> I'm counting on kmalloc to return a cache aligned buffer.  I found
> some reason to think it does, but I don't remember offhand what that

Its defined to

> reason was, or if it's configurable per-architecture.  The buffer has
> to be both physically and virtually contiguous, I was tempted to just
> allocate a page and waste some space but we've got 64K pages, so I'm a
> bit more sensitive about that.

Ok I was expecting a different approach if you mark the field with the
magic  ____cacheline_aligned tag after it (ie int foo ____blah_aligned;)
the compiler should align it all for you , which is probably cleaner if
it works.
