From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.29-rc libata sff 32bit PIO regression
Date: Sun, 25 Jan 2009 15:22:11 +0000
Message-ID: <20090125152211.18a838f9@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.64.0901211322010.15945@blonde.anvils>
	<18807.33113.550070.329912@harpo.it.uu.se>
	<20090121214746.2b15d1de@lxorguk.ukuu.org.uk>
	<4977A6E5.6080506@ru.mvista.com>
	<20090121225808.1f5ffac1@lxorguk.ukuu.org.uk>
	<4977B10B.5050904@ru.mvista.com>
	<4977B1D1.2010305@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40739 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754051AbZAYPWz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Jan 2009 10:22:55 -0500
In-Reply-To: <4977B1D1.2010305@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Mikael Pettersson <mikpe@it.uu.se>, Hugh Dickins <hugh@veritas.com>, Jeff Garzik <jgarzik@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> >> "Note: only 32-bit writes to the data port are allowed when this bit is
> >> set."
> >>   
> >  
> >   Now tell me who forces you to set that bit (I assume it's the write 
> > buffer enable) for the ATAPI devices?
> 
>    Yes, it's the write buffer enable (about which I have written already).

Yeah that seems the best way to go - not I note that the old drivers/ide
driver programs it right for 16bit I/O or doing mixed 16/32 ..

Patch added to my tree which together with Hugh's change should do the
trick. The others I've checked seem to have no such rule except in VLB
space. Never tried ATAPI in anger on a VLB box but it's easy enough to
address and I'll do a third patch for those.

Alan
