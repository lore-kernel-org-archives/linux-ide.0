From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [git patches] libata fixes
Date: Fri, 16 Jan 2009 18:21:28 +0000
Message-ID: <20090116182128.35b63bf7@lxorguk.ukuu.org.uk>
References: <20090116152721.GA6994@havoc.gtf.org>
	<20090116093101.6d77b69b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55916 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S936651AbZAPSVs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Jan 2009 13:21:48 -0500
In-Reply-To: <20090116093101.6d77b69b.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

> > +	for (i = 0; i < 2; i++)
> 
> s/2/ARRAY_SIZE/

It's 2. It's always 2 for a SFF controller. ARRAY_SIZE is just confusing
in this case as the array won't change size.


> There's a 64-bit divide in there.  Will it link on 32-bit platforms?
> Or is this all 64-bit-only code?
> 
> wtf is an octeon anyway?  (greps).  Some MIPS thing.  I guess it's
> 64-bit-only.

Board specific driver anyway

