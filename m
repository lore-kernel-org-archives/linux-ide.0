From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: add SAMSUNG SP0822N with firmware WA100-10 to ivb_list[]
Date: Fri, 21 Nov 2008 22:40:33 +0100
Message-ID: <200811212240.34153.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:58041 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753925AbYKUVoT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Nov 2008 16:44:19 -0500
Received: by ey-out-2122.google.com with SMTP id 6so478095eyi.37
        for <linux-ide@vger.kernel.org>; Fri, 21 Nov 2008 13:44:19 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Matthias B." <haferfrost@web.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Should fix kernel.org bug #10225:
http://bugzilla.kernel.org/show_bug.cgi?id=10225

Reported-by: Matthias B. <haferfrost@web.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -610,6 +610,7 @@ static const struct drive_list_entry ivb
 	{ "TSSTcorp CDDVDW SH-S202N"	, "SB01"	},
 	{ "TSSTcorp CDDVDW SH-S202H"	, "SB00"	},
 	{ "TSSTcorp CDDVDW SH-S202H"	, "SB01"	},
+	{ "SAMSUNG SP0822N"		, "WA100-10"	},
 	{ NULL				, NULL		}
 };
 
