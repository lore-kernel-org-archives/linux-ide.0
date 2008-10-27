From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Switch to a common address
Date: Mon, 27 Oct 2008 15:12:41 +0000
Message-ID: <20081027151241.48cd2feb@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52870 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751479AbYJ0PMe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Oct 2008 11:12:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff --git a/drivers/ide/alim15x3.c b/drivers/ide/alim15x3.c
index daf9dce..e56c7b7 100644
--- a/drivers/ide/alim15x3.c
+++ b/drivers/ide/alim15x3.c
@@ -5,7 +5,7 @@
  *
  *  Copyright (C) 1998-2000 Andre Hedrick (andre@linux-ide.org)
  *  May be copied or modified under the terms of the GNU General Public License
- *  Copyright (C) 2002 Alan Cox <alan@redhat.com>
+ *  Copyright (C) 2002 Alan Cox
  *  ALi (now ULi M5228) support by Clear Zhang <Clear.Zhang@ali.com.tw>
  *  Copyright (C) 2007 MontaVista Software, Inc. <source@mvista.com>
  *  Copyright (C) 2007 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
diff --git a/drivers/ide/hpt366.c b/drivers/ide/hpt366.c
index a7909e9..f5afd46 100644
--- a/drivers/ide/hpt366.c
+++ b/drivers/ide/hpt366.c
@@ -52,7 +52,7 @@
  * different clocks on read/write. This requires overloading rw_disk and
  * other deeply crazy things. Thanks to <http://www.hoerstreich.de> for
  * keeping me sane. 
- *		Alan Cox <alan@redhat.com>
+ *		Alan Cox <alan@lxorguk.ukuu.org.uk>
  *
  * - fix the clock turnaround code: it was writing to the wrong ports when
  *   called for the secondary channel, caching the current clock mode per-
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index e5adebe..eb9fac4 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -2,7 +2,7 @@
  *  Copyright (C) 1994-1998	   Linus Torvalds & authors (see below)
  *  Copyright (C) 1998-2002	   Linux ATA Development
  *				      Andre Hedrick <andre@linux-ide.org>
- *  Copyright (C) 2003		   Red Hat <alan@redhat.com>
+ *  Copyright (C) 2003		   Red Hat
  *  Copyright (C) 2003-2005, 2007  Bartlomiej Zolnierkiewicz
  */
 
diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
index bb7a1ed..5d6ba14 100644
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -1,6 +1,6 @@
 /*
  *  Copyright (C) 2000-2002	Andre Hedrick <andre@linux-ide.org>
- *  Copyright (C) 2003		Red Hat <alan@redhat.com>
+ *  Copyright (C) 2003		Red Hat
  *
  */
 
diff --git a/drivers/ide/ide-pci-generic.c b/drivers/ide/ide-pci-generic.c
index 474f96a..bddae2b 100644
--- a/drivers/ide/ide-pci-generic.c
+++ b/drivers/ide/ide-pci-generic.c
@@ -1,6 +1,6 @@
 /*
  *  Copyright (C) 2001-2002	Andre Hedrick <andre@linux-ide.org>
- *  Portions (C) Copyright 2002  Red Hat Inc <alan@redhat.com>
+ *  Portions (C) Copyright 2002  Red Hat Inc
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
index c31d0dd..f3cddd1 100644
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -1,6 +1,6 @@
 /*
  *  Copyright (C) 1997-1998	Mark Lord
- *  Copyright (C) 2003		Red Hat <alan@redhat.com>
+ *  Copyright (C) 2003		Red Hat
  *
  *  Some code was moved here from ide.c, see it for original copyrights.
  */
diff --git a/drivers/ide/it821x.c b/drivers/ide/it821x.c
index 995e18b..ef00408 100644
--- a/drivers/ide/it821x.c
+++ b/drivers/ide/it821x.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2004		Red Hat <alan@redhat.com>
+ * Copyright (C) 2004		Red Hat
  * Copyright (C) 2007		Bartlomiej Zolnierkiewicz
  *
  *  May be copied or modified under the terms of the GNU General Public License
diff --git a/drivers/ide/jmicron.c b/drivers/ide/jmicron.c
index 9a68433..bf2be64 100644
--- a/drivers/ide/jmicron.c
+++ b/drivers/ide/jmicron.c
@@ -1,6 +1,6 @@
 
 /*
- * Copyright (C) 2006		Red Hat <alan@redhat.com>
+ * Copyright (C) 2006		Red Hat
  *
  *  May be copied or modified under the terms of the GNU General Public License
  */
diff --git a/drivers/ide/piix.c b/drivers/ide/piix.c
index d63f9fd..61d2d92 100644
--- a/drivers/ide/piix.c
+++ b/drivers/ide/piix.c
@@ -1,7 +1,7 @@
 /*
  *  Copyright (C) 1998-1999 Andrzej Krzysztofowicz, Author and Maintainer
  *  Copyright (C) 1998-2000 Andre Hedrick <andre@linux-ide.org>
- *  Copyright (C) 2003 Red Hat Inc <alan@redhat.com>
+ *  Copyright (C) 2003 Red Hat
  *  Copyright (C) 2006-2007 MontaVista Software, Inc. <source@mvista.com>
  *
  *  May be copied or modified under the terms of the GNU General Public License
diff --git a/drivers/ide/scc_pata.c b/drivers/ide/scc_pata.c
index f26aa5d..0f48f9d 100644
--- a/drivers/ide/scc_pata.c
+++ b/drivers/ide/scc_pata.c
@@ -5,7 +5,7 @@
  *
  * This code is based on drivers/ide/pci/siimage.c:
  * Copyright (C) 2001-2002	Andre Hedrick <andre@linux-ide.org>
- * Copyright (C) 2003		Red Hat <alan@redhat.com>
+ * Copyright (C) 2003		Red Hat
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
diff --git a/drivers/ide/siimage.c b/drivers/ide/siimage.c
index c3107df..7d622d2 100644
--- a/drivers/ide/siimage.c
+++ b/drivers/ide/siimage.c
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2001-2002	Andre Hedrick <andre@linux-ide.org>
- * Copyright (C) 2003		Red Hat <alan@redhat.com>
+ * Copyright (C) 2003		Red Hat
  * Copyright (C) 2007-2008	MontaVista Software, Inc.
  * Copyright (C) 2007-2008	Bartlomiej Zolnierkiewicz
  *
