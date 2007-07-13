From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 5/6] sgiioc4: use ide_tune_dma()
Date: Fri, 13 Jul 2007 19:25:19 +0400
Message-ID: <4697995F.6070004@ru.mvista.com>
References: <200707110206.07157.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:44366 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755522AbXGMPXQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jul 2007 11:23:16 -0400
In-Reply-To: <200707110206.07157.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Jeremy Higdon <jeremy@sgi.com>

Hello.

Bartlomiej Zolnierkiewicz wrote:

> * Add DRV_NAME define and use it instead of sgiioc4_chipset.name.

> * Remove no longer needed sgiioc4_chipset.

> * Remove needless clearing of ->atapi_dma from ide_dma_sgiioc4().

> * Fix ide_dma_sgiioc4() to return success/failure.  Check return value in
>   sgiioc4_ide_setup_pci_device() and set hwif->autodma accordingly.  Also add
>   missing setting of drive->autodma.

> * Add sgiioc4_speedproc() (implementation of ->speedproc method).

> * Fix ->mwdma_mask (MWDMA2 mask is 0x04 not 0x02) and remove incorrect
>   ->swdma_mask.  Also remove needless initialization of ->ultra_mask.

> * Use ide_tune_dma() in sgiioc4_ide_dma_check(), this fixes following bugs:
>   - DMA capability bit not being checked on the device
>   - DMA blacklist not being checked
>   - MWDMA2 mode support by device not being checked

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

    Nice cleanups...

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

