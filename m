From: Kel Modderman <kel@otaku42.de>
Subject: [PATCH 2/5] storage-fixup: fix typo of configuration filename
Date: Wed, 29 Oct 2008 09:09:29 +1000
Message-ID: <200810290909.29583.kel@otaku42.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from venema.h4ckr.net ([217.24.1.135]:43266 "EHLO venema.h4ckr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209AbYJ1Xlp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Oct 2008 19:41:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by venema.h4ckr.net (Postfix) with ESMTP id C2B333067C4
	for <linux-ide@vger.kernel.org>; Wed, 29 Oct 2008 00:12:42 +0100 (CET)
Received: from venema.h4ckr.net ([127.0.0.1])
	by localhost (venema.h4ckr.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IcZVzonqsSEZ for <linux-ide@vger.kernel.org>;
	Wed, 29 Oct 2008 00:12:40 +0100 (CET)
Received: from [192.168.1.99] (anikodeak.plus.com [80.229.152.168])
	by venema.h4ckr.net (Postfix) with ESMTP id B5D483067C9
	for <linux-ide@vger.kernel.org>; Wed, 29 Oct 2008 00:12:38 +0100 (CET)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Fix spelling of storage-fixup.conf in storage-fixup script header.

Signed-off-by: Kel Modderman <kel@otaku42.de>
---
--- a/storage-fixup
+++ b/storage-fixup
@@ -6,10 +6,10 @@
 # to adjust ATA APM setting.  Some laptop BIOSen set this value too
 # aggressively causing frequent head unloads which can kill the drive
 # quickly.  This script should be called during boot and resume.  It
-# examines rules from /etc/stroage-fixup.conf and executes matching
+# examines rules from /etc/storage-fixup.conf and executes matching
 # commands.
 #
-# In stroage-fixup.conf, empty lines and lines starting w/ # are
+# In storage-fixup.conf, empty lines and lines starting w/ # are
 # ignored.  Each line starts with rule, dmi, ata or act.
 #
 # rule RULENAME
---
