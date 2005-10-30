From: Rob Landley <rob@landley.net>
Subject: Re: [git patches] 2.6.x libata updates
Date: Sun, 30 Oct 2005 17:31:46 -0600
Message-ID: <200510301731.47825.rob@landley.net>
References: <20051029182228.GA14495@havoc.gtf.org> <200510300644.20225.rob@landley.net> <Pine.LNX.4.64.0510301435520.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:65213
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932406AbVJ3XcB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 30 Oct 2005 18:32:01 -0500
In-Reply-To: <Pine.LNX.4.64.0510301435520.27915@g5.osdl.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 30 October 2005 16:36, Linus Torvalds wrote:
> > Is this a viable option?
>
> No.
>
> There is no "ordering" in a distributed environment. We have things
> happening in parallel, adn you can't really linearize the patches.
>
> The closest you can get is "git bisect", which does the right thing.
>
>   Linus

I know there isn't an absolute or stable ordering, but can't a temporary 
ordering be exported?

I was under the impression that the bk->cvs gateway squashed changes into a 
sort of order, way back when.  Admittedly this order wasn't stable, and new 
changes perturbed the whole list.  But just for debugging purposes with a 
"patch vs last -rc"?

Rob
