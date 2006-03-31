From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/15] libata: make ata_bus_probe() return negative errno on failure
Date: Sat, 1 Apr 2006 01:38:17 +0900
Message-ID: <11438230973036-git-send-email-htejun@gmail.com>
References: <1143823097579-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:11491 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750720AbWCaQiZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 11:38:25 -0500
Received: by zproxy.gmail.com with SMTP id o37so955009nzf
        for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 08:38:24 -0800 (PST)
In-Reply-To: <1143823097579-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_bus_probe() uses unsigned int rc to receive negative errno and
returns the converted unsigned int value.  Convert temporary variables
to int and make ata_bus_probe() return negative errno on failure.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

f1cffe0d11839b2aa79cc6ae1517715566b18083
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 8def7a5..c7ba523 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1349,13 +1349,13 @@ err_out_nosup:
  *	PCI/etc. bus probe sem.
  *
  *	RETURNS:
- *	Zero on success, non-zero on error.
+ *	Zero on success, negative errno otherwise.
  */
 
 static int ata_bus_probe(struct ata_port *ap)
 {
 	unsigned int classes[ATA_MAX_DEVICES];
-	unsigned int i, rc, found = 0;
+	int i, rc, found = 0;
 
 	ata_port_probe(ap);
 
@@ -1421,7 +1421,7 @@ static int ata_bus_probe(struct ata_port
 
 err_out_disable:
 	ap->ops->port_disable(ap);
-	return -1;
+	return -ENODEV;
 }
 
 /**
-- 
1.2.4


