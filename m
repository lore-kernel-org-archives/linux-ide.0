From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: ide_timer_expiry() - shouldn't 'wait' be int?
Date: Mon, 02 Mar 2009 18:39:36 +0300
Message-ID: <49ABFDB8.9050600@ru.mvista.com>
References: <49ABEAC0.40407@gmail.com> <49ABEF7B.9080005@ru.mvista.com> <200903021558.20809.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:15911 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752667AbZCBPjF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Mar 2009 10:39:05 -0500
In-Reply-To: <200903021558.20809.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Roel Kluin <roel.kluin@gmail.com>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>vi drivers/ide/ide-io.c +906 and note:

>>>void ide_timer_expiry (unsigned long data)
>>>{
>>>	ide_expiry_t *expiry = hwif->expiry;
>>>	...
>>>	unsigned long   wait = -1;

>>    Hm, haven't nothiced that this is *unsigned*.

>>>		...
>>>		if (expiry) {
>>>			...
>>>			wait = expiry(drive);
>>>			if (wait > 0) { /* continue */
>>
>>>also note that in include/linux/ide.h:883:

>>>typedef int (ide_expiry_t)(ide_drive_t *);

>>>doesn't this mean that expiry returns int, and wait therefore should
>>>be int as well?

>>    It rather means that ide_expiry_t() should return unsigned.

> Seconded.  Roel, could you also handle it?

    Not worth it, IMO...

> [ However since this is 2.6.30 stuff and there has been much work in
>   this area recently please base in top of linux-next or pata-2.6 tree. ]

>>    However, you're right as ide_dma_timeout_retry() takes *int* as a 2nd 
>>argument.

> Though it works fine (by a luck :) we should also fix it while we're at it.

    Fix what?

> Thanks,
> Bart

MBR, Sergei
