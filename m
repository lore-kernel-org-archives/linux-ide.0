From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 5/5] pata_hpt366: remove irrelevant TODO
Date: Mon, 7 Dec 2009 23:39:38 +0400
Message-ID: <200912072239.38921.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:3827 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S932191AbZLGTiT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Dec 2009 14:38:19 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

HPT36x chips just don't have DPLL.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 drivers/ata/pata_hpt366.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

Index: linux-2.6/drivers/ata/pata_hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt366.c
+++ linux-2.6/drivers/ata/pata_hpt366.c
@@ -11,9 +11,7 @@
  *
  *
  * TODO
- *	Maybe PLL mode
- *	Look into engine reset on timeout errors. Should not be
- *		required.
+ *	Look into engine reset on timeout errors. Should not be required.
  */
 
 

