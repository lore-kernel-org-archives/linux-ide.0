From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] printk: implement printk_header() and merging printk, take #2
Date: Mon, 21 Jan 2008 14:13:52 +0900
Message-ID: <1200892437108-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:17273 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbYAUFOE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 00:14:04 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3470939wah.23
        for <linux-ide@vger.kernel.org>; Sun, 20 Jan 2008 21:14:03 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: randy.dunlap@oracle.com, daniel.ritz-ml@swissonline.ch, matthew@wil.cx, jeff@garzik.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, all.

This is the second take of implement-printk_header-and-mprintk
patchset.

  Changes from the last take[L] are...

  * s/mprintk_push/mprintk_add/ and other changes suggested by Randy
    Dunlap.

  * mp->buf instead of mp->header to ease freeing kmalloc'd buffer
    later.

  * mprintk multiline log level handling fixed and improved.  mp->prv is
    removed and mp->flags is used to track whether header log level
    exists and log level is overridden.  One critical bug was re-using
    va_list more than once resulting in dereferences of wrong addresses.
    Fixed by using va_copy().

This patchset aims to make printing multiline messages and assembling
message piece-by-piece easier.

In a nutshell, printk_header() lets you do the following atomically
(against other messages).

 code:
  printk(KERN_INFO "ata1.00: ", "line0\nline1\nline2\n");

 output:
  <6>ata1.00: line0
  <6>         line1
  <6>         line2

And mprintk the following.

 code:
  DEFINE_MPRINTK(mp, 2 * 80);

  mprintk_set_header(&mp, KERN_INFO "ata%u.%2u: ", 1, 0);
  mprintk_push(&mp, "ATA %d", 7);
  mprintk_push(&mp, ", %u sectors\n", 1024);
  mprintk(&mp, "everything seems dandy\n");

 output:
  <6>ata1.00: ATA 7, 1024 sectors
  <6>         everything seems dandy

For more info, please read Documentation/printk.txt which is created
by the fourth patch.

This patchset is against the current linux-2.6#master (a7da60f4) and
contains the following patches.

0001-printk-keep-log-level-on-multiline-messages.patch
0002-printk-implement-v-printk_header.patch
0003-printk-implement-merging-printk.patch
0004-printk-add-Documentation-printk.txt.patch
0005-libata-make-libata-use-printk_header-and-mprintk.patch

 Documentation/00-INDEX      |    2 
 Documentation/printk.txt    |  711 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata-core.c   |  202 +++++++-----
 drivers/ata/libata-eh.c     |  150 ++++-----
 drivers/ata/libata-pmp.c    |    5 
 drivers/ata/libata-scsi.c   |    6 
 drivers/ata/sata_inic162x.c |    2 
 drivers/ata/sata_nv.c       |    4 
 include/linux/kernel.h      |   81 +++++
 include/linux/libata.h      |   35 +-
 kernel/printk.c             |  392 ++++++++++++++++++++++--
 11 files changed, 1379 insertions(+), 211 deletions(-)

Randy, Jeff, if this take gets acked, how about pushing this through
libata-dev as it's the first user and I have other libata changes
depending on mprintk?

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/27199
