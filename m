From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH] libata: PIO via bounce buffer
Date: Sat, 1 Mar 2008 16:38:03 +0000
Message-ID: <20080301163803.2ff1d1bc@core>
References: <20080229135106.4fcf19e3@core>
	<47C8A2C0.7070005@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59856 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751927AbYCAQtQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Mar 2008 11:49:16 -0500
In-Reply-To: <47C8A2C0.7070005@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

> Inside ata_bounce_pio_xfer(), get the buffer for your CPU.  If NULL or 
> too small, allocate new buffer, otherwise re-use existing buffer.
> 
> This method makes the common case _not_ allocate anything, which should 
> be obviously more efficient.

Obviously ?

kmalloc will usually return us a cache hot buffer very very fast. A
private allocator will return us an almost certainly cache cold buffer
slightly faster.

I'm not sure its that simple.

Alan
