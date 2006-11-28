From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Scary Intel SATA problem: "frozen"
Date: Tue, 28 Nov 2006 10:33:29 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611281020590.4244@woody.osdl.org>
References: <20061114150454.GA11900@havoc.gtf.org>
 <Pine.LNX.4.64.0611280908320.4244@woody.osdl.org> <20061128180554.3ec64259@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:11985 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1758736AbWK1Sdt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 13:33:49 -0500
In-Reply-To: <20061128180554.3ec64259@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org



On Tue, 28 Nov 2006, Alan wrote:
>
> On Tue, 28 Nov 2006 09:31:51 -0800 (PST)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> >  I just had a scary thing on my nice new Intel i965 box (all Intel 
> > chipsets apart from some strange Marvell IDE interface that I'm not using 
> > and that no driver even detected, and a TI firewire thing that I'm 
> 
> Mr Morton has the Marvell libata driver in his tree waiting to head your
> way.

Well, I don't actually personally want it (I have nothing connected to it, 
nor any intention of connecting anything in the future), I just want my 
bog-standard PIIX driver to not do the scary things to me.

	"Mommy, mommy, the IDE messages/behaviour is scaring me!"

I just mentioned the Marvell chip because apart from those two (unused) 
chips, the box is absolutely and utterly bog-standard Intel-everything. 
The i965 may still be somewhat unusual right now, but that's going to 
change, and if there's something strange going on, we should try to fix it 
asap.

It could be a one-off thing (knock wood), but on the other hand, I've only 
been using this machine for a couple of weeks now, and I can't remember 
seeing anything even remotely similar on my other machines (including the 
earlier-generation i945 SATA setup that I've had a lot longer). So I worry 
that it's something i965-specific, and that will be a _very_ common 
chipset soon enough.

One data-point that may or may not be relevant: the afore-mentioned i945 
machine that I've had longer is otherwise reasonably similar, but the DVD 
drive on that one is in legacy mode. Not that I see why it should matter 
(the problem happened on the harddisk, not the DVD)...

		Linus
