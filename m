From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH ] ide-{cd,floppy,tape}: Do not include <linux/irq.h>
Date: Thu, 20 Oct 2011 14:11:15 +0200
Message-ID: <1319112675-27523-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <petkovbb@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-ide@vger.kernel.org

The top of <linux/irq.h> has this comment:

 * Please do not include this file in generic code.  There is currently
 * no requirement for any architecture to implement anything held
 * within this file.
 *
 * Thanks. --rmk

Remove inclusion of <linux/irq.h>, to prevent the following compile err=
or
from happening soon:

| include/linux/irq.h:132: error: redefinition of =E2=80=98struct irq_d=
ata=E2=80=99
| include/linux/irq.h:286: error: redefinition of =E2=80=98struct irq_c=
hip=E2=80=99

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-ide@vger.kernel.org
---
RESEND: Fixed typo in commit message, as pointed out by Sergei Shtylyov
        <sshtylyov@mvista.com>

 drivers/ide/ide-cd.c     |    1 -
 drivers/ide/ide-floppy.c |    1 -
 drivers/ide/ide-tape.c   |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 04b0956..8126824 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -43,7 +43,6 @@
 /* For SCSI -> ATAPI command conversion */
 #include <scsi/scsi.h>
=20
-#include <linux/irq.h>
 #include <linux/io.h>
 #include <asm/byteorder.h>
 #include <linux/uaccess.h>
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 61fdf54..3d42043 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -35,7 +35,6 @@
 #include <scsi/scsi_ioctl.h>
=20
 #include <asm/byteorder.h>
-#include <linux/irq.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
 #include <asm/unaligned.h>
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 7ecb1ad..ce8237d 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -41,7 +41,6 @@
 #include <scsi/scsi.h>
=20
 #include <asm/byteorder.h>
-#include <linux/irq.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
 #include <asm/unaligned.h>
--=20
1.7.0.4
