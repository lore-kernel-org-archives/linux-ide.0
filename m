From: Sebastian Siewior <ide-bug@ml.breakpoint.cc>
Subject: Current git --> kaboom [bisect] seems IDE related.
Date: Sat, 9 Feb 2008 20:32:24 +0100
Message-ID: <20080209193224.GA21448@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:52327 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752435AbYBITc2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Feb 2008 14:32:28 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

Hello,

current git results in a freeze. I tracked it down to

|         error = type->get_sb(type, flags, name, data, mnt);
in vfs_kern_mount(), fs/super.c (what is called from mount_root() during
the boot process). I use XFS on my rootfs partition. After this, I
started to bisect.
During the bisect process I stepped into two things. The commit

|commit 813a0eb233ee67d7166241a8b389b6a76f2247f9
|Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
|Date:   Fri Jan 25 22:17:10 2008 +0100
|
|    ide: switch idedisk_prepare_flush() to use REQ_TYPE_ATA_TASKFILE requests
|
|    Based on the earlier work by Tejun Heo.
|
|    There should be no functionality changes caused by this patch.
|
|    Cc: Tejun Heo <htejun@gmail.com>
|    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
|
|:040000 040000 e4708c62aef233d2b07da20aedd644182258f1f1 66aea951e7c32aa82621d8460b0f97ff132f23a6 M      drivers
 
turned the working boot process into [1]. Since this isn't the freeze I
was looking I continued my bisect process. The commit
 
|10d90157c83d4b6743c9063c36f9e7f27aa254b6 is first bad commit
|commit 10d90157c83d4b6743c9063c36f9e7f27aa254b6
|Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
|Date:   Fri Jan 25 22:17:16 2008 +0100
|
|    ide: convert do_rw_taskfile() to use ->data_phase
|
|    * Use task->data_phase in do_rw_taskfile() to decide what to do.
|
|    * task->prehandler is only used by TASKFILE[_MULTI]_OUT so just
|      use pre_task_out_intr() directly and remove no longer needed
|      'prehandler' field from ide_task_t.
|
|    * Remove no longer needed ide_pre_handler_t type.
|
|    There should be no functionality changes caused by this patch.
|
|    Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
|    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
|
|:040000 040000 4197f4ab343f54f9eab32000df33eb118121f9fa e38665b62f3fc315e5b3bd9bb9c49bec4a961d43 M      drivers
|:040000 040000 a9abbd138a5713e16406fd63be0799e109849c53 3ee5fade5fc65ea1b41b6ca55b3de2dbb904623b M      include
 
turned the Oops into the freeze. There was no working commit in between
(well, git-bisect did not find one).

My .config [2], my lspci and cpuinfo [3].

[1] http://download.breakpoint.cc/lnx-2.6.24-post-crash.jpg
[2] http://download.breakpoint.cc/notebook-config.txt
[3] http://download.breakpoint.cc/system.txt

Sebastian
