From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Fri, 16 Nov 2012 08:39:34 +0000 (UTC)
Message-ID: <20121116083934.B4F9711FEE3@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:37843 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937Ab2KPIjk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Nov 2012 03:39:40 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id BCC38202A5
	for <linux-ide@vger.kernel.org>; Fri, 16 Nov 2012 08:39:38 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 9B5E22029C
	for <linux-ide@vger.kernel.org>; Fri, 16 Nov 2012 08:39:37 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #41 from Aaron Lu <aaron.lu@intel.com>  2012-11-16 08:39:33 ---
The problem I see is:
During init time, identify command needs to be sent;
pacpi_qc_issue is invoked, and if the chipset can not set timing independently
for each drive, and the qc is not for the current drive, dma mode will be set
for the target device if ata_dma_enabled returns true;
At this time, ata_device->dma_mode is still un-initialized as 0, but
ata_dma_enabled would treat this as valid, and the ata_timing table doesn't
handle mode 0, so we get NULL. This problem only occurs when processing
identify command.

So I think we should init ata_device->dma_mode to 0xff when we are to reset the
drive, and the real value will get set in ata_set_mode afterwards. This way,
when pacpi_qc_issue is invoked, it will not attempt to set dma mode for the
device.

And for Szymon's bisect, I think the 'offending' commit actually fixed a
problem of pata_acpi(maybe a long standing problem). And due to this fix,
pata_acpi module triggered this bug.

In previous kernels(pre the 'offending' commit Szymon bisected), the
acpi_port_start function will always fail due to ap->acpi_handle is NULL, the
reason is showed in the following call sequence:

ata_host_start
  ap->ops->port_start -> pacpi_port_start -> where ap->acpi_handle is used
ata_host_register
  ata_associate_acpi -> where the ap->acpi_handle is assigned

So in previous kernels, pata_acpi module will always fail to init the
controller, effectively hiding this bug.

Please someone test the following patch, as I do not have a system to reproduce
this:

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3cc7096..e04cdc2 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2560,6 +2560,7 @@ int ata_bus_probe(struct ata_port *ap)
          * bus as we may be talking too fast.
          */
         dev->pio_mode = XFER_PIO_0;
+        dev->dma_mode = 0xff;

         /* If the controller has a pio mode setup function
          * then use it to set the chipset to rights. Don't
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index e60437c..bf039b0 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2657,6 +2657,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
          * bus as we may be talking too fast.
          */
         dev->pio_mode = XFER_PIO_0;
+        dev->dma_mode = 0xff;

         /* If the controller has a pio mode setup function
          * then use it to set the chipset to rights. Don't

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
