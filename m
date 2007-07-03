From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [git patches] libata fixes
Date: Tue, 3 Jul 2007 17:34:29 +0100
Message-ID: <20070703173429.24b5dbdc@the-village.bc.nu>
References: <20070703155238.GA7344@havoc.gtf.org>
	<20070703170734.5a25b9c5@the-village.bc.nu>
	<alpine.LFD.0.98.0707030919391.9434@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:42739 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759416AbXGCQ2b (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 12:28:31 -0400
In-Reply-To: <alpine.LFD.0.98.0707030919391.9434@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

> attribution. Probably because of some insane system he uses (he has a 
> comment in that bugzilla about "patch from comment #14 is in CVS now.".
> 
> CVS? What kind if insane setup do you have there at Red Hat?

CVS is used for tracking patch sets for RPMS rather than source trees.
Its quite good at that job and its reliable and proven and has been done
that way for years. When you are keeping a stable distribution for large
business end users the "stable and proven" wins over new technology...

Alan
