From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/15] libata: separate out ata_spd_string()
Date: Sat, 1 Apr 2006 01:38:17 +0900
Message-ID: <11438230971646-git-send-email-htejun@gmail.com>
References: <1143823097579-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:30179 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751395AbWCaQiY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 11:38:24 -0500
Received: by zproxy.gmail.com with SMTP id o37so955016nzf
        for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 08:38:23 -0800 (PST)
In-Reply-To: <1143823097579-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Separate out ata_spd_string() from sata_print_link_status().  This
will be used by SATA spd configuration routines.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

f10d6a608edacca5ef8c751bb3c48d2cb47f9166
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index c7ba523..6a336ba 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -397,6 +397,18 @@ static const char *ata_mode_string(unsig
 	return "<n/a>";
 }
 
+static const char *sata_spd_string(unsigned int spd)
+{
+	static const char * const spd_str[] = {
+		"1.5 Gbps",
+		"3.0 Gbps",
+	};
+
+	if (spd == 0 || (spd - 1) >= ARRAY_SIZE(spd_str))
+		return "<unknown>";
+	return spd_str[spd - 1];
+}
+
 static void ata_dev_disable(struct ata_port *ap, struct ata_device *dev)
 {
 	if (ata_dev_present(dev)) {
@@ -1452,7 +1464,6 @@ void ata_port_probe(struct ata_port *ap)
 static void sata_print_link_status(struct ata_port *ap)
 {
 	u32 sstatus, tmp;
-	const char *speed;
 
 	if (!ap->ops->scr_read)
 		return;
@@ -1461,14 +1472,8 @@ static void sata_print_link_status(struc
 
 	if (sata_dev_present(ap)) {
 		tmp = (sstatus >> 4) & 0xf;
-		if (tmp & (1 << 0))
-			speed = "1.5";
-		else if (tmp & (1 << 1))
-			speed = "3.0";
-		else
-			speed = "<unknown>";
-		printk(KERN_INFO "ata%u: SATA link up %s Gbps (SStatus %X)\n",
-		       ap->id, speed, sstatus);
+		printk(KERN_INFO "ata%u: SATA link up %s (SStatus %X)\n",
+		       ap->id, sata_spd_string(tmp), sstatus);
 	} else {
 		printk(KERN_INFO "ata%u: SATA link down (SStatus %X)\n",
 		       ap->id, sstatus);
-- 
1.2.4


