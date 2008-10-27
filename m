From: Tejun Heo <tj@kernel.org>
Subject: Re: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Mon, 27 Oct 2008 16:38:18 +0900
Message-ID: <49056FEA.4070405@kernel.org>
References: <20081011142735.GB5904@cleopatra.jogback.se> <48F4337A.50307@kernel.org> <20081014201917.GA5974@cleopatra.jogback.se> <48F595DB.4030301@kernel.org> <20081018165209.GA7754@cleopatra.jogback.se> <20081023181443.GA7323@cleopatra.jogback.se> <49056F2C.20101@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020904060203070905070800"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57944 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921AbYJ0HiZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Oct 2008 03:38:25 -0400
In-Reply-To: <49056F2C.20101@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lars Michael Jogback <lm@jogback.se>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020904060203070905070800
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Oh.. one more thing.  Can you please try the attached patch and post the
failing log?

Thanks.

-- 
tejun

--------------020904060203070905070800
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 4621807..f8b9898 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -978,6 +978,8 @@ static void sil24_error_intr(struct ata_port *ap)
 	ehi = &link->eh_info;
 	ata_ehi_clear_desc(ehi);
 
+	ata_port_printk(ap, KERN_INFO,
+			"XXX error_intr irq_stat=0x%x\n", irq_stat);
 	ata_ehi_push_desc(ehi, "irq_stat 0x%08x", irq_stat);
 
 	if (irq_stat & PORT_IRQ_SDB_NOTIFY) {
@@ -1045,6 +1047,8 @@ static void sil24_error_intr(struct ata_port *ap)
 
 		/* analyze CMD_ERR */
 		cerr = readl(port + PORT_CMD_ERR);
+		ata_port_printk(ap, KERN_INFO,
+				"XXX error_intr cerr=%u\n", cerr);
 		if (cerr < ARRAY_SIZE(sil24_cerr_db))
 			ci = &sil24_cerr_db[cerr];
 

--------------020904060203070905070800--
