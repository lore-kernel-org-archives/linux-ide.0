From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH] drivers/ide-cd: Handle missing driver data during status
 check gracefully
Date: Tue, 7 Nov 2017 17:37:24 +0100
Message-ID: <20171107163723.7u5iyvewrrjglqif@pd.tnic>
References: <20171107102538.mzbfdxll3fpf2kqg@wfg-t540p.sh.intel.com>
 <20171107104336.ojanuvgjgt5o53ox@pd.tnic>
 <20171107130626.dk5rxrprolvcne5w@wfg-t540p.sh.intel.com>
 <20171107140102.n2pncsaer5o5hmt7@pd.tnic>
 <CA+55aFxBEMsrqTPOST18iQ_VwNkFxqWq744W74M+8VVT2eL-3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:50472 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751755AbdKGQhn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 7 Nov 2017 11:37:43 -0500
Content-Disposition: inline
In-Reply-To: <CA+55aFxBEMsrqTPOST18iQ_VwNkFxqWq744W74M+8VVT2eL-3w@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>, IDE-ML <linux-ide@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@sandisk.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Nov 07, 2017 at 08:01:10AM -0800, Linus Torvalds wrote:
> Because this is not really worth spending a ton of effort on debugging
> (.. because IDE), but yes, the disassembly of the code clearly shows
> that the problem here is that 'info' is NULL.

Right.

> So adding the NULL guard and saying "we have a race somewhere in the
> IDE layer" and not wasting any more time on it is almost certainly the
> right thing to do.

I tried to reflect that situation in the commit message.

> Borislav, mind sending a signed-off patch or a pull request or whatever?

Here it is:

---
From: Borislav Petkov <bp@suse.de>
Subject: [PATCH] drivers/ide-cd: Handle missing driver data during status check gracefully

The 0day bot reports the below failure which happens occasionally, with
their randconfig testing (once every ~100 boots). The Code points at the
private pointer ->driver_data being NULL, which hints at a race of sorts
where the private driver_data descriptor has disappeared by the time we
get to run the workqueue.

So let's check that pointer before we continue with issuing the command
to the drive.

This fix is of the brown paper bag nature but considering that IDE is
long deprecated, let's do that so that random testing which happens to
enable CONFIG_IDE during randconfig builds, doesn't fail because of
this.

Besides, failing the TEST_UNIT_READY command because the drive private
data is gone is something which we could simply do anyway, to denote
that there was a problem communicating with the device.

  BUG: unable to handle kernel NULL pointer dereference at 000001c0
  IP: cdrom_check_status
  *pde = 00000000
  Oops: 0000 [#1] SMP
  CPU: 1 PID: 155 Comm: kworker/1:2 Not tainted 4.14.0-rc8 #127
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
  Workqueue: events_freezable_power_ disk_events_workfn
  task: 4fe90980 task.stack: 507ac000
  EIP: cdrom_check_status+0x2c/0x90
  EFLAGS: 00210246 CPU: 1
  EAX: 00000000 EBX: 4fefec00 ECX: 00000000 EDX: 00000000
  ESI: 00000003 EDI: ffffffff EBP: 467a9340 ESP: 507aded0
   DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
  CR0: 80050033 CR2: 000001c0 CR3: 06e0f000 CR4: 00000690
  Call Trace:
   ? ide_cdrom_check_events_real
   ? cdrom_check_events
   ? disk_check_events
   ? process_one_work
   ? process_one_work
   ? worker_thread
   ? kthread
   ? process_one_work
   ? __kthread_create_on_node
   ? ret_from_fork
  Code: 53 83 ec 14 89 c3 89 d1 be 03 00 00 00 65 a1 14 00 00 00 89 44 24 10 31 c0 8b 43 18 c7 44 24 04 00 00 00 00 c7 04 24 00 00 00 00 <8a> 80 c0 01 00 00 c7 44 24 08 00 00 00 00 83 e0 03 c7 44 24 0c
  EIP: cdrom_check_status+0x2c/0x90 SS:ESP: 0068:507aded0
  CR2: 00000000000001c0
  ---[ end trace 2410e586dd8f88b2 ]---

Reported-and-tested-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>
---
 drivers/ide/ide-cd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index a7355ab3bb22..6ff0be8cbdc9 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -867,11 +867,16 @@ static void msf_from_bcd(struct atapi_msf *msf)
 int cdrom_check_status(ide_drive_t *drive, struct request_sense *sense)
 {
 	struct cdrom_info *info = drive->driver_data;
-	struct cdrom_device_info *cdi = &info->devinfo;
+	struct cdrom_device_info *cdi;
 	unsigned char cmd[BLK_MAX_CDB];
 
 	ide_debug_log(IDE_DBG_FUNC, "enter");
 
+	if (!info)
+		return -EIO;
+
+	cdi = &info->devinfo;
+
 	memset(cmd, 0, BLK_MAX_CDB);
 	cmd[0] = GPCMD_TEST_UNIT_READY;
 
-- 
2.13.0

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
