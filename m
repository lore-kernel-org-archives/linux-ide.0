From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH ide-dev-2.6] ide: ide_dma_intr oops fix
Date: Thu, 03 Mar 2005 15:57:18 +0900
Message-ID: <4226B54E.6020709@gmail.com>
References: <20050303030318.GA25410@htj.dyndns.org> <20050303064925.GB19505@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.204]:35679 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261540AbVCCG5Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Mar 2005 01:57:24 -0500
Received: by wproxy.gmail.com with SMTP id 70so414547wra
        for <linux-ide@vger.kernel.org>; Wed, 02 Mar 2005 22:57:24 -0800 (PST)
In-Reply-To: <20050303064925.GB19505@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

  Hello, Jens.

Jens Axboe wrote:
> On Thu, Mar 03 2005, Tejun Heo wrote:
> 
>> Hello, Bartlomiej.
>>
>> This patch fixes ide_dma_intr() oops which occurs for TASKFILE ioctl
>>using DMA dataphses.  This is against the latest ide-dev-2.6 tree +
>>all your recent 9 patches.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>>Index: linux-taskfile-ng/drivers/ide/ide-dma.c
>>===================================================================
>>--- linux-taskfile-ng.orig/drivers/ide/ide-dma.c	2005-03-03 11:59:16.485582413 +0900
>>+++ linux-taskfile-ng/drivers/ide/ide-dma.c	2005-03-03 12:00:07.753376048 +0900
>>@@ -175,10 +175,14 @@ ide_startstop_t ide_dma_intr (ide_drive_
>> 	if (OK_STAT(stat,DRIVE_READY,drive->bad_wstat|DRQ_STAT)) {
>> 		if (!dma_stat) {
>> 			struct request *rq = HWGROUP(drive)->rq;
>>-			ide_driver_t *drv;
>> 
>>-			drv = *(ide_driver_t **)rq->rq_disk->private_data;;
>>-			drv->end_request(drive, 1, rq->nr_sectors);
>>+			if (rq->rq_disk) {
>>+				ide_driver_t *drv;
>>+
>>+				drv = *(ide_driver_t **)rq->rq_disk->private_data;;
>>+				drv->end_request(drive, 1, rq->nr_sectors);
>>+			} else
>>+				ide_end_request(drive, 1, rq->nr_sectors);
>> 			return ide_stopped;
>> 		}
>> 		printk(KERN_ERR "%s: dma_intr: bad DMA status (dma_stat=%x)\n", 
> 
> Why not just set rq_disk for taskfile requests as well, seems a lot
> cleaner than special casing the end_request handling.

  Just because other places were fixed this way and the whole drive 
command issue/completion codes are just about to be restructured.  Above 
code will go away soon.  Please consider it a quick fix.

  Thanks.

-- 
tejun

