From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Mon, 26 Jan 2009 21:47:36 +0300
Message-ID: <497E0548.80904@ru.mvista.com>
References: <200901231615.38011.sshtylyov@ru.mvista.com> <497B9EE4.8010807@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:3310 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751565AbZAZSrG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 13:47:06 -0500
In-Reply-To: <497B9EE4.8010807@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, gdu@mns.spb.ru

Hello, I wrote:

>> When checking for CFA feature set support, ata_id_is_cfa() tests bit 2 
>> in word
>> 82 of the identify data instead the word 83.  It also checks the ATA 
>> revision
>> in the  word 80 instead of usual validity check for the words 82-83 -- 
>> word 83
>> bit 14 set, bit 15 cleared.

>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>> ---
>> I'm not sure who should queue this patch... it's against Linus' tree.
>>
>>  include/linux/ata.h |    5 ++---
>>  1 files changed, 2 insertions(+), 3 deletions(-)

>> Index: linux-2.6/include/linux/ata.h
>> ===================================================================
>> --- linux-2.6.orig/include/linux/ata.h
>> +++ linux-2.6/include/linux/ata.h
>> @@ -734,9 +734,8 @@ static inline int ata_id_is_cfa(const u1
>>      if (id[ATA_ID_CONFIG] == 0x848A)    /* Standard CF */
>>          return 1;
>>      /* Could be CF hiding as standard ATA */
>> -    if (ata_id_major_version(id) >= 3 &&
>> -        id[ATA_ID_COMMAND_SET_1] != 0xFFFF &&
>> -       (id[ATA_ID_COMMAND_SET_1] & (1 << 2)))
>> +    if ((id[ATA_ID_COMMAND_SET_2] & 0xC000) == 0x4000 &&
>> +        (id[ATA_ID_COMMAND_SET_2] & (1 << 2)))
>>          return 1;
>>      return 0;
>>  }

>   Jeff, Bart, I've changed my mind about recasting this patch as Alan 
> has requested, as I do consider it correct now. The version check should 
> be unnecessary since I'm adding the validity bits check

    ... replacing 0xFFFF check (with zero value got sorted out by testing bit 
2) with it to be precise.

> (hte fact that 
> ata_id_major_complex() is quite cumbesome way of checking the minumum 
> revision # -- this can be done with a single comparison instead of the 
> bit scan).

    ... "added to that" I meant to type.

MBR, Sergei
