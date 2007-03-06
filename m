From: akpm@linux-foundation.org
Subject: [patch 18/30] pata_legacy: Fix missing methods and add cable types
Date: Tue, 06 Mar 2007 02:38:04 -0800
Message-ID: <200703061038.l26Ac4At019515@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:34474 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934050AbXCFKi1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 05:38:27 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Several method sets lacked freeze/resume methods. Fix this and while we
are at it force the cable to 40wire

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_legacy.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff -puN drivers/ata/pata_legacy.c~pata_legacy-fix-missing-methods-and-add-cable-types drivers/ata/pata_legacy.c
--- a/drivers/ata/pata_legacy.c~pata_legacy-fix-missing-methods-and-add-cable-types
+++ a/drivers/ata/pata_legacy.c
@@ -162,6 +162,7 @@ static struct ata_port_operations simple
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
@@ -185,6 +186,7 @@ static struct ata_port_operations legacy
 	.check_status 	= ata_check_status,
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
+	.cable_detect	= ata_cable_40wire,
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
@@ -305,6 +307,7 @@ static struct ata_port_operations pdc202
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
@@ -360,6 +363,7 @@ static struct ata_port_operations ht6560
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
@@ -426,6 +430,7 @@ static struct ata_port_operations ht6560
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
@@ -547,6 +552,7 @@ static struct ata_port_operations opti82
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
@@ -680,6 +686,7 @@ static struct ata_port_operations opti82
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= opti82c46x_qc_issue_prot,
_
