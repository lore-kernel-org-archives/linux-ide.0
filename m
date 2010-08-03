From: Dan Carpenter <error27@gmail.com>
Subject: [patch] pata_winbond: fix module init
Date: Tue, 3 Aug 2010 17:27:47 +0200
Message-ID: <20100803152549.GQ26313@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, alan@lxorguk.ukuu.org.uk
List-Id: linux-ide@vger.kernel.org

winbond_init_one() returns 0 on success and an error code on failure.
In the original code, we always just released the regions and return
-ENODEV.  This was introduce in 2006 by 7e45b0e5f6f6 "[PATCH] libata:
Winbond support".

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
Compile tested.

diff --git a/drivers/ata/pata_winbond.c b/drivers/ata/pata_winbond.c
index 6d8619b..b34b594 100644
--- a/drivers/ata/pata_winbond.c
+++ b/drivers/ata/pata_winbond.c
@@ -248,9 +248,10 @@ static __init int winbond_init(void)
 
 			if (request_region(port, 2, "pata_winbond")) {
 				ret = winbond_init_one(port);
-				if (ret <= 0)
+				if (ret < 0)
 					release_region(port, 2);
-				else ct+= ret;
+				else
+					ct++;
 			}
 		}
 	}
