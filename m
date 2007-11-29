From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 05/14] libata: make ->data_xfer return the number of
 consumed bytes
Date: Thu, 29 Nov 2007 17:42:59 +0000
Message-ID: <20071129174259.6a1edc88@the-village.bc.nu>
References: <1196346817387-git-send-email-htejun@gmail.com>
	<11963468181417-git-send-email-htejun@gmail.com>
	<20071129155546.694c6c45@the-village.bc.nu>
	<474EE394.6020604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32781 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932082AbXK2Rri (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 12:47:38 -0500
In-Reply-To: <474EE394.6020604@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com

> It's for draining.  Let's say drive says it wanna transfer 18 bytes but
> the buffer is only 13 bytes long.  If the transfer method consumes 2
> bytes per read, it would consume 14 bytes.  If the transfer method
> consumes 4 bytes per read, it would consume 16 bytes.  If we drain too
> much, we risk hanging the machine.

Do we have any actual cases where trying to drain beyond the controller
granuality is a problem ?

Might be cleaner to sort this (and the DMA assumption of 2 byte
alignment, and possibly 16 byte for some devices/controllers) with 

	dev->pio_io_size;
	dev->dma_io_size;

