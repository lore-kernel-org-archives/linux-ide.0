From: "Alfred E. Heggestad" <linuxedmund@home.no>
Subject: [PATCH] hdreg.h documentation fix
Date: 05 Mar 2003 12:19:30 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1046863170.17509.3.camel@tellus>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org
To: linux ide <linux-ide@vger.kernel.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>

--- linux-2.5.63_orig/include/linux/hdreg.h	2003-02-24 20:05:31.000000000 +0100
+++ linux-2.5.63/include/linux/hdreg.h	2003-03-05 00:26:59.000000000 +0100
@@ -466,8 +466,8 @@
 /*
  * Structure returned by HDIO_GET_IDENTITY, as per ANSI NCITS ATA6 rev.1b spec.
  *
- * If you change something here, please remember to update fix_driveid() in
- * ide/probe.c.
+ * If you change something here, please remember to update ide_fix_driveid() in
+ * ide/ide-iops.c.
  */
 struct hd_driveid {
 	unsigned short	config;		/* lots of obsolete bit flags */


