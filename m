From: "Tobias Oed" <tobiasoed@hotmail.com>
Subject: [patch] Kill useless fcn call
Date: Tue, 18 Apr 2006 09:06:32 -0400
Message-ID: <BAY105-F2814461145B361479E76BDA3C40@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bay105-f28.bay105.hotmail.com ([65.54.224.38]:22137 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1750842AbWDRNGg
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Apr 2006 09:06:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: tobiasoed@hotmail.com, andre@linux-ide.org

Hello,
this patch against 2.6.17-mm3 for pdc202xx_old.c removes a call
to hwif->tuneproc() on the error path of config_chipset_for_dma(),
as its single caller (pdc202xx_config_drive_xfer_rate()) will do the call
in that case.
Tobias

Signed-off-by: Tobias Oed <tobiasoed@hotmail.com>

--- pdc202xx_old.c.orig 2006-04-18 13:10:54.000000000 +0200
+++ pdc202xx_old.c    2006-04-18 13:12:47.000000000 +0200
@@ -370,7 +370,6 @@
        if (!(speed)) {
                /* restore original pci-config space */
                pci_write_config_dword(dev, drive_pci, drive_conf);
-               hwif->tuneproc(drive, 5);
                return 0;
        }

_________________________________________________________________
On the road to retirement? Check out MSN Life Events for advice on how to 
get there! http://lifeevents.msn.com/category.aspx?cid=Retirement

