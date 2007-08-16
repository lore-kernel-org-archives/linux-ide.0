From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: kill sector_buf temporary buffer
Date: Thu, 16 Aug 2007 11:31:38 +0100
Message-ID: <20070816113138.4e4fe446@the-village.bc.nu>
References: <20070816080451.GA6547@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39903 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760185AbXHPKXu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Aug 2007 06:23:50 -0400
In-Reply-To: <20070816080451.GA6547@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Thu, 16 Aug 2007 04:04:51 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> 
> Rather than carrying around this buffer all the time, for rare
> circumstances, it seems that we can easily alloc/free a temp buffer as
> needed.
> 
> Saves a big chunk of per-port memory.

NAK. The allocation may deadlock, and if you set it not to do I/O you
must then handle failure.

It may be possible to get down to one buffer by serializing the use of it
and proving we can always make progress but thats pretty hairy work for
512 bytes of room.
