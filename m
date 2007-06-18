From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] ide dma_timer_expiry, then hard lockup
Date: Mon, 18 Jun 2007 21:27:04 +0100
Message-ID: <20070618212704.394912b8@the-village.bc.nu>
References: <20070618175713.GD5836@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35374 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754263AbXFRUVy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 16:21:54 -0400
In-Reply-To: <20070618175713.GD5836@austin.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linas Vepstas <linas@austin.ibm.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> ide_dma_timeout_retry() in ide-io.c 
>   prints the "hdc: DMA Timeout error" then calls
>   HWIF(drive)->ide_dma_end(drive);
>     which returns, and then calls 
>   hwif->INB(IDE_STATUS_REG) which is needed as an argument to ide_error()
> 
> But this hangs! -- The INB never returns.
> Now:  hwif->INB = ide_inb; in ide-iops.c

Yep and the I/O cycle never completes so the box hangs. This occurs if
the drive blows up and never switches IORDY to indicate completion. The
hpt will also do this sometimes if it gets addled by a confused drive,
while an intel one often won't.

Alan
