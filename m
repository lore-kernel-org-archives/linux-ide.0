From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 4/4] libata: expose AN to user space
Date: Thu, 25 Oct 2007 03:21:32 -0400
Message-ID: <472043FC.5090800@garzik.org>
References: <200710162121.l9GLLQJ2017814@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090303080102070907020702"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42356 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754652AbXJYHVf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Oct 2007 03:21:35 -0400
In-Reply-To: <200710162121.l9GLLQJ2017814@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, kristen.c.accardi@intel.com, James.Bottomley@steeleye.com, htejun@gmail.com

This is a multi-part message in MIME format.
--------------090303080102070907020702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

akpm@linux-foundation.org wrote:
> From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> 
> If Asynchronous Notification of media change events is supported, pass that
> information up to the SCSI layer.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> Cc: Jeff Garzik <jeff@garzik.org>
> Cc: Tejun Heo <htejun@gmail.com>
> Cc: James Bottomley <James.Bottomley@steeleye.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/libata-scsi.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff -puN drivers/ata/libata-scsi.c~libata-expose-an-to-user-space drivers/ata/libata-scsi.c
> --- a/drivers/ata/libata-scsi.c~libata-expose-an-to-user-space
> +++ a/drivers/ata/libata-scsi.c
> @@ -773,6 +773,9 @@ static void ata_scsi_dev_config(struct s
>  		blk_queue_max_hw_segments(q, q->max_hw_segments - 1);
>  	}
>  
> +	if (dev->flags & ATA_DFLAG_AN)
> +		sdev->media_change_notify = 1;
> +

Methinks this wasn't tested, as you missed removal of the crucial 
OTHER_AN_PATCHES_HAVE_BEEN_APPLIED ifdef-ery... :)

Anyway, I updated the patch for the media_event thingy in the last 
email, and applied the attached patch


--------------090303080102070907020702
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

commit 6ba2326c804e2d449c2f40a63ba0a9ea650bef47
Author: Jeff Garzik <jeff@garzik.org>
Date:   Thu Oct 25 03:20:05 2007 -0400

    [libata] Utilize new SCSI media event infrastructure
    
    Signed-off-by: Jeff Garzik <jgarzik@redhat.com>

 drivers/ata/libata-scsi.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

6ba2326c804e2d449c2f40a63ba0a9ea650bef47
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index f5d5420..65b6153 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -773,6 +773,9 @@ static void ata_scsi_dev_config(struct scsi_device *sdev,
 		blk_queue_max_hw_segments(q, q->max_hw_segments - 1);
 	}
 
+	if (dev->flags & ATA_DFLAG_AN)
+		sdev->media_events = 1;
+
 	if (dev->flags & ATA_DFLAG_NCQ) {
 		int depth;
 
@@ -3248,10 +3251,8 @@ static void ata_scsi_handle_link_detach(struct ata_link *link)
  */
 void ata_scsi_media_change_notify(struct ata_device *dev)
 {
-#ifdef OTHER_AN_PATCHES_HAVE_BEEN_APPLIED
 	if (dev->sdev)
-		scsi_device_event_notify(dev->sdev, SDEV_MEDIA_CHANGE);
-#endif
+		scsi_device_event_notify(dev->sdev, 1UL << SDEV_MEDIA_CHANGE);
 }
 
 /**

--------------090303080102070907020702--
