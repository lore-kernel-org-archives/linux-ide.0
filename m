From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] ata: sata_dwc_460ex: remove incorrect locking
Date: Mon, 21 Dec 2015 22:41:17 +0200
Message-ID: <1450730477.30729.274.camel@linux.intel.com>
References: <1450721870-23266-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:47911 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751376AbbLUUlB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Dec 2015 15:41:01 -0500
In-Reply-To: <1450721870-23266-1-git-send-email-mans@mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Julian Margetson <runaway@candw.ms>

On Mon, 2015-12-21 at 18:17 +0000, Mans Rullgard wrote:
> This lock is already taken in ata_scsi_queuecmd() a few levels up the
> call stack so attempting to take it here is an error.=C2=A0=C2=A0More=
over, it
> is
> pointless in the first place since it only protects a single, atomic
> assignment.
>=20
> Enabling lock debugging gives the following output:
>=20

+Julian.

I think Julian may give his Tested-by: tag.

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ INFO: possible recursive locking detected ]
> 4.4.0-rc5+ #189 Not tainted
> ---------------------------------------------
> kworker/u2:3/37 is trying to acquire lock:
> =C2=A0(&(&host->lock)->rlock){-.-...}, at: [<90283294>]
> sata_dwc_exec_command_by_tag.constprop.14+0x44/0x8c
>=20
> but task is already holding lock:
> =C2=A0(&(&host->lock)->rlock){-.-...}, at: [<902761ac>]
> ata_scsi_queuecmd+0x2c/0x330
>=20
> other info that might help us debug this:
> =C2=A0Possible unsafe locking scenario:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CPU0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0----
> =C2=A0 lock(&(&host->lock)->rlock);
> =C2=A0 lock(&(&host->lock)->rlock);
>=20
> =C2=A0*** DEADLOCK ***
> =C2=A0May be due to missing lock nesting notation
>=20
> 4 locks held by kworker/u2:3/37:
> =C2=A0#0:=C2=A0=C2=A0("events_unbound"){.+.+.+}, at: [<9003a0a4>]
> process_one_work+0x12c/0x430
> =C2=A0#1:=C2=A0=C2=A0((&entry->work)){+.+.+.}, at: [<9003a0a4>]
> process_one_work+0x12c/0x430
> =C2=A0#2:=C2=A0=C2=A0(&bdev->bd_mutex){+.+.+.}, at: [<9011fd54>]
> __blkdev_get+0x50/0x380
> =C2=A0#3:=C2=A0=C2=A0(&(&host->lock)->rlock){-.-...}, at: [<902761ac>=
]
> ata_scsi_queuecmd+0x2c/0x330
>=20
> stack backtrace:
> CPU: 0 PID: 37 Comm: kworker/u2:3 Not tainted 4.4.0-rc5+ #189
> Workqueue: events_unbound async_run_entry_fn
> Stack : 90b38e30 00000021 00000003 9b2a6040 00000000 9005f3f0
> 904fc8dc 00000025
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0906b96e4 00000000 905=
28648 9b3336c4 904fc8dc 9009bf18
> 00000002 00000004
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A000000000 00000000 9b3=
336c4 9b3336e4 904fc8dc 9003d074
> 00000000 90500000
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A09005e738 00000000 000=
00000 00000000 00000000 00000000
> 00000000 00000000
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A06e657665 755f7374 756=
f626e 0000646e 00000000 00000000
> 9b00ca00 9b025000
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0...
> Call Trace:
> [<90009d6c>] show_stack+0x88/0xa4
> [<90057744>] __lock_acquire+0x1ce8/0x2154
> [<900583e4>] lock_acquire+0x64/0x8c
> [<9045ff10>] _raw_spin_lock_irqsave+0x54/0x78
> [<90283294>] sata_dwc_exec_command_by_tag.constprop.14+0x44/0x8c
> [<90283484>] sata_dwc_qc_issue+0x1a8/0x24c
> [<9026b39c>] ata_qc_issue+0x1f0/0x410
> [<90273c6c>] ata_scsi_translate+0xb4/0x200
> [<90276234>] ata_scsi_queuecmd+0xb4/0x330
> [<9025800c>] scsi_dispatch_cmd+0xd0/0x128
> [<90259934>] scsi_request_fn+0x58c/0x638
> [<901a3e50>] __blk_run_queue+0x40/0x5c
> [<901a83d4>] blk_queue_bio+0x27c/0x28c
> [<901a5914>] generic_make_request+0xf0/0x188
> [<901a5a54>] submit_bio+0xa8/0x194
> [<9011adcc>] submit_bh_wbc.isra.23+0x15c/0x17c
> [<9011c908>] block_read_full_page+0x3e4/0x428
> [<9009e2e0>] do_read_cache_page+0xac/0x210
> [<9009fd90>] read_cache_page+0x18/0x24
> [<901bbd18>] read_dev_sector+0x38/0xb0
> [<901bd174>] msdos_partition+0xb4/0x5c0
> [<901bcb8c>] check_partition+0x140/0x274
> [<901bba60>] rescan_partitions+0xa0/0x2b0
> [<9011ff68>] __blkdev_get+0x264/0x380
> [<901201ac>] blkdev_get+0x128/0x36c
> [<901b9378>] add_disk+0x3c0/0x4bc
> [<90268268>] sd_probe_async+0x100/0x224
> [<90043a44>] async_run_entry_fn+0x50/0x124
> [<9003a11c>] process_one_work+0x1a4/0x430
> [<9003a4f4>] worker_thread+0x14c/0x4fc
> [<900408f4>] kthread+0xd0/0xe8
> [<90004338>] ret_from_kernel_thread+0x14/0x1c
>=20
> Fixes: 62936009f35a ("[libata] Add 460EX on-chip SATA driver,
> sata_dwc_460ex")
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
> =C2=A0drivers/ata/sata_dwc_460ex.c | 4 +---
> =C2=A01 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/ata/sata_dwc_460ex.c
> b/drivers/ata/sata_dwc_460ex.c
> index 902034991517..7a7faca0ddcd 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -924,15 +924,13 @@ static void sata_dwc_exec_command_by_tag(struct
> ata_port *ap,
> =C2=A0					=C2=A0struct ata_taskfile *tf,
> =C2=A0					=C2=A0u8 tag, u32 cmd_issued)
> =C2=A0{
> -	unsigned long flags;
> =C2=A0	struct sata_dwc_device_port *hsdevp =3D HSDEVP_FROM_AP(ap);
> =C2=A0
> =C2=A0	dev_dbg(ap->dev, "%s cmd(0x%02x): %s tag=3D%d\n", __func__,
> tf->command,
> =C2=A0		ata_get_cmd_descript(tf->command), tag);
> =C2=A0
> -	spin_lock_irqsave(&ap->host->lock, flags);
> =C2=A0	hsdevp->cmd_issued[tag] =3D cmd_issued;
> -	spin_unlock_irqrestore(&ap->host->lock, flags);
> +
> =C2=A0	/*
> =C2=A0	=C2=A0* Clear SError before executing a new command.
> =C2=A0	=C2=A0* sata_dwc_scr_write and read can not be used here.
> Clearing the PM

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

