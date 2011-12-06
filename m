From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
Date: Tue, 6 Dec 2011 11:49:52 +0000
Message-ID: <20111206114952.GS14542@n2100.arm.linux.org.uk>
References: <1322867573.11728.22.camel@pasglop> <20111205161157.GA27550@localhost.localdomain> <alpine.LFD.2.02.1112051236350.2357@xanadu.home> <20111205180253.GB29812@localhost.localdomain> <alpine.LFD.2.02.1112051310150.2357@xanadu.home> <20111205192605.GD29812@localhost.localdomain> <alpine.LFD.2.02.1112051443190.2357@xanadu.home> <20111206093709.GB2274@linaro.org> <20111206104654.GN14542@n2100.arm.linux.org.uk> <20111206113735.GC2274@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58022 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933236Ab1LFLuv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Dec 2011 06:50:51 -0500
Content-Disposition: inline
In-Reply-To: <20111206113735.GC2274@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Pawel Moll <pawel.moll@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, devicetree-discuss@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@redhat.com>, linux-ide@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Anton Vorontsov <cbouatmailru@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Tue, Dec 06, 2011 at 11:37:35AM +0000, Dave Martin wrote:
> 1) All OF code and drivers should be migrating to use 0 instead of NO_IRQ
>    for the no-interrupt case.  Code which receives irq numbers directly
>    from the OF framework and refers to NO_IRQ, or expects 0 to be a valid
>    needs to be fixed.
> 
> 2) Where we hit a problem, board code needs to be adapted to remap HW IRQs
>    0-15 to different software values.  (This could be done using irq
>    domains, or not)

No AMBA driver I'm aware of ever uses an IRQ number 0 or is passed such
an IRQ number.
