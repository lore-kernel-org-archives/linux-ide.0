From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 06/11] ata: sparse fixes for pata_amd.c
Date: Wed, 13 Feb 2008 21:14:20 -0800
Message-ID: <1202966060.2748.20.camel@brick>
References: <3ad7c41048d88a3f8aad098570b9fac9ff719aff.1202965399.git.harvey.harrison@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:7963 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759163AbYBNFOW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 00:14:22 -0500
Received: by rv-out-0910.google.com with SMTP id k20so160092rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 21:14:21 -0800 (PST)
In-Reply-To: <3ad7c41048d88a3f8aad098570b9fac9ff719aff.1202965399.git.harvey.harrison@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

drop return statement.
drivers/ata/pata_amd.c:149:2: warning: returning void-valued expression

Commit ce54d1616302117fa98513ae916bb3333e1c02ea pata_amd: update mode selection for NV PATAs

added the initializer for nv_mode_filter but missed deleting the previously
set mode_filter

drivers/ata/pata_amd.c:509:3: warning: Initializer entry defined twice
drivers/ata/pata_amd.c:521:3:   also defined here
drivers/ata/pata_amd.c:544:3: warning: Initializer entry defined twice
drivers/ata/pata_amd.c:556:3:   also defined here

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/ata/pata_amd.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index ea567e2..4b8d9b5 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -146,9 +146,8 @@ static int amd_pre_reset(struct ata_link *link, unsigned long deadline)
 
 static void amd_error_handler(struct ata_port *ap)
 {
-	return ata_bmdma_drive_eh(ap, amd_pre_reset,
-				      ata_std_softreset, NULL,
-				      ata_std_postreset);
+	ata_bmdma_drive_eh(ap, amd_pre_reset, ata_std_softreset, NULL,
+			   ata_std_postreset);
 }
 
 static int amd_cable_detect(struct ata_port *ap)
@@ -506,7 +505,6 @@ static struct ata_port_operations amd133_port_ops = {
 static struct ata_port_operations nv100_port_ops = {
 	.set_piomode	= nv100_set_piomode,
 	.set_dmamode	= nv100_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
 	.tf_load	= ata_tf_load,
 	.tf_read	= ata_tf_read,
 	.check_status 	= ata_check_status,
@@ -541,7 +539,6 @@ static struct ata_port_operations nv100_port_ops = {
 static struct ata_port_operations nv133_port_ops = {
 	.set_piomode	= nv133_set_piomode,
 	.set_dmamode	= nv133_set_dmamode,
-	.mode_filter	= ata_pci_default_filter,
 	.tf_load	= ata_tf_load,
 	.tf_read	= ata_tf_read,
 	.check_status 	= ata_check_status,
-- 
1.5.4.1.1278.gc75be


