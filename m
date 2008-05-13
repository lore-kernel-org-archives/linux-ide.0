From: <gregkh@suse.de>
Subject: patch ata_piix-verify-sidpr-access-before-enabling-it.patch added to 2.6.25-stable tree
Date: Tue, 13 May 2008 10:54:55 -0700
Message-ID: <20080513175649.B81DB1454476@imap.suse.de>
References: <4829500A.7060506@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34313 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756213AbYEMR4x (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 May 2008 13:56:53 -0400
In-Reply-To: <4829500A.7060506@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, gregkh@suse.de, jeff@garzik.org, jgarzik@redhat.com, linux-ide@vger.kernel.org, ryan.roth@ch2m.com
Cc: stable@kernel.org, stable-commits@vger.kernel.org


This is a note to let you know that we have just queued up the patch titled

     Subject: ata_piix: verify SIDPR access before enabling it

to the 2.6.25-stable tree.  Its filename is

     ata_piix-verify-sidpr-access-before-enabling-it.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


>From stable-bounces@linux.kernel.org Tue May 13 01:24:07 2008
From: Tejun Heo <htejun@gmail.com>
Date: Tue, 13 May 2008 17:23:38 +0900
Subject: ata_piix: verify SIDPR access before enabling it
To: stable@kernel.org, Jeff Garzik l <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>
Message-ID: <4829500A.7060506@gmail.com>

From: Tejun Heo <htejun@gmail.com>

commit cb6716c879ecf49e2af344926c6a476821812061 upstream

On certain configurations (certain macbooks), even though all the
conditions for SIDPR access described in the datasheet are met,
actually reading those registers just returns 0 and have no effect on
write.  Verify SIDPR is actually working before enabling it.

This is reported by Ryan Roth in bz#10512.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Ryan Roth <ryan.roth@ch2m.com>
Signed-off-by: Jeff Garzik <jgarzik@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/ata/ata_piix.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1531,6 +1531,8 @@ static void __devinit piix_init_sidpr(st
 {
 	struct pci_dev *pdev = to_pci_dev(host->dev);
 	struct piix_host_priv *hpriv = host->private_data;
+	struct ata_device *dev0 = &host->ports[0]->link.device[0];
+	u32 scontrol;
 	int i;
 
 	/* check for availability */
@@ -1549,6 +1551,29 @@ static void __devinit piix_init_sidpr(st
 		return;
 
 	hpriv->sidpr = pcim_iomap_table(pdev)[PIIX_SIDPR_BAR];
+
+	/* SCR access via SIDPR doesn't work on some configurations.
+	 * Give it a test drive by inhibiting power save modes which
+	 * we'll do anyway.
+	 */
+	scontrol = piix_sidpr_read(dev0, SCR_CONTROL);
+
+	/* if IPM is already 3, SCR access is probably working.  Don't
+	 * un-inhibit power save modes as BIOS might have inhibited
+	 * them for a reason.
+	 */
+	if ((scontrol & 0xf00) != 0x300) {
+		scontrol |= 0x300;
+		piix_sidpr_write(dev0, SCR_CONTROL, scontrol);
+		scontrol = piix_sidpr_read(dev0, SCR_CONTROL);
+
+		if ((scontrol & 0xf00) != 0x300) {
+			dev_printk(KERN_INFO, host->dev, "SCR access via "
+				   "SIDPR is available but doesn't work\n");
+			return;
+		}
+	}
+
 	host->ports[0]->ops = &piix_sidpr_sata_ops;
 	host->ports[1]->ops = &piix_sidpr_sata_ops;
 }


Patches currently in stable-queue which might be from htejun@gmail.com are

queue-2.6.25/ata_piix-verify-sidpr-access-before-enabling-it.patch
