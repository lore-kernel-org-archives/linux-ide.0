From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata fixes
Date: Wed, 28 Mar 2007 13:53:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703281346060.6730@woody.linux-foundation.org>
References: <20070328073219.GA26024@havoc.gtf.org> <460A1A3D.6050501@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:59355 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752804AbXC1UxS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Mar 2007 16:53:18 -0400
In-Reply-To: <460A1A3D.6050501@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>



On Wed, 28 Mar 2007, Jeff Garzik wrote:
>
> Jeff Garzik wrote:
> > This disables libata ACPI, among other things.
> 
> If a -rc6 is possible, that would be quite nice...

Heh. I don't think -rc6 is "possible" - it's "inevitable". We have too 
much fallout from the timer changes still outstanding. It looks people 
finally figured out a big issue with the HPET timer, and that hopefully 
resolves most of the remaining timer-related regressions, but yes, we most 
definitely _will_ have an -rc6.

Andrew, what's your feeling apart from the timer fallout?

		Linus
