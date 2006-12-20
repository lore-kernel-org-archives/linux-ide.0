From: Stephen Frost <sfrost@snowman.net>
Subject: Re: [git patches] libata fixes
Date: Wed, 20 Dec 2006 16:19:27 -0500
Message-ID: <20061220211927.GI24675@kenobi.snowman.net>
References: <20061220210042.GA25303@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kenobi.snowman.net ([70.84.9.186]:32946 "EHLO
	kenobi.snowman.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030350AbWLTVpl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Dec 2006 16:45:41 -0500
Content-Disposition: inline
In-Reply-To: <20061220210042.GA25303@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

* Jeff Garzik (jeff@garzik.org) wrote:
> FWIW the Tejun cleanups are a fix, split into three reviewable pieces.
> 
> Also, my local iomap branch has advanced sufficiently enough that I
> think it's high time to kill those libata warnings that spew on every
> build.  (I hear the crowds roar)

Perhaps I missed it, but, when is PMP support going to be included in
main-stream?  Seems like it's been around for a while now and I doubt
I'm the only one extremely frustrated with having to hunt down an
external patch to get a new toy supported.  I'll probably bug the Debian
kernel folks next but it'd be nicer if it was in upstream.

	Thanks!

		Stephen
