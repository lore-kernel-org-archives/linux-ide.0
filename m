From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata changes for v4.11-rc2
Date: Tue, 14 Mar 2017 16:57:49 -0400
Message-ID: <20170314205749.GC15132@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34035 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752676AbdCNU5w (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Mar 2017 16:57:52 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello,

Three libata fixes.

* Fix for a circular reference bug in sysfs code which prevented
  pata_legacy devices from being released after probe failure, which
  in turn prevented devres from releasing the associated resources.

* Drop spurious WARN in the command issue path which can be triggered
  by a legitimate passthrough command.

* A ahci_qoriq specific fix.

Thanks.

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.11-fixes

for you to fetch changes up to 6022c5cadf1a43ca30f431f128daa6163909ad60:

  ahci: qoriq: correct the sata ecc setting error (2017-03-09 11:55:23 -0500)

----------------------------------------------------------------
Gwendal Grignou (1):
      libata: transport: Remove circular dependency at free time

Tejun Heo (1):
      libata: drop WARN from protocol error in ata_sff_qc_issue()

Yuantian Tang (1):
      ahci: qoriq: correct the sata ecc setting error

 drivers/ata/ahci_qoriq.c       | 6 ++++--
 drivers/ata/libata-sff.c       | 1 -
 drivers/ata/libata-transport.c | 9 +++------
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 85d8332..4c96f3a 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -177,7 +177,8 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 	case AHCI_LS1043A:
 		if (!qpriv->ecc_addr)
 			return -EINVAL;
-		writel(ECC_DIS_ARMV8_CH2, qpriv->ecc_addr);
+		writel(readl(qpriv->ecc_addr) | ECC_DIS_ARMV8_CH2,
+				qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
 		if (qpriv->is_dmacoherent)
@@ -194,7 +195,8 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 	case AHCI_LS1046A:
 		if (!qpriv->ecc_addr)
 			return -EINVAL;
-		writel(ECC_DIS_ARMV8_CH2, qpriv->ecc_addr);
+		writel(readl(qpriv->ecc_addr) | ECC_DIS_ARMV8_CH2,
+				qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
 		if (qpriv->is_dmacoherent)
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 2bd92dc..274d6d7 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1482,7 +1482,6 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 		break;
 
 	default:
-		WARN_ON_ONCE(1);
 		return AC_ERR_SYSTEM;
 	}
 
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 4669823..19e6e53 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -224,7 +224,6 @@ static DECLARE_TRANSPORT_CLASS(ata_port_class,
 
 static void ata_tport_release(struct device *dev)
 {
-	put_device(dev->parent);
 }
 
 /**
@@ -284,7 +283,7 @@ int ata_tport_add(struct device *parent,
 	device_initialize(dev);
 	dev->type = &ata_port_type;
 
-	dev->parent = get_device(parent);
+	dev->parent = parent;
 	dev->release = ata_tport_release;
 	dev_set_name(dev, "ata%d", ap->print_id);
 	transport_setup_device(dev);
@@ -348,7 +347,6 @@ static DECLARE_TRANSPORT_CLASS(ata_link_class,
 
 static void ata_tlink_release(struct device *dev)
 {
-	put_device(dev->parent);
 }
 
 /**
@@ -410,7 +408,7 @@ int ata_tlink_add(struct ata_link *link)
 	int error;
 
 	device_initialize(dev);
-	dev->parent = get_device(&ap->tdev);
+	dev->parent = &ap->tdev;
 	dev->release = ata_tlink_release;
 	if (ata_is_host_link(link))
 		dev_set_name(dev, "link%d", ap->print_id);
@@ -589,7 +587,6 @@ static DECLARE_TRANSPORT_CLASS(ata_dev_class,
 
 static void ata_tdev_release(struct device *dev)
 {
-	put_device(dev->parent);
 }
 
 /**
@@ -662,7 +659,7 @@ static int ata_tdev_add(struct ata_device *ata_dev)
 	int error;
 
 	device_initialize(dev);
-	dev->parent = get_device(&link->tdev);
+	dev->parent = &link->tdev;
 	dev->release = ata_tdev_release;
 	if (ata_is_host_link(link))
 		dev_set_name(dev, "dev%d.%d", ap->print_id,ata_dev->devno);

-- 
tejun
