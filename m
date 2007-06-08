From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Re: Linux v2.6.22-rc3
Date: Fri, 8 Jun 2007 16:59:10 +0100
Message-ID: <20070608165910.576c9949@the-village.bc.nu>
References: <alpine.LFD.0.98.0706071352440.4205@woody.linux-foundation.org>
	<20070607224746.GA23290@havoc.gtf.org>
	<46690D10.9040808@gmail.com>
	<20070608122750.7f8ae0e0@the-village.bc.nu>
	<46693E33.6080705@gmail.com>
	<20070608124058.7948dee1@the-village.bc.nu>
	<20070608142822.GB25649@havoc.gtf.org>
	<20070608163615.3177dd9a@the-village.bc.nu>
	<20070608153256.GD25649@havoc.gtf.org>
	<20070608164630.0cec98ff@the-village.bc.nu>
	<20070608154908.GG25649@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40625 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752121AbXFHPyi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jun 2007 11:54:38 -0400
In-Reply-To: <20070608154908.GG25649@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Gregor Jasny <gjasny@googlemail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

> I agree IT821x wants fixing, FWIW, just trying to get a handle on
> the big picture.  I'm not surprised that IT821x gets reset wrong,
> since it's a very non-standard BIOS.

Its a firmware emulation bug, the IT821X is emulating an IDE device
rather than neccessarily exposing one directly to the kernel.
