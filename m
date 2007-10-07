From: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: [PATCH] IDE:  Remove inclusion of non-existent io_trace.h.
Date: Sun, 7 Oct 2007 07:51:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710070748180.1286@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nic.NetDirect.CA ([216.16.235.2]:54118 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbXJGLyZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Oct 2007 07:54:25 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bzolnier@gmail.com, gadio@netvision.net.il


Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  the fact that this header file doesn't exist has apparently been
known for quite some time:

http://osdir.com/ml/linux.tape/2005-07/msg00001.html

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 1fa5794..e5a86a9 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -621,7 +621,6 @@ typedef struct os_dat_s {
  */
 #define USE_IOTRACE	0
 #if USE_IOTRACE
-#include <linux/io_trace.h>
 #define IO_IDETAPE_FIFO	500
 #endif

-- 
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://crashcourse.ca
========================================================================
