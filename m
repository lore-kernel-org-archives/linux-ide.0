From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH] ide: disable dma for transcend CF
Date: Tue, 20 Jun 2006 14:52:36 +0400
Message-ID: <200606201452.37905.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.mnsspb.ru ([84.204.75.2]:47234 "EHLO mail.mnsspb.ru")
	by vger.kernel.org with ESMTP id S932561AbWFTKww (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Jun 2006 06:52:52 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

NB: bart/ide-2.6.git seems to be unmaintained,  so I'm sending this directly to -mm

I have a CF card which identifies itself as model=TRANSCEND rev=200508011
The card id labeled as TS512MCF80

hdparm -i /dev/hdci  reports:
...
DMA modes:  mdma0 mdma1 *mdma2

IDE controller:
IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)


but if dma is turned on i get a lot of errors::

    hdc: dma_timer_epiry: dma_status == 0x21
    hdc: DMA timeout error
    hdc: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
    ide: failed opcode was: unknown
    ...


So blacklist this CF model.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>

Index: linux-2.6.17/drivers/ide/ide-dma.c
===================================================================
--- linux-2.6.17.orig/drivers/ide/ide-dma.c	2006-06-18 05:49:35.000000000 +0400
+++ linux-2.6.17/drivers/ide/ide-dma.c	2006-06-20 11:37:30.000000000 +0400
@@ -129,6 +129,7 @@
 	{ "SanDisk SDP3B-64"	,	"ALL"		},
 	{ "ATAPI CD-ROM DRIVE 40X MAXIMUM",	"ALL"		},
 	{ "_NEC DV5800A",               "ALL"           },  
+	{ "TRANSCEND"		,	"20050811"	},
 	{ NULL			,	NULL		}
 
 };



