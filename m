From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 7/12] ide-disk: merge LBA28 and LBA48 Host Protected Area
 support code
Date: Thu, 25 Oct 2007 21:21:12 +0400
Message-ID: <4720D088.2010409@ru.mvista.com>
References: <200710082313.39894.bzolnier@gmail.com> <471758A7.90402@ru.mvista.com> <200710250114.53414.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:46803 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752178AbXJYRVD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 13:21:03 -0400
In-Reply-To: <200710250114.53414.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>* Merge idedisk_{read_native,set}_max_address_ext() into
>>>  idedisk_{read_native,set}_max_address().

>>>There should be no functionality changes caused by this patch.

>>    This is unfortunately not achieved...

>>>Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

>>    No cookie this time. :-)

> "Oh, cookie cookie cookie starts with C!" :)

    I thought it all started with web. 8-)

>>>Index: b/drivers/ide/ide-disk.c
>>>===================================================================
>>>--- a/drivers/ide/ide-disk.c
>>>+++ b/drivers/ide/ide-disk.c

>>[...]

>>>@@ -350,31 +353,12 @@ static unsigned long idedisk_read_native
>>> 
>>> 	/* if OK, compute maximum address value */
>>> 	if ((tf->command & 0x01) == 0) {
>>>-		addr = ((tf->device & 0xf) << 24) |
>>>-		       (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
>>>-		addr++;	/* since the return value is (maxlba - 1), we add 1 */

>>    Actually, the return value is just maxlba (which is *not* the same as 
>>capacity).

> Indeed, moreover idedisk_{read_native,set}_max_address() comments look
> also incorrect, ditto for the function names.

> Probably if we handle 'addr++'/'addr_req--'/'addr_set++' in
> idedisk_check_hpa() all issues will fix themselves.

> Care to look into it? 

    Still no time...

> [...]

>>>-		high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) | tf->hob_lbal;
>>>+		if (lba48)
>>>+			high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) |
>>>+				tf->hob_lbal;
>>>+		else
>>>+			high = tf->device & 0xf;
>>> 		low  = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
>>> 		addr_set = ((__u64)high << 24) | low;
>>> 		addr_set++;

>>    BTW, haven't you noticed that LBA readback code is duplicate? It just asks 
>>to be put into a separate function, like:

>>static u64 ide_read_lba(struct ide_taskfile *tf)
>>{
>>	if (!(tf->command & 0x01)) {
>>		u32 high, low;
>>
>>		if (lba48)
>>			high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) |
>>				tf->hob_lbal;
>>		else
>>			high = tf->device & 0xf;
>>		low  = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
>>		return (((__u64)high << 24) | low) + 1;
>>	} else
>>		return 0;
>>}

> "back in the days" I even had a patch doing something similar but since
> it is still lost somewhere in the TODO folder + requires update for the
> recent changes (which makes it useless a starting point) it would be
> great if you could cook a patch adding the above helper.

    I'll think about it... :-)

> Thanks for review (especially for catching problem with 'high' variable),
> revised patch:

> [PATCH] ide-disk: merge LBA28 and LBA48 Host Protected Area support code (take 2)

> * Merge idedisk_{read_native,set}_max_address_ext() into
>   idedisk_{read_native,set}_max_address().

> v2:
> * Remove LBA48 code leftover from idedisk_read_native_max_address()
>   ('high' variable initialization).  (Noticed by Sergei).

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
