From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCH] 2.6.x libata fix
Date: Thu, 21 Oct 2004 13:48:12 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041021174812.GA21850@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.28.190.101]:55457 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S270769AbUJURsS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Oct 2004 13:48:18 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org


Please do a

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 drivers/scsi/sata_sil.c |    1 +
 1 files changed, 1 insertion(+)

through these ChangeSets:

<akpm@osdl.org> (04/10/20 1.2255)
   [PATCH] sata_sil mod15 quirk with Seagate ST3120026AS
   
   From: <stuart@cybertherial.com>
   
   Hardware Environment: AMD64, sil3512 controller on m/b.  Harddrive: Seagate
   120GB ST3120026AS
   
   Problem Description: Drive would lock when writing large files, eg video
   from firewire, audio editing.  Checked dmesg, was obviously the sata drive.
   
   Have added the drive to the blacklist in sata_sil.c and the problem seems
   to have disappeared.
   
   Is there a good test to verify that the mod15 bug is really the problem?
   
   Signed-off-by: Andrew Morton <akpm@osdl.org>

diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	2004-10-21 13:47:46 -04:00
+++ b/drivers/scsi/sata_sil.c	2004-10-21 13:47:46 -04:00
@@ -87,6 +87,7 @@
 	{ "ST380023AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST3120023AS",	SIL_QUIRK_MOD15WRITE },
 	{ "ST3160023AS",	SIL_QUIRK_MOD15WRITE },
+	{ "ST3120026AS",	SIL_QUIRK_MOD15WRITE },
 	{ "ST340014ASL",	SIL_QUIRK_MOD15WRITE },
 	{ "ST360014ASL",	SIL_QUIRK_MOD15WRITE },
 	{ "ST380011ASL",	SIL_QUIRK_MOD15WRITE },
