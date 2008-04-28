From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: add TSSTcorp CDDVDW SH-S202H to ivb_list[]
Date: Mon, 28 Apr 2008 23:42:08 +0200
Message-ID: <200804282342.08448.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:24001 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965774AbYD1V1t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Apr 2008 17:27:49 -0400
Received: by fg-out-1718.google.com with SMTP id l27so5100204fgb.17
        for <linux-ide@vger.kernel.org>; Mon, 28 Apr 2008 14:27:45 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alexander Smal <avsmal@gmail.com>

From: Alexander Smal <avsmal@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -625,6 +625,8 @@ static const struct drive_list_entry ivb
 	{ "TSSTcorp CDDVDW SH-S202J"	, "SB01"	},
 	{ "TSSTcorp CDDVDW SH-S202N"	, "SB00"	},
 	{ "TSSTcorp CDDVDW SH-S202N"	, "SB01"	},
+	{ "TSSTcorp CDDVDW SH-S202H"	, "SB00"	},
+	{ "TSSTcorp CDDVDW SH-S202H"	, "SB01"	},
 	{ NULL				, NULL		}
 };
 
