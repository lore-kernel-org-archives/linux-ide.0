From: Robert Hancock <hancockr@shaw.ca>
Subject: [PATCH 3/5] sata_nv: Cleanup taskfile setup
Date: Mon, 19 Feb 2007 19:02:46 -0600
Message-ID: <45DA48B6.5020807@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933029AbXBTBGP@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org

This edits the taskfile setup to more closely match the way that libata
sends the taskfile for other controllers. This avoids putting taskfile writes
into the CPB buffer that are not needed according to the taskfile flags.

Signed-off-by: Robert Hancock <hancockr@shaw.ca>

--- linux-2.6.20-git6edit/drivers/ata/sata_nv.c	2007-02-15 22:36:02.000000000 -0600
+++ linux-2.6.20-git6edit/drivers/ata/sata_nv.c.delayandfixes	2007-02-19 17:00:14.000000000 -0600
@@ -662,29 +662,30 @@ static unsigned int nv_adma_tf_to_cpb(st
 {
 	unsigned int idx = 0;
 
-	cpb[idx++] = cpu_to_le16((ATA_REG_DEVICE << 8) | tf->device | WNB);
-
-	if ((tf->flags & ATA_TFLAG_LBA48) == 0) {
-		cpb[idx++] = cpu_to_le16(IGN);
-		cpb[idx++] = cpu_to_le16(IGN);
-		cpb[idx++] = cpu_to_le16(IGN);
-		cpb[idx++] = cpu_to_le16(IGN);
-		cpb[idx++] = cpu_to_le16(IGN);
-	}
-	else {
-		cpb[idx++] = cpu_to_le16((ATA_REG_ERR   << 8) | tf->hob_feature);
-		cpb[idx++] = cpu_to_le16((ATA_REG_NSECT << 8) | tf->hob_nsect);
-		cpb[idx++] = cpu_to_le16((ATA_REG_LBAL  << 8) | tf->hob_lbal);
-		cpb[idx++] = cpu_to_le16((ATA_REG_LBAM  << 8) | tf->hob_lbam);
-		cpb[idx++] = cpu_to_le16((ATA_REG_LBAH  << 8) | tf->hob_lbah);
-	}
-	cpb[idx++] = cpu_to_le16((ATA_REG_ERR    << 8) | tf->feature);
-	cpb[idx++] = cpu_to_le16((ATA_REG_NSECT  << 8) | tf->nsect);
-	cpb[idx++] = cpu_to_le16((ATA_REG_LBAL   << 8) | tf->lbal);
-	cpb[idx++] = cpu_to_le16((ATA_REG_LBAM   << 8) | tf->lbam);
-	cpb[idx++] = cpu_to_le16((ATA_REG_LBAH   << 8) | tf->lbah);
+	if(tf->flags & ATA_TFLAG_ISADDR) {
+		if (tf->flags & ATA_TFLAG_LBA48) {
+			cpb[idx++] = cpu_to_le16((ATA_REG_ERR   << 8) | tf->hob_feature | WNB);
+			cpb[idx++] = cpu_to_le16((ATA_REG_NSECT << 8) | tf->hob_nsect);
+			cpb[idx++] = cpu_to_le16((ATA_REG_LBAL  << 8) | tf->hob_lbal);
+			cpb[idx++] = cpu_to_le16((ATA_REG_LBAM  << 8) | tf->hob_lbam);
+			cpb[idx++] = cpu_to_le16((ATA_REG_LBAH  << 8) | tf->hob_lbah);
+			cpb[idx++] = cpu_to_le16((ATA_REG_ERR    << 8) | tf->feature);
+		} else
+			cpb[idx++] = cpu_to_le16((ATA_REG_ERR    << 8) | tf->feature | WNB);
+			
+		cpb[idx++] = cpu_to_le16((ATA_REG_NSECT  << 8) | tf->nsect);
+		cpb[idx++] = cpu_to_le16((ATA_REG_LBAL   << 8) | tf->lbal);
+		cpb[idx++] = cpu_to_le16((ATA_REG_LBAM   << 8) | tf->lbam);
+		cpb[idx++] = cpu_to_le16((ATA_REG_LBAH   << 8) | tf->lbah);
+	}
+	
+	if(tf->flags & ATA_TFLAG_DEVICE)
+		cpb[idx++] = cpu_to_le16((ATA_REG_DEVICE << 8) | tf->device);
 
 	cpb[idx++] = cpu_to_le16((ATA_REG_CMD    << 8) | tf->command | CMDEND);
+	
+	while(idx < 12)
+		cpb[idx++] = cpu_to_le16(IGN);
 
 	return idx;
 }
