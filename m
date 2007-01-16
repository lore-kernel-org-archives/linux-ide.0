From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: ipr SATA problems in 2.6.20
Date: Tue, 16 Jan 2007 22:41:15 +0000
Message-ID: <20070116224115.50d29cf7@localhost.localdomain>
References: <45AD50AD.2040700@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33626 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751418AbXAPWho (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Jan 2007 17:37:44 -0500
In-Reply-To: <45AD50AD.2040700@linux.vnet.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: brking@linux.vnet.ibm.com
Cc: linux-scsi@vger.kernel.org, James Bottomley <James.Bottomley@steeleye.com>, Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

> The other oddity I've been seeing is that I am getting zero length commands,
> such as TEST_UNIT_READY with a dma_dir of DMA_FROM_DEVICE. Shouldn't this be
> DMA_NONE? I'm still tracking this down.

I was looking at a PATA trace that was looking the same 2 days ago and
couldn't figure what was going on. 

Alan
