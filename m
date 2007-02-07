From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: Impact of no_lba48{_dma} = 1 ?
Date: Wed, 7 Feb 2007 13:53:09 +0000
Message-ID: <20070207135309.66942d25@localhost.localdomain>
References: <45C9A23E.3030201@imc-berlin.de>
	<20070207115826.2e3609e3@localhost.localdomain>
	<45C9D34E.1060007@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49752 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161297AbXBGNj7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Feb 2007 08:39:59 -0500
In-Reply-To: <45C9D34E.1060007@imc-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linux-ide@vger.kernel.org

> > Only relevant for DMA really
> 
> So rqsize is only needed for DMA accesses?

PIO transfers are sector at a time, or multi-sector up to a usual limit
of about 16 sectors.
