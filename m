From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] libata: Support PIO polling-only hosts.
Date: Wed, 7 Nov 2007 13:09:40 +0000
Message-ID: <20071107130940.16b5ea86@the-village.bc.nu>
References: <20071107081052.GA25913@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50430 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750830AbXKGNJt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Nov 2007 08:09:49 -0500
In-Reply-To: <20071107081052.GA25913@linux-sh.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxsh-dev@lists.sourceforge.net

On Wed, 7 Nov 2007 17:10:52 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> By default ata_host_activate() expects a valid IRQ in order to
> successfully register the host. This patch enables a special case
> for registering polling-only hosts that either don't have IRQs
> or have buggy IRQ generation (either in terms of handling or
> sensing), which otherwise work fine.
> 
> Hosts that want to use polling mode can simply set ATA_FLAG_PIO_POLLING
> and pass in a NULL IRQ handler or invalid (< 0) IRQ.

NAK

Zero is "no IRQ", please use that for polling not "< 0"

> + *	A NULL @irq_handler or invalid IRQ skips the IRQ registration
> + *	and expects the host to have set polling mode on the port.
> + *

There is no need to llow NULL irq_handler as a different case here. Any
caller can provide (NULL, 0). If anything you might want to warn if they
provide IRQ 0, and a handler

