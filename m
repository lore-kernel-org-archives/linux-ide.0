From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/4] Introduce ata_id_has_unload()
Date: Sat, 30 Aug 2008 22:01:35 +0400
Message-ID: <48B98AFF.1040301@ru.mvista.com>
References: <87wshzplvk.fsf@denkblock.local>	<20080829211345.4355.63012.stgit@denkblock.local>	<48B9357A.3040508@ru.mvista.com> <87sksmmmx4.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:33691 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753265AbYH3SBK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Aug 2008 14:01:10 -0400
In-Reply-To: <87sksmmmx4.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jeff@garzik.org>, Randy Dunlap <randy.dunlap@oracle.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Elias Oltmanns wrote:

>>>diff --git a/include/linux/ata.h b/include/linux/ata.h
>>>index 80364b6..d9a94bd 100644
>>>--- a/include/linux/ata.h
>>>+++ b/include/linux/ata.h
>>>@@ -707,6 +707,23 @@ static inline int ata_id_has_dword_io(const u16 *id)
>>> 	return 0;
>>> }
>>> +static inline int ata_id_has_unload(const u16 *id)
>>>+{
>>>+	/*
>>>+	 * ATA-7 specifies two places to indicate unload feature
>>>+	 * support. Since I don't really understand the difference,
>>>+	 * I'll just check both and only return zero if none of them
>>>+	 * indicates otherwise.

>>  If you read the comments to the words 82:84 and 85:87, they say that
>>the former indicate the supported features, and the latter indicate
>>the enabed features AND in case a feature can't be disabled, the
>>latter words will have the corresponding bit set. So it should be
>>sufficient to check only one word.

> Yes, I tend to agree with you and, in fact, I have been leaning in this
> direction myself. However, there is something that really bothers me.
> Both entries describing bit 13 of word 87 and 84 are worded alike. In
> particular, it says *supported* in both places, whereas in the case of the
> other features it would say enabled in one and supported in the other
> place.

    I think it says "supported" where the feature can't be disabled and 
"enabled" where it can. Otherwise, this would make a little sense indeed.
Hm, I even found a quote in ATA/PI-7 rev. 4b backing this claim (should've 
pasted it into previous mail):

6.17.43 Words (87:85): Features/command sets enabled

Words (87:85) shall indicate features/command sets enabled. If a defined bit 
is cleared to zero, the indicated features/command set is not enabled. If a 
supported features/command set is supported and cannot be disabled, it is 
defined as supported and the bit shall be set to one.

>>>+	 */
>>>+	if (ata_id_major_version(id) >= 7
>>>+	    && (((id[ATA_ID_CFSSE] & 0xC000) == 0x4000
>>>+		 && id[ATA_ID_CFSSE] & (1 << 13))
>>>+		|| ((id[ATA_ID_CSF_DEFAULT] & 0xC000) == 0x4000
>>>+		    && (id[ATA_ID_CSF_DEFAULT] & (1 << 13)))))
>>>  

>>  I think that it's preferrable to leave the operator on the same line
>>with the first operand...

> Not having too strong an opinion about it, I just thought that an
> operator at the beginning of the line was another indication (apart from
> indentation) that this still belongs to the condition. Still, I can

   Do we need *another* indication? :-)

> change it for the next series round.

> Regards,

> Elias

MBR, Sergei
