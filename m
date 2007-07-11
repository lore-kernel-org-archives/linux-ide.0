From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/6] icside: fix ->speedproc to return on unsupported modes
Date: Wed, 11 Jul 2007 02:00:37 +0200
Message-ID: <200707110200.37607.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:5174 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747AbXGJXw1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 19:52:27 -0400
Received: by wr-out-0506.google.com with SMTP id i30so694381wra
        for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 16:52:25 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>


icside_set_speed() happily accepts unsupported transfer modes which
results in drive->drive_data being set to the maximum value (480)
and drive->current_speed being set to the unsupported transfer mode.

Fix it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Russell King <rmk@arm.linux.org.uk>
---
 drivers/ide/arm/icside.c |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -272,6 +272,8 @@ static int icside_set_speed(ide_drive_t 
 	case XFER_SW_DMA_0:
 		cycle_time = 480;
 		break;
+	default:
+		return 1;
 	}
 
 	/*
