From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: disable pdev on all suspend events
Date: Tue, 20 Feb 2007 18:14:48 +0900
Message-ID: <45DABC08.9030607@gmail.com>
References: <20070216213153.f6704ff5.akpm@linux-foundation.org> <45D6FE5A.1080603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:20960 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbXBTJOv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Feb 2007 04:14:51 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1900548nze
        for <linux-ide@vger.kernel.org>; Tue, 20 Feb 2007 01:14:50 -0800 (PST)
In-Reply-To: <45D6FE5A.1080603@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, Greg KH <greg@kroah.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, pavel@suse.cz

libata used disable pdev only on PM_EVENT_SUSPEND while re-enable pdev
unconditionally.  This was okay before ref-counted pdev enable update
but it now makes the pdev pinned after swsusp cycle (enabled twice but
disabled only once) and devres sanity check whines about it.

Fix it by unconditionally disabling pdev on all suspend events.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Pavel, I took your advice and chose to disable unconditionally rather
than recording the status separately, but I still think it would be
nice if we can tell the status we're waking from from either the mesg
itself (say, PM_EVENT_THAW) or recorded prev state.

Both STM and STD are tested.  Please apply.  Thanks.

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2cf8251..12bde4b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6001,11 +6001,10 @@ int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits)
 void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
 	pci_save_state(pdev);
+	pci_disable_device(pdev);
 
-	if (mesg.event == PM_EVENT_SUSPEND) {
-		pci_disable_device(pdev);
+	if (mesg.event == PM_EVENT_SUSPEND)
 		pci_set_power_state(pdev, PCI_D3hot);
-	}
 }
 
 int ata_pci_device_do_resume(struct pci_dev *pdev)

