From: Matti Linnanvuori <mattilinnanvuori@yahoo.com>
Subject: [PATCH] ide: add IDEDISK_MULTI_MODE text adapted from hdparm manual page
Date: Fri, 26 Oct 2007 09:58:04 -0700 (PDT)
Message-ID: <474753.23820.qm@web52006.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web52006.mail.re2.yahoo.com ([206.190.49.253]:42741 "HELO
	web52006.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753771AbXJZQ6G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Oct 2007 12:58:06 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

=46rom: Matti Linnanvuori <mattilinnanvuori@yahoo.com>

Add IDEDISK_MULTI_MODE text adapted from hdparm manual page.

Signed-off-by: Matti Linnanvuori <mattilinnanvuori@yahoo.com>
---

--- a/drivers/ide/Kconfig	2007-10-26 19:21:15.017817500 +0300
+++ b/drivers/ide/Kconfig	2007-10-26 19:42:56.759696000 +0300
@@ -152,9 +152,22 @@ config BLK_DEV_IDEDISK
 	  If unsure, say Y.
=20
 config IDEDISK_MULTI_MODE
-	bool "Use multi-mode by default"
+	bool "Use multiple sector mode for Programmed Input/Output by default=
"
 	help
-	  If you get this error, try to say Y here:
+	  This setting is irrelevant for most IDE disks, with direct memory
+	  access, to which multiple sector mode does not apply. Multiple sect=
or
+	  mode is a feature of most modern IDE hard drives, permitting the
+	  transfer of multiple sectors per Programmed Input/Output interrupt,
+	  rather than the usual one sector per interrupt. When this feature i=
s
+	  enabled, it can reduce operating system overhead for disk Programme=
d
+	  Input/Output. On some systems, it also can increase the data
+	  throughput of Programmed Input/Output. Some drives, however, seemed
+	  to run slower with multiple sector mode enabled. Some drives claime=
d
+	  to support multiple sector mode, but lost data at some settings.
+	  Under rare circumstances, such failures could result in massive
+	  filesystem corruption.
+
+	  If you get the following error, try to say Y here:
=20
 	  hda: set_multmode: status=3D0x51 { DriveReady SeekComplete Error }
 	  hda: set_multmode: error=3D0x04 { DriveStatusError }




      Heute schon einen Blick in die Zukunft von E-Mails wagen? Versuch=
en Sie=B4s mit dem neuen Yahoo! Mail. www.yahoo.de/mail
