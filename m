From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: ahci_gtf_filter_workaround function breaks current git build
Date: Fri, 9 Oct 2009 05:41:47 +0200
Message-ID: <20091009034147.GA1985@phenom2.trippelsdorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out-068.synserver.de ([212.40.180.68]:1035 "HELO
	smtp-out-068.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755220AbZJIDtG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Oct 2009 23:49:06 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, tj@kernel.org

ahci: Add ifdef wrapper to ahci_gtf_filter_workaround

Commit f80ae7e45a0e03da188494c6e947a5c8b0cdfb4a 
ahci: filter FPDMA non-zero offset enable for Aspire 3810T 
breaks the current git build for configurations that don't define
CONFIG_ATA_ACPI.  
This adds an ifdef wrapper to ahci_gtf_filter_workaround.

Signed-off-by: Markus Trippelsdorf <markus@trippelsdorf.de>

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 4edca6e..b1a2577 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -2884,6 +2884,7 @@ static bool ahci_broken_online(struct pci_dev *pdev)
 	return pdev->bus->number == (val >> 8) && pdev->devfn == (val & 0xff);
 }
 
+#ifdef CONFIG_ATA_ACPI
 static void ahci_gtf_filter_workaround(struct ata_host *host)
 {
 	static const struct dmi_system_id sysids[] = {
@@ -2927,6 +2928,10 @@ static void ahci_gtf_filter_workaround(struct ata_host *host)
 				dev->gtf_filter |= filter;
 	}
 }
+#else
+static inline void ahci_gtf_filter_workaround(struct ata_host *host)
+{}
+#endif
 
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
-- 
Markus
