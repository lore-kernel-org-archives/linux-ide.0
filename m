From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [git pull] IDE fixes
Date: Sat, 27 Sep 2008 19:47:06 +0200
Message-ID: <200809271947.06723.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:28410 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756681AbYI0Rti convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Sep 2008 13:49:38 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1173021muf.1
        for <linux-ide@vger.kernel.org>; Sat, 27 Sep 2008 10:49:35 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

Linus, please pull from:

master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git/

to receive the following updates:

 Documentation/ioctl/cdrom.txt |    4 ++--
 drivers/ide/Kconfig           |   14 ++++++++++++++
 drivers/ide/ide-tape.c        |   10 +++++-----
 drivers/ide/mips/swarm.c      |    1 +
 4 files changed, 22 insertions(+), 7 deletions(-)


Borislav Petkov (1):
      ide-tape: fix vendor strings

M=E1rton N=E9meth (1):
      cdrom: update ioctl documentation

Ralf Baechle (1):
      Swarm: Fix crash due to missing initialization

Tejun Heo (1):
      ide: note that IDE generic may prevent other drivers from attachi=
ng


diff --git a/Documentation/ioctl/cdrom.txt b/Documentation/ioctl/cdrom.=
txt
index 62d4af4..59df81c 100644
--- a/Documentation/ioctl/cdrom.txt
+++ b/Documentation/ioctl/cdrom.txt
@@ -271,14 +271,14 @@ CDROMCLOSETRAY			pendant of CDROMEJECT
=20
 	usage:
=20
-	  ioctl(fd, CDROMEJECT, 0);
+	  ioctl(fd, CDROMCLOSETRAY, 0);
=20
 	inputs:		none
=20
 	outputs:	none
=20
 	error returns:
-	  ENOSYS	cd drive not capable of ejecting
+	  ENOSYS	cd drive not capable of closing the tray
 	  EBUSY		other processes are accessing drive, or door is locked
=20
 	notes:
diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index fc735ab..8e93a79 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -292,6 +292,20 @@ config IDE_GENERIC
 	tristate "generic/default IDE chipset support"
 	depends on ALPHA || X86 || IA64 || M32R || MIPS
 	help
+	  This is the generic IDE driver.  This driver attaches to the
+	  fixed legacy ports (e.g. on PCs 0x1f0/0x170, 0x1e8/0x168 and
+	  so on).  Please note that if this driver is built into the
+	  kernel or loaded before other ATA (IDE or libata) drivers
+	  and the controller is located at legacy ports, this driver
+	  may grab those ports and thus can prevent the controller
+	  specific driver from attaching.
+
+	  Also, currently, IDE generic doesn't allow IRQ sharing
+	  meaning that the IRQs it grabs won't be available to other
+	  controllers sharing those IRQs which usually makes drivers
+	  for those controllers fail.  Generally, it's not a good idea
+	  to load IDE generic driver on modern systems.
+
 	  If unsure, say N.
=20
 config BLK_DEV_PLATFORM
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 1bce84b..3833189 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -2338,7 +2338,7 @@ static void idetape_get_inquiry_results(ide_drive=
_t *drive)
 {
 	idetape_tape_t *tape =3D drive->driver_data;
 	struct ide_atapi_pc pc;
-	char fw_rev[6], vendor_id[10], product_id[18];
+	char fw_rev[4], vendor_id[8], product_id[16];
=20
 	idetape_create_inquiry_cmd(&pc);
 	if (idetape_queue_pc_tail(drive, &pc)) {
@@ -2350,11 +2350,11 @@ static void idetape_get_inquiry_results(ide_dri=
ve_t *drive)
 	memcpy(product_id, &pc.buf[16], 16);
 	memcpy(fw_rev, &pc.buf[32], 4);
=20
-	ide_fixstring(vendor_id, 10, 0);
-	ide_fixstring(product_id, 18, 0);
-	ide_fixstring(fw_rev, 6, 0);
+	ide_fixstring(vendor_id, 8, 0);
+	ide_fixstring(product_id, 16, 0);
+	ide_fixstring(fw_rev, 4, 0);
=20
-	printk(KERN_INFO "ide-tape: %s <-> %s: %s %s rev %s\n",
+	printk(KERN_INFO "ide-tape: %s <-> %s: %.8s %.16s rev %.4s\n",
 			drive->name, tape->name, vendor_id, product_id, fw_rev);
 }
=20
diff --git a/drivers/ide/mips/swarm.c b/drivers/ide/mips/swarm.c
index badf79f..39c9ee9 100644
--- a/drivers/ide/mips/swarm.c
+++ b/drivers/ide/mips/swarm.c
@@ -107,6 +107,7 @@ static int __devinit swarm_ide_probe(struct device =
*dev)
=20
 	base =3D ioremap(offset, size);
=20
+	memset(&hw, 0, sizeof(hw));
 	for (i =3D 0; i <=3D 7; i++)
 		hw.io_ports_array[i] =3D
 				(unsigned long)(base + ((0x1f0 + i) << 5));
