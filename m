From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH -repost 1/1] ATA: pata_via, fix double put on isa bridge
Date: Fri,  9 Oct 2009 16:03:52 +0200
Message-ID: <1255097032-23949-1-git-send-email-jirislaby@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760882AbZJIOEb@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jgarzik@pobox.com
Cc: josephchan@via.com.tw, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-ide@vger.kernel.org

In via_init_one, when via_isa_bridges iterator reaches
PCI_DEVICE_ID_VIA_ANON and last but one via_isa_bridges bridge is
found but rev doesn't match, pci_dev_put(isa) is called twice.

Do pci_dev_put only once.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>
---
 drivers/ata/pata_via.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 45657ca..9688fe5 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -526,7 +526,7 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		.port_ops = &via_port_ops
 	};
 	const struct ata_port_info *ppi[] = { NULL, NULL };
-	struct pci_dev *isa = NULL;
+	struct pci_dev *isa;
 	const struct via_isa_bridge *config;
 	static int printed_version;
 	u8 enable;
@@ -551,15 +551,13 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		if ((isa = pci_get_device(PCI_VENDOR_ID_VIA +
 			!!(config->flags & VIA_BAD_ID),
 			config->id, NULL))) {
+			u8 rev = isa->revision;
+			pci_dev_put(isa);
 
-			if (isa->revision >= config->rev_min &&
-			    isa->revision <= config->rev_max)
+			if (rev >= config->rev_min && rev <= config->rev_max)
 				break;
-			pci_dev_put(isa);
 		}
 
-	pci_dev_put(isa);
-
 	if (!(config->flags & VIA_NO_ENABLES)) {
 		/* 0x40 low bits indicate enabled channels */
 		pci_read_config_byte(pdev, 0x40 , &enable);
-- 
1.6.4.2
