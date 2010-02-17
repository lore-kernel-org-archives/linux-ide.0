From: Alan Cox <alan@linux.intel.com>
Subject: [RFC 2/4] libata: Remove excess delay in the tf_load path
Date: Wed, 17 Feb 2010 13:11:40 +0000
Message-ID: <20100217131032.16338.64825.stgit@localhost.localdomain>
References: <20100217130847.16338.55586.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100217130847.16338.55586.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: jeff@garzik.org.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

We don't need to stall and wait after loading the task file and before
issuing a command, so don't do it. This shows up on profiles and is not
needed. It costs us up to 1mS on a dumb controller. Matches the old IDE
behaviour.

[Note we are now at 2mS on a dumb controller of what seems to be excess
 delay and fiddling, 3mS if you are writing ctl]

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/ata/libata-sff.c |    3 ---
 drivers/ata/pata_via.c   |    2 --
 2 files changed, 0 insertions(+), 5 deletions(-)


diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index cf0332a..3558ca8 100644
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
index 6356377..eccfed2 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -416,8 +416,6 @@ static void via_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
 			tf->lbam,
 			tf->lbah);
 	}
-
-	ata_wait_idle(ap);
 }
 
 static int via_port_start(struct ata_port *ap)
