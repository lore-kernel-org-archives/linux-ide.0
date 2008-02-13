From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] printk: implement printk_header() and merging printk, take #3
Date: Wed, 13 Feb 2008 18:09:28 +0900
Message-ID: <12028937731333-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:24265 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbYBMJJt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 04:09:49 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3843088rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 01:09:49 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, jengelh@computergmbh.de, matthew@wil.cx, randy.dunlap@oracle.com, daniel.ritz-ml@swissonline.ch, linux-kernel@vger.kernel.org, akpm@linux-f

Hello, all.

This is the third take of implement-printk_header-and-mprintk
patchset.

Changes from the last take[L] are...

* Now header is printed on every line of a multiline message.  If the
  header ends with ':' followed by spaces.  The colon is replaced with
  space from the second line.

* s/mprintk/mprintk_flush/ and s/mprintk_add/mprintk/ as suggested.

* mprintk_init_alloc() and mprintk_free() added to ease malloc'd
  buffer handling.  No need to specify buffer size.  Sizing is left to
  mprintk.

This patchset aims to make printing multiline messages and assembling
message piece-by-piece easier.

In a nutshell, printk_header() lets you do the following atomically
(against other messages).

 code:
  printk(KERN_INFO "ata1.00: ", "line0\nline1\nline2\n");

 output:
  <6>ata1.00: line0
  <6>ata1.00  line1
  <6>ata1.00  line2

And mprintk the following.

 code:
  DEFINE_MPRINTK(mp, 2 * 80);

  mprintk_set_header(&mp, KERN_INFO "ata%u.%2u: ", 1, 0);
  mprintk_push(&mp, "ATA %d", 7);
  mprintk_push(&mp, ", %u sectors\n", 1024);
  mprintk(&mp, "everything seems dandy\n");

 output:
  <6>ata1.00: ATA 7, 1024 sectors
  <6>ata1.00  everything seems dandy

For more info, please read Documentation/printk.txt which is created
by the fourth patch.

This patchset is on top of

  linux-2.6#master (96b5a46e2a72dc1829370c87053e0cd558d58bc0)
+ printk-fix-possible-printk-buffer-overrun [1]
+ printk-implement-printk_buf-overflow-warning [2]

and contains the following patches.

0001-printk-keep-log-level-on-multiline-messages.patch
0002-printk-implement-v-printk_header.patch
0003-printk-implement-merging-printk.patch
0004-printk-add-Documentation-printk.txt.patch
0005-libata-make-libata-use-printk_header-and-mprintk.patch

 Documentation/00-INDEX      |    2 
 Documentation/printk.txt    |  724 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata-core.c   |  204 +++++++-----
 drivers/ata/libata-eh.c     |  182 +++++------
 drivers/ata/libata-pmp.c    |    5 
 drivers/ata/libata-scsi.c   |    6 
 drivers/ata/sata_inic162x.c |    2 
 drivers/ata/sata_nv.c       |    4 
 include/linux/kernel.h      |   85 +++++
 include/linux/libata.h      |   35 +-
 kernel/printk.c             |  435 ++++++++++++++++++++++++--
 11 files changed, 1453 insertions(+), 231 deletions(-)

If this gets acked, I think it's best to push it through libata-dev as
libata is the first user.

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/27317
[1] http://article.gmane.org/gmane.linux.kernel/639018
[2] http://article.gmane.org/gmane.linux.kernel/639029
