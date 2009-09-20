From: Robert Hancock <hancockrwd@gmail.com>
Subject: [PATCH] ahci: display all AHCI 1.3 HBA capability flags
Date: Sun, 20 Sep 2009 12:16:44 -0600
Message-ID: <4AB6718C.2050107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.211.173]:46658 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbZITSQo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Sep 2009 14:16:44 -0400
Received: by ywh3 with SMTP id 3so2925672ywh.22
        for <linux-ide@vger.kernel.org>; Sun, 20 Sep 2009 11:16:48 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <tj@kernel.org>

Update the AHCI driver to display all of the HBA capabilities defined in the
AHCI 1.3 specification. Some of these are in a new CAP2 (HBA Capabilities
Extended) register.

For example, on an Intel Ibex Peak (PCH) controller:

ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp pio slum part ems
sxs apst 

We don't do anything special with these new flags yet.

Signed-off-by: Robert Hancock <hancockrwd@gmail.com>

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index acd1162..d7b0f12 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -122,6 +122,7 @@ enum {
 	HOST_VERSION		= 0x10, /* AHCI spec. version compliancy */
 	HOST_EM_LOC		= 0x1c, /* Enclosure Management location */
 	HOST_EM_CTL		= 0x20, /* Enclosure Management Control */
+	HOST_CAP2		= 0x24, /* host capabilities, extended */
 
 	/* HOST_CTL bits */
 	HOST_RESET		= (1 << 0),  /* reset controller; self-clear */
@@ -2534,13 +2535,14 @@ static void ahci_print_info(struct ata_host *host)
 	struct ahci_host_priv *hpriv = host->private_data;
 	struct pci_dev *pdev = to_pci_dev(host->dev);
 	void __iomem *mmio = host->iomap[AHCI_PCI_BAR];
-	u32 vers, cap, impl, speed;
+	u32 vers, cap, cap2, impl, speed;
 	const char *speed_s;
 	u16 cc;
 	const char *scc_s;
 
 	vers = readl(mmio + HOST_VERSION);
 	cap = hpriv->cap;
+	cap2 = readl(mmio + HOST_CAP2);
 	impl = hpriv->port_map;
 
 	speed = (cap >> 20) & 0xf;
@@ -2583,7 +2585,7 @@ static void ahci_print_info(struct ata_host *host)
 		"flags: "
 		"%s%s%s%s%s%s%s"
 		"%s%s%s%s%s%s%s"
-		"%s\n"
+		"%s%s%s%s%s%s%s\n"
 		,
 
 		cap & (1 << 31) ? "64bit " : "",
@@ -2598,10 +2600,16 @@ static void ahci_print_info(struct ata_host *host)
 		cap & (1 << 19) ? "nz " : "",
 		cap & (1 << 18) ? "only " : "",
 		cap & (1 << 17) ? "pmp " : "",
+		cap & (1 << 16) ? "fbss " : "",
 		cap & (1 << 15) ? "pio " : "",
 		cap & (1 << 14) ? "slum " : "",
 		cap & (1 << 13) ? "part " : "",
-		cap & (1 << 6) ? "ems ": ""
+		cap & (1 << 7) ? "ccc " : "",
+		cap & (1 << 6) ? "ems " : "",
+		cap & (1 << 5) ? "sxs " : "",
+		cap2 & (1 << 2) ? "apst " : "",
+		cap2 & (1 << 1) ? "nvmp " : "",
+		cap2 & (1 << 0) ? "boh " : ""
 		);
 }
 
