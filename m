From: Adrian Bunk <bunk@stusta.de>
Subject: [2.4 patch] let SCSI_SATA_NV depend on EXPERIMENTAL
Date: Wed, 8 Dec 2004 04:02:46 +0100
Message-ID: <20041208030246.GP5496@stusta.de>
References: <20041205165908.GA25139@thune.sonic.net> <20041208025248.GN5496@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58376 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262022AbULHDCv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Dec 2004 22:02:51 -0500
Content-Disposition: inline
In-Reply-To: <20041208025248.GN5496@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo.tosatti@cyclades.com>, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Jeff,

Mike Castle <dalgoda@ix.netcom.com> noticed that CONFIG_SCSI_SATA_NV in 
2.4 is marked as "(EXPERIMENTAL)", but doesn't depend on EXPERIMENTAL.

Since it depends on EXPERIMENTAL in 2.6, I'd sugget the patch below to 
add this dependency in 2.4, too.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.4.29-pre1-full/drivers/scsi/Config.in.old	2004-12-08 03:53:07.000000000 +0100
+++ linux-2.4.29-pre1-full/drivers/scsi/Config.in	2004-12-08 03:53:26.000000000 +0100
@@ -72,7 +72,7 @@
 dep_tristate '  AHCI SATA support (EXPERIMENTAL)' CONFIG_SCSI_SATA_AHCI $CONFIG_SCSI_SATA $CONFIG_PCI $CONFIG_EXPERIMENTAL
 dep_tristate '  ServerWorks Frodo / Apple K2 SATA support (EXPERIMENTAL)' CONFIG_SCSI_SATA_SVW $CONFIG_SCSI_SATA $CONFIG_PCI $CONFIG_EXPERIMENTAL
 dep_tristate '  Intel PIIX/ICH SATA support' CONFIG_SCSI_ATA_PIIX $CONFIG_SCSI_SATA $CONFIG_PCI
-dep_tristate '  NVIDIA SATA support (EXPERIMENTAL)' CONFIG_SCSI_SATA_NV $CONFIG_SCSI_SATA $CONFIG_PCI
+dep_tristate '  NVIDIA SATA support (EXPERIMENTAL)' CONFIG_SCSI_SATA_NV $CONFIG_SCSI_SATA $CONFIG_PCI $CONFIG_EXPERIMENTAL
 dep_tristate '  Promise SATA TX2/TX4 support (EXPERIMENTAL)' CONFIG_SCSI_SATA_PROMISE $CONFIG_SCSI_SATA $CONFIG_PCI $CONFIG_EXPERIMENTAL
 dep_tristate '  Promise SATA SX4 support (EXPERIMENTAL)' CONFIG_SCSI_SATA_SX4 $CONFIG_SCSI_SATA $CONFIG_PCI $CONFIG_EXPERIMENTAL
 dep_tristate '  Silicon Image SATA support (EXPERIMENTAL)' CONFIG_SCSI_SATA_SIL $CONFIG_SCSI_SATA $CONFIG_PCI $CONFIG_EXPERIMENTAL
