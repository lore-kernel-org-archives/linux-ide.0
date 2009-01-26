From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Mon, 26 Jan 2009 22:32:38 +0300
Message-ID: <497E0FD6.7060300@ru.mvista.com>
References: <200901231615.38011.sshtylyov@ru.mvista.com> <497B9EE4.8010807@ru.mvista.com> <200901252004.18486.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:3918 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753290AbZAZTcI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 14:32:08 -0500
In-Reply-To: <200901252004.18486.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, gdu@mns.spb.ru

Bartlomiej Zolnierkiewicz wrote:

>>Hello, I wrote:

>>>When checking for CFA feature set support, ata_id_is_cfa() tests bit 2 in word
>>>82 of the identify data instead the word 83.  It also checks the ATA revision
>>>in the  word 80 instead of usual validity check for the words 82-83 -- word 83
>>>bit 14 set, bit 15 cleared.

>>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>>---
>>>I'm not sure who should queue this patch... it's against Linus' tree.

>>> include/linux/ata.h |    5 ++---
>>> 1 files changed, 2 insertions(+), 3 deletions(-)

>>>Index: linux-2.6/include/linux/ata.h
>>>===================================================================
>>>--- linux-2.6.orig/include/linux/ata.h
>>>+++ linux-2.6/include/linux/ata.h
>>>@@ -734,9 +734,8 @@ static inline int ata_id_is_cfa(const u1
>>> 	if (id[ATA_ID_CONFIG] == 0x848A)	/* Standard CF */
>>> 		return 1;
>>> 	/* Could be CF hiding as standard ATA */
>>>-	if (ata_id_major_version(id) >= 3 &&
>>>-	    id[ATA_ID_COMMAND_SET_1] != 0xFFFF &&
>>>-	   (id[ATA_ID_COMMAND_SET_1] & (1 << 2)))
>>>+	if ((id[ATA_ID_COMMAND_SET_2] & 0xC000) == 0x4000 &&
>>>+	    (id[ATA_ID_COMMAND_SET_2] & (1 << 2)))
>>> 		return 1;
>>> 	return 0;
>>> }

>>   Jeff, Bart, I've changed my mind about recasting this patch as Alan 
>>has requested, as I do consider it correct now. The version check should 
>>be unnecessary since I'm adding the validity bits check (hte fact that 
>>ata_id_major_complex() is quite cumbesome way of checking the minumum 
>>revision # -- this can be done with a single comparison instead of the 
>>bit scan). Note that words 64-127 were marked reserved, and must be set 
>>to 0 since ATA-1. Have your say please -- do I still need to recast the 
>>patch?

> I'm fine with the current version -- validity checking should take care of
> handling reserved words (even if they are set to 0xff) and we can always add
> more detailed checks later if necessary (which is very unlikely)...

    The only improvement it needs is referring to the CF specs on why the 
version check wasn't really ever correct.

MBR, Sergei
