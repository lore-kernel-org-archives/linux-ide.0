From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata fixes
Date: Tue, 3 Jul 2007 09:42:56 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0707030941280.9434@woody.linux-foundation.org>
References: <20070703155238.GA7344@havoc.gtf.org> <20070703170734.5a25b9c5@the-village.bc.nu>
 <alpine.LFD.0.98.0707030919391.9434@woody.linux-foundation.org>
 <20070703173429.24b5dbdc@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52700 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755093AbXGCQnP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 12:43:15 -0400
In-Reply-To: <20070703173429.24b5dbdc@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>



On Tue, 3 Jul 2007, Alan Cox wrote:
>
> > attribution. Probably because of some insane system he uses (he has a 
> > comment in that bugzilla about "patch from comment #14 is in CVS now.".
> > 
> > CVS? What kind if insane setup do you have there at Red Hat?
> 
> CVS is used for tracking patch sets for RPMS rather than source trees.
> Its quite good at that job and its reliable and proven and has been done
> that way for years. When you are keeping a stable distribution for large
> business end users the "stable and proven" wins over new technology...

Yes, but it also explains why it lost all authorship. 

So instead of complaining to Jeff about this, you should look at YOUR OWN 
damn system. It was apparently your "enterprise ready" stuff, used by 
another Red Hat engineer, that screwed up.

THAT is my point.

			Linus
