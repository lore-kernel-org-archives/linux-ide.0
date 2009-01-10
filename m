From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: libata: make parallel port scan a per-host opt-in feature
Date: Fri, 9 Jan 2009 16:58:08 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901091657090.6528@localhost.localdomain>
References: <20090109161455.08d5a54c@infradead.org> <alpine.LFD.2.00.0901091655530.6528@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45178 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754904AbZAJA6R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Jan 2009 19:58:17 -0500
In-Reply-To: <alpine.LFD.2.00.0901091655530.6528@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jgarzik@pobox.net



On Fri, 9 Jan 2009, Linus Torvalds wrote:

> 
> 
> On Fri, 9 Jan 2009, Arjan van de Ven wrote:
> >  
> > +	if (!hpriv->cap & HOST_CAP_SSS)
> > +		host->flags |= ATA_HOST_PARALLEL_SCAN;
> > +
> 
> I don't think that does what you think it does.

And furthermore I'm surprised gcc doesn't warn about it. It would seem to 
be an obvious thing to warn about. I'll see what a sparse warning would 
look like.

		Linus
