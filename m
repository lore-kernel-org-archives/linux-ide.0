From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] IDE-ACPI: Move an assignment for one variable in
 ide_get_dev_handle()
Date: Sat, 26 Dec 2015 11:20:10 +0100
Message-ID: <567E69DA.5020409@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <567E6799.5070802@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <567E6799.5070802@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-ide@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 26 Dec 2015 10:50:33 +0100

Move the assignment for the variable "addr" to the statement
where its value is used after previous function calls succeeded.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ide/ide-acpi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/ide-acpi.c b/drivers/ide/ide-acpi.c
index b6b2111..c2de9f9 100644
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -132,9 +132,6 @@ static int ide_get_dev_handle(struct device *dev, acpi_handle *handle,
 	bus = pdev->bus->number;
 	devnum = PCI_SLOT(pdev->devfn);
 	func = PCI_FUNC(pdev->devfn);
-	/* ACPI _ADR encoding for PCI bus: */
-	addr = (u64)(devnum << 16 | func);
-
 	DEBPRINT("ENTER: pci %02x:%02x.%01x\n", bus, devnum, func);
 
 	dev_handle = ACPI_HANDLE(dev);
@@ -148,6 +145,8 @@ static int ide_get_dev_handle(struct device *dev, acpi_handle *handle,
 		DEBPRINT("get_object_info for device failed\n");
 		return -ENODEV;
 	}
+	/* ACPI _ADR encoding for PCI bus: */
+	addr = (u64)(devnum << 16 | func);
 	if ((dinfo->valid & ACPI_VALID_ADR) &&
 	    dinfo->address == addr) {
 		*pcidevfn = addr;
-- 
2.6.3
