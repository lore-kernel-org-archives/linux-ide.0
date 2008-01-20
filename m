From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: [PATCH 0/12] ide-floppy redux v2.5
Date: Sun, 20 Jan 2008 13:38:15 +0100
Message-ID: <20080120123815.GA20082@gollum.tnic>
References: <1200255505-31418-1-git-send-email-bbpetkov@yahoo.de> <200801142238.17282.bzolnier@gmail.com>
Reply-To: bbpetkov@yahoo.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp113.plus.mail.re1.yahoo.com ([69.147.102.76]:24034 "HELO
	smtp113.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752656AbYATMmK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Jan 2008 07:42:10 -0500
Content-Disposition: inline
In-Reply-To: <200801142238.17282.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Mon, Jan 14, 2008 at 10:38:17PM +0100, Bartlomiej Zolnierkiewicz wro=
te:
> > By the way, I have an Iomega ZIP 100 drive somewhere in my hardware=
 pile and
> > will do some testing with the "new" :) driver just in case.
>=20
> This would be great. :)
Hi Bart,

i just whipped rc8 along with your pata-2.6 tree on top and had several=
 test
runs of the ide-floppy driver (raw reads, software floppy disk eject, e=
tc) and
everything seems to work fine. I will keep this hardware setup here so =
that we
could at least test ide-floppy occasionally. We should probably acknowl=
edge this
major driver cleanup with a new driver version?

---
=46rom 6f948b93839cdf397cb38ca75c3c6cc9a21e6070 Mon Sep 17 00:00:00 200=
1
=46rom: Borislav Petkov <bbpetkov@yahoo.de>
Date: Sun, 20 Jan 2008 13:32:24 +0100
Subject: [PATCH] ide-floppy: bump driver version number

Acknowledge major ide-floppy code refactoring and cleanup by bumping th=
e driver
version number. Also, remove a wrong comment.

Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
---
 drivers/ide/ide-floppy.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 0bf6596..b455cf1 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -5,9 +5,6 @@
  * Copyright (C) 2000-2002  Paul Bristow <paul@paulbristow.net>
  * Copyright (C) 2005       Bartlomiej Zolnierkiewicz
  *
- * The driver currently doesn't have any fancy features, just the bare
- * minimum read/write support.
- *
  * This driver supports the following IDE floppy drives:
  *
  * LS-120/240 SuperDisk
@@ -18,7 +15,7 @@
  * Documentation/ide/ChangeLog.ide-floppy.1996-2002
  */

-#define IDEFLOPPY_VERSION "0.99.newide"
+#define IDEFLOPPY_VERSION "1.00"

 #include <linux/module.h>
 #include <linux/types.h>
--
1.5.3.7


--=20
Regards/Gru=DF,
    Boris.
