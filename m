From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/4] hpt366: UltraDMA filter for SATA cards (take 2)
Date: Fri, 24 Aug 2007 22:11:05 +0400
Message-ID: <46CF1F39.6000908@ru.mvista.com>
References: <200708192300.35564.sshtylyov@ru.mvista.com> <200708212236.10803.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:44486 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1763135AbXHXSIa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Aug 2007 14:08:30 -0400
In-Reply-To: <200708212236.10803.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: rah@bash.sh, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>The Marvell bridge chips used on HighPoint SATA cards do not seem to support
>>the UltraDMA modes 1, 2, and 3 as well as any MWDMA modes, so the driver needs
>>to account for this in the udma_filter() method.  In order to achieve that, do
>>the following changes:

>>- install the method for all chips, not only HPT36x/370 and impove the code
>>  formatting by killing the extra tabs while at it;

> s/impove/improve/

    Will fix in the updated patch...

>>- add to the end of the 'switch' statement in the method cases for HPT372[AN]
>>  and HPT374 chips upon which the known SATA cards are based;

>>- use hwif->ultra_mask as a default mask for the ide_dma_filter() method to
>>  behave correctly;

    ... and I was actually going to get rid of all explict masks there, just 
modifying the 'mask' variable -- this was may paper version but I was in hury 
and forgotten to look at this particular place.

>>- move the HPT370[A] cases below the HPT36x case for consistency.

>>While at it, replace the explicit UltraDMA mode masks with ATA_UDMA* constants
>>all over the driver...

    This is certainly worth a big patch covering all PCI drivers. Maybe I'll 
cook it up.  For now, I'm going to drop this part

>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> applied

    ... with imminent recast. :-)

>>---
>>This is against the current Linus tree and unfortunately I was able to only
>>compile test it since that tree gives MODPOST warning and dies early on bootup.

> Is this still case?  Not an IDE problem but definitely needs fixing especially
> given that we are already in -rc3...

    Yeah, it is, at least on my Geode GX2 testing target.

>>Will hopefully finish with the patch series next weekend...

    I'll do my best (althou I've already encountered trouble with displays 
suddenly being blanked -- some{one|thing} set the standby timer to 1-2 
minutes. :-) Beside that my typing loses as an effect of some pills. +:-)

MBR, Sergei
