From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6.19 patch] ATA must depend on BLOCK
Date: Mon, 9 Oct 2006 01:16:21 +0200
Message-ID: <20061008231621.GM6755@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51217 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932098AbWJHXQ1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Oct 2006 19:16:27 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Jesper Juhl <jesper.juhl@gmail.com>

This patch fixes the following compile error with CONFIG_ATA=3Dy,=20
CONFIG_BLOCK=3Dn:

<--  snip  -->

=2E..
  CC      drivers/ata/libata-scsi.o
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-scsi.c: In=
 function =E2=80=98ata_scsi_dev_config=E2=80=99:
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-scsi.c:791=
: warning: implicit declaration of function =E2=80=98blk_queue_max_sect=
ors=E2=80=99
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-scsi.c:799=
: error: =E2=80=98request_queue_t=E2=80=99 undeclared (first use in thi=
s function)
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-scsi.c:799=
: error: (Each undeclared identifier is reported only once
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-scsi.c:799=
: error: for each function it appears in.)
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-scsi.c:799=
: error: =E2=80=98q=E2=80=99 undeclared (first use in this function)
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-scsi.c:800=
: warning: implicit declaration of function =E2=80=98blk_queue_max_hw_s=
egments=E2=80=99
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-scsi.c: In=
 function =E2=80=98ata_scsi_slave_config=E2=80=99:
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ata/libata-scsi.c:831=
:=20
warning: implicit declaration of function =E2=80=98blk_queue_max_phys_s=
egments=E2=80=99
make[3]: *** [drivers/ata/libata-scsi.o] Error 1

<--  snip  -->

Bug report by Jesper Juhl.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6/drivers/ata/Kconfig.old	2006-10-08 23:40:05.000000000 +02=
00
+++ linux-2.6/drivers/ata/Kconfig	2006-10-08 23:40:55.000000000 +0200
@@ -6,6 +6,7 @@
=20
 config ATA
 	tristate "ATA device support"
+	depends on BLOCK
 	depends on !(M32R || M68K) || BROKEN
 	depends on !SUN4 || BROKEN
 	select SCSI

