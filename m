From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH] ide_tape: kill off use of the ->ioctl operation
Date: Mon, 04 Jan 2010 16:24:00 +0000
Message-ID: <20100104162354.17012.20586.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48877 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753517Ab0ADQrO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 11:47:14 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net, linux-ide@vger.kernel.org

Ready to get everything using unlocked_ioctl()

For ide_tape we just push down as this is legacy code anyway

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/ide/ide-tape.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)


diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 6a0e625..b072328 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1365,7 +1365,7 @@ static int idetape_mtioctop(ide_drive_t *drive, short mt_op, int mt_count)
  * supported here, and not in the corresponding block interface. Our own
  * ide-tape ioctls are supported on both interfaces.
  */
-static int idetape_chrdev_ioctl(struct inode *inode, struct file *file,
+static long do_idetape_chrdev_ioctl(struct file *file,
 				unsigned int cmd, unsigned long arg)
 {
 	struct ide_tape_obj *tape = file->private_data;
@@ -1420,6 +1420,16 @@ static int idetape_chrdev_ioctl(struct inode *inode, struct file *file,
 	}
 }
 
+static long idetape_chrdev_ioctl(struct file *file,
+				unsigned int cmd, unsigned long arg)
+{
+	long ret;
+	lock_kernel();
+	ret = do_idetape_chrdev_ioctl(file, cmd, arg);
+	unlock_kernel();
+	return ret;
+}
+
 /*
  * Do a mode sense page 0 with block descriptor and if it succeeds set the tape
  * block size with the reported value.
@@ -1888,7 +1898,7 @@ static const struct file_operations idetape_fops = {
 	.owner		= THIS_MODULE,
 	.read		= idetape_chrdev_read,
 	.write		= idetape_chrdev_write,
-	.ioctl		= idetape_chrdev_ioctl,
+	.unlocked_ioctl	= idetape_chrdev_ioctl,
 	.open		= idetape_chrdev_open,
 	.release	= idetape_chrdev_release,
 };

