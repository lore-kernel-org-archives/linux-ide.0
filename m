From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 1/3] libata: Remove excess delay in the tf_load path
Date: Wed, 05 May 2010 10:24:57 +0100
Message-ID: <20100505092448.586.25299.stgit@localhost.localdomain>
References: <20100505092350.586.46344.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39732 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751342Ab0EEKD0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 May 2010 06:03:26 -0400
In-Reply-To: <20100505092350.586.46344.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

We don't need to stall and wait after loading the task file and before
issuing a command, so don't do it. This shows up on profiles and is not
needed.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/ata/libata-sff.c |    3 ---
 drivers/ata/pata_via.c   |    2 --
 2 files changed, 0 insertions(+), 5 deletions(-)


diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index b313896..17754a7 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -579,7 +579,6 @@ void ata_sff_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
 		if (ioaddr->ctl_addr)
 			iowrite8(tf->ctl, ioaddr->ctl_addr);
 		ap->last_ctl = tf->ctl;
-		ata_wait_idle(ap);
 	}
 
 	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
@@ -615,8 +614,6 @@ void ata_sff_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
 		iowrite8(tf->device, ioaddr->device_addr);
 		VPRINTK("device 0x%X\n", tf->device);
 	}
-
-	ata_wait_idle(ap);
 }
 EXPORT_SYMBOL_GPL(ata_sff_tf_load);
 
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 741e7cb..87fb89e 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -417,8 +417,6 @@ static void via_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
 			tf->lbam,
 			tf->lbah);
 	}
-
-	ata_wait_idle(ap);
 }
 
 static int via_port_start(struct ata_port *ap)

