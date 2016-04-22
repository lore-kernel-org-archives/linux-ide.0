From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 1/5] ata: ahci: add support for non-standard port offset/length
Date: Fri, 22 Apr 2016 16:32:37 +0200
Message-ID: <1461335561-18363-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1461335561-18363-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:41720 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754372AbcDVOct (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Apr 2016 10:32:49 -0400
In-Reply-To: <1461335561-18363-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>
Cc: linux-ide@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Hanna Hawa <hannah@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

By default, the AHCI registers start at a base of 0x100 bytes from the
base register address, and have a length of 0x80 bytes for each
port. Unfortunately, the ARM64 Marvell Armada 7K/8K deviates from this
default, with a base of 0x10000 bytes and a register length of 0x10000
bytes per port.

In order to support the Armada 7K/8K AHCI controller easily, this
commit extends the ahci_host_priv structure with two members:

 - port_offset, which contains the offset from the base, which
   defaults to AHCI_DEFAULT_PORT_OFFSET (0x100 bytes)

 - port_length, which contains the length of the per-port register
   area, which defaults to AHCI_DEFAULT_PORT_LENGTH (0x80 bytes)

This commit adds the structure members, initializes them to their
default value in ahci_platform_get_resources() and uses those
structure members were appropriate in the AHCI core.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/ata/ahci.c             | 5 +++--
 drivers/ata/ahci.h             | 7 ++++++-
 drivers/ata/libahci_platform.c | 7 ++++++-
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index a83bbcc..a695c17 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1714,10 +1714,11 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
+		unsigned int offset =
+			hpriv->port_offset + ap->port_no * hpriv->port_length;
 
 		ata_port_pbar_desc(ap, ahci_pci_bar, -1, "abar");
-		ata_port_pbar_desc(ap, ahci_pci_bar,
-				   0x100 + ap->port_no * 0x80, "port");
+		ata_port_pbar_desc(ap, ahci_pci_bar, offset, "port");
 
 		/* set enclosure management message type */
 		if (ap->flags & ATA_FLAG_EM)
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 70b06bc..aca6bb2 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -326,6 +326,9 @@ struct ahci_port_priv {
 	char			*irq_desc;	/* desc in /proc/interrupts */
 };
 
+#define AHCI_DEFAULT_PORT_OFFSET	0x100
+#define AHCI_DEFAULT_PORT_LENGTH	0x80
+
 struct ahci_host_priv {
 	/* Input fields */
 	unsigned int		flags;		/* AHCI_HFLAG_* */
@@ -333,6 +336,8 @@ struct ahci_host_priv {
 	u32			mask_port_map;	/* mask out particular bits */
 
 	void __iomem *		mmio;		/* bus-independent mem map */
+	u32			port_offset;	/* offset of ports from base */
+	u32			port_length;	/* length of per-port area */
 	u32			cap;		/* cap to use */
 	u32			cap2;		/* cap2 to use */
 	u32			version;	/* cached version */
@@ -433,7 +438,7 @@ static inline void __iomem *__ahci_port_base(struct ata_host *host,
 	struct ahci_host_priv *hpriv = host->private_data;
 	void __iomem *mmio = hpriv->mmio;
 
-	return mmio + 0x100 + (port_no * 0x80);
+	return mmio + hpriv->port_offset + (port_no * hpriv->port_length);
 }
 
 static inline void __iomem *ahci_port_base(struct ata_port *ap)
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index aaa761b..727fe66 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -371,6 +371,9 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
 		goto err_out;
 	}
 
+	hpriv->port_offset = AHCI_DEFAULT_PORT_OFFSET;
+	hpriv->port_length = AHCI_DEFAULT_PORT_LENGTH;
+
 	for (i = 0; i < AHCI_MAX_CLKS; i++) {
 		/*
 		 * For now we must use clk_get(dev, NULL) for the first clock,
@@ -556,10 +559,12 @@ int ahci_platform_init_host(struct platform_device *pdev,
 
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
+		unsigned int offset =
+			hpriv->port_offset + ap->port_no * hpriv->port_length;
 
 		ata_port_desc(ap, "mmio %pR",
 			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
-		ata_port_desc(ap, "port 0x%x", 0x100 + ap->port_no * 0x80);
+		ata_port_desc(ap, "port 0x%x", offset);
 
 		/* set enclosure management message type */
 		if (ap->flags & ATA_FLAG_EM)
-- 
2.6.4

