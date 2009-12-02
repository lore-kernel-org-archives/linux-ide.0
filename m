From: Tejun Heo <tj@kernel.org>
Subject: Re: Intermittent SATA failures ("link offline, clearing class 1 to
 NONE")
Date: Wed, 02 Dec 2009 10:43:42 +0900
Message-ID: <4B15C64E.7090106@kernel.org>
References: <1258054583-sup-4108@utwig> <4B14B207.9010208@kernel.org> <1259652273-sup-686@utwig> <4B14D003.30407@kernel.org> <4B14D454.7010300@kernel.org> <1259704924-sup-4007@utwig>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080504020002030205020109"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50245 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793AbZLBBos (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Dec 2009 20:44:48 -0500
In-Reply-To: <1259704924-sup-4007@utwig>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alex Vandiver <alex@chmrr.net>
Cc: linux-ide <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------080504020002030205020109
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

Can you please try this one?

Thanks.

-- 
tejun

--------------080504020002030205020109
Content-Type: text/x-patch;
 name="piix-longer-debounce.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="piix-longer-debounce.patch"

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 9ac4e37..f50bba6 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -173,6 +173,8 @@ static int piix_sidpr_scr_read(struct ata_link *link,
 			       unsigned int reg, u32 *val);
 static int piix_sidpr_scr_write(struct ata_link *link,
 				unsigned int reg, u32 val);
+static int piix_sidpr_hardreset(struct ata_link *link, unsigned int *class,
+				unsigned long deadline);
 #ifdef CONFIG_PM
 static int piix_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
 static int piix_pci_device_resume(struct pci_dev *pdev);
@@ -334,9 +336,9 @@ static struct ata_port_operations piix_sata_ops = {
 
 static struct ata_port_operations piix_sidpr_sata_ops = {
 	.inherits		= &piix_sata_ops,
-	.hardreset		= sata_std_hardreset,
 	.scr_read		= piix_sidpr_scr_read,
 	.scr_write		= piix_sidpr_scr_write,
+	.hardreset		= piix_sidpr_hardreset,
 };
 
 static const struct piix_map_db ich5_map_db = {
@@ -962,6 +964,18 @@ static int piix_sidpr_scr_write(struct ata_link *link,
 	return 0;
 }
 
+static int piix_sidpr_hardreset(struct ata_link *link, unsigned int *class,
+				unsigned long deadline)
+{
+	const unsigned long *timing = sata_deb_timing_hotplug;
+	bool online;
+	int rc;
+
+	/* do hardreset */
+	rc = sata_link_hardreset(link, timing, deadline, &online, NULL);
+	return online ? -EAGAIN : rc;
+}
+
 #ifdef CONFIG_PM
 static int piix_broken_suspend(void)
 {
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index dc72690..c501e1e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3731,7 +3731,7 @@ int sata_link_debounce(struct ata_link *link, const unsigned long *params,
 	unsigned long interval = params[0];
 	unsigned long duration = params[1];
 	unsigned long last_jiffies, t;
-	u32 last, cur;
+	u32 last, cur, xxx;
 	int rc;
 
 	t = ata_deadline(jiffies, params[2]);
@@ -3740,7 +3740,9 @@ int sata_link_debounce(struct ata_link *link, const unsigned long *params,
 
 	if ((rc = sata_scr_read(link, SCR_STATUS, &cur)))
 		return rc;
+	xxx = cur;
 	cur &= 0xf;
+	ata_link_printk(link, KERN_INFO, "XXX debounce start, SStatus=%x\n", xxx);
 
 	last = cur;
 	last_jiffies = jiffies;
@@ -3749,6 +3751,7 @@ int sata_link_debounce(struct ata_link *link, const unsigned long *params,
 		msleep(interval);
 		if ((rc = sata_scr_read(link, SCR_STATUS, &cur)))
 			return rc;
+		xxx = cur;
 		cur &= 0xf;
 
 		/* DET stable? */
@@ -3756,8 +3759,12 @@ int sata_link_debounce(struct ata_link *link, const unsigned long *params,
 			if (cur == 1 && time_before(jiffies, deadline))
 				continue;
 			if (time_after(jiffies,
-				       ata_deadline(last_jiffies, duration)))
+				       ata_deadline(last_jiffies, duration))) {
+				ata_link_printk(link, KERN_INFO,
+						"XXX debounce done, SStatus=%x, DET stable for %u msecs\n",
+						xxx, jiffies_to_msecs(jiffies - last_jiffies));
 				return 0;
+			}
 			continue;
 		}
 

--------------080504020002030205020109--
