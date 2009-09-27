From: "Michael Gavlick" <mgavl69@juno.com>
Subject: [PATCH] ide-iops: fix for drive side 80-wire cable detection failure f
	or IBM-DJNA-371350 HD
Date: Sun, 27 Sep 2009 23:34:19 GMT
Message-ID: <20090927.193419.17010.1@webmail21.vgs.untd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-mail.vgs.untd.com ([64.136.55.15]:9082 "HELO
	outbound-mail.vgs.untd.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750912AbZI0XmC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Sep 2009 19:42:02 -0400
Received: from outbound-bu1.vgs.untd.com (webmail21.vgs.untd.com [10.181.12.161])
	by smtpout01.vgs.untd.com with SMTP id AABFM97XYAUMK8JA
	for <linux-ide@vger.kernel.org> (sender <mgavl69@juno.com>);
	Sun, 27 Sep 2009 16:35:18 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: davem@davemloft.net

  The IDE driver complains about an 80-wire cable detection failure and falls back to UDMA/33 for the old IBM-DJNA-371350 Rev. J7NOA30K HD even though it is an UDMA/66 HD.

Kernel Message:
"hdb: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hdb: drive side 80-wire cable detection failed, limiting max speed to UDMA33
hdb: UDMA/33 mode selected"

  This patch disables the word 93 validity check in /drivers/ide/ide-iops.c for this particular hardware by adding it to the buggy firmware ivb_list. 

diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
index 6cc6c83..6d6f78f 100644
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -218,6 +218,7 @@ static const struct drive_list_entry ivb_list[] = {
 	{ "TSSTcorp CDDVDW SH-S202H"	, "SB00"	},
 	{ "TSSTcorp CDDVDW SH-S202H"	, "SB01"	},
 	{ "SAMSUNG SP0822N"		, "WA100-10"	},
+        { "IBM-DJNA-371350"             , "J7NOA30K"    },
 	{ NULL				, NULL		}
 };




____________________________________________________________
Best Weight Loss Program - Click Here!
http://thirdpartyoffers.juno.com/TGL2131/fc/BLSrjnsEGrFwnIvIOVxbEtcxl1mbToJZIUdYtrSAhgUZhuqeEORJOOJ5xRW/
