From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/5] libata: fix ata_port_detach() for old EH ports
Date: Sat, 5 Aug 2006 05:48:46 +0900
Message-ID: <1154724526723-git-send-email-htejun@gmail.com>
References: <11547243571730-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:43281 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161462AbWHDUsx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Aug 2006 16:48:53 -0400
Received: by py-out-1112.google.com with SMTP id z74so508111pyg
        for <linux-ide@vger.kernel.org>; Fri, 04 Aug 2006 13:48:52 -0700 (PDT)
In-Reply-To: <11547243571730-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_prot_detach() did nothing for old EH ports and thus SCSI hosts
associated with those ports are left dangling after they are detached
leaving stale devices and causing oops eventually.  Make
ata_port_detach() remove SCSI hosts for old EH ports.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

c3cf30a989efec8144225517e0b2f82c955e3966
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 386e5f2..bca92dd 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5558,7 +5558,7 @@ void ata_port_detach(struct ata_port *ap
 	int i;
 
 	if (!ap->ops->error_handler)
-		return;
+		goto skip_eh;
 
 	/* tell EH we're leaving & flush EH */
 	spin_lock_irqsave(ap->lock, flags);
@@ -5594,6 +5594,7 @@ void ata_port_detach(struct ata_port *ap
 	cancel_delayed_work(&ap->hotplug_task);
 	flush_workqueue(ata_aux_wq);
 
+ skip_eh:
 	/* remove the associated SCSI host */
 	scsi_remove_host(ap->host);
 }
-- 
1.3.2


