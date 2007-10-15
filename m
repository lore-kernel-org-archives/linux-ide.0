From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] dtc2278: note on docs
Date: Mon, 15 Oct 2007 20:47:44 +0100
Message-ID: <20071015204744.3e973b08@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42792 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755998AbXJOTnn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Oct 2007 15:43:43 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23-mm1/drivers/ide/legacy/dtc2278.c linux-2.6.23-mm1/drivers/ide/legacy/dtc2278.c
--- linux.vanilla-2.6.23-mm1/drivers/ide/legacy/dtc2278.c	2007-10-15 15:03:27.000000000 +0100
+++ linux-2.6.23-mm1/drivers/ide/legacy/dtc2278.c	2007-10-15 15:18:56.000000000 +0100
@@ -83,6 +83,8 @@
 		spin_unlock_irqrestore(&dtc2278_lock, flags);
 	} else {
 		/* we don't know how to set it back again.. */
+		/* Actually we do - there is a data sheet available for the
+		   Winbond but does anyone actually care */
 	}
 
 	/*
