From: Tejun Heo <tj@kernel.org>
Subject: Re: WARNING in ata_qc_issue
Date: Mon, 30 Oct 2017 08:23:00 -0700
Message-ID: <20171030152300.GG3252168@devbig577.frc2.facebook.com>
References: <001a11425956f5f3d0055c82f08d@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <001a11425956f5f3d0055c82f08d@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: syzbot <bot+f7b556d1766502a69d85071d2ff08bd87be53d0f@syzkaller.appspotmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
List-Id: linux-ide@vger.kernel.org

Hello,

On Fri, Oct 27, 2017 at 01:19:01AM -0700, syzbot wrote:
> WARNING: CPU: 1 PID: 2909 at drivers/ata/libata-core.c:5391
> ata_qc_issue+0x519/0xea0 drivers/ata/libata-core.c:5390
...
>  sg_common_write.isra.17+0xf80/0x1c10 drivers/scsi/sg.c:806
>  sg_write+0x7a0/0xc90 drivers/scsi/sg.c:677
>  __vfs_write+0xef/0x970 fs/read_write.c:468
>  vfs_write+0x189/0x510 fs/read_write.c:518
>  SYSC_write fs/read_write.c:565 [inline]
>  SyS_write+0xef/0x220 fs/read_write.c:557

It's issuing an invalid command (data command w/o any data) via SG and
libata triggered a warning before failing the command.  The warning is
still somewhat meaningful in that if we ever hit that during normal
kernel operation, it shows the caller who's screwing up.  idk, we can
shut it up (nothing is really wrong in this case) or make it a bit
smarter (filter out invalid sg commands earlier).

Thanks.

-- 
tejun
