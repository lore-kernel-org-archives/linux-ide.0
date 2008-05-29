From: Li Zefan <lizf@cn.fujitsu.com>
Subject: [BUG ?] kmalloc() with GFP_KERNEL while holding spinlock ?
Date: Thu, 29 May 2008 11:21:58 +0800
Message-ID: <483E2156.9020108@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:51173 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbYE2DX2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 May 2008 23:23:28 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

I noticed the following issue in the code:

in drivers/ata/libata-acpi.c:

static void ata_acpi_handle_hotplug(struct ata_port *ap, struct ata_device *dev,
				    u32 event)
{
	...
	spin_lock_irqsave(ap->lock, flags);
	...

	if (dev) {
		if (dev->sdev)
			kobj = &dev->sdev->sdev_gendev.kobj;
	} else
		kobj = &ap->dev->kobj;

	if (kobj) {
		sprintf(event_string, "BAY_EVENT=%d", event);
		kobject_uevent_env(kobj, KOBJ_CHANGE, envp);
	}

	spin_unlock_irqrestore(ap->lock, flags);
	...
}

and kobject_uevent_env() calls kzalloc(..., GFP_KERNEL);
