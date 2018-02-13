From: Aishwarya Pant <aishpant@gmail.com>
Subject: [PATCH] libata: transport: cleanup documentation of sysfs interface
Date: Tue, 13 Feb 2018 16:51:59 +0530
Message-ID: <20180213112159.GA24306@mordor.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41969 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934226AbeBMLWF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 13 Feb 2018 06:22:05 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>, Gwendal Grignou <gwendal@chromium.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>

Clean-up the documentation of sysfs interfaces to be in the same format
as described in Documentation/ABI/README. This will be useful for
tracking changes in the ABI. Attributes are grouped by function (device,
link or port) and then by date added.

This patch also adds documentation for one attribute -
/sys/class/ata_port/ataX/port_no

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 Documentation/ABI/testing/sysfs-ata | 171 +++++++++++++++++++++---------------
 1 file changed, 100 insertions(+), 71 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-ata b/Documentation/ABI/testing/sysfs-ata
index aa4296498859..9ab0ef1dd1c7 100644
--- a/Documentation/ABI/testing/sysfs-ata
+++ b/Documentation/ABI/testing/sysfs-ata
@@ -1,110 +1,139 @@
 What:		/sys/class/ata_...
-Date:		August 2008
-Contact:	Gwendal Grignou<gwendal@google.com>
 Description:
-
-Provide a place in sysfs for storing the ATA topology of the system.  This allows
-retrieving various information about ATA objects.
+		Provide a place in sysfs for storing the ATA topology of the
+		system. This allows retrieving various information about ATA
+		objects.
 
 Files under /sys/class/ata_port
 -------------------------------
 
-	For each port, a directory ataX is created where X is the ata_port_id of
-	the port. The device parent is the ata host device.
+For each port, a directory ataX is created where X is the ata_port_id of the
+port. The device parent is the ata host device.
 
-idle_irq (read)
 
-	Number of IRQ received by the port while idle [some ata HBA only].
+What:		/sys/class/ata_port/ataX/nr_pmp_links
+What:		/sys/class/ata_port/ataX/idle_irq
+Date:		May, 2010
+KernelVersion:	v2.6.37
+Contact:	Gwendal Grignou <gwendal@chromium.org>
+Description:
+		nr_pmp_links:	(RO) If a SATA Port Multiplier (PM) is
+				connected, the number of links behind it.
 
-nr_pmp_links (read)
+		idle_irq:	(RO) Number of IRQ received by the port while
+				idle [some ata HBA only].
 
-	If a SATA Port Multiplier (PM) is connected, number of link behind it.
+
+What:		/sys/class/ata_port/ataX/port_no
+Date:		May, 2013
+KernelVersion:	v3.11
+Contact:	Gwendal Grignou <gwendal@chromium.org>
+Description:
+		(RO) Host local port number. While registering host controller,
+		port numbers are tracked based upon number of ports available on
+		the controller. This attribute is needed by udev for composing
+		persistent links in /dev/disk/by-path.
 
 Files under /sys/class/ata_link
 -------------------------------
 
-	Behind each port, there is a ata_link. If there is a SATA PM in the
-	topology, 15 ata_link objects are created.
-
-	If a link is behind a port, the directory name is linkX, where X is
-	ata_port_id of the port.
-	If a link is behind a PM, its name is linkX.Y where X is ata_port_id
-	of the parent port and Y the PM port.
+Behind each port, there is a ata_link. If there is a SATA PM in the topology, 15
+ata_link objects are created.
 
-hw_sata_spd_limit
+If a link is behind a port, the directory name is linkX, where X is ata_port_id
+of the port. If a link is behind a PM, its name is linkX.Y where X is
+ata_port_id of the parent port and Y the PM port.
 
-	Maximum speed supported by the connected SATA device.
 
-sata_spd_limit
+What:		/sys/class/ata_link/linkX[.Y]/hw_sata_spd_limit
+What:		/sys/class/ata_link/linkX[.Y]/sata_spd_limit
+What:		/sys/class/ata_link/linkX[.Y]/sata_spd
+Date:		May, 2010
+KernelVersion:	v2.6.37
+Contact:	Gwendal Grignou <gwendal@chromium.org>
+Description:
+		hw_sata_spd_limit:	(RO) Maximum speed supported by the
+					connected SATA device.
 
-	Maximum speed imposed by libata.
+		sata_spd_limit:		(RO) Maximum speed imposed by libata.
 
-sata_spd
+		sata_spd:		(RO) Current speed of the link
+					eg. 1.5, 3 Gbps etc.
 
-	Current speed of the link [1.5, 3Gps,...].
 
 Files under /sys/class/ata_device
 ---------------------------------
 
