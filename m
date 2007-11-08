From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2 take #2] libata: Support PIO polling-only hosts.
Date: Thu, 8 Nov 2007 10:52:35 +0000
Message-ID: <20071108105235.636accd4@the-village.bc.nu>
References: <20071108021456.GA30648@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46905 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753636AbXKHKwe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Nov 2007 05:52:34 -0500
In-Reply-To: <20071108021456.GA30648@linux-sh.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxsh-dev@lists.sourceforge.net

On Thu, 8 Nov 2007 11:14:56 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> By default ata_host_activate() expects a valid IRQ in order to
> successfully register the host. This patch enables a special case
> for registering polling-only hosts that either don't have IRQs
> or have buggy IRQ generation (either in terms of handling or
> sensing), which otherwise work fine.
> 
> Hosts that want to use polling mode can simply set ATA_FLAG_PIO_POLLING
> and pass in an invalid IRQ.
> 
> Signed-off-by: Paul Mundt <lethal@linux-sh.org>

Acked-by: Alan Cox <alan@redhat.com>


May need to tweak polled isapnp support (or add it) to avoid the WARN but
I will take care of it
