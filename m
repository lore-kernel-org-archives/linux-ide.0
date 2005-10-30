From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [git patches] 2.6.x libata updates
Date: Sun, 30 Oct 2005 14:36:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0510301435520.27915@g5.osdl.org>
References: <20051029182228.GA14495@havoc.gtf.org> <4363CB60.2000201@pobox.com>
 <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org> <200510300644.20225.rob@landley.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:13764 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932374AbVJ3Wgs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Oct 2005 17:36:48 -0500
In-Reply-To: <200510300644.20225.rob@landley.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rob Landley <rob@landley.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org



On Sun, 30 Oct 2005, Rob Landley wrote:
> 
> Rather than making the patch a simple diff of the trees, make the patch a cat 
> of the individual patches/commits (preferably with descriptions) that got 
> applied, in the order they got applied.
> 
> This makes the patch bigger, but it also means that bisect can be done with 
> vi, simply by truncating the file at the last interesting patch and applying 
> the truncated version to a clean tree.  Since patch applies hunks in order 
> and sifts out hunks from description already...
> 
> Is this a viable option?

No.

There is no "ordering" in a distributed environment. We have things 
happening in parallel, adn you can't really linearize the patches.

The closest you can get is "git bisect", which does the right thing.

		Linus
