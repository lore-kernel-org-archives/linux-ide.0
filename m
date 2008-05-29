From: Johannes Weiner <hannes@saeurebad.de>
Subject: Re: [BUG ?] kmalloc() with GFP_KERNEL while holding spinlock ?
Date: Thu, 29 May 2008 05:59:03 +0200
Message-ID: <87fxs1rcag.fsf@saeurebad.de>
References: <483E2156.9020108@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from saeurebad.de ([85.214.36.134]:39794 "EHLO saeurebad.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753711AbYE2D7f (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 May 2008 23:59:35 -0400
In-Reply-To: <483E2156.9020108@cn.fujitsu.com> (Li Zefan's message of "Thu, 29
	May 2008 11:21:58 +0800")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Li Zefan <lizf@cn.fujitsu.com>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Hi,

Li Zefan <lizf@cn.fujitsu.com> writes:

> I noticed the following issue in the code:
>
> in drivers/ata/libata-acpi.c:
>
> static void ata_acpi_handle_hotplug(struct ata_port *ap, struct ata_device *dev,
> 				    u32 event)
> {
> 	...
> 	spin_lock_irqsave(ap->lock, flags);
> 	...
>
> 	if (dev) {
> 		if (dev->sdev)
> 			kobj = &dev->sdev->sdev_gendev.kobj;
> 	} else
> 		kobj = &ap->dev->kobj;
>
> 	if (kobj) {
> 		sprintf(event_string, "BAY_EVENT=%d", event);
> 		kobject_uevent_env(kobj, KOBJ_CHANGE, envp);
> 	}
>
> 	spin_unlock_irqrestore(ap->lock, flags);
> 	...
> }
>
> and kobject_uevent_env() calls kzalloc(..., GFP_KERNEL);

Fixed by commit ae6c23c4e1ec9720b99e1e6850fe47c6c7fddbb3 "Fixups to ATA
ACPI hotplug" by Matthew Garrett.

	Hannes
