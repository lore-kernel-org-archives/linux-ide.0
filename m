From: akpm@osdl.org
Subject: [patch 01/12] ATA must depend on BLOCK
Date: Fri, 20 Oct 2006 14:39:35 -0700
Message-ID: <200610202139.k9KLdZ2Q003562@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:53124 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946481AbWJTVnu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Oct 2006 17:43:50 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@osdl.org, bunk@stusta.de

=46rom: Adrian Bunk <bunk@stusta.de>

=46ix the following compile error with CONFIG_ATA=3Dy, CONFIG_BLOCK=3Dn=
:

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
:
warning: implicit declaration of function =E2=80=98blk_queue_max_phys_s=
egments=E2=80=99
make[3]: *** [drivers/ata/libata-scsi.o] Error 1

Bug report by Jesper Juhl.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/ata/Kconfig |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/ata/Kconfig~ata-must-depend-on-block drivers/ata/Kcon=
fig
--- a/drivers/ata/Kconfig~ata-must-depend-on-block
+++ a/drivers/ata/Kconfig
@@ -6,6 +6,7 @@ menu "Serial ATA (prod) and Parallel ATA
=20
 config ATA
 	tristate "ATA device support"
+	depends on BLOCK
 	depends on !(M32R || M68K) || BROKEN
 	depends on !SUN4 || BROKEN
 	select SCSI
_
