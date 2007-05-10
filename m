From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2] libata: reimplement suspend/resume support using
 sdev->manage_start_stop
Date: Wed, 09 May 2007 21:42:41 -0400
Message-ID: <46427891.9040702@garzik.org>
References: <463B88EC.1080304@gmail.com> <463B8933.4010704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51122 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555AbXEJBmv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 May 2007 21:42:51 -0400
In-Reply-To: <463B8933.4010704@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Lord <lkml@rtr.ca>, hancockr@shaw.ca, cebbert@redhat.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, emisca.ml@gmail.com, IDE/ATA development list <linux-ide@vger.kernel.org>, Stephen.Clark@seclark.us, fabio.comolli@gmail.com, a.p.zijlstra@chello.nlAlan <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> Reimplement suspend/resume support using sdev->manage_start_stop.
> 
> * Device suspend/resume is now SCSI layer's responsibility and the
>   code is simplified a lot.
> 
> * DPM is dropped.  This also simplifies code a lot.  Suspend/resume
>   status is port-wide now.
> 
> * ata_scsi_device_suspend/resume() and ata_dev_ready() removed.
> 
> * Resume now has to wait for disk to spin up before proceeding.  I
>   couldn't find easy way out as libata is in EH waiting for the
>   disk to be ready and sd is waiting for EH to complete to issue
>   START_STOP.
> 
> * sdev->manage_start_stop is set to 1 in ata_scsi_slave_config().
>   This fixes spindown on shutdown and suspend-to-disk.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied patches 1-2, but explicitly did not send them upstream today.

I'm hoping we can get this into 2.6.22 -- but also expose it in -mm for 
a few days as well.

I agree it is important to fix this issue.

	Jeff



