From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: ignore EH scheduling during initialization
Date: Tue, 01 May 2007 11:50:15 +0200
Message-ID: <46370D57.1070504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:9632 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031638AbXEAJvd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 May 2007 05:51:33 -0400
Received: by nz-out-0506.google.com with SMTP id o1so2177276nzf
        for <linux-ide@vger.kernel.org>; Tue, 01 May 2007 02:51:33 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Berck E. Nash" <flyboy@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

libata enables SCSI host during ATA host activation which happens
after IRQ handler is registered and IRQ is enabled.  All ATA ports are
in frozen state when IRQ is enabled but frozen ports may raise limited
number of IRQs after being frozen - IOW, ->freeze() is not responsible
for clearing pending IRQs.  During normal operation, the IRQ handler
is responsible for clearing spurious IRQs on frozen ports and it
usually doesn't require any extra code.

Unfortunately, during host initialization, the IRQ handler can end up
scheduling EH for a port whose SCSI host isn't initialized yet.  This
results in OOPS in the SCSI midlayer.  This is relatively short window
and scheduling EH for probing is the first thing libata does after
initialization, so ignoring EH scheduling until initialization is
complete solves the problem nicely.

This problem was spotted by Berck E. Nash in the following thread.

  http://thread.gmane.org/gmane.linux.kernel/519412

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Berck E. Nash <flyboy@gmail.com>

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6d0a946..a7219aa 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5897,6 +5897,7 @@ struct ata_port *ata_port_alloc(struct a
 	if (!ap)
 		return NULL;
 
+	ap->pflags |= ATA_PFLAG_INITIALIZING;
 	ap->lock = &host->lock;
 	ap->flags = ATA_FLAG_DISABLED;
 	ap->print_id = -1;
@@ -6265,6 +6266,7 @@ int ata_host_register(struct ata_host *h
 			ehi->action |= ATA_EH_SOFTRESET;
 			ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
 
+			ap->pflags &= ~ATA_PFLAG_INITIALIZING;
 			ap->pflags |= ATA_PFLAG_LOADING;
 			ata_port_schedule_eh(ap);
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 0dbee55..26260ce 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -546,6 +546,9 @@ void ata_port_schedule_eh(struct ata_por
 {
 	WARN_ON(!ap->ops->error_handler);
 
+	if (ap->pflags & ATA_PFLAG_INITIALIZING)
+		return;
+
 	ap->pflags |= ATA_PFLAG_EH_PENDING;
 	scsi_schedule_eh(ap->scsi_host);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 73b86dd..cdb23a7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -191,6 +191,7 @@ enum {
 	ATA_PFLAG_LOADING	= (1 << 4), /* boot/loading probe */
 	ATA_PFLAG_UNLOADING	= (1 << 5), /* module is unloading */
 	ATA_PFLAG_SCSI_HOTPLUG	= (1 << 6), /* SCSI hotplug scheduled */
+	ATA_PFLAG_INITIALIZING	= (1 << 7), /* being initialized, don't touch */
 
 	ATA_PFLAG_FLUSH_PORT_TASK = (1 << 16), /* flush port task */
 	ATA_PFLAG_SUSPENDED	= (1 << 17), /* port is suspended (power) */
