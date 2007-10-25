From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 12/15] ide: remove ->dma_master field from ide_hwif_t
Date: Thu, 25 Oct 2007 19:01:12 +0400
Message-ID: <4720AFB8.2050804@ru.mvista.com>
References: <200710012339.39304.bzolnier@gmail.com> <200710082303.58761.bzolnier@gmail.com> <47179309.1090906@ru.mvista.com> <200710242324.53080.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:45838 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754662AbXJYPBD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 11:01:03 -0400
In-Reply-To: <200710242324.53080.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>Index: b/drivers/ide/pci/pdc202xx_old.c
>>>===================================================================
>>>--- a/drivers/ide/pci/pdc202xx_old.c
>>>+++ b/drivers/ide/pci/pdc202xx_old.c
>>>@@ -193,7 +193,7 @@ static void pdc202xx_old_ide_dma_start(i
>>> 	if (drive->media != ide_disk || drive->addressing == 1) {
>>> 		struct request *rq	= HWGROUP(drive)->rq;
>>> 		ide_hwif_t *hwif	= HWIF(drive);
>>>-		unsigned long high_16   = hwif->dma_master;
>>>+		unsigned long high_16	= hwif->extra_base - 16;
>>> 		unsigned long atapi_reg	= high_16 + (hwif->channel ? 0x24 : 0x20);

>>    That 'high_16' is *not* a good name in this case --

    It's not a good name in any case, because there's more than 16 extra 
registers.

>> it would've been if we 
>>didn't subtract 16. So, I'd wrote:

>>  		unsigned long atapi_reg	= hwif->extra_base +
>>					 (hwif->channel ? 0x14 : 0x10);

> 'high_16' is used for more than 'atapi_reg' (same is true for other places
> defining 'high_16' local variable).  With five revisions of this patch
> needed to hopefully, finally get it right I prefer to defer futher cleanups
> to the incremental patches (*hint*).

    Hint gotten. I'm still neck deep in other stuff but the IDE cleanups can 
wait anyway.

> [PATCH] ide: remove ->dma_master field from ide_hwif_t (take 5)

> * Convert cmd64x, hpt366 and pdc202xx_old host drivers to use
>   pci_resource_start(hwif->pci_dev, 4) instead of hwif->dma_master.

> * Remove no longer needed ->dma_master field from ide_hwif_t.

> v2:
> * Use the more readable 'hwif->dma_base - (hwif->channel * 8)' instead of
>   pci_resource_start(hwif->pci_dev, 4).

> v3:
> * Use hwif->extra_base in hpt366/pdc20xx_old + some cosmetic fixups over v2
>   (suggested by Sergei).

> v4:
> * Correct offsets in hpt3xxn_set_clock().

> v5:
> * Use hwif->extra_base in hpt366 for _real_ this time. (Noticed by Sergei)

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
