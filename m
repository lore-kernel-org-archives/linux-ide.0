From: "Rakib Mullick" <rakib.mullick@gmail.com>
Subject: [PATCH] Proper initialization of rc in drivers/ide/ide-probe.c
Date: Fri, 25 Jul 2008 23:54:17 +0600
Message-ID: <b9df5fa10807251054i5bd1d309g93a23ba405fc15b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:63277 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbYGYRyT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jul 2008 13:54:19 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1296927nfc.21
        for <linux-ide@vger.kernel.org>; Fri, 25 Jul 2008 10:54:18 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Hello to all , In existing code, rc might remain uninitialized. This
patch initializes rc properly.

Signed-off-by: Md.Rakib Hassan Mullick ( rakib.mullick@gmail.com)

--- drivers/ide/ide-probe.c.orig	2008-07-25 23:33:22.000000000 +0600
+++ drivers/ide/ide-probe.c	2008-07-25 23:35:00.000000000 +0600
@@ -1437,7 +1437,7 @@ static struct device_attribute *ide_port

 static int ide_sysfs_register_port(ide_hwif_t *hwif)
 {
-	int i, rc;
+	int i, rc = 0;

 	for (i = 0; ide_port_attrs[i]; i++) {
 		rc = device_create_file(hwif->portdev, ide_port_attrs[i]);
