From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/8] ide: remove ->init_setup_dma from ide_pci_device_t
Date: Mon, 08 Oct 2007 23:22:43 +0400
Message-ID: <470A8383.3070006@ru.mvista.com>
References: <200708271933.24566.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:18547 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752342AbXJHTXE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Oct 2007 15:23:04 -0400
In-Reply-To: <200708271933.24566.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Make ide_pci_device_t.host_flags u32 and add IDE_HFLAG_CS5520 host flag.

> * Pass ide_pci_device_t *d to setup-pci.c::ide_get_or_set_dma_base()
>   and use d->name instead of hwif->cds->name.

> * Set IDE_HFLAG_CS5520 host flag in cs5520 host driver and use it in
>   ide_get_or_set_dma_base() to find out which PCI BAR to use, remove no longer
>   needed cs5520.c::cs5520_init_setup_dma() and ide_pci_device_t.init_setup_dma.

>   This fixes PCI bus-mastering and DMA simplex mode not being checked for
>   CS5510/CS5520 hosts.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
