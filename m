From: Adrian Bunk <bunk@stusta.de>
Subject: [RFC: 2.6 patch] schedule BLK_DEV_IDE_SATA for removal
Date: Fri, 22 Jun 2007 01:52:11 +0200
Message-ID: <20070621235211.GH23017@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:35914 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755133AbXFUXvw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Jun 2007 19:51:52 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Users should use the libata based drivers for SATA drives.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---
--- linux-2.6.22-rc4-mm2/Documentation/feature-removal-schedule.txt.old	2007-06-21 23:41:03.000000000 +0200
+++ linux-2.6.22-rc4-mm2/Documentation/feature-removal-schedule.txt	2007-06-21 23:42:03.000000000 +0200
@@ -347,3 +347,10 @@
 Who:	Jean Delvare <khali@linux-fr.org>
 
 ---------------------------
+
+What:  CONFIG_BLK_DEV_IDE_SATA
+When:  December 2007
+Why:   users should use the libata based drivers for SATA
+Who:   Adrian Bunk <bunk@stusta.de>
+
+---------------------------

