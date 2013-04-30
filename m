From: Robert Richter <rric@kernel.org>
Subject: [PATCH] sata_highbank: Rename proc_name to the module name
Date: Tue, 30 Apr 2013 18:57:18 +0200
Message-ID: <1367341038-7335-1-git-send-email-rric@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Richter <robert.richter@calxeda.com>, Rob Herring <rob.herring@calxeda.com>, Alexander Graf <agraf@suse.de>, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Robert Richter <robert.richter@calxeda.com>

mkinitrd looks at /sys/class/scsi_host/host$hostnum/proc_name to find
the module name of a disk driver. Current name is "highbank-ahci" but
the module is "sata_highbank". Rename it to match the module name.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Alexander Graf <agraf@suse.de>
Cc: <stable@vger.kernel.org> v3.7..
Signed-off-by: Robert Richter <robert.richter@calxeda.com>
---
 drivers/ata/sata_highbank.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index 5dba77c..b1a664a 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -251,7 +251,7 @@ static const struct ata_port_info ahci_highbank_port_info = {
 };
 
 static struct scsi_host_template ahci_highbank_platform_sht = {
-	AHCI_SHT("highbank-ahci"),
+	AHCI_SHT("sata_highbank"),
 };
 
 static const struct of_device_id ahci_of_match[] = {
-- 
1.8.1.1
