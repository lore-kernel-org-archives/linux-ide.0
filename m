From: Tejun Heo <htejun@gmail.com>
Subject: regarding xfer mode representation in dev, ap and other places
Date: Wed, 15 Feb 2006 21:53:31 +0900
Message-ID: <43F3244B.2010600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.181]:2140 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1945932AbWBOMxp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2006 07:53:45 -0500
Received: by pproxy.gmail.com with SMTP id f25so1483418pyf
        for <linux-ide@vger.kernel.org>; Wed, 15 Feb 2006 04:53:45 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Albert Lee <albertcc@tw.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux-ide <linux-ide@vger.kernel.org>

Hello, all.

Now that new reset mechanism is in tree and configuration changes are 
submitted, I'm about to send out transfer mode setting changes.  Two 
major goals of the changes are...

* Give upper layer the power to determine whether devices/ports go 
offline or not.

* Add per-device xfermode limit mask such that EH can limit transfer 
mode later.

One thing that bothers me is various representations of xfermode in 
ata_device, ata_port and other places.

* In ata_device, the current pio and dma transfer mode are recorded in 
->pio_mode and ->dma_mode using SETFEATURES XFERMODE constants.  Of the 
two, currently active mode is copied in ->xfer_mode and ->xfer_shift 
indicates which one is copied.

* In ata_port, supported transfer modes are recorded in three unsigned 
int fields, ->pio_mask, ->mwdma_mask and ->udma_mask.

* Yet another representation is used for printing supported transfer 
mode.  This is a combined mask of ->pio_mask, ->mwdma_mask and 
->udma_mask shifted by respective ATA_SHIFT_XXX.

IMHO, storing SETFEATURES XFERMODE constants and ATA_SHIFT_xxx isn't a 
very good idea.  Except for writing directly to the device, this value 
is just cumbersome to deal with.  e.g. we currently have awkward code 
involving base_from_shift() and offset arithmetics to reverse map and 
print configured transfer mode in ata_dev_set_mode().  Logical transfer 
mode -> constants is easy, the other way around, not.  Also, multiple 
transfer modes cannot be represented in this way.

Of the left two representations, IMHO, the packed one is easier to deal 
with.  It can be easily passed, returned and masked.  Storing as a 
single mask and unpacking when needed is much more convenient then 
carrying around three values, and it isn't like we're gonna need more 
than 32 bits in any foreseeable future; also, we always have u64.

So, I'm proposing to convert all transfer mode representations to one 
packed bit mask which would be u32 for now.  How does it sound?

Thanks.

-- 
tejun
