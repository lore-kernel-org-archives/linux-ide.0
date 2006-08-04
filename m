From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 8/9] libata: replace ap->hard_port_no with ap->port_no
Date: Sat, 5 Aug 2006 06:01:34 +0900
Message-ID: <11547252943673-git-send-email-htejun@gmail.com>
References: <11547252923301-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:59189 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161463AbWHDVBs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Aug 2006 17:01:48 -0400
Received: by py-out-1112.google.com with SMTP id z74so516815pyg
        for <linux-ide@vger.kernel.org>; Fri, 04 Aug 2006 14:01:47 -0700 (PDT)
In-Reply-To: <11547252923301-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, davej@redhat.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Replace ap->hard_port_no with ap->port_no.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ata_piix.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

0a77da170fa203e495b08fd92ef488a51578a93c
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index dfdf4a7..99ed16c 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -487,7 +487,7 @@ static void piix_pata_cbl_detect(struct 
 		goto cbl40;
 
 	/* check BIOS cable detect results */
-	mask = ap->hard_port_no == 0 ? PIIX_80C_PRI : PIIX_80C_SEC;
+	mask = ap->port_no == 0 ? PIIX_80C_PRI : PIIX_80C_SEC;
 	pci_read_config_byte(pdev, PIIX_IOCFG, &tmp);
 	if ((tmp & mask) == 0)
 		goto cbl40;
@@ -513,7 +513,7 @@ static int piix_pata_prereset(struct ata
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 
-	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->hard_port_no])) {
+	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->port_no])) {
 		ata_port_printk(ap, KERN_INFO, "port disabled. ignoring.\n");
 		ap->eh_context.i.action &= ~ATA_EH_RESET_MASK;
 		return 0;
@@ -550,7 +550,7 @@ static int piix_sata_prereset(struct ata
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	struct piix_host_priv *hpriv = ap->host_set->private_data;
 	const unsigned int *map = hpriv->map;
-	int base = 2 * ap->hard_port_no;
+	int base = 2 * ap->port_no;
 	unsigned int present = 0;
 	int port, i;
 	u16 pcs;
@@ -601,7 +601,7 @@ static void piix_set_piomode (struct ata
 	unsigned int pio	= adev->pio_mode - XFER_PIO_0;
 	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
 	unsigned int is_slave	= (adev->devno != 0);
-	unsigned int master_port= ap->hard_port_no ? 0x42 : 0x40;
+	unsigned int master_port= ap->port_no ? 0x42 : 0x40;
 	unsigned int slave_port	= 0x44;
 	u16 master_data;
 	u8 slave_data;
@@ -619,10 +619,10 @@ static void piix_set_piomode (struct ata
 		/* enable PPE, IE and TIME */
 		master_data |= 0x0070;
 		pci_read_config_byte(dev, slave_port, &slave_data);
-		slave_data &= (ap->hard_port_no ? 0x0f : 0xf0);
+		slave_data &= (ap->port_no ? 0x0f : 0xf0);
 		slave_data |=
 			(timings[pio][0] << 2) |
-			(timings[pio][1] << (ap->hard_port_no ? 4 : 0));
+			(timings[pio][1] << (ap->port_no ? 4 : 0));
 	} else {
 		master_data &= 0xccf8;
 		/* enable PPE, IE and TIME */
@@ -652,9 +652,9 @@ static void piix_set_dmamode (struct ata
 {
 	unsigned int udma	= adev->dma_mode; /* FIXME: MWDMA too */
 	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
-	u8 maslave		= ap->hard_port_no ? 0x42 : 0x40;
+	u8 maslave		= ap->port_no ? 0x42 : 0x40;
 	u8 speed		= udma;
-	unsigned int drive_dn	= (ap->hard_port_no ? 2 : 0) + adev->devno;
+	unsigned int drive_dn	= (ap->port_no ? 2 : 0) + adev->devno;
 	int a_speed		= 3 << (drive_dn * 4);
 	int u_flag		= 1 << drive_dn;
 	int v_flag		= 0x01 << drive_dn;
-- 
1.3.2


