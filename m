From: Tejun Heo <htejun@gmail.com>
Subject: libata transfer mode & FUA & mode sense page
Date: Thu, 17 Nov 2005 01:55:56 +0900
Message-ID: <437B649C.5080708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:44112 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030412AbVKPQ4G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Nov 2005 11:56:06 -0500
Received: by zproxy.gmail.com with SMTP id 18so1754542nzp
        for <linux-ide@vger.kernel.org>; Wed, 16 Nov 2005 08:56:05 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Douglas Gilbert <dougg@torque.net>, Jens Axboe <axboe@suse.de>
Cc: Linux-ide <linux-ide@vger.kernel.org>

Hello, Jeff, Douglas and Jens.

I've been trying to port the ordered reimplementation patchset over to 
post-2.6.15 head of blk tree.  This tree now contains PIO and mode sense 
improvements for libata.

ATA FUA is interesting in that it's supported only for multisector PIO 
and DMA protocols.  There is no ATA_CMD_PIO_WRITE_FUA_EXT.  So, when 
generating mode sense page, the status of FUA supported bit is dependent 
on the configured transfer mode.  As there doesn't seem to be dynamic 
transfer mode configuration yet, I'm thinking of simply passing ap or 
device down to mode sense functions and use it to report FUA status. 
How does that sound?

If dynamic transport configuration is implemented in the future (from EH 
or explicit user input), this FUA bit will go on and off depending on 
transfer mode.  Ugh... It seems that we'll need a way to raise UA for 
configuration change and trigger revalidation of SCSI disk device.

-- 
tejun
