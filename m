From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: Impact of no_lba48{_dma} = 1 ?
Date: Wed, 7 Feb 2007 14:16:02 +0000
Message-ID: <20070207141602.08ab7a3f@localhost.localdomain>
References: <45C9A23E.3030201@imc-berlin.de>
	<20070207115826.2e3609e3@localhost.localdomain>
	<45C9D34E.1060007@imc-berlin.de>
	<20070207135309.66942d25@localhost.localdomain>
	<45C9DAC7.10701@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33501 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161313AbXBGOCv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Feb 2007 09:02:51 -0500
In-Reply-To: <45C9DAC7.10701@imc-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linux-ide@vger.kernel.org

On Wed, 07 Feb 2007 14:57:27 +0100
Steven Scholz <steven.scholz@imc-berlin.de> wrote:

> Alan,
> 
> >>> Only relevant for DMA really
> >> So rqsize is only needed for DMA accesses?
> > 
> > PIO transfers are sector at a time, or multi-sector up to a usual limit
> > of about 16 sectors.
> 
> So again: rqsize does not matter for PIO transfer?
> 
> Looking at the lines
> 
> 	if (hwif->no_lba48_dma && lba48 && dma) {
> 		if (block + rq->nr_sectors > 1ULL << 28)
> 			dma = 0;
> 		else
> 			lba48 = 0;
> 	}

This code is for DMA transfers when we need LBA48 and can't do it. The
general code tries to avoid LBA48 commands when possible as they require
two loads of the taskfile which has a performance impact. The old IDE
code didn't use to do this for PIO that I remember but I'd need to
re-read the code in case it ever got changed. If it doesn't its not hard
to add a check for the PIO case.

