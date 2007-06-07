From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata interface fatal error
Date: Thu, 07 Jun 2007 18:50:45 +0900
Message-ID: <4667D4F5.1060302@gmail.com>
References: <46580134.7010107@effenberger.org> <465BEF50.8050207@gmail.com> <466725E5.9030405@effenberger.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020003040601020304000407"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:18526 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbXFGJuy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jun 2007 05:50:54 -0400
Received: by wa-out-1112.google.com with SMTP id v27so530987wah
        for <linux-ide@vger.kernel.org>; Thu, 07 Jun 2007 02:50:54 -0700 (PDT)
In-Reply-To: <466725E5.9030405@effenberger.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Effenberger <florian@effenberger.org>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

This is a multi-part message in MIME format.
--------------020003040601020304000407
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Florian Effenberger wrote:
> Hi,
> 
>> Currently, there is no mechanism to do that but hard drives usually have
>> dip switch to force 1.5Gbps.  Please try that.  If your harddrive
>> doesn't have that, please lemme know.  I'll prepare a simple patch.
> 
> unfortunately, the disks have a jumper board, but the jumpers are
> missing... could you write a patch for me? Would be much appreciated!

Okay, there was a bug in link speed limit logic.  That's probably why
speed down to 1.5Gbps didn't kick in.  The attached patch contains the
fix and hack to force 1.5Gbps.  Please give it a shot.

Thanks.

-- 
tejun

--------------020003040601020304000407
Content-Type: text/x-patch;
 name="ahci-force-1_5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ahci-force-1_5.patch"

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 7baeaff..f9550f1 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -219,6 +219,7 @@ static int ahci_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc);
 static void ahci_irq_clear(struct ata_port *ap);
 static int ahci_port_start(struct ata_port *ap);
+static int ahci_vt8251_port_start(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
 static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
@@ -284,7 +285,7 @@ static const struct ata_port_operations ahci_ops = {
 	.port_resume		= ahci_port_resume,
 #endif
 
-	.port_start		= ahci_port_start,
+	.port_start		= ahci_vt8251_port_start,
 	.port_stop		= ahci_port_stop,
 };
 
@@ -318,7 +319,7 @@ static const struct ata_port_operations ahci_vt8251_ops = {
 	.port_resume		= ahci_port_resume,
 #endif
 
-	.port_start		= ahci_port_start,
+	.port_start		= ahci_vt8251_port_start,
 	.port_stop		= ahci_port_stop,
 };
 
@@ -1558,6 +1559,19 @@ static int ahci_port_start(struct ata_port *ap)
 	return 0;
 }
 
+static int ahci_vt8251_port_start(struct ata_port *ap)
+{
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+
+	if (((hpriv->cap >> 20) & 0xf) != 1) {
+		printk("limiting SATA link speed to 1.5Gbps\n");
+		ap->hw_sata_spd_limit = 1;
+		ap->eh_info.action |= ATA_EH_HARDRESET;
+	}
+
+	return ahci_port_start(ap);
+}
+
 static void ahci_port_stop(struct ata_port *ap)
 {
 	const char *emsg = NULL;
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4733f00..57940ba 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6313,7 +6313,8 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 		/* init sata_spd_limit to the current value */
 		if (sata_scr_read(ap, SCR_CONTROL, &scontrol) == 0) {
 			int spd = (scontrol >> 4) & 0xf;
-			ap->hw_sata_spd_limit &= (1 << spd) - 1;
+			if (spd)
+				ap->hw_sata_spd_limit &= (1 << spd) - 1;
 		}
 		ap->sata_spd_limit = ap->hw_sata_spd_limit;
 

--------------020003040601020304000407--
