From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] ata: mark expected switch fall-throughs
Date: Thu, 12 Oct 2017 14:19:16 -0500
Message-ID: <20171012191916.GA2974@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-ide@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

In cases where a "drop through" comment was already in place, I replaced
it  with a proper "fall through" comment, which is what GCC is expecting
to find.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
This code was tested by compilation only (GCC 7.2.0 was used).
Please, double check if the actual intention of the code is to
fall through.

 drivers/ata/libahci_platform.c | 1 +
 drivers/ata/libata-core.c      | 3 +++
 drivers/ata/libata-eh.c        | 2 ++
 drivers/ata/pata_atp867x.c     | 2 ++
 drivers/ata/sata_mv.c          | 4 ++--
 5 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index a270a11..341d0ef 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -295,6 +295,7 @@ static int ahci_platform_get_phy(struct ahci_host_priv *hpriv, u32 port,
 				node->name);
 			break;
 		}
+		/* fall through */
 	case -ENODEV:
 		/* continue normally */
 		hpriv->phys[port] = NULL;
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 29e3516..5b18510 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1879,6 +1879,7 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 	switch (class) {
 	case ATA_DEV_SEMB:
 		class = ATA_DEV_ATA;	/* some hard drives report SEMB sig */
+		/* fall through */
 	case ATA_DEV_ATA:
 	case ATA_DEV_ZAC:
 		tf.command = ATA_CMD_ID_ATA;
@@ -2975,6 +2976,7 @@ int ata_bus_probe(struct ata_port *ap)
 	case -ENODEV:
 		/* give it just one more chance */
 		tries[dev->devno] = min(tries[dev->devno], 1);
+		/* fall through */
 	case -EIO:
 		if (tries[dev->devno] == 1) {
 			/* This is the last chance, better to slow
@@ -3462,6 +3464,7 @@ int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel)
 
 	case ATA_DNXFER_FORCE_PIO0:
 		pio_mask &= 1;
+		/* fall through */
 	case ATA_DNXFER_FORCE_PIO:
 		mwdma_mask = 0;
 		udma_mask = 0;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 49b3745..e070fe8 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3711,9 +3711,11 @@ static int ata_eh_handle_dev_fail(struct ata_device *dev, int err)
 	case -ENODEV:
 		/* device missing or wrong IDENTIFY data, schedule probing */
 		ehc->i.probe_mask |= (1 << dev->devno);
+		/* fall through */
 	case -EINVAL:
 		/* give it just one more chance */
 		ehc->tries[dev->devno] = min(ehc->tries[dev->devno], 1);
+		/* fall through */
 	case -EIO:
 		if (ehc->tries[dev->devno] == 1) {
 			/* This is the last chance, better to slow
diff --git a/drivers/ata/pata_atp867x.c b/drivers/ata/pata_atp867x.c
index 3ea50dc..3729e24 100644
--- a/drivers/ata/pata_atp867x.c
+++ b/drivers/ata/pata_atp867x.c
@@ -171,6 +171,7 @@ static int atp867x_get_active_clocks_shifted(struct ata_port *ap,
 	default:
 		printk(KERN_WARNING "ATP867X: active %dclk is invalid. "
 			"Using 12clk.\n", clk);
+		/* fall through */
 	case 9 ... 12:
 		clocks = 7;	/* 12 clk */
 		break;
@@ -203,6 +204,7 @@ static int atp867x_get_recover_clocks_shifted(unsigned int clk)
 	default:
 		printk(KERN_WARNING "ATP867X: recover %dclk is invalid. "
 			"Using default 12clk.\n", clk);
+		/* fall through */
 	case 12:	/* default 12 clk */
 		clocks = 0;
 		break;
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 3b2246d..03f5301 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2387,7 +2387,7 @@ static unsigned int mv_qc_issue(struct ata_queued_cmd *qc)
 				      ": attempting PIO w/multiple DRQ: "
 				      "this may fail due to h/w errata\n");
 		}
-		/* drop through */
+		/* fall through */
 	case ATA_PROT_NODATA:
 	case ATAPI_PROT_PIO:
 	case ATAPI_PROT_NODATA:
@@ -3877,7 +3877,7 @@ static int mv_chip_id(struct ata_host *host, unsigned int board_idx)
 				" and avoid the final two gigabytes on"
 				" all RocketRAID BIOS initialized drives.\n");
 		}
-		/* drop through */
+		/* fall through */
 	case chip_6042:
 		hpriv->ops = &mv6xxx_ops;
 		hp_flags |= MV_HP_GEN_IIE;
-- 
2.7.4
