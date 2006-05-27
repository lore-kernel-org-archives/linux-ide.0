From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE command
Date: Fri, 26 May 2006 20:15:01 -0400
Message-ID: <44779A05.4010209@garzik.org>
References: <1148547763.23979.15.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:5089 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750955AbWE0APG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 May 2006 20:15:06 -0400
In-Reply-To: <1148547763.23979.15.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>, htejun@gmail.com
Cc: liml@rtr.ca, linux-ide@vger.kernel.org

zhao, forrest wrote:
> Hi, all
> 
> This patch makes libata "Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE
> command" and clean the things up(e.g. revalidate and rescan). 
> 
> Here is the processing path:
> 
> 1 in ata_scsi_qc_complete(), if we find that a "SET FEATURES - WRITE CACHE
> ENABLE/DISABLE" command is executed successfully, we schedule the according
> port to do revalidation
> 2 in ata_dev_revalidate(), if we find that the "write cahce enable bit" was
> changed, set port flags in order to schedule scsi_rescan_device() later in
> ata_scsi_error()
> 3 in ata_scsi_error(), if ATA_FLAG_SCSI_RESCAN is set for ap->flags, we
> queue the ata_scsi_dev_rescan() to work_queue "ata_scsi_wq"
> 4 at last, scsi_rescan_device() is invoked, so the current state of "write
> cahce enable bit" is propogated to SCSI layer.

I agree with the concept, and agree that the SCSI layer must be notified 
when the ATA write cache type changes.  However, I NAK the patch for the 
following reasons:

1) Tejun's revalidate should trigger scsi_rescan_device(), as your patch 
indicates.  But that's pretty much all that needs to be done.

2) Thus, a new bit (ATA_FLAG_SCSI_RESCAN) and a new workqueue are 
unnecessary.

3) While the following test is correct,
+	if ((dev->id[85] & (1 << 5)) != (id[85] & (1 << 5)))
+		dev->ap->flags |= ATA_FLAG_SCSI_RESCAN;

there is no pressing need to avoid unnecessary rescans, during revalidation.

4) Using [__]scsi_add_device() is a regression from using scsi_scan_target()

