From: Shane Huang <shane.huang@amd.com>
Subject: [PATCH] Add SATA GEN3 related messages
Date: Tue, 18 Nov 2008 17:33:38 +0800
Message-ID: <1227000818.5631.12.camel@chunhao-desktop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-dub.frontbridge.com ([213.199.154.16]:39034 "EHLO
	IE1EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863AbYKRJeK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Nov 2008 04:34:10 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, htejun@gmail.com, shane.huang@amd.com

The present AHCI driver seems to support SATA GEN 3 speed, but the related
messages should be modified.

Signed-off-by: Shane Huang <shane.huang@amd.com>

diff -ruN c/drivers/ata/ahci.c d/drivers/ata/ahci.c
--- c/drivers/ata/ahci.c	2008-11-07 11:23:24.000000000 +0800
+++ d/drivers/ata/ahci.c	2008-11-07 13:47:46.000000000 +0800
@@ -2446,6 +2446,8 @@
 		speed_s = "1.5";
 	else if (speed == 2)
 		speed_s = "3";
+	else if (speed == 3)
+		speed_s = "6";
 	else
 		speed_s = "?";
 
diff -ruN c/drivers/ata/libata-core.c d/drivers/ata/libata-core.c
--- c/drivers/ata/libata-core.c	2008-11-07 13:46:39.000000000 +0800
+++ d/drivers/ata/libata-core.c	2008-11-07 13:46:23.000000000 +0800
@@ -930,6 +930,7 @@
 	static const char * const spd_str[] = {
 		"1.5 Gbps",
 		"3.0 Gbps",
+		"6.0 Gbps",
 	};
 
 	if (spd == 0 || (spd - 1) >= ARRAY_SIZE(spd_str))


