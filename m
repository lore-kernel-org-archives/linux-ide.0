From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: libata : ata_dev_set_mode failed
Date: Sat, 13 May 2006 22:03:39 +0200
Message-ID: <pan.2006.05.13.20.03.38.622157@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:37779 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750736AbWEMUPF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 May 2006 16:15:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Ff0Vy-0001zA-HH
	for linux-ide@vger.kernel.org; Sat, 13 May 2006 22:15:02 +0200
Received: from cac94-1-81-57-151-96.fbx.proxad.net ([81.57.151.96])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 13 May 2006 22:15:02 +0200
Received: from castet.matthieu by cac94-1-81-57-151-96.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 13 May 2006 22:15:02 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

when using the pata driver for a via vt8235, the ata_dev_set_mode function
failed for one my ATAPI drive ( ata4: failed to set xfermode
(err_mask=0x4) ). This error doesn't happen if I put the drive on another
controller.

Using the old ide stack, there is a similar problem if I change the
xfermode with hdparm : there is an interrupt lost.
The interrupt is lost when calling ide_wait_cmd from ide_cmd_ioctl
(drivers/ide/ide-taskfile.c).
But there no problem in the ide initialisation, because
ide_cmd_ioctl (and ide_wait_cmd) isn't called in this case, but
ide_config_drive_speed is directly called.

In drivers/ide/ide-iops.c, ide_config_drive_speed have a comment
saying they can't use ide_wait_cmd because it could cause "lost interrupt"
[1]. Does the issue described in this comment are solved in libata or it
is the problem I am seeing with my drive ?


Matthieu

PS : my drive accept ide_wait_cmd or ata_dev_set_mode after I insert a CD
and doesn't wait to much (10-20 seconds).

[1]
	/*
         * Don't use ide_wait_cmd here - it will
         * attempt to set_geometry and recalibrate,
         * but for some reason these don't work at
         * this point (lost interrupt).
         */

