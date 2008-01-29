From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Problem with ata layer in 2.6.24
Date: Tue, 29 Jan 2008 12:12:01 +0000
Message-ID: <20080129121201.2f727f5f@core>
References: <200801272122.21823.gene.heskett@gmail.com>
	<1201539043.31293.7.camel@zem>
	<1201540830.6526.19.camel@localhost>
	<200801281230.32910.gene.heskett@gmail.com>
	<alpine.LNX.1.00.0801281248190.13593@iabervon.org>
	<479E1D9E.3000900@bobjweil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52370 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751099AbYA2MQ1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jan 2008 07:16:27 -0500
In-Reply-To: <479E1D9E.3000900@bobjweil.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Heck <rgheck@bobjweil.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>, Gene Heskett <gene.heskett@gmail.com>, Zan Lynx <zlynx@acm.org>, Calvin Walton <calvin.walton@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ide Mailing list <linux-ide@vger.kernel.org>

> not one problem but lots---is sufficiently widespread that a Mini HOWTO, 
> say, would be really welcome and, I'm guessing, widely used.

We don't see very many libata problems at the distro level and they for
the most part boil down to

- error messages looking different - Most bugs I get are things like
media errors (timeout looks different, UNC report looks different)

- broken hardware - I've closed a whole raft of bugs that turn out to be
new PC systems where even the BIOS doesn't see the drives

- faulty hardware being picked up because we actually do real error
checking now. We now check for and give some devices more slack while
still doing error checking. Both IDE layers also added blacklists for
stuff like the TSScorp DVD drives. Qemu has now had its bugs patched.

- sata_nv with >4GB of RAM, knowing being worked on, no old IDE driver
anyway
 
- pata_ali MWDMA with ATAPI, PIO works fine, all a bit of a mystery and
as it affects only a few chip variants hard to figure out. Workaround
libata.dma=1

- CS handling. On a few boxes using cable select (particularly on one
drive and not the other) shows up a problem, normally a failed SRST.
That's still under investigation.

- Promise timeouts. The old IDE times out then polls the device and finds
the IRQ was never sent and then recovers so the user sees a short stall
but no errors. The new libata doesn't do this and pdc202xx_old thus
produces some error messages on some boxes. Backup polling is on my todo
list.
