From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Problem with ata layer in 2.6.24
Date: Tue, 29 Jan 2008 15:47:52 +0000
Message-ID: <20080129154752.3d7758f1@core>
References: <200801272122.21823.gene.heskett@gmail.com>
	<479E1D9E.3000900@bobjweil.com>
	<20080129121201.2f727f5f@core>
	<200801290951.55492.gene.heskett@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47078 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1764811AbYA2PwQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jan 2008 10:52:16 -0500
In-Reply-To: <200801290951.55492.gene.heskett@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gene Heskett <gene.heskett@gmail.com>
Cc: Richard Heck <rgheck@bobjweil.com>, Daniel Barkalow <barkalow@iabervon.org>, Zan Lynx <zlynx@acm.org>, Calvin Walton <calvin.walton@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ide Mailing list <linux-ide@vger.kernel.org>

> As slight change here, I was going to use the same .config as 2.6.24-rc8, but 
> just discovered that neither rc8 nor final is finding the drivers for my

If it is not finding a driver that is nothing to do with libata. It means
it's not being loaded by the distribution, or the distribution kernel is
too old (2.6.22) for the hardware - in which case see the Fedora respins
which are on 2.6.23.something right now.

Alan
