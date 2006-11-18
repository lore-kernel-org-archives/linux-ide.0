From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: possibility to merge via_pata fixes to .19 stable series?
Date: Sat, 18 Nov 2006 22:43:34 +0000
Message-ID: <20061118224334.72e3685c@localhost.localdomain>
References: <200611180759.34622.t.powa@gmx.de>
	<20061118002357.564dbb9d.akpm@osdl.org>
	<455F790C.2030509@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43478 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1755320AbWKRWjP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 18 Nov 2006 17:39:15 -0500
In-Reply-To: <455F790C.2030509@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Tobias Powalowski <t.powa@gmx.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Sat, 18 Nov 2006 16:20:12 -0500
Jeff Garzik <jeff@garzik.org> wrote:
> > I don't know if they're still concerns, nor if they're fatal concerns
> > either.  But I've been sitting on that patch for nearly five months.
> 
> This isn't driver-specific, so a similar change should be applied to the 
> core.

Agreed - it belongs in the core code. We see the same problem on multiple
controllers and its one of the big things that at the moment makes it
impossible to progress the PATA drivers further.

