From: Andrew Morton <akpm@osdl.org>
Subject: Re: possibility to merge via_pata fixes to .19 stable series?
Date: Sat, 18 Nov 2006 19:07:20 -0800
Message-ID: <20061118190720.4498d14e.akpm@osdl.org>
References: <200611180759.34622.t.powa@gmx.de>
	<20061118002357.564dbb9d.akpm@osdl.org>
	<455F790C.2030509@garzik.org>
	<20061118224334.72e3685c@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:60113 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1755694AbWKSDIC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Nov 2006 22:08:02 -0500
In-Reply-To: <20061118224334.72e3685c@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Tobias Powalowski <t.powa@gmx.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, matthieu castet <castet.matthieu@free.fr>

On Sat, 18 Nov 2006 22:43:34 +0000
Alan <alan@lxorguk.ukuu.org.uk> wrote:

> On Sat, 18 Nov 2006 16:20:12 -0500
> Jeff Garzik <jeff@garzik.org> wrote:
> > > I don't know if they're still concerns, nor if they're fatal concerns
> > > either.  But I've been sitting on that patch for nearly five months.
> > 
> > This isn't driver-specific, so a similar change should be applied to the 
> > core.
> 
> Agreed - it belongs in the core code. We see the same problem on multiple
> controllers and its one of the big things that at the moment makes it
> impossible to progress the PATA drivers further.

A five month stall of a patch which makes the difference betweem "working"
and "not working" sounds pretty serious.

Is this something someone is working on?  If not, is it something which
Matthieu might have time to look into (please?)
