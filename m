From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Regression: commit "ide: constify struct ide_port_info" causes
 breakage
Date: Fri, 26 Oct 2007 10:05:53 -0700
Message-ID: <20071026100553.754e20ab@laptopd505.fenrus.org>
References: <20071026155648.GB4321@flint.arm.linux.org.uk>
	<47221164.10200@ru.mvista.com>
	<alpine.LFD.0.999.0710260929290.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:35121 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447AbXJZRJq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2007 13:09:46 -0400
In-Reply-To: <alpine.LFD.0.999.0710260929290.30120@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Russell King <rmk@arm.linux.org.uk>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Fri, 26 Oct 2007 09:30:20 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Fri, 26 Oct 2007, Sergei Shtylyov wrote:
> > 
> >    We can just convert cariables declared as 'struct hpt_info' to
> > const too -- they are read-only templates.
> 
> Generally "__devinitdata" is better than "const", since it means that
> the data may be thrown away.
> 
> So if you drop one over the other, it's generally the "const" that
> should be dropped ;/
> 

we could do a
__constdevinitdata
that translate to "const" for the "not throw away" cases, and to the
throw-away secontion for the other cases...
