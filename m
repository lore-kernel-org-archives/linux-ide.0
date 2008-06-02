From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata: ahci: power off unused ports
Date: Mon, 2 Jun 2008 14:54:58 +0100
Message-ID: <20080602145458.011b3655@core>
References: <20080508161008.59361de5@appleyard>
	<20080527030854.GC7515@mit.edu>
	<20080527143202.4bab5bf0@appleyard>
	<20080527225926.GE6843@mit.edu>
	<20080527163251.04054a74@appleyard>
	<20080531080015.GG5405@ucw.cz>
	<4842F5A8.9020708@garzik.org>
	<20080602080440.25fc663c@core>
	<4843A4A7.3020809@garzik.org>
	<20080602092225.26db9b5b@core>
	<4843C1E0.3080900@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:33776 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754765AbYFBOKf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jun 2008 10:10:35 -0400
In-Reply-To: <4843C1E0.3080900@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Pavel Machek <pavel@ucw.cz>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Theodore Tso <tytso@mit.edu>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> > We don't need it per port Jeff, you are being quite silly here. Right now
> > its permanently foo=0 for all ports and nobody has suffered anything too
> > horrible so being able to turn it off for all ports is clearly quite
> > sufficient for the neat future.
> 
> Er, huh?  foo=0 means hotplug continues to work on the unused ports. 
> Nobody has suffered because we default to enabling all the goodies.

Thats a simple question of what "=0" means - is it "disable=1" or
"enable=1" or to quote Alice in Wonderland

	'When I use a word,' Humpty Dumpty said, in a rather scornful
	tone,' it means just what I choose it to mean, neither more nor
	less

It really doesn't matter if it is on by default or off by default,
whether 0 means off or on, what matters is that the single switch is
quite sufficient initially to improve matters for everyone wanting to use
the feature without harming anyone else.

Sure you might want to make it per port later but someone who wants to
optimise that peculiar case, has a problem and can test it can deal with
that.

Alan

