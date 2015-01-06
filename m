From: Tejun Heo <tj@kernel.org>
Subject: [PATCH libata/for-3.19-fixes] ata: add MAINTAINERS entry for libata
 PATA drivers
Date: Tue, 6 Jan 2015 18:44:57 -0500
Message-ID: <20150106234457.GF24106@htj.dyndns.org>
References: <27267694.oe0s2nj2E5@amdc1032>
 <1417541347.3203.77.camel@acox1-desk.ger.corp.intel.com>
 <2792593.liaEN2q9W3@amdc1032>
 <2294122.mDExhRe5Kf@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:45953 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845AbbAFXpA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Jan 2015 18:45:00 -0500
Received: by mail-qc0-f173.google.com with SMTP id i17so224757qcy.4
        for <linux-ide@vger.kernel.org>; Tue, 06 Jan 2015 15:45:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2294122.mDExhRe5Kf@amdc1032>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org

>From c7fa056c820fef26de34d346b148943e717958a0 Mon Sep 17 00:00:00 2001
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 2 Dec 2014 17:29:08 +0100

Add myself as the primary maintainer for libata PATA drivers.

The merging process would remain unchanged with patches going
through Tejun's tree.

Cc: Alan Cox <alan@linux.intel.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
Hello,

Sorry about the delay.  I forgot about this one.  Applied the
following to libata/for-3.19-fixes.

Thanks.

 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c20aebe..5d7b387 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5703,6 +5703,15 @@ S:	Maintained
 F:	include/linux/pata_arasan_cf_data.h
 F:	drivers/ata/pata_arasan_cf.c
 
+LIBATA PATA DRIVERS
+M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
+M:	Tejun Heo <tj@kernel.org>
+L:	linux-ide@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git
+S:	Maintained
+F:	drivers/ata/pata_*.c
+F:	drivers/ata/ata_generic.c
+
 LIBATA SATA AHCI PLATFORM devices support
 M:	Hans de Goede <hdegoede@redhat.com>
 M:	Tejun Heo <tj@kernel.org>
-- 
2.1.0

