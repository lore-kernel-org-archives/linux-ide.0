From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCH 0/2] libata-sff: prevent irq descriptions for dummy ports
Date: Sun, 24 Apr 2011 14:31:33 -0500
Message-ID: <1303673493.5231.13.camel@mulgrave.site>
References: <1303673315.5231.9.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1303673315.5231.9.camel@mulgrave.site>
Sender: linux-parisc-owner@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>
Cc: Parisc List <linux-parisc@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@mvista.com>
List-Id: linux-ide@vger.kernel.org

This is a cosmetic change to prevent libata-sff adding irq
descriptions to dummy ports, since the information, while largely
unused, is erroneous.

Signed-off-by: James Bottomley <James.Bottomley@suse.de>
---
 drivers/ata/libata-sff.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index f8380ce..b1b926c 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2447,13 +2447,18 @@ int ata_pci_sff_activate_host(struct ata_host *host,
 		return -ENOMEM;
 
 	if (!legacy_mode && pdev->irq) {
+		int i;
+
 		rc = devm_request_irq(dev, pdev->irq, irq_handler,
 				      IRQF_SHARED, drv_name, host);
 		if (rc)
 			goto out;
 
-		ata_port_desc(host->ports[0], "irq %d", pdev->irq);
-		ata_port_desc(host->ports[1], "irq %d", pdev->irq);
+		for (i = 0; i < 2; i++) {
+			if (ata_port_is_dummy(host->ports[i]))
+				continue;
+			ata_port_desc(host->ports[i], "irq %d", pdev->irq);
+		}
 	} else if (legacy_mode) {
 		if (!ata_port_is_dummy(host->ports[0])) {
 			rc = devm_request_irq(dev, ATA_PRIMARY_IRQ(pdev),
-- 
1.7.4.1



