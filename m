From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: libata: make parallel port scan a per-host opt-in feature
Date: Fri, 9 Jan 2009 17:00:41 -0800
Message-ID: <20090109170041.2d830cd5@infradead.org>
References: <20090109161455.08d5a54c@infradead.org>
	<alpine.LFD.2.00.0901091655530.6528@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:55828 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759433AbZAJA6g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Jan 2009 19:58:36 -0500
In-Reply-To: <alpine.LFD.2.00.0901091655530.6528@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jgarzik@pobox.net

On Fri, 9 Jan 2009 16:56:59 -0800 (PST)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Fri, 9 Jan 2009, Arjan van de Ven wrote:
> >  
> > +	if (!hpriv->cap & HOST_CAP_SSS)
> > +		host->flags |= ATA_HOST_PARALLEL_SCAN;
> > +
> 
> I don't think that does what you think it does.
> 
> 		Linus
argh two few ()'s


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
