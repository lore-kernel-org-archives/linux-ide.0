From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: "Fix ATAPI transfer lengths" causes CD writing regression
Date: Thu, 1 Nov 2007 10:50:36 +0000
Message-ID: <20071101105036.3565decf@the-village.bc.nu>
References: <47274A5F.6070409@gentoo.org>
	<20071030153417.59b9182c@the-village.bc.nu>
	<47276DCA.1000808@gentoo.org>
	<20071030190153.373c9347@the-village.bc.nu>
	<47278439.4030801@gentoo.org>
	<20071031114958.210bd7cc@the-village.bc.nu>
	<20071031115754.GK5059@kernel.dk>
	<472872F6.70802@garzik.org>
	<4729209A.50809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:60771 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753882AbXKAKwS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Nov 2007 06:52:18 -0400
In-Reply-To: <4729209A.50809@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Jens Axboe <jens.axboe@oracle.com>, Daniel Drake <dsd@gentoo.org>, linux list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

O> Hmmm.... reading ide-cd.c::cdrom_pc_intr().  OIC, ide-cd is dealing with
> this problem by draining PIO after BMDMA engine is done.  This is
> possible for BMDMA engines as they simply step out when the SG entries
> are exhausted; then, the interrupt handler kicks in and drains the
> left-over using PIO.  This just isn't possible with more modern DMA engines.

Its not possible with old ones either - its a bug not a feature and is
why there is special casing for stuff like promise where this hangs the
chip.

Alan
