From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/5] libata: fix ata_device_add() error path
Date: Sat, 5 Aug 2006 05:48:47 +0900
Message-ID: <11547245271753-git-send-email-htejun@gmail.com>
References: <11547243571730-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:50704 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161461AbWHDUsx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Aug 2006 16:48:53 -0400
Received: by py-out-1112.google.com with SMTP id z74so508112pyg
        for <linux-ide@vger.kernel.org>; Fri, 04 Aug 2006 13:48:52 -0700 (PDT)
In-Reply-To: <11547243571730-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

In the error path, ata_device_add()

* dereferences null host_set->ports[] element.
* calls scsi_remove_host() on not-yet-added shost.

This patch fixes both bugs.  The first problem was spotted and initial
patch submitted by Dave Jones <davej@redhat.com>.  The second problem
was mentioned and fixed by Jeff Garzik <jgarzik@pobox.com> in a larger
cleanup patch.

Cc: Dave Jones <davej@redhat.com>
Cc: Jeff Garzik <jgarzik@pobox.com>
Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

77f3f879387cc5fce6c7a4ca7777c586fe6291cd
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 509b048..16fc2dd 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5511,10 +5511,10 @@ int ata_device_add(const struct ata_prob
 err_out:
 	for (i = 0; i < count; i++) {
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
 err_free_ret:
 	kfree(host_set);
-- 
1.3.2


