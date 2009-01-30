From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Switching from (deprecated) IDE driver -> SATA (PATA support)
Date: Fri, 30 Jan 2009 10:11:34 +0000
Message-ID: <20090130101134.1bb4d3b2@lxorguk.ukuu.org.uk>
References: <alpine.DEB.1.10.0901250553430.2441@p34.internal.lan>
	<200901252027.43376.bzolnier@gmail.com>
	<alpine.DEB.1.10.0901251612310.16676@p34.internal.lan>
	<200901252239.26268.bzolnier@gmail.com>
	<498240B7.6010500@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36431 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750992AbZA3KLb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jan 2009 05:11:31 -0500
In-Reply-To: <498240B7.6010500@tmr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bill Davidsen <davidsen@tmr.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> > However if you need we can bring support for HPT34x hardware back. :)
> 
> I don't think "bring it back" is enough, it had some major issues as I recall. I 
> actually have a pile of these, but not running any recent kernel.

And me - I've spent some time trying to dig deeper into the DMA on the
HPT343 but there isn't any useful documentation and Andre didn't have any
immediate insights (other than a slightly less than printable review of
his opinion of the device)

In PIO its pretty solid, but for the original 343 at least DMA is still a
bit of a mystery that might not be solved without a bus analyser - for
one it completes DMA transfers but they don't seem to arrive in the
location specified in the PRD, even if you try obvious errata type things
like 64K alignment.

Unfortunately if the errata is something gross like flipping bits in PRD
addresses we aren't going to be able to figure it out.

Alan
