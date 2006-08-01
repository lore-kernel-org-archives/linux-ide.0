From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/11] libata: fix ata_device_add() error path
Date: Wed, 2 Aug 2006 05:11:49 +0900
Message-ID: <11544631093797-git-send-email-htejun@gmail.com>
References: <11544631081793-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:2909 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932568AbWHAUMB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Aug 2006 16:12:01 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1473626ugc
        for <linux-ide@vger.kernel.org>; Tue, 01 Aug 2006 13:12:00 -0700 (PDT)
In-Reply-To: <11544631081793-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.ukjgarzik@pobox.com, akpm@osdl.org, davej@redhat.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

In the error path, ata_device_add()

* dereferences null host_set->ports[] element.
* calls scsi_remove_host() on not-yet-added shost.

This patch fixes both bugs.  The first problem was spotted and initial
patch submitted by Dave Jones <davej@redhat.com>.  The second problem
was mentioned and fixed by Jeff Garzik <jgarzik@pobox.com> in a larger
cleanup patch.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Dave Jones <davej@redhat.com>
Cc: Jeff Garzik <jgarzik@pobox.com>

---

 drivers/scsi/libata-core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

4d1a48cb2671959685bdeef6d186727b9cfeee10
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index fdcc58e..96fc7a5 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5505,10 +5505,10 @@ int ata_device_add(const struct ata_prob
 err_out:
 	for (i = 0; i < host_set->n_ports; i++) {
 		struct ata_port *ap = host_set->ports[i];
-
-		scsi_remove_host(ap->host);
-		ap->ops->port_stop(ap);
-		scsi_host_put(ap->host);
+		if (ap) {
+			ap->ops->port_stop(ap);
+			scsi_host_put(ap->host);
+		}
 	}
 
 	kfree(host_set);
-- 
1.3.2


