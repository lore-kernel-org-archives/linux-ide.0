From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] TXx9: Add TX4938 ATA support (v2)
Date: Fri, 24 Oct 2008 22:40:58 +0100
Message-ID: <20081024214057.GJ25297@linux-mips.org>
References: <20081023.011646.51867355.anemo@mba.ocn.ne.jp> <200810232206.50973.bzolnier@gmail.com> <4900F8DE.4070203@ru.mvista.com> <200810242252.25327.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h4.dl5rb.org.uk ([81.2.74.4]:46100 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750979AbYJXVlP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Oct 2008 17:41:15 -0400
Content-Disposition: inline
In-Reply-To: <200810242252.25327.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org, linux-ide@vger.kernel.org

On Fri, Oct 24, 2008 at 10:52:25PM +0200, Bartlomiej Zolnierkiewicz wrote:

> > > applied
> > >   
> > 
> >    Hm, I thought that one was for Ralf...
> 
> Ralf ACK-ed the change and was fine with it going through ide tree.
> 
> Anyway it really doesn't matter through whose tree such patches are
> going in as long as people are fine with them.
> 

To explain why - there were no ordering constraints but it's always nice
if all bits make it to kernel.org in one pull.  The arch part was rather
minor compared to the IDE part so this should preferably go through the
IDE tree.

> No need to add some more rigid kernel bureaucracy...

Wildy-acked-by: Ralf Baechle <ralf@linux-mips.org> :-)

  Ralf
