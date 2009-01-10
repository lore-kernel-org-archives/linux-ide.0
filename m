From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Support for Marvel 6141 in ahci.c
Date: Sat, 10 Jan 2009 15:45:29 +0000
Message-ID: <20090110154529.7d7e7765@lxorguk.ukuu.org.uk>
References: <49686AE8.1050209@digadd.de>
	<20090110122438.0992c319@lxorguk.ukuu.org.uk>
	<49689A9B.2070508@digadd.de>
	<4968B6F8.9050005@wasp.net.au>
	<4968C1B6.3010701@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:46315 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752162AbZAJPpO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Jan 2009 10:45:14 -0500
In-Reply-To: <4968C1B6.3010701@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Brad Campbell <brad@wasp.net.au>, "Christian P. Schmidt" <schmidt@digadd.de>, linux-ide@vger.kernel.org

> > How is that working for you? I did the same style of patch back in 
> > 2.6.26 (on the same board) and found it died _hard_ when writing to more 
> > than one port at a time. It worked with only one drive attached though, 
> > although I could not get hot plugging to work either.
> 
> Yes... that is why the ID is not in there at present :/

You could try borrowing the extra logic from sl82c105_qc_defer and apply
it to the AHCI driver in this case. Would need a bit of reworking but it
is sufficient to keep command issue to one channel at a time.

Reminds me I must update the artop driver..
