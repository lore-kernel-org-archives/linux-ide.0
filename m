From: "Albert Lee" <albertlee@tikira.net>
Subject: [PATCH] ide-timing.h: make the timing from the IDE device work
Date: Thu, 19 Aug 2004 15:48:57 +0800
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <004001c485c0$fe5031a0$6401a8c0@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:15096 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S263117AbUHSHt5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Aug 2004 03:49:57 -0400
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: vojtech@ucw.cz, linux-ide@vger.kernel.org

ide-timing.h patch: make the timing from the IDE device work.

Albert Lee

--- linux-2.6.6\drivers\ide\ide-timing.h.ori 2004-05-10 10:32:28.000000000
+0800
+++ linux-2.6.6\drivers\ide\ide-timing.h 2004-08-19 13:01:17.117860800 +0800
@@ -220,6 +220,7 @@
  if (!(s = ide_timing_find_mode(speed)))
   return -EINVAL;

+ memcpy(t, s, sizeof(*t));
 /*
  * If the drive is an EIDE drive, it can tell us it needs extended
  * PIO/MWDMA cycle timing.
@@ -248,7 +249,7 @@
  * Convert the timing to bus clock counts.
  */

- ide_timing_quantize(s, t, T, UT);
+ ide_timing_quantize(t, t, T, UT);

 /*
  * Even in DMA/UDMA modes we still use PIO access for IDENTIFY, S.M.A.R.T

