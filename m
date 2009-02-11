From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Bad module reference counter
Date: Wed, 11 Feb 2009 10:32:59 +0100
Message-ID: <200902111032.59225.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:20105 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439AbZBKJdL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Feb 2009 04:33:11 -0500
Received: from ebg226.internetdsl.tpnet.pl (HELO staszek-desktop.local) (stf_xl@wp.pl@[83.14.136.226])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
          for <linux-ide@vger.kernel.org>; 11 Feb 2009 10:33:04 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello.

I entered a problem with double decreasing module reference counter
where it become "negative", here is the usage scenario:

# modprobe at91_ide
# modprobe ide_gd_mod
# lsmod
Module                  Size  Used by    Not tainted
ide_gd_mod             22948  0
at91_ide                4672  0
ide_core               77020  2 ide_gd_mod,at91_ide
# rmmod ide_gd_mod
# lsmod
Module                  Size  Used by    Not tainted
at91_ide                4672 4294967295
ide_core               77020  1 at91_ide

Note when I first remove at91_ide module and then ide_gd_mod
everyting is ok.

I tired to debug issue and I did not found any suspicious in at91_ide.
I think probable reason is double free in ide-gd.c . Here is patch with
workaround (or maybe it is a real fix, but I'm not sure):

diff --git a/drivers/ide/ide-gd.c b/drivers/ide/ide-gd.c
index 7857b20..31ae04e 100644
--- a/drivers/ide/ide-gd.c
+++ b/drivers/ide/ide-gd.c
@@ -70,8 +70,6 @@ static void ide_gd_remove(ide_drive_t *drive)
 	del_gendisk(g);
 
 	drive->disk_ops->flush(drive);
-
-	ide_disk_put(idkp);
 }
 
 static void ide_disk_release(struct kref *kref)

If this patch is ok, maybe similar things need to be done also in ide-cd and
perhaps other device type modules.

Cheers
Stanislaw Gruszka
