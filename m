From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH v2 2/3] ahci: move AHCI_HFLAGS() macro to ahci.h
Date: Tue, 21 Feb 2012 10:38:43 -0800
Message-ID: <1329849524-23758-3-git-send-email-computersforpeace@gmail.com>
References: <1329849524-23758-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1329849524-23758-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Brian Norris <computersforpeace@gmail.com>, Lin Ming <ming.m.lin@intel.com>, Norbert Preining <preining@logic.at>, "Srivatsa S . Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Valdis Kletnieks <valdis.kletnieks@vt.edu>, "Rafael J . Wysocki" <rjw@sisk.pl>
List-Id: linux-ide@vger.kernel.org

We will need this macro in both ahci.c and ahci_platform.c, so just move it
to the header.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/ata/ahci.c |    2 --
 drivers/ata/ahci.h |    3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index d07bf03..ddeb845 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -103,8 +103,6 @@ static struct ata_port_operations ahci_p5wdh_ops = {
 	.hardreset		= ahci_p5wdh_hardreset,
 };
 
-#define AHCI_HFLAGS(flags)	.private_data	= (void *)(flags)
-
 static const struct ata_port_info ahci_port_info[] = {
 	/* by features */
 	[board_ahci] =
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index feb127e..c2594dd 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -195,6 +195,9 @@ enum {
 	PORT_FBS_EN		= (1 << 0), /* Enable FBS */
 
 	/* hpriv->flags bits */
+
+#define AHCI_HFLAGS(flags)		.private_data	= (void *)(flags)
+
 	AHCI_HFLAG_NO_NCQ		= (1 << 0),
 	AHCI_HFLAG_IGN_IRQ_IF_ERR	= (1 << 1), /* ignore IRQ_IF_ERR */
 	AHCI_HFLAG_IGN_SERR_INTERNAL	= (1 << 2), /* ignore SERR_INTERNAL */
