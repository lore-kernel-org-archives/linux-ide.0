From: alan@lxorguk.ukuu.org.uk
Subject: [PATCH 12/24] jmicron: Configuration
Date: Tue, 4 Jul 2006 18:14:45 +0000 (UTC)
Message-ID: <11520361173710-git-send-email-alan@lxorguk.ukuu.org.uk>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109888-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361102106-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036111326-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361121401-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361123190-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036113264-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361141196-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361153194-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361162763-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361161279-git-send-email-alan@lxorguk.ukuu.org.uk>
Reply-To: alan@lxorguk.ukuu.org.uk
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48014 "EHLO
	hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S932307AbWGDSO1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 14:14:27 -0400
Date: Maw, 04 Gor 2006 19:01:36 +0100
In-Reply-To: <11520361161279-git-send-email-alan@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, root <root@hraefn.swansea.linux.org.uk>, Alan Cox <alan@redhat.com>

From: root <root@hraefn.swansea.linux.org.uk>

Add the new jmicron driver to the configuration options

Signed-off-by: Alan Cox <alan@redhat.com>


---

 drivers/scsi/Kconfig  |    8 ++++++++
 drivers/scsi/Makefile |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

32a334dd5c47fb4b5c1ac30357a4e53c83cc3ac2
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 53fae27..13c5943 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -641,6 +641,14 @@ config SCSI_PATA_IT821X
 
 	  If unsure, say N.
 
+config SCSI_ATA_JMICRON
+	tristate "JMicron non-AHCI support (Experimental)"
+	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	help
+	  This option enables support for Jmicron ATA controllers
+	  when running in non-AHCI mode. Where possible you should
+	  set the configuration for AHCI to get better performance
+
 config SCSI_PATA_LEGACY
 	tristate "Legacy ISA PATA support (Experimental)"
 	depends on SCSI_SATA && PCI && EXPERIMENTAL
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index 8464997..0031c76 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -140,6 +140,7 @@ obj-$(CONFIG_SCSI_PATA_HPT3X3)	+= libata
 obj-$(CONFIG_SCSI_PATA_ISAPNP)	+= libata.o pata_isapnp.o
 obj-$(CONFIG_SCSI_PATA_IT8172)	+= libata.o pata_it8172.o
 obj-$(CONFIG_SCSI_PATA_IT821X)	+= libata.o pata_it821x.o
+obj-$(CONFIG_SCSI_PATA_JMICRON)	+= libata.o ata_jmicron.o
 obj-$(CONFIG_SCSI_PATA_NETCELL)	+= libata.o pata_netcell.o
 obj-$(CONFIG_SCSI_PATA_NS87410)	+= libata.o pata_ns87410.o
 obj-$(CONFIG_SCSI_PATA_OPTI)	+= libata.o pata_opti.o
-- 
1.2.GIT

