From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 01/18] ide: add ->read_sff_dma_status method
Date: Sun, 07 Sep 2008 22:15:10 +0400
Message-ID: <48C41A2E.8040907@ru.mvista.com>
References: <20080620213323.13202.71450.sendpatchset@localhost.localdomain> <48BE8EFD.70103@ru.mvista.com> <200809032013.08489.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:17718 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754561AbYIGSOd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Sep 2008 14:14:33 -0400
In-Reply-To: <200809032013.08489.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>> static void ide_tf_load(ide_drive_t *drive, ide_task_t *task)
>>> {
>>> 	ide_hwif_t *hwif = drive->hwif;
>>>@@ -323,6 +331,8 @@ static void ata_output_data(ide_drive_t 
>>> 
>>> void default_hwif_transport(ide_hwif_t *hwif)
>>> {
>>>+	hwif->read_sff_dma_status = ide_read_sff_dma_status;
>>>+
>>> 	hwif->tf_load	  = ide_tf_load;
>>> 	hwif->tf_read	  = ide_tf_read;
>>
>>    I also didn't understand the motivation behind putting this method 
>>together with the transport operations... IMO, DMA programming interface 
>>hardly has anything to do with transporting the data over IDE bus.

> The motivation was that hwif->dma_ops is not available yet when
> ->read_sff_dma_status is used in ide_pci_check_simplex().

> However I agree that it should somehow find its way into ->dma_ops
> (as usual patches are stongly preffered :).

    Unless I'm missing something changing the place where hwif->dma_ops is 
initialized to sff_dma_ops (along the lines it was changed for hwif->dma_base) 
seems pretty trivial, so I wonder why you didn't do it in the same patch...
    Hm, I guess I'm seeing a real issue with this patch...

> Thanks,
> Bart

MBR, Sergei
