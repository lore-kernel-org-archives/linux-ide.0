From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Success(?) with SiI + Seagate pessimistic fix disabled.
Date: Fri, 9 Jan 2004 01:00:03 -0800
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040109090003.GA3032@Mayonaise>
References: <20040109054800.GA32112@Mayonaise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from user-0c8gj4g.cable.mindspring.com ([24.136.76.144]:32386 "EHLO
	localhost") by vger.kernel.org with ESMTP id S266446AbUAIJAD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Jan 2004 04:00:03 -0500
Content-Disposition: inline
In-Reply-To: <20040109054800.GA32112@Mayonaise>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com

Eric Wong <normalperson@yhbt.net> wrote:
<snip success story>

I'm not feeling any more pessimistic than usual at the moment, so I
might as well start a one item whitelist.  It works for me, but more
testing is always a good thing.

On a related note, I couldn't find a way to get the firmware revision
from hdparm or dmesg when using libata.

--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -65,6 +65,15 @@ static struct pci_device_id sil_pci_tbl[
 	{ }	/* terminate list */
 };
 
+
+/* TODO firmware versions should be added - eric */
+struct sil_drivelist {
+	char * product;
+} sil_whitelist [] = {
+	{ "ST3160023AS" }, /* firmware 3.05 */
+	{ 0 }
+};
+
 static struct pci_driver sil_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= sil_pci_tbl,
@@ -184,6 +194,7 @@ static void sil_scr_write (struct ata_po
  */
 static void sil_dev_config(struct ata_port *ap, struct ata_device *dev)
 {
+	int n;
 	const char *s = &dev->product[0];
 	unsigned int len = strnlen(s, sizeof(dev->product));
 
@@ -191,6 +202,12 @@ static void sil_dev_config(struct ata_po
 	while ((len > 0) && (s[len - 1] == ' '))
 		len--;
 
+	/* check against whitelist */
+	for (n = 0; sil_whitelist[n].product; n++)
+		if ( (len == strlen(sil_whitelist[n].product))
+		&& !strncmp(sil_whitelist[n].product,s,len) )
+			return;
+
 	/* limit to udma5 */
 	if (!memcmp(s, "Maxtor ", 7)) {
 		printk(KERN_INFO "ata%u(%u): applying pessimistic Maxtor errata fix\n",

-- 
Eric Wong
