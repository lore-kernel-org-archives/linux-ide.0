From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: 2.6.25 semantic change in bay handling?
Date: Tue, 6 May 2008 10:17:18 +0100
Message-ID: <20080506091718.GA11617@srcf.ucam.org>
References: <20080505223357.GA2839@srcf.ucam.org> <20080506081347.GA8688@homac> <20080506082110.GA10355@srcf.ucam.org> <48201987.4020009@gmail.com> <20080506084625.GA10817@srcf.ucam.org> <48201C7D.1070303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mjg.x.mythic-beasts.com ([93.93.128.6]:56564 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1764220AbYEFJR1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 May 2008 05:17:27 -0400
Content-Disposition: inline
In-Reply-To: <48201C7D.1070303@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, hmacht@suse.de

On Tue, May 06, 2008 at 05:53:17PM +0900, Tejun Heo wrote:
> Matthew Garrett wrote:
> >Yeah, but I can't see an easy way of doing that. It's not enough to keep 
> >track of the current state and assume that it's either an insertion or 
> >removal as a result - some machines fire bus checks on resume, even if 
> >the bay device hasn't been changed.
> 
> All we need is separate out the ejection case out.  For suspend, resume, 
> attach or whatever can be handled the same way.  The problem occurs 
> because some controllers get very unhappy when certain registers are 
> accessed when there's no device attached to it.

Ok. What we probably ought to be doing then is checking the _STA method 
on the bay when we receive a bus check. That should be sufficient for 
determining whether the device is actually there (if so, perform a 
hotplug) or not (flag the device as detached, don't probe). I don't have 
the hardware here right now, but something like...

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 8c1cfc6..f1d5c87 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -126,37 +126,49 @@ static void ata_acpi_handle_hotplug(struct ata_port *ap, struct ata_device *dev,
 	struct ata_eh_info *ehi;
 	struct kobject *kobj = NULL;
 	int wait = 0;
-	unsigned long flags;
+	unsigned long flags, sta;
+	acpi_status status;
+	acpi_handle handle;
 
 	if (!ap)
 		ap = dev->link->ap;
 	ehi = &ap->link.eh_info;
 
+	if (dev)
+		handle = dev->acpi_handle;
+	else
+		handle = ap->handle;
+
 	spin_lock_irqsave(ap->lock, flags);
 
 	switch (event) {
 	case ACPI_NOTIFY_BUS_CHECK:
 	case ACPI_NOTIFY_DEVICE_CHECK:
+		status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
+		if (!ACPI_SUCCESS(status)) {
+			printk(KERN_ERR "Unable to evaluate bay status\n");
+			break;
+		}
 		ata_ehi_push_desc(ehi, "ACPI event");
-		ata_ehi_hotplugged(ehi);
-		ata_port_freeze(ap);
-		break;
-
-	case ACPI_NOTIFY_EJECT_REQUEST:
-		ata_ehi_push_desc(ehi, "ACPI event");
-		if (dev)
-			dev->flags |= ATA_DFLAG_DETACH;
-		else {
-			struct ata_link *tlink;
-			struct ata_device *tdev;
-
-			ata_port_for_each_link(tlink, ap)
-				ata_link_for_each_dev(tdev, tlink)
+		if (sta) {
+			ata_ehi_hotplugged(ehi);
+			ata_port_freeze(ap);
+		} else {
+			/* The device has gone - unplug it */
+			if (dev)
+				dev->flags |= ATA_DFLAG_DETACH;
+			else {
+				struct ata_link *tlink;
+				struct ata_device *tdev;
+				
+				ata_port_for_each_link(tlink, ap)
+					ata_link_for_each_dev(tdev, tlink)
 					tdev->flags |= ATA_DFLAG_DETACH;
+			}
+			wait = 1;
+			ata_port_freeze(ap);
+			ata_port_schedule_eh(ap);
 		}
-
-		ata_port_schedule_eh(ap);
-		wait = 1;
 		break;
 	}

Might work. Possibly. I'll be able to test on real hardware sometime 
next week, but I don't have access to an ACPI dock with an internal bay. 
I'm not sure how that case would be handled off-hand.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
