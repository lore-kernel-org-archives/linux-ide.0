From: Adrian Bunk <bunk@stusta.de>
Subject: [-mm patch] drivers/ide/pci/tc86c001.c: make a function static
Date: Sat, 16 Dec 2006 14:56:50 +0100
Message-ID: <20061216135650.GA3388@stusta.de>
References: <20061214225913.3338f677.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3326 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753711AbWLPN4v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Dec 2006 08:56:51 -0500
Content-Disposition: inline
In-Reply-To: <20061214225913.3338f677.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org

On Thu, Dec 14, 2006 at 10:59:13PM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-mm1:
>...
> +toshiba-tc86c001-ide-driver-take-2.patch
>...
>  Misc.
>...

This patch makes the needlessly global init_hwif_tc86c001() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

BTW:
I'm not sure whether it'd be a good idea to include such a driver for 
the legacy IDE subsystem without a libata based driver for the same 
hardware.

--- linux-2.6.20-rc1-mm1/drivers/ide/pci/tc86c001.c.old	2006-12-15 21:58:44.000000000 +0100
+++ linux-2.6.20-rc1-mm1/drivers/ide/pci/tc86c001.c	2006-12-15 21:58:54.000000000 +0100
@@ -204,7 +204,7 @@
 	return 0;
 }
 
-void __devinit init_hwif_tc86c001(ide_hwif_t *hwif)
+static void __devinit init_hwif_tc86c001(ide_hwif_t *hwif)
 {
 	unsigned long sc_base	= pci_resource_start(hwif->pci_dev, 5);
 	u16 scr1		= hwif->INW(sc_base + 0x00);;

