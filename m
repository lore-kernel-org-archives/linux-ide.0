From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sata_sil data corruption
Date: Mon, 21 Feb 2005 11:29:23 -0500
Message-ID: <20050221162923.GA29621@havoc.gtf.org>
References: <Pine.LNX.4.58.0412281319001.5054@rainstorm.org> <421778E4.8060705@pobox.com> <Pine.LNX.4.58.0502211219250.23186@rainstorm.org> <4219A3AD.1000002@comcast.net> <421A0990.7070506@pobox.com> <4219C543.8030903@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from atlmail.prod.rxgsys.com ([64.74.124.160]:46035 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S262026AbVBUQ3f (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Feb 2005 11:29:35 -0500
Content-Disposition: inline
In-Reply-To: <4219C543.8030903@comcast.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Doug McLain <nostar@comcast.net>
Cc: PALFFY Daniel <dpalffy-lists@rainstorm.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Mon, Feb 21, 2005 at 11:25:55AM +0000, Doug McLain wrote:
> Jeff Garzik wrote:
> >Doug McLain wrote:
> >
> >>The sata_sil driver is without a doubt, totally hosed.  I, along with 
> >
> >
> >"without a doubt" being defined, of course, as "it works for a lot of 
> >people."
> >
> >    Jeff
> >
> >
> >
> >
> Thats like saying "turn up the radio" when your car makes a funny noise, 
> or "if a tree falls in the woods and nobody is there to hear it, does it 
> make a sound?"
> 
> It's tempting and comforting to pick the good ones as an example, and 
> some bugs are hard enough to find, let alone fix.  In the end though, if 
> one is broke, it's still broke, isn't it?

In this case, the bug _reports_ are hard to find.

Each case with sata_sil is either solved with a BIOS update, a
blacklist entry, or new cables.  Just read through bugzilla.kernel.org.

	Jeff



