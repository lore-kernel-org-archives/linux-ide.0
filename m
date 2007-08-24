From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] hpt366: fix PCI clock detection for HPT374 (take 4)
Date: Fri, 24 Aug 2007 22:04:09 +0400
Message-ID: <46CF1D99.5020501@ru.mvista.com>
References: <200708112349.50483.sshtylyov@ru.mvista.com> <200708212235.49323.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:44432 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932310AbXHXSBd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Aug 2007 14:01:33 -0400
In-Reply-To: <200708212235.49323.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>HPT374 BIOS seems to only save f_CNT register value for the function #0 before
>>re-tuning DPLL (that causes the driver to report obviously distorted f_CNT for
>>the function #1) -- fix this by always reading the saved f_CNT register value
>>from the function #0 in the driver's init_chipset() method.
>>While at it, introduce 'chip_type' for holding the 'struct hpt_info' field
>>of the same name and replace the structure assignment with memcpy()...

>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> applied

>>---
>>This is still against the current Linus tree -- this time I've made the comment
>>more clear (hopefully :-)...

> Yep, thanks!

    /me bows

>> drivers/ide/pci/hpt366.c |   44 +++++++++++++++++++++++++++++++-------------
>> 1 files changed, 31 insertions(+), 13 deletions(-)
>>
>>Index: linux-2.6/drivers/ide/pci/hpt366.c
>>===================================================================
>>--- linux-2.6.orig/drivers/ide/pci/hpt366.c
>>+++ linux-2.6/drivers/ide/pci/hpt366.c
>>@@ -1,5 +1,5 @@
>> /*
>>- * linux/drivers/ide/pci/hpt366.c		Version 1.10	Jun 29, 2007
>>+ * linux/drivers/ide/pci/hpt366.c		Version 1.11	Aug 11, 2007
>>  *
>>  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
>>  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
>>@@ -68,7 +68,8 @@
>>  *   HPT37x chip family; save space by introducing the separate transfer mode
>>  *   table in which the mode lookup is done
>>  * - use f_CNT value saved by  the HighPoint BIOS as reading it directly gives
>>- *   the wrong PCI frequency since DPLL has already been calibrated by BIOS
>>+ *   the wrong PCI frequency since DPLL has already been calibrated by BIOS;
>>+ *   read it only from the fucntion 0 of HPT374 chips

> s/fucntion/function/

    I thought it's contagious -- I've seen "ot" and Alan's patch and now I'm 
infected.  So, it's you turn. ;-)

>>  * - fix the hotswap code:  it caused RESET- to glitch when tristating the bus,
>>  *   and for HPT36x the obsolete HDIO_TRISTATE_HWIF handler was called instead
>>  * - pass to init_chipset() handlers a copy of the IDE PCI device structure as

MBR, Sergei
