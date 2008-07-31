From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ide pmac breakage
Date: Thu, 31 Jul 2008 09:49:01 +0100
Message-ID: <20080731094901.062a2602@lxorguk.ukuu.org.uk>
References: <1217208596.11188.144.camel@pasglop>
	<200807302111.54514.bzolnier@gmail.com>
	<1217458152.11188.355.camel@pasglop>
	<200807310248.29214.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:59721 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752627AbYGaJGo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Jul 2008 05:06:44 -0400
In-Reply-To: <200807310248.29214.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: benh@kernel.crashing.org, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, petkovbb@gmail.com

> There seems to be some confusion between warm-plugging of IDE devices
> and hot-plugging of IDE devices.
> 
> > not a single piece of HW to exercise those code path ? I don't ask you
> > to get a powermac with a media-bay, but ide_cs seems to be a pretty
> > important one that's part of what the ide maintainer should take care
> > of... And I suspect it's going to exercise the same code path as
> > mediabay.

That confuses people sometimes - ide_cs is a controller hotplug not a
device hotplug ...

