From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/6] ata_piix: reimplement piix_sata_probe()
Date: Wed, 1 Mar 2006 01:25:39 +0900
Message-ID: <11411439393563-git-send-email-htejun@gmail.com>
References: <11411439383398-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.195]:28470 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751874AbWB1QZ5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 11:25:57 -0500
Received: by zproxy.gmail.com with SMTP id l1so1218059nzf
        for <linux-ide@vger.kernel.org>; Tue, 28 Feb 2006 08:25:56 -0800 (PST)
In-Reply-To: <11411439383398-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, jfs@keytradebank.com, 0602@eq.cz, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Reimplement piix_sata_probe() such that it turns on PCS enable bits on
all avaliable ports and check present bits after a while to determine
device presence.  This should help broken BIOSes.  After device
presence detection is complete, PCS enable bits of unoccupied bits are
turned off unless the controller supports AHCI (ICH6/7 docs mandate
all enables bits are always set on AHCI capable controllers).

Note that PCS present bits are ignored on 6300ESB as described in the
datasheet.  This should fix device detection problems reported with
the controller.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ata_piix.c |   59 +++++++++++++++++++++++++++++------------------
 1 files changed, 37 insertions(+), 22 deletions(-)

cea33259b68294395b5d855aff308f342e9913a4
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 4080b8b..72e38e6 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -499,44 +499,59 @@ static int piix_pata_probe_reset(struct 
  *	piix_sata_probe - Probe PCI device for present SATA devices
  *	@ap: Port associated with the PCI device we wish to probe
  *
- *	Reads SATA PCI device's PCI config register Port Configuration
- *	and Status (PCS) to determine port and device availability.
+ *	Reads and configures SATA PCI device's PCI config register
+ *	Port Configuration and Status (PCS) to determine port and
+ *	device availability.
  *
  *	LOCKING:
  *	None (inherited from caller).
  *
  *	RETURNS:
- *	Non-zero if port is enabled, it may or may not have a device
- *	attached in that case (PRESENT bit would only be set if BIOS probe
- *	was done). Zero is returned if port is disabled.
+ *	Mask of avaliable devices on the port.
  */
-static int piix_sata_probe (struct ata_port *ap)
+static unsigned int piix_sata_probe (struct ata_port *ap)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	int combined = (ap->flags & ATA_FLAG_SLAVE_POSS);
-	int orig_mask, mask, i;
+	const unsigned int *map = ap->host_set->private_data;
+	int base = 2 * ap->hard_port_no;
+	unsigned int present_mask = 0;
+	int port, i;
 	u8 pcs;
 
 	pci_read_config_byte(pdev, ICH5_PCS, &pcs);
-	orig_mask = (int) pcs & 0xff;
+	DPRINTK("ata%u: ENTER, pcs=0x%x base=%d\n", ap->id, pcs, base);
 
-	/* TODO: this is vaguely wrong for ICH6 combined mode,
-	 * where only two of the four SATA ports are mapped
-	 * onto a single ATA channel.  It is also vaguely inaccurate
-	 * for ICH5, which has only two ports.  However, this is ok,
-	 * as further device presence detection code will handle
-	 * any false positives produced here.
-	 */
+	/* enable all ports on this ap and wait for them to settle */
+	for (i = 0; i < 2; i++) {
+		port = map[base + i];
+		if (port >= 0)
+			pcs |= 1 << port;
+	}
 
-	for (i = 0; i < 4; i++) {
-		mask = (PIIX_PORT_ENABLED << i);
+	pci_write_config_byte(pdev, ICH5_PCS, pcs);
+	msleep(100);
+
+	/* let's see which devices are present */
+	pci_read_config_byte(pdev, ICH5_PCS, &pcs);
 
-		if ((orig_mask & mask) == mask)
-			if (combined || (i == ap->hard_port_no))
-				return 1;
+	for (i = 0; i < 2; i++) {
+		port = map[base + i];
+		if (port < 0)
+			continue;
+		if (ap->flags & PIIX_FLAG_IGN_PRESENT || pcs & 1 << (4 + port))
+			present_mask |= 1 << i;
+		else
+			pcs &= ~(1 << port);
 	}
 
-	return 0;
+	/* disable offline ports on non-AHCI controllers */
+	if (!(ap->flags & PIIX_FLAG_AHCI))
+		pci_write_config_byte(pdev, ICH5_PCS, pcs);
+
+	DPRINTK("ata%u: LEAVE, pcs=0x%x present_mask=0x%x\n",
+		ap->id, pcs, present_mask);
+
+	return present_mask;
 }
 
 /**
-- 
1.2.1


