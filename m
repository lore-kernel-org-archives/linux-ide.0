From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: ide_timer_expiry() - shouldn't 'wait' be int?
Date: Mon, 02 Mar 2009 18:43:47 +0300
Message-ID: <49ABFEB3.1080505@ru.mvista.com>
References: <49ABEAC0.40407@gmail.com> <200903021550.45608.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:16014 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752852AbZCBPnQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Mar 2009 10:43:16 -0500
In-Reply-To: <200903021550.45608.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Roel Kluin <roel.kluin@gmail.com>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Bartlomiej Zolnierkiewicz wrote:

>>vi drivers/ide/ide-io.c +906 and note:

>>void ide_timer_expiry (unsigned long data)
>>{
>>	ide_expiry_t *expiry = hwif->expiry;
>>	...
>>	unsigned long   wait = -1;
>>		...
>>		if (expiry) {
>>			...
>>			wait = expiry(drive);
>>			if (wait > 0) { /* continue */

>>also note that in include/linux/ide.h:883:

>>typedef int (ide_expiry_t)(ide_drive_t *);

>>doesn't this mean that expiry returns int, and wait therefore should
>>be int as well?

> It does... and it seems like it could cause insanely long timeouts for:

> * ATA_DMA_ERR error in dma_timer_expiry()

> * commands without ->expiry in tc86c001_timer_expiry()
>   (TC86C001 IDE controller only)

> This is 2.6.29 material, care to make a patch?

    Er, it's not that bad as it gets cast back to *int* when calling 
ide_dma_timer_expiry().

> Thanks,
> Bart

MBR, Sergei
