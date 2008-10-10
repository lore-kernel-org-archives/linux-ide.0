From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Better timeout recovery
Date: Fri, 10 Oct 2008 10:19:41 +0100
Message-ID: <20081010101941.5822926e@lxorguk.ukuu.org.uk>
References: <20081009164351.26205.50193.stgit@localhost.localdomain>
	<87od1set2a.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44326 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751479AbYJJJT5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Oct 2008 05:19:57 -0400
In-Reply-To: <87od1set2a.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> I'd very much prefer comments to be formatted like this:

Would you... ;)

> > +	/* Can become DEBUG later */
> > +	if (count)
> > +		ata_port_printk(ap, KERN_WARNING,
> > +			"drained %d bytes to clear DRQ.\n", count);
> > +
> > +}
> 
> Presumably, you didn't intentionally leave a blank line before the
> closing brace.

Yes I did, it looked cleaner.

> Sorry if you were aware of all that and just sent the patch as a first
> draft in order to get comments on the actual code.

At the moment the main concern is the code quality - but you are right
I've not run the result through the style checker and probably should do
so.