-	Behind each link, up to two ata device are created.
-	The name of the directory is devX[.Y].Z where:
-	- X is ata_port_id of the port where the device is connected,
-	- Y the port of the PM if any, and
-	- Z the device id: for PATA, there is usually 2 devices [0,1],
-	only 1 for SATA.
-
-class
-	Device class. Can be "ata" for disk, "atapi" for packet device,
-	"pmp" for PM, or "none" if no device was found behind the link.
-
-dma_mode
+Behind each link, up to two ata devices are created.
+The name of the directory is devX[.Y].Z where:
+- X is ata_port_id of the port where the device is connected,
+- Y the port of the PM if any, and
+- Z the device id: for PATA, there is usually 2 devices [0,1], only 1 for SATA.
+
+
+What:		/sys/class/ata_device/devX[.Y].Z/spdn_cnt
+What:		/sys/class/ata_device/devX[.Y].Z/gscr
+What:		/sys/class/ata_device/devX[.Y].Z/ering
+What:		/sys/class/ata_device/devX[.Y].Z/id
+What:		/sys/class/ata_device/devX[.Y].Z/pio_mode
+What:		/sys/class/ata_device/devX[.Y].Z/xfer_mode
+What:		/sys/class/ata_device/devX[.Y].Z/dma_mode
+What:		/sys/class/ata_device/devX[.Y].Z/class
+Date:		May, 2010
+KernelVersion:	v2.6.37
+Contact:	Gwendal Grignou <gwendal@chromium.org>
+Description:
+		spdn_cnt:	(RO) Number of times libata decided to lower the
+				speed of link due to errors.
 
-	Transfer modes supported by the device when in DMA mode.
-	Mostly used by PATA device.
+		gscr:		(RO) Cached result of the dump of PM GSCR
+				register. Valid registers are:
 
-pio_mode
+				0:      SATA_PMP_GSCR_PROD_ID,
+				1:	SATA_PMP_GSCR_REV,
+				2:      SATA_PMP_GSCR_PORT_INFO,
+				32:     SATA_PMP_GSCR_ERROR,
+				33:     SATA_PMP_GSCR_ERROR_EN,
+				64:     SATA_PMP_GSCR_FEAT,
+				96:     SATA_PMP_GSCR_FEAT_EN,
+				130:    SATA_PMP_GSCR_SII_GPIO
 
-	Transfer modes supported by the device when in PIO mode.
-	Mostly used by PATA device.
+				Only valid if the device is a PM.
 
-xfer_mode
+		ering:		(RO) Formatted output of the error ring of the
+				device.
 
-	Current transfer mode.
+		id:		(RO) Cached result of IDENTIFY command, as
+				described in ATA8 7.16 and 7.17. Only valid if
+				the device is not a PM.
 
-id
+		pio_mode:	(RO) Transfer modes supported by the device when
+				in PIO mode. Mostly used by PATA device.
 
-	Cached result of IDENTIFY command, as described in ATA8 7.16 and 7.17.
-	Only valid if the device is not a PM.
+		xfer_mode:	(RO) Current transfer mode
 
-gscr
+		dma_mode:	(RO) Transfer modes supported by the device when
+				in DMA mode. Mostly used by PATA device.
 
-	Cached result of the dump of PM GSCR register.
-	Valid registers are:
-	0: 	SATA_PMP_GSCR_PROD_ID,
-	1: 	SATA_PMP_GSCR_REV,
-	2: 	SATA_PMP_GSCR_PORT_INFO,
-	32:	SATA_PMP_GSCR_ERROR,
-	33:	SATA_PMP_GSCR_ERROR_EN,
-	64:	SATA_PMP_GSCR_FEAT,
-	96:	SATA_PMP_GSCR_FEAT_EN,
-	130:	SATA_PMP_GSCR_SII_GPIO
-	Only valid if the device is a PM.
+		class:		(RO) Device class. Can be "ata" for disk,
+				"atapi" for packet device, "pmp" for PM, or
+				"none" if no device was found behind the link.
 
-trim
 
-	Shows the DSM TRIM mode currently used by the device. Valid
-	values are:
-	unsupported:		Drive does not support DSM TRIM
-	unqueued:		Drive supports unqueued DSM TRIM only
-	queued:			Drive supports queued DSM TRIM
-	forced_unqueued:	Drive's queued DSM support is known to be
-				buggy and only unqueued TRIM commands
-				are sent
+What:		/sys/class/ata_device/devX[.Y].Z/trim
+Date:		May, 2015
+KernelVersion:	v4.10
+Contact:	Gwendal Grignou <gwendal@chromium.org>
+Description:
+		(RO) Shows the DSM TRIM mode currently used by the device. Valid
+		values are:
 
-spdn_cnt
+		unsupported:		Drive does not support DSM TRIM
 
-	Number of time libata decided to lower the speed of link due to errors.
+		unqueued:               Drive supports unqueued DSM TRIM only
 
-ering
+		queued:                 Drive supports queued DSM TRIM
 
-	Formatted output of the error ring of the device.
+		forced_unqueued:	Drive's queued DSM support is known to
+					be buggy and only unqueued TRIM commands
+					are sent
-- 
2.16.1

