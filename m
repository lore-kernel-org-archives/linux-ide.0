From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ata: add MAINTAINERS entry for libata PATA drivers
Date: Tue, 02 Dec 2014 17:29:08 +0100
Message-ID: <27267694.oe0s2nj2E5@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:43891 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbaLBQ3n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Dec 2014 11:29:43 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NFY0052MR5IIQB0@mailout3.samsung.com> for
 linux-ide@vger.kernel.org; Wed, 03 Dec 2014 01:29:42 +0900 (KST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@linux.intel.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-ide@vger.kernel.org

Add myself as the primary maintainer for libata PATA drivers.

The merging process would remain unchanged with patches going
through Tejun's tree.

Cc: Alan Cox <alan@linux.intel.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
If people are fine with it I would like to more officially take
care of the libata PATA drivers.

 MAINTAINERS |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: b/MAINTAINERS
===================================================================
--- a/MAINTAINERS	2014-12-02 16:48:28.932973963 +0100
+++ b/MAINTAINERS	2014-12-02 16:58:35.532969351 +0100
@@ -7116,6 +7116,14 @@ F:	drivers/video/fbdev/sti*
 F:	drivers/video/console/sti*
 F:	drivers/video/logo/logo_parisc*
 
+PATA LIBATA DRIVERS
+M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
+M:	Tejun Heo <tj@kernel.org>
+L:	linux-ide@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git
+S:	Supported
+F:	drivers/ata/pata_*.c
+
 PC87360 HARDWARE MONITORING DRIVER
 M:	Jim Cromie <jim.cromie@gmail.com>
 L:	lm-sensors@lm-sensors.org

