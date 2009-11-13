From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: remove experimental tag on PATA drivers
Date: Fri, 13 Nov 2009 18:25:15 +0000
Message-ID: <20091113182515.38fb3793@lxorguk.ukuu.org.uk>
References: <4AFCC0D4.9020708@gmail.com>
	<200911131715.24377.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48029 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756764AbZKMSXl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Nov 2009 13:23:41 -0500
In-Reply-To: <200911131715.24377.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

> Fine but please update status of following host drivers that were
> marked as "stable" prematurely by commit e3389cb first:
> 
> PATA_PDC_OLD: needs to be marked as EXPERIMENTAL (or just BROKEN)
> - known reliability problems with UDMA

A few odd reports apparently linked to specific chip revs. It's at
least as stable as the old IDE one which doesn't work on my hardware. I'd
love to get it working on everything but neither driver does and I don't
think we are likely to ever extract more docs from Promise.

> PATA_ALI: EXPERIMENTAL
> - ATAPI DMA is still broken

Not experimental as we default to not doing ATAPI DMA. Glancing over the
code I notice the ALI C2/C3 workaround probably wants adding to the old
driver as it can do nasty things otherwise. (See the reset function in
the pata_ali driver)

> PATA_CMD64X: EXPERIMENTAL
> - potential data corruption issues remains unfixed for CMD64[3,6]

Patch in testing, and unlike the old IDE one it doesn't cripple the
controller but implements the proper workaround in full including
permitting parallel PIO command streams. I'll push that back through
stable once done.

> PATA_SIS: EXPERIMENTAL
> - missing MWDMA support on newer controllers

Yes seems someone fixed that in the old driver but didn't forward port
it. Trivial and fixed.

BTW - its wrong in the old driver as far as I can see - it doesn't clip
the DMA mode to the PIO limit as required by the documentation and the
ATA standard. Remember the same timings are used for both PIO and MWDMA
cycles.

> They are all old & known problems and not present in
> [ "old", "deprecated", "legacy" ] counterparts.

Which has its own different set of problems.

Any others spring to mind while you are at it ?

Alan

