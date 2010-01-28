From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] ahci: add Acer G725 to broken suspend list
Date: Thu, 28 Jan 2010 16:04:15 +0900
Message-ID: <4B6136EF.706@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58163 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616Ab0A1G6E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Jan 2010 01:58:04 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: jani-matti.hatinen@iki.fi

Acer G725 shares the same suspend problem with the HP laptops which
lose ATA devices on resume.  New firmware which fixes the problem is
already available.  Add G725 with old firmwares to the broken suspend
list.

This problem has been reported in bko#15104.

  http://bugzilla.kernel.org/show_bug.cgi?id=3D15104

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Jani-Matti H=E4tinen <jani-matti.hatinen@iki.fi>
---
 drivers/ata/ahci.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index b8bea10..b343903 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -2868,6 +2868,21 @@ static bool ahci_broken_suspend(struct pci_dev *=
pdev)
 			},
 			.driver_data =3D "F.23",	/* cutoff BIOS version */
 		},
+		/*
+		 * Acer eMachines G725 has the same problem.  BIOS
+		 * V1.03 is known to be broken.  V3.04 is known to
+		 * work.  Inbetween, there are V1.06, V2.06 and V3.03
+		 * that we don't have much idea about.  For now,
+		 * blacklist anything older than V3.04.
+		 */
+		{
+			.ident =3D "G725",
+			.matches =3D {
+				DMI_MATCH(DMI_SYS_VENDOR, "eMachines"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "eMachines G725"),
+			},
+			.driver_data =3D "V3.04",	/* cutoff BIOS version */
+		},
 		{ }	/* terminate list */
 	};
 	const struct dmi_system_id *dmi =3D dmi_first_match(sysids);
