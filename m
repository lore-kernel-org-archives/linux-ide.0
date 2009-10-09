From: Jeff Garzik <jeff@garzik.org>
Subject: [git patches] libata build fix
Date: Fri, 9 Oct 2009 00:32:48 -0400
Message-ID: <20091009043248.GA12304@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752165AbZJIEd0@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/ata/ahci.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

Markus Trippelsdorf (1):
      ahci: Add ifdef wrapper to ahci_gtf_filter_workaround

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
