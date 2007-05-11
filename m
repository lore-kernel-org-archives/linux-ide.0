From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/2] libata: reimplement suspend/resume support using
 sdev->manage_start_stop
Date: Fri, 11 May 2007 14:09:35 +0200
Message-ID: <46445CFF.5060709@gmail.com>
References: <463B88EC.1080304@gmail.com> <463B8933.4010704@gmail.com> <46427891.9040702@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:4697 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827AbXEKMJt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 08:09:49 -0400
Received: by py-out-1112.google.com with SMTP id a29so766651pyi
        for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 05:09:49 -0700 (PDT)
In-Reply-To: <46427891.9040702@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mark Lord <lkml@rtr.ca>, hancockr@shaw.ca, cebbert@redhat.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, emisca.ml@gmail.com, IDE/ATA development list <linux-ide@vger.kernel.org>, Stephen.Clark@seclark.us, fabio.comolli@gmail.com, a.p.zijlstra@chello.nl

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Reimplement suspend/resume support using sdev->manage_start_stop.
>>
>> * Device suspend/resume is now SCSI layer's responsibility and the
>>   code is simplified a lot.
>>
>> * DPM is dropped.  This also simplifies code a lot.  Suspend/resume
>>   status is port-wide now.
>>
>> * ata_scsi_device_suspend/resume() and ata_dev_ready() removed.
>>
>> * Resume now has to wait for disk to spin up before proceeding.  I
>>   couldn't find easy way out as libata is in EH waiting for the
>>   disk to be ready and sd is waiting for EH to complete to issue
>>   START_STOP.
>>
>> * sdev->manage_start_stop is set to 1 in ata_scsi_slave_config().
>>   This fixes spindown on shutdown and suspend-to-disk.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> applied patches 1-2, but explicitly did not send them upstream today.
> 
> I'm hoping we can get this into 2.6.22 -- but also expose it in -mm for
> a few days as well.

Okay, will prepare the scary webpage then.

-- 
tejun
