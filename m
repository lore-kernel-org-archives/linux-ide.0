From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: [PATCH] pata_scc.c: add thaw ops
Date: Wed, 13 Feb 2008 11:55:07 +0900
Message-ID: <200802130254.m1D2s9bG023092@toshiba.co.jp>
Mime-Version: 1.0
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imx9.toshiba.co.jp ([202.33.96.51]:35797 "EHLO
	imx9.toshiba.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759213AbYBMDYP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 22:24:15 -0500
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5 [202.33.96.24])
	by imx9.toshiba.co.jp  with ESMTP id m1D3O9QR015068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 12:24:09 +0900 (JST)
Received: from arc1.toshiba.co.jp ([133.199.194.235])
	by inet-tsb5.toshiba.co.jp  with ESMTP id m1D2sA59015714
	for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 11:54:10 +0900 (JST)
Received: (from root@localhost)
	by arc1.toshiba.co.jp  id m1D2sAS6012387
	for linux-ide@vger.kernel.org; Wed, 13 Feb 2008 11:54:10 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp2.toshiba.co.jp  with ESMTP id m1D2s9S6012769
	for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 11:54:09 +0900 (JST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: kou.ishizaki@toshiba.co.jp, linux-ide@vger.kernel.org

This patch adds default thaw ops and fixes the freeze/thaw inconsistency.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

diff -pu linux-2.6.25-rc1/drivers/ata/pata_scc.c linux-2.6.25-rc1_mod/drivers/ata/pata_scc.c
--- linux-2.6.25-rc1/drivers/ata/pata_scc.c	2008-02-11 07:18:14.000000000 +0900
+++ linux-2.6.25-rc1_mod/drivers/ata/pata_scc.c	2008-02-13 11:37:34.000000000 +0900
@@ -1007,6 +1007,8 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 
 	.freeze			= scc_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+
 	.error_handler		= scc_error_handler,
 	.post_internal_cmd	= scc_bmdma_stop,
 


