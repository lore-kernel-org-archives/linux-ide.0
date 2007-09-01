From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] hpt366: UltraDMA filtering for SATA cards
Date: Sat, 01 Sep 2007 18:36:33 +0400
Message-ID: <46D978F1.7030903@ru.mvista.com>
References: <200708060008.38077.sshtylyov@ru.mvista.com> <200708090008.10352.bzolnier@gmail.com> <46D06349.7050009@ru.mvista.com> <200708271922.35546.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:48833 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753042AbXIAOdq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Sep 2007 10:33:46 -0400
In-Reply-To: <200708271922.35546.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>>>The Marvell bridge chips used on HighPoint SATA cards do not seem to support
>>>>the UltraDMA modes 1, 2, and 3 (as well as any MWDMA modes), so the driver
>>>>needs to account for this in the udma_filter() method.  In order to achieve
>>>>that, do the following changes:

>>>>- install the method for all chips, not only HPT36x/370 (improve code formatting
>>>> by killing an extra tabs while at it);

>>>>- add to the end of the 'switch' statement in hpt3xx_udma_filter() case for
>>>> HPT372[AN] and HPT374 chips upon which the SATA cards are based and check
>>>> there whether we're dealing with SATA drive (by looking at words 80 and 93
>>>> of the drive's identify data), reorder HPT370[A] cases for consistency...

>>>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>[...]

>>>Also now that ->udma_filter is always present the initial hwif->ultra_mask

>>    Aha, so this method's semantics intended to *completely override* the 
>>ultra_mask field?!  Wouldn't it be better to make the code behave more 
>>consistent, i.e. in ide_get_mode_mask() do:

>>         unsigned int mask = 0;
>>
>>         switch(base) {
>>         case XFER_UDMA_0:
>>                 if ((id->field_valid & 4) == 0)
>>                         break;
>>
>>                 if (hwif->udma_filter)
>>                         mask = hwif->udma_filter(drive);
>>		else
>>                         mask = hwif->ultra_mask;
>>
>>                 mask &= id->dma_ultra;
>>                 if ((mask & 0x78) && (eighty_ninty_three(drive) == 0))
>>                         mask &= 0x07;
>>                 break;
>>         case XFER_MW_DMA_0:
>>                 if ((id->field_valid & 2) == 0)
>>                         break;
>>
>>                 if (hwif->mdma_filter)
>>                         mask = hwif->mdma_filter(drive);
>>		else
>>                         mask = hwif->mwdma_mask;
>>                 mask &= id->dma_mword;
>>                 break;

>>to avoid the further confusion? ;-)

> Fine with me but you forgot to attach a patch. ;)

    That was only a trial ball. ;-)

> Bart

MBR, Sergei
