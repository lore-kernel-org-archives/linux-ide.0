From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
Subject: [PATCH] cdrom: add TEAC CD-224E to the NO_AUTOCLOSE list
Date: Thu, 23 Oct 2008 13:51:58 +0200
Message-ID: <4900655E.7050906@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755717AbYJWLwW@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <petkovbb@gmail.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

=46rom: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>

The "TEAC CD-ROM CD-224E" cannot close its tray, so add it to the NO_AU=
TOCLOSE list. This
will correct the "Can close tray" field of /proc/sys/dev/cdrom/info.

Signed-off-by: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>
---
--- linux-2.6.27/drivers/ide/ide-cd.c.orig	2008-10-10 00:13:53.00000000=
0 +0200
+++ linux-2.6.27/drivers/ide/ide-cd.c	2008-10-23 11:34:59.000000000 +02=
00
@@ -1863,6 +1863,7 @@ static const struct cd_list_entry ide_cd
 	{ "Optiarc DVD RW AD-5200A", NULL,   IDE_AFLAG_PLAY_AUDIO_OK	     },
 	{ "Optiarc DVD RW AD-7200A", NULL,   IDE_AFLAG_PLAY_AUDIO_OK	     },
 	{ "Optiarc DVD RW AD-7543A", NULL,   IDE_AFLAG_NO_AUTOCLOSE	     },
+	{ "TEAC CD-ROM CD-224E",     NULL,   IDE_AFLAG_NO_AUTOCLOSE	     },
 	{ NULL, NULL, 0 }
 };
