From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] it821x: remove dead URL
Date: Wed, 18 Feb 2009 20:18:03 +0100
Message-ID: <200902182018.04495.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:19199 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665AbZBRTVb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Feb 2009 14:21:31 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] it821x: remove dead URL

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/it821x.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: b/drivers/ide/it821x.c
===================================================================
--- a/drivers/ide/it821x.c
+++ b/drivers/ide/it821x.c
@@ -5,9 +5,8 @@
  *  May be copied or modified under the terms of the GNU General Public License
  *  Based in part on the ITE vendor provided SCSI driver.
  *
- *  Documentation available from
- * 	http://www.ite.com.tw/pc/IT8212F_V04.pdf
- *  Some other documents are NDA.
+ *  Documentation:
+ *	Datasheet is freely available, some other documents under NDA.
  *
  *  The ITE8212 isn't exactly a standard IDE controller. It has two
  *  modes. In pass through mode then it is an IDE controller. In its smart
