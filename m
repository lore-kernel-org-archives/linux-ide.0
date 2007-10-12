From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2] drivers/ata: add support to Freescale 3.0Gbps SATA
 Controller
Date: Fri, 12 Oct 2007 14:55:22 +0100
Message-ID: <20071012145522.29dd7413@the-village.bc.nu>
References: <1192196849-24758-1-git-send-email-leoli@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48981 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751947AbXJLNvU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Oct 2007 09:51:20 -0400
In-Reply-To: <1192196849-24758-1-git-send-email-leoli@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, Ashish Kalra <ashish.kalra@freescale.com>, Li Yang <leoli@freescale.com>

> +	cd = pp->cmdentry + tag;
> +
> +	memcpy(fis, &cd->sfis, 6 * 4);	/* should we use memcpy_from_io() */

If cd->sfis points at memory over the PCI bus (eg mmio or memory on the
controller card) then you need to use ioread/_io type functions. If
cd->sfis points into host memory where the FIS is delivered by DMA from
the card you will be fine if it was allocated with an _coherent allocator


Alan
