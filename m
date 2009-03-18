From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata-core Use more robust parsing for multi_count
Date: Wed, 18 Mar 2009 11:13:01 -0400
Message-ID: <49C10F7D.2010804@rtr.ca>
References: <49C1047D.4000008@rtr.ca> <20090318143230.2b64e273@lxorguk.ukuu.org.uk> <49C10DFC.2070206@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:51552 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751405AbZCRPNH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Mar 2009 11:13:07 -0400
In-Reply-To: <49C10DFC.2070206@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Alan Cox wrote:
>>> +            switch (dev->id[59] & 0xff) {
>>
>> Umm surely...
>>
>>     if (n & (n - 1))
> ..
> 
> ????
..

Ah.. backwards.  Thanks, Alan!  Revised patch follows:

-----

Make libata a little more robust in parsing the multi_count
field from a drive's identify data.  This prevents libata from
attempting to use dubious multi_count values ad infinitum.

Signed-off-by: Mark Lord <mlord@pobox.com> 

--- upstream/drivers/ata/libata-core.c	2009-03-18 10:21:07.000000000 -0400
+++ new/drivers/ata/libata-core.c	2009-03-18 10:22:05.000000000 -0400
@@ -2426,9 +2426,12 @@
 
 		dev->n_sectors = ata_id_n_sectors(id);
 
-		if (dev->id[59] & 0x100)
-			dev->multi_count = dev->id[59] & 0xff;
-
+		dev->multi_count = 0;
+		if (dev->id[59] & 0x100) {
+			int mc = dev->id[59] & 0xff;
+			if ((mc & (mc - 1)) == 0) /* even power of two? */
+				dev->multi_count = mc;
+		}
 		if (ata_id_has_lba(id)) {
 			const char *lba_desc;
 			char ncq_desc[20];
