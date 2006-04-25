From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] Actually honor drive's minimum PIO/DMA cycle times
Date: Wed, 26 Apr 2006 02:40:08 +0400
Message-ID: <444EA548.9080106@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030003070302000803070809"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:54970 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S932211AbWDYWlU
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Apr 2006 18:41:20 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------030003070302000803070809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

    The function ide_timing_compute() fails to *actually* take drive's
specified minimum PIO/DMA cycle times into account -- when doing this, it
calls ide_timing_merge() on the 'struct ide_timing' argument which contains
garbage at the moment, and then ultimately destroys the read cycle time by
quantizing the ide_timing[] entry, instead of copying from that entry to the
argument structure, and only then doing a merge/quantize.

MBR, Sergei


--------------030003070302000803070809
Content-Type: text/plain;
 name="IDE-actually-honor-min-cycle-time.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="IDE-actually-honor-min-cycle-time.patch"

diff --git a/drivers/ide/ide-timing.h b/drivers/ide/ide-timing.h
index 2fcfac6..c0864b1 100644
--- a/drivers/ide/ide-timing.h
+++ b/drivers/ide/ide-timing.h
@@ -220,6 +220,12 @@ static int ide_timing_compute(ide_drive_
 		return -EINVAL;
 
 /*
+ * Copy the timing from the table.
+ */
+
+	*t = *s;
+
+/*
  * If the drive is an EIDE drive, it can tell us it needs extended
  * PIO/MWDMA cycle timing.
  */
@@ -247,7 +253,7 @@ static int ide_timing_compute(ide_drive_
  * Convert the timing to bus clock counts.
  */
 
-	ide_timing_quantize(s, t, T, UT);
+	ide_timing_quantize(t, t, T, UT);
 
 /*
  * Even in DMA/UDMA modes we still use PIO access for IDENTIFY, S.M.A.R.T


--------------030003070302000803070809--
