From: "Adrian McMenamin" <lkmladrian@gmail.com>
Subject: [PATCH 3/3] Add GD-Rom support to the SEGA Dreamcast
Date: Sun, 16 Dec 2007 00:21:28 +0000
Message-ID: <8b67d60712151621m6dbd3e14sbcaf4b5c0de61097@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:20972 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756631AbXLPAV2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Dec 2007 19:21:28 -0500
Received: by py-out-1112.google.com with SMTP id u77so2318775pyb.16
        for <linux-ide@vger.kernel.org>; Sat, 15 Dec 2007 16:21:28 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, axboe@kernel.dk, linux-ide@vger.kernel.org, linux-sh@vger.kernel.org

diff -ruN ./linux-2.6-orig/drivers/sh/Makefile ./linux-2.6/drivers/sh/Makefile
--- ./linux-2.6-orig/drivers/sh/Makefile	2007-12-15 22:23:59.000000000 +0000
+++ ./linux-2.6/drivers/sh/Makefile	2007-12-15 22:18:45.000000000 +0000
@@ -4,3 +4,4 @@

 obj-$(CONFIG_SUPERHYWAY)	+= superhyway/
 obj-$(CONFIG_MAPLE)		+= maple/
+obj-$(CONFIG_GDROM)		+= gdrom/
