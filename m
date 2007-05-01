From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Problems with Linux SATA driver and ARC-770 IDE Bridge chip
Date: Tue, 1 May 2007 11:21:51 +0100
Message-ID: <20070501112151.5ffa4902@the-village.bc.nu>
References: <5760903.1177441381244.JavaMail.root@wombat.diezmil.com>
	<4636D7CE.9070702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50159 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161679AbXEAKSd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 May 2007 06:18:33 -0400
In-Reply-To: <4636D7CE.9070702@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: sjackerman@comcast.net, linux-ide@vger.kernel.org, cmetz@inner.net, Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, albertcc@tw.ibm.com

> Jeff, Alan, Mark and Albert, do you have ideas how we should support
> this one?  This thing locks up if nIEN is set in command FIS.  For

I believe they make a round receptacle for putting them in, along with
other rubbish.

> ahci and sata_sil24, we can and probably should stop setting nIEN when
> polling, but what are we gonna do with all the SFF controllers?  I can
> think of some dirty hacks along the line of polling with IRQ enabled
> but I would love to be enlightened with something cleaner.

The SFF controllers need nIEN, I don't believe this "product" is
supportable if the diagnosis and claims of the cause of the problem are
true - I've no idea if they are the half-clued ramblings of front line
support or someone technical and reflect the real reason the device fails.

We can certainly handle the "should be zero" for pure SATA controllers
where we decide what goes in that bit in the FIS, but for SFF based and
emulation controllers there's nothing we can sanely do.

Alan
