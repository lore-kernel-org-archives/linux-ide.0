From: Vladimir LAVALLADE <erus.iluvatar@gmail.com>
Subject: [PATCH] libata: add DVRTD08A and DVR-215 to NOSETXFER devices
Date: Sun, 8 Jan 2012 13:50:13 +0100
Message-ID: <CAFiHmUUfFD+CM-xGOwYVLxxiyFg7g+UPL1mr=sNEVngQsP7r7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:37974 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388Ab2AHMuO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Jan 2012 07:50:14 -0500
Received: by werm1 with SMTP id m1so2052402wer.19
        for <linux-ide@vger.kernel.org>; Sun, 08 Jan 2012 04:50:13 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Patch adding DVRT08A and DVR-215 to the horkage list for NOSETXFER.

---

Since commit 4a5610a04d415ed94af75bb1159d2621d62c8328 (adding DVR-212D to
devices not handling SETXFER correctly), DVR-216D has been added, and this
fix have been applied to all revision of failing drives.

I'm experiencing the same issue with my DVRTD08A, and DVR-215 was reported too
at https://bugs.archlinux.org/task/21606


--- linux/drivers/ata/libata-core.c.orig	2012-01-08 12:50:00.000000000 +0100
+++ linux/drivers/ata/libata-core.c	2012-01-08 12:55:00.000000000 +0100
@@ -4125,6 +4125,8 @@ static const struct ata_blacklist_entry
 	 * device and controller are SATA.
 	 */
 	{ "PIONEER DVD-RW  DVRTD08",	NULL,	ATA_HORKAGE_NOSETXFER },
+	{ "PIONEER DVD-RW  DVRTD08A",	NULL,	ATA_HORKAGE_NOSETXFER },
+	{ "PIONEER DVD-RW  DVR-215",	NULL,	ATA_HORKAGE_NOSETXFER },
 	{ "PIONEER DVD-RW  DVR-212D",	NULL,	ATA_HORKAGE_NOSETXFER },
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
