From: Kel Modderman <kel@otaku42.de>
Subject: [PATCH 5/5] storage-fixup: a Makefile
Date: Wed, 29 Oct 2008 09:11:51 +1000
Message-ID: <200810290911.51961.kel@otaku42.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from venema.h4ckr.net ([217.24.1.135]:43264 "EHLO venema.h4ckr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083AbYJ1Xlp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Oct 2008 19:41:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by venema.h4ckr.net (Postfix) with ESMTP id 858693067CC
	for <linux-ide@vger.kernel.org>; Wed, 29 Oct 2008 00:12:45 +0100 (CET)
Received: from venema.h4ckr.net ([127.0.0.1])
	by localhost (venema.h4ckr.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cOcw85lRW6xl for <linux-ide@vger.kernel.org>;
	Wed, 29 Oct 2008 00:12:43 +0100 (CET)
Received: from [192.168.1.99] (anikodeak.plus.com [80.229.152.168])
	by venema.h4ckr.net (Postfix) with ESMTP id A05AF3067CD
	for <linux-ide@vger.kernel.org>; Wed, 29 Oct 2008 00:12:39 +0100 (CET)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Add a Makefile for convenience of installation and preparing dist. tarball.

This could be handy for distributions/admins who want to deploy this workaround
in a package.

Signed-off-by: Kel Modderman <kel@otaku42.de>
---
--- /dev/null
+++ b/Makefile
@@ -0,0 +1,33 @@
+#!/usr/bin/make -f
+
+NAME    := storage-fixup
+FILES   := $(NAME) $(NAME).conf $(NAME).8 LICENSE Makefile
+VERSION := $(shell /bin/bash ./$(NAME) -V)
+BINDIR  := /usr/sbin
+ETCDIR  := /etc
+MANDIR  := /usr/share/man/man8
+MKDIR   := mkdir -p
+INSTALL := install
+
+all:
+	$(info Nothing to be done, ready for "$(MAKE) install" ...)
+
+%.gz: %
+	gzip -9 < $< > $@
+
+install: $(NAME).8.gz
+	$(MKDIR) $(DESTDIR)$(BINDIR)
+	$(INSTALL) -t $(DESTDIR)$(BINDIR) -m 755 $(NAME)
+	$(MKDIR) $(DESTDIR)$(ETCDIR)
+	$(INSTALL) -t $(DESTDIR)$(ETCDIR) -m 644 $(NAME).conf
+	$(MKDIR) $(DESTDIR)$(MANDIR)
+	$(INSTALL) -t $(DESTDIR)$(MANDIR) -m 644 $(NAME).8.gz
+
+clean:
+	$(RM) $(NAME).8.gz
+
+dist: clean
+	git-archive --format=tar --prefix=$(NAME)-$(VERSION)/ HEAD \
+		$(FILES) | tar -C.. -xf -
+	tar -czvf ../$(NAME)-$(VERSION).tar.gz -C.. $(NAME)-$(VERSION)/
+	$(RM) -r ../$(NAME)-$(VERSION)/
---
