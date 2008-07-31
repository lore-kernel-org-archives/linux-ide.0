From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ide pmac breakage
Date: Thu, 31 Jul 2008 19:11:33 +1000
Message-ID: <1217495493.11188.441.camel@pasglop>
References: <1217208596.11188.144.camel@pasglop>
	 <200807302111.54514.bzolnier@gmail.com>
	 <1217458152.11188.355.camel@pasglop>
	 <200807310248.29214.bzolnier@gmail.com>
	 <20080731094901.062a2602@lxorguk.ukuu.org.uk>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:42878 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752565AbYGaJLy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 05:11:54 -0400
In-Reply-To: <20080731094901.062a2602@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, petkovbb@gmail.com

On Thu, 2008-07-31 at 09:49 +0100, Alan Cox wrote:
> > There seems to be some confusion between warm-plugging of IDE devices
> > and hot-plugging of IDE devices.
> > 
> > > not a single piece of HW to exercise those code path ? I don't ask you
> > > to get a powermac with a media-bay, but ide_cs seems to be a pretty
> > > important one that's part of what the ide maintainer should take care
> > > of... And I suspect it's going to exercise the same code path as
> > > mediabay.
> 
> That confuses people sometimes - ide_cs is a controller hotplug not a
> device hotplug ...

I could make the media-bay look like a controller hotplug if it was
going to make things easier...

Cheers,
Ben.


