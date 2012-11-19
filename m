From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 307/493] ide: remove use of __devinitdata
Date: Mon, 19 Nov 2012 13:24:16 -0500
Message-ID: <1353349642-3677-307-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41458 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754193Ab2KSSeZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2012 13:34:25 -0500
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devinitdata is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: "David S. Miller" <davem@davemloft.net> 
Cc: linux-ide@vger.kernel.org 
---
 drivers/ide/delkin_cb.c   | 2 +-
 drivers/ide/palm_bk3710.c | 2 +-
 drivers/ide/sgiioc4.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/delkin_cb.c b/drivers/ide/delkin_cb.c
index 1b96393..9254b58 100644
--- a/drivers/ide/delkin_cb.c
+++ b/drivers/ide/delkin_cb.c
@@ -158,7 +158,7 @@ static int delkin_cb_resume(struct pci_dev *dev)
 #define delkin_cb_resume NULL
 #endif
 
-static struct pci_device_id delkin_cb_pci_tbl[] __devinitdata = {
+static struct pci_device_id delkin_cb_pci_tbl[] = {
 	{ 0x1145, 0xf021, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0x1145, 0xf024, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
diff --git a/drivers/ide/palm_bk3710.c b/drivers/ide/palm_bk3710.c
index c4b0b8f..7e1e836 100644
--- a/drivers/ide/palm_bk3710.c
+++ b/drivers/ide/palm_bk3710.c
@@ -301,7 +301,7 @@ static const struct ide_port_ops palm_bk3710_ports_ops = {
 	.cable_detect		= palm_bk3710_cable_detect,
 };
 
-static struct ide_port_info __devinitdata palm_bk3710_port_info = {
+static struct ide_port_info palm_bk3710_port_info = {
 	.init_dma		= palm_bk3710_init_dma,
 	.port_ops		= &palm_bk3710_ports_ops,
 	.dma_ops		= &sff_dma_ops,
diff --git a/drivers/ide/sgiioc4.c b/drivers/ide/sgiioc4.c
index 62dffeb..b5b93f2 100644
--- a/drivers/ide/sgiioc4.c
+++ b/drivers/ide/sgiioc4.c
@@ -613,7 +613,7 @@ int ioc4_ide_attach_one(struct ioc4_driver_data *idd)
 	return pci_init_sgiioc4(idd->idd_pdev);
 }
 
-static struct ioc4_submodule __devinitdata ioc4_ide_submodule = {
+static struct ioc4_submodule ioc4_ide_submodule = {
 	.is_name = "IOC4_ide",
 	.is_owner = THIS_MODULE,
 	.is_probe = ioc4_ide_attach_one,
-- 
1.8.0

