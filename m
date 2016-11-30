From: Matthew Whitehead <tedheadster@gmail.com>
Subject: [PATCH,v2] pata_legacy: Allow disabling of legacy PATA device probes on non-PCI systems
Date: Wed, 30 Nov 2016 12:20:56 -0500
Message-ID: <1480526456-15797-1-git-send-email-tedheadster@gmail.com>
References: <1480440386-20400-1-git-send-email-tedheadster@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34603 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754171AbcK3RVa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 30 Nov 2016 12:21:30 -0500
Received: by mail-qt0-f196.google.com with SMTP id l20so20400713qta.1
        for <linux-ide@vger.kernel.org>; Wed, 30 Nov 2016 09:21:30 -0800 (PST)
In-Reply-To: <1480440386-20400-1-git-send-email-tedheadster@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org, b.zolnierkie@samsung.com, sergei.shtylyov@cogentembedded.com, gnomes@lxorguk.ukuu.org.uk
Cc: Matthew Whitehead <tedheadster@gmail.com>

If there is no PCI bus detected in drivers/ata/pata_legacy.c, it registers all
the common legacy PATA devices. This includes I/O ports (0x1f0, 0x170, 0x1e8,
0x168, 0x1e0, 0x160) and also their associated interrupts (14,15,11,10,8,12).

Unfortunately, on such systems those interrupt lines are at a premium because
there is no PCI alternative. This patch allows you to disable individual
port/interrupt pairs by providing a list of ports to skip allocating.

modprobe pata_legacy ignore_ports=0x1e8,0x168,0x1e0,0x160

Signed-off-by: Matthew Whitehead <tedheadster@gmail.com>
---
 drivers/ata/pata_legacy.c |   30 ++++++++++++++++++++++++------
 1 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index 4fe9d21..65a33b4 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -130,6 +130,8 @@ static struct legacy_data legacy_data[NR_HOST];
 static struct ata_host *legacy_host[NR_HOST];
 static int nr_legacy_host;
 
+static int ignore_ports[NR_HOST];
+static int ignore_ports_count;
 
 static int probe_all;		/* Set to check all ISA port ranges */
 static int ht6560a;		/* HT 6560A on primary 1, second 2, both 3 */
@@ -1168,6 +1170,16 @@ static __init void probe_qdi_vlb(void)
 	}
 }
 
+static bool port_ignored(int port)
+{
+	int i;
+	for (i = 0; i < ignore_ports_count; i++) {
+		if (port == ignore_ports[i])
+			return 1;
+	}
+	return 0;
+}
+
 /**
  *	legacy_init		-	attach legacy interfaces
  *
@@ -1212,17 +1224,22 @@ static __init int legacy_init(void)
 	if (winbond == 1)
 		winbond = 0x130;	/* Default port, alt is 1B0 */
 
-	if (primary == 0 || all)
+	if ((primary == 0 || all) && !port_ignored(0x1F0))
 		legacy_probe_add(0x1F0, 14, UNKNOWN, 0);
-	if (secondary == 0 || all)
+	if ((secondary == 0 || all) && !port_ignored(0x170))
 		legacy_probe_add(0x170, 15, UNKNOWN, 0);
 
 	if (probe_all || !pci_present) {
 		/* ISA/VLB extra ports */
-		legacy_probe_add(0x1E8, 11, UNKNOWN, 0);
-		legacy_probe_add(0x168, 10, UNKNOWN, 0);
-		legacy_probe_add(0x1E0, 8, UNKNOWN, 0);
-		legacy_probe_add(0x160, 12, UNKNOWN, 0);
+
+		if (!port_ignored(0x1E8))
+			legacy_probe_add(0x1E8, 11, UNKNOWN, 0);
+		if (!port_ignored(0x168))
+			legacy_probe_add(0x168, 10, UNKNOWN, 0);
+		if (!port_ignored(0x1E0))
+			legacy_probe_add(0x1E0, 8, UNKNOWN, 0);
+		if (!port_ignored(0x160))
+			legacy_probe_add(0x160, 12, UNKNOWN, 0);
 	}
 
 	if (opti82c46x)
@@ -1272,6 +1289,7 @@ module_param(qdi, int, 0);
 module_param(winbond, int, 0);
 module_param(pio_mask, int, 0);
 module_param(iordy_mask, int, 0);
+module_param_array(ignore_ports, int, &ignore_ports_count, 0444);
 
 module_init(legacy_init);
 module_exit(legacy_exit);
-- 
1.7.1

