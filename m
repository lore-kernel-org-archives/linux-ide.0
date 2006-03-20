From: Martin Michlmayr <tbm@cyrius.com>
Subject: [PATCH 7/12] [IDE] Set CFLAGS only for au1xxx-ide
Date: Mon, 20 Mar 2006 04:40:17 +0000
Message-ID: <20060320044017.GG20416@deprecation.cyrius.com>
References: <20060320043802.GA20389@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:55311 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1751497AbWCTEks
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Mar 2006 23:40:48 -0500
Content-Disposition: inline
In-Reply-To: <20060320043802.GA20389@deprecation.cyrius.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-ide@vger.kernel.org

Set CFLAGS only for au1xxx-ide since swarm does not reference any
include files from drivers/ide.  This brings drivers/ide/mips/Makefile
in sync with the linux-mips tree.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- linux-2.6/drivers/ide/mips/Makefile	2006-03-05 19:35:03.000000000 +0000
+++ mips.git/drivers/ide/mips/Makefile	2006-03-05 18:51:15.000000000 +0000
@@ -1,4 +1,4 @@
 obj-$(CONFIG_BLK_DEV_IDE_SWARM)		+= swarm.o
 obj-$(CONFIG_BLK_DEV_IDE_AU1XXX)	+= au1xxx-ide.o
 
-EXTRA_CFLAGS    := -Idrivers/ide
+CFLAGS_au1xxx-ide.o := -Idrivers/ide

-- 
Martin Michlmayr
http://www.cyrius.com/
