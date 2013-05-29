From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: [PATCH] ata: increase retry count but shorten duration for Calxeda controller
Date: Wed, 29 May 2013 10:51:19 -0500
Message-ID: <1369842679-9680-1-git-send-email-mark.langsdorf@calxeda.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, tj@kernel.org, linux-ide@vger.kernel.org
Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>
List-Id: linux-ide@vger.kernel.org

The Calxeda SATA phy intermittently fails to bring up a link with Gen3
Retrying the phy hard reset can work around the issue, but the drive
may fail again. In less than 150 out of 15000 test runs, it took more
than 10 tries for the link to be established (but never more than 35).
Increase the retry count to guarantee the link is established.

Also, the default 2 second time-out on a failed drive is too long in
this situation. Shorten it to 500 ms. This was also tested 15000 times
on 24 drives and none of them experienced a time out.

Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
---
 drivers/ata/sata_highbank.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index 0d7c4c2..536936f 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -199,7 +199,7 @@ static int highbank_initialize_phys(struct device *dev, void __iomem *addr)
 static int ahci_highbank_hardreset(struct ata_link *link, unsigned int *class,
 				unsigned long deadline)
 {
-	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
+	unsigned long timing[] = { 5, 100, 500};
 	struct ata_port *ap = link->ap;
 	struct ahci_port_priv *pp = ap->private_data;
 	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
@@ -207,7 +207,7 @@ static int ahci_highbank_hardreset(struct ata_link *link, unsigned int *class,
 	bool online;
 	u32 sstatus;
 	int rc;
-	int retry = 10;
+	int retry = 100;
 
 	ahci_stop_engine(ap);
 
-- 
1.7.10.4
