From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/3] sis5513: DMA setup fixes
Date: Thu, 02 Aug 2007 20:51:24 +0400
Message-ID: <46B20B8C.4030102@ru.mvista.com>
References: <200708012238.44022.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:38852 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750713AbXHBQtZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Aug 2007 12:49:25 -0400
In-Reply-To: <200708012238.44022.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> * Add sis_ata133_get_base() helper function for obtaining the address of
>   the drive control registers on chipset_family == ATA_133 chipsets.

> * Add three helper functions for programming PIO/MWDMA timings:
>   - sis_ata16_program_timings()  (for ATA_16/33/66/100a chipset families)
>   - sis_ata100_program_timings() (for ATA_100/133a chipset families)
>   - sis_ata133_program_timings() (for ATA_133 chipset family)

>   MWDMA timings are taken from datasheets and they match ATA spec.

> * Add generic helper function sis_program_timings() and use it in
>   ->set_pio_mode and ->set_dma_mode methods (previously the driver
>   depended on BIOS to program the correct MWDMA timings).

> * Remove redundant !chipset_family check from init_hwif_sis5513()
>   (init_chipset_sis5513() guarantees that we will never get here if
>    chipset_family cannot be determined).

> * SWDMA seems to be unsupported by SiS chipsets (no info about SWDMA in
>   datasheets and for SWDMA0 mode timing requirements are impossible to
>   fulfill) so remove ->swdma_mask from init_hwif_sis5513() and handling
>   of SWDMA modes from sis_set_dma_mode().

> * Enable DMA support for chipset_family == ATA_16.

> * Bump driver version.

    I see that SiS has managed to make chip identification even more painful
than HighPoint representing all the different chipset families by the couple
device IDs with even no ability to differ them via revision ID... :-/

    Although I don't have docs for the newer variants (at least not at hand), 
this looks good to me.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
