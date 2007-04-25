From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.21-rc7-mm1 BUG at kernel/sched-clock.c:175 init_sched_clock()
Date: Wed, 25 Apr 2007 18:30:44 +0900
Message-ID: <20070425093044.GE17130@htj.dyndns.org>
References: <462E4C4D.9020806@gmail.com> <20070425011654.222a2b4b.akpm@linux-foundation.org> <462F1481.8010807@gmail.com> <20070425085432.GD17130@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:41675 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992458AbXDYJau (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Apr 2007 05:30:50 -0400
Received: by py-out-1112.google.com with SMTP id a29so138200pyi
        for <linux-ide@vger.kernel.org>; Wed, 25 Apr 2007 02:30:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070425085432.GD17130@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Berck E. Nash" <flyboy@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Please test this one instead.  Thanks.

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1c00526..c9999e6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5871,6 +5871,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 	if (!ap)
 		return NULL;
 
+	ap->pflags |= ATA_PFLAG_INITIALIZING;
 	ap->lock = &host->lock;
 	ap->flags = ATA_FLAG_DISABLED;
 	ap->print_id = -1;
@@ -6239,6 +6240,7 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 			ehi->action |= ATA_EH_SOFTRESET;
 			ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
 
+			ap->pflags &= ~ATA_PFLAG_INITIALIZING;
 			ap->pflags |= ATA_PFLAG_LOADING;
 			ata_port_schedule_eh(ap);
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 59d0fb5..4c6914c 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -529,6 +529,9 @@ void ata_port_schedule_eh(struct ata_port *ap)
 {
 	WARN_ON(!ap->ops->error_handler);
 
+	if (ap->pflags & ATA_PFLAG_INITIALIZING)
+		return;
+
 	ap->pflags |= ATA_PFLAG_EH_PENDING;
 	scsi_schedule_eh(ap->scsi_host);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index fa551fd..8ca3611 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -191,6 +191,7 @@ enum {
 	ATA_PFLAG_LOADING	= (1 << 4), /* boot/loading probe */
 	ATA_PFLAG_UNLOADING	= (1 << 5), /* module is unloading */
 	ATA_PFLAG_SCSI_HOTPLUG	= (1 << 6), /* SCSI hotplug scheduled */
+	ATA_PFLAG_INITIALIZING	= (1 << 7), /* being initialized, don't touch */
 
 	ATA_PFLAG_FLUSH_PORT_TASK = (1 << 16), /* flush port task */
 	ATA_PFLAG_SUSPENDED	= (1 << 17), /* port is suspended (power) */
