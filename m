From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 06/10] scsi: expose AN support to user space
Date: Wed, 03 Oct 2007 16:39:00 -0400
Message-ID: <4703FDE4.5060301@garzik.org>
References: <200710022053.l92Kr2ka021694@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56300 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754145AbXJCUjF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Oct 2007 16:39:05 -0400
In-Reply-To: <200710022053.l92Kr2ka021694@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, kristen.c.accardi@intel.com, James.Bottomley@steeleye.com, htejun@gmail.com

akpm@linux-foundation.org wrote:
> From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> 
> If a scsi_device supports async notification for media change, then let user
> space know this capability exists by creating a new sysfs entry
> "media_change_notify", which will be 1 if it is supported, and 0 if not
> supported.  Create a routine which allows scsi devices to send a uevent when
> media change events occur.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> Cc: Jeff Garzik <jeff@garzik.org>
> Cc: Tejun Heo <htejun@gmail.com>
> Cc: James Bottomley <James.Bottomley@steeleye.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

ACK

Though I either (a) would like SCSI maintainers to apply this, or (b) 
would like SCSI maintainers to ACK this before I apply it myself.

Or IOW, if others are happy, I'm happy :)

The follow-up patch "libata: expose AN to user space" requires this one 
in order to compile, so it has the same fate.


Additional background, for those interested:  libata-dev.git#upstream 
(2.6.24 queue) already contains Kristen's libata-specific portions of 
the media event notification.  Internally, all the "guts" are there, and 
we currently call a no-op function that's waiting for the SCSI guts:

void ata_scsi_media_change_notify(struct ata_device *dev)
{
#ifdef OTHER_AN_PATCHES_HAVE_BEEN_APPLIED
         if (dev->sdev)
                 scsi_device_event_notify(dev->sdev, SDEV_MEDIA_CHANGE);
#endif
}

Regards,

	Jeff


