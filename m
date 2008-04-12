From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/4] ide: add struct ide_dma_ops
Date: Sat, 12 Apr 2008 21:54:06 +0400
Message-ID: <4800F73E.3000802@ru.mvista.com>
References: <200803091700.46136.bzolnier@gmail.com> <200803181512.50134.bzolnier@gmail.com> <47FF636E.4070903@ru.mvista.com> <200804121432.03366.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:44892 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755032AbYDLRyt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Apr 2008 13:54:49 -0400
In-Reply-To: <200804121432.03366.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>>   Now where is the code which selects the correct dma_ops for the 

>>>>>HPT36x/370/372/372N chip with device ID 4 I'm asking you?  :-) 

>>>fixed

>>    Not actually... :-/

> Arghhh.  I see now that the HPT370/370A needs a special handling...

    Yes, and a lot of. :-)

> (HPT372/372N has already been handled by 'idx++')

    Didn't grasp this at first - the init. code grew somewhat convoluted...

> [...]

>>>@@ -1483,6 +1489,7 @@ static const struct ide_port_info hpt366
>>> 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
>>> 		.udma_mask	= ATA_UDMA5,
>>> 		.port_ops	= &hpt3xx_port_ops,
>>>+		.dma_ops	= &hpt370_dma_ops,

>>    Wrong -- HPT374 should have hpt37x_dma_ops...

> Yep, thanks for catching it.

> interdiff between v2->v3:

> [...]
> v3:
> * Two bugs slipped in v2 (noticed by Sergei):
>   - use correct DMA ops for HPT374 (for real this time)
>   - handle HPT370/HPT370A properly

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
