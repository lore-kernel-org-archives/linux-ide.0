From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 17/21] libata: improve SCSI scan failure handling
Date: Fri, 20 Jul 2007 08:26:08 -0400
Message-ID: <46A0A9E0.3020002@garzik.org>
References: <11845637801356-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50179 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753292AbXGTM0L (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Jul 2007 08:26:11 -0400
In-Reply-To: <11845637801356-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> SCSI scan may fail due to memory allocation failure even if EH is not
> in progress.  Due to use of GFP_ATOMIC in SCSI scan path, allocation
> failure isn't too rare especially while probing multiple devices at
> once which is the case when a bunch of devices are connected to PMP.
> 
> This patch moves SCSI scan failure detetion logic from
> ata_scsi_hotplug() to ata_scsi_scan_host() and implement synchronous
> scan behavior.  The synchronous path sleeps briefly and repeats SCSI
> scan if some devices aren't attached properly.  It contains robust
> retry loop to minimize the chance of device misdetection during boot
> and falls back to async retry if everything fails.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |    2 +-
>  drivers/ata/libata-scsi.c |   63 +++++++++++++++++++++++++++++++++-----------
>  drivers/ata/libata.h      |    2 +-
>  3 files changed, 49 insertions(+), 18 deletions(-)

applied 17-21, though this one makes me nervous.  off to test upstream + 
patchset #1...  :)


