From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH pata-2.6 fix] hpt366: disallow Ultra133 for HPT374
Date: Thu, 07 Jun 2007 17:26:29 +0400
Message-ID: <46680785.4060907@ru.mvista.com>
References: <200706062353.28707.sshtylyov@ru.mvista.com> <20070606185455.fc264488.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:45375 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750826AbXFGNYm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 7 Jun 2007 09:24:42 -0400
In-Reply-To: <20070606185455.fc264488.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: bzolnier@gmail.com, wildy@petra.hos.u-szeged.hu, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Andrew Morton wrote:

>>Eliminate UltraATA/133 support for HPT374 -- the chip isn't capable of this mode
>>according to the manual, and doesn't even seem to tolerate 66 MHz DPLL clock...

>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>---
>> drivers/ide/pci/hpt366.c |    8 ++++----
>> 1 files changed, 4 insertions(+), 4 deletions(-)

>>Index: linux-2.6/drivers/ide/pci/hpt366.c
>>===================================================================
>>--- linux-2.6.orig/drivers/ide/pci/hpt366.c
>>+++ linux-2.6/drivers/ide/pci/hpt366.c
>>@@ -1,5 +1,5 @@
>> /*
>>- * linux/drivers/ide/pci/hpt366.c		Version 1.03	May 4, 2007
>>+ * linux/drivers/ide/pci/hpt366.c		Version 1.04	Jun 4, 2007

> argh.  Please just delete this version numbering.  It's a sure-fire way of
> maximising patch conflicts.

> It's 1.10 in Bart's tree.

    Of course, this patch is a fix and Bart's tree also has a cleanup waiting 
for the merge window -- and I've recast that cleanup already. :-)

>>  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
>>  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
>>@@ -106,7 +106,8 @@
>>  *   switch  to calculating  PCI clock frequency based on the chip's base DPLL
>>  *   frequency
>>  * - switch to using the  DPLL clock and enable UltraATA/133 mode by default on
>>- *   anything  newer than HPT370/A
>>+ *   anything  newer than HPT370/A (except HPT374 that is not capable of this
>>+ *   mode according to the manual)
>>  * - fold PCI clock detection and DPLL setup code into init_chipset_hpt366(),
>>  *   also fixing the interchanged 25/40 MHz PCI clock cases for HPT36x chips;
>>  *   unify HPT36x/37x timing setup code and the speedproc handlers by joining
>>@@ -365,7 +366,6 @@ static u32 sixty_six_base_hpt37x[] = {
>> };

>> #define HPT366_DEBUG_DRIVE_INFO		0
>>-#define HPT374_ALLOW_ATA133_6		1
>> #define HPT371_ALLOW_ATA133_6		1
>> #define HPT302_ALLOW_ATA133_6		1
>> #define HPT372_ALLOW_ATA133_6		1
>>@@ -450,7 +450,7 @@ static struct hpt_info hpt370a __devinit

>> static struct hpt_info hpt374 __devinitdata = {
>> 	.chip_type	= HPT374,
>>-	.max_mode	= HPT374_ALLOW_ATA133_6 ? 4 : 3,
>>+	.max_mode	= 3,
>> 	.dpll_clk	= 48,
>> 	.settings	= hpt37x_settings
>> };

> The code in Bart's tree has

> static struct hpt_info hpt374 __devinitdata = {
> 	.chip_type	= HPT374,
> 	.max_ultra	= HPT374_ALLOW_ATA133_6 ? 6 : 5,
> 	.dpll_clk	= 48,
> 	.settings	= hpt37x_settings
> };

> I can handle the renaming, but note that Bart's tree has different values
> as well.

    I don't think you need to bother yet. I hope Bart will merge it himself 
closer to weekend.

MBR, Sergei

