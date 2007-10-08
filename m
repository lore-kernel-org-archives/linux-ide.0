From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 6/8] ide: remove ->init_setup_dma from ide_pci_device_t
Date: Mon, 8 Oct 2007 20:47:52 +0100
Message-ID: <20071008204752.136b6259@the-village.bc.nu>
References: <200708271933.24566.bzolnier@gmail.com>
	<470A8383.3070006@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60191 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750844AbXJHTm6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Oct 2007 15:42:58 -0400
In-Reply-To: <470A8383.3070006@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org


> >   This fixes PCI bus-mastering and DMA simplex mode not being checked for
> >   CS5510/CS5520 hosts.
> 

Just noticed this patch:

You do realise that the CS5510 and CS5520 aren't IDE class devices so its
wrong to check the simplex bits on them (Ditto the MPIIX ?)

You really shouldn't be taking the CS5510, CS5520 or MPIIX via the SFF
IDE setup paths at all. You'll note that libata takes care not to do so.
Indeed last time I tested the MPIIX support in old IDE didn't actually
work precisely due to this.

Alan
