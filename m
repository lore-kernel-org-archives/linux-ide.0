From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [CALL-FOR-HELP] pata_ali: can't get MWDMA working!
Date: Wed, 9 Jan 2008 17:16:35 +0000
Message-ID: <20080109171635.27d625f0@lxorguk.ukuu.org.uk>
References: <4784FBC1.7070804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52736 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752421AbYAIRTF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 12:19:05 -0500
In-Reply-To: <4784FBC1.7070804@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, andre@linux-ide.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> trying to fix it for some time now && finally got a machine with
> pata_ali and non-working MWDMA2 ATAPI device on my desk a few weeks ago.

Oh good. I've been through a pile of ones that just work.

Which North and south does it have and what revision ?

> I walked through IDE and libata codes and found some differences in the
> order registers are accessed and which values are written (e.g. libata
> never turns on device 0/1 DMA capable bits in BMDMA status register
> while IDE does).  I made them access the registers in the same order and
> write the same values.  Still no go.

Tried that.

> Then, I made libata probing sequence very close to IDE such that no
> reset is performed and NIEN isn't tempered with.  No go.

Ditto, and removing the taskfile writing optimisations

> So, I'm out of ideas at this point.  Any suggestions?  Ideas?

Short of doing a printk of each access to the PCI and I/O space and
comparing them no. I ran out of ideas as well. I guess some kind of weird
chance alignment bug but who knows, and the docs I have don't explain it.

Alan
