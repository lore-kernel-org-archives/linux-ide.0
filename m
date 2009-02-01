From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 05/07] sata_mv: mv_fill_sg fixes v2
Date: Sun, 01 Feb 2009 16:50:32 -0500
Message-ID: <49861928.9020803@rtr.ca>
References: <49839107.2040603@rtr.ca> <4983915F.7090705@rtr.ca>	 <498391A7.1090209@rtr.ca> <498391D9.2000403@rtr.ca>	 <49839209.9010602@rtr.ca> <49839256.7090402@rtr.ca> <da824cf30902011255s52878598v5f1e98746865bcab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:52585 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797AbZBAVuf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 Feb 2009 16:50:35 -0500
In-Reply-To: <da824cf30902011255s52878598v5f1e98746865bcab@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Grant Grundler wrote:
> On Fri, Jan 30, 2009 at 3:50 PM, Mark Lord <liml@rtr.ca> wrote:
>> Fix mv_fill_sg() to zero out the reserved word (required for ATAPI),
>> and to include a memory barrier.  This may also help with problems
>> reported by Jens on the PPC platform.
>>
>> Signed-off-by: Mark Lord <mlord@pobox.com>
>>
>> --- old/drivers/ata/sata_mv.c   2009-01-30 18:31:03.000000000 -0500
>> +++ linux/drivers/ata/sata_mv.c 2009-01-30 18:32:08.000000000 -0500
>> @@ -1364,12 +1364,13 @@
>>                        u32 offset = addr & 0xffff;
>>                        u32 len = sg_len;
>>
>> -                       if ((offset + sg_len > 0x10000))
>> +                       if ((offset + len > 0x10000))
> 
> Why the double parens?
..

No reason, no harm -- they were there already.

But if we're being pedantic, here it is again without them:

(REPOST, without the redundant parenthesis)

Fix mv_fill_sg() to zero out the reserved word (required for ATAPI),
and to include a memory barrier.  This may also help with problems
reported by Jens on the PPC platform.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2009-01-30 18:31:03.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2009-01-30 18:32:08.000000000 -0500
@@ -1364,12 +1364,13 @@
 			u32 offset = addr & 0xffff;
 			u32 len = sg_len;
 
-			if ((offset + sg_len > 0x10000))
+			if (offset + len > 0x10000)
 				len = 0x10000 - offset;
 
 			mv_sg->addr = cpu_to_le32(addr & 0xffffffff);
 			mv_sg->addr_hi = cpu_to_le32((addr >> 16) >> 16);
 			mv_sg->flags_size = cpu_to_le32(len & 0xffff);
+			mv_sg->reserved = 0;
 
 			sg_len -= len;
 			addr += len;
@@ -1381,6 +1382,7 @@
 
 	if (likely(last_sg))
 		last_sg->flags_size |= cpu_to_le32(EPRD_FLAG_END_OF_TBL);
+	mb(); /* ensure data structure is visible to the chipset */
 }
 
 static void mv_crqb_pack_cmd(__le16 *cmdw, u8 data, u8 addr, unsigned last)
