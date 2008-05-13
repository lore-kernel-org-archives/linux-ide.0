From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH -stable] ata_piix: verify SIDPR access before enabling it
Date: Tue, 13 May 2008 17:23:38 +0900
Message-ID: <4829500A.7060506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:10723 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755336AbYEMIXr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 May 2008 04:23:47 -0400
Received: by wa-out-1112.google.com with SMTP id j37so3992069waf.23
        for <linux-ide@vger.kernel.org>; Tue, 13 May 2008 01:23:44 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: stable@kernel.org, Jeff Garzik l <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On certain configurations (certain macbooks), even though all the
conditions for SIDPR access described in the datasheet are met,
actually reading those registers just returns 0 and have no effect on
write.  Verify SIDPR is actually working before enabling it.

This is reported by Ryan Roth in bz#10512.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Ryan Roth <ryan.roth@ch2m.com>
---
This patch is now in Linus' tree and it's probably a good idea to
include it for 2.6.25-x.

Thanks.

drivers/ata/ata_piix.c |   25 +++++++++++++++++++++++++
1 file changed, 25 insertions(+)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index ea2c764..a9027b8 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1348,6 +1348,8 @@ static void __devinit piix_init_sidpr(struct ata_host *host)
{
	struct pci_dev *pdev = to_pci_dev(host->dev);
	struct piix_host_priv *hpriv = host->private_data;
+	struct ata_device *dev0 = &host->ports[0]->link.device[0];
+	u32 scontrol;
	int i;

	/* check for availability */
@@ -1366,6 +1368,29 @@ static void __devinit piix_init_sidpr(struct ata_host *host)
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

