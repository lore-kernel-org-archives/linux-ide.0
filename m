From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc3 08/11] ide: remove REQ_DRIVE_TASK handling
Date: Thu, 24 Feb 2005 16:45:07 +0100
Message-ID: <58cb370e0502240745fcba7a3@mail.gmail.com>
References: <20050210083808.48E9DD1A@htj.dyndns.org>
	 <20050210083844.AD987173@htj.dyndns.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050210083844.AD987173@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-ide@vger.kernel.org

> @@ -945,33 +931,7 @@ static ide_startstop_t execute_drive_cmd
>                 if (args->tf_out_flags.all != 0)
>                         return flagged_taskfile(drive, args);
>                 return do_rw_taskfile(drive, args);
> -       } else if (rq->flags & REQ_DRIVE_TASK) {
> -               u8 *args = rq->buffer;
> -               u8 sel;
> -
> -               if (!args)
> -                       goto done;
> -#ifdef DEBUG
> -               printk("%s: DRIVE_TASK_CMD ", drive->name);
> -               printk("cmd=0x%02x ", args[0]);
> -               printk("fr=0x%02x ", args[1]);
> -               printk("ns=0x%02x ", args[2]);
> -               printk("sc=0x%02x ", args[3]);
> -               printk("lcyl=0x%02x ", args[4]);
> -               printk("hcyl=0x%02x ", args[5]);
> -               printk("sel=0x%02x\n", args[6]);
> -#endif
> -               hwif->OUTB(args[1], IDE_FEATURE_REG);
> -               hwif->OUTB(args[3], IDE_SECTOR_REG);
> -               hwif->OUTB(args[4], IDE_LCYL_REG);
> -               hwif->OUTB(args[5], IDE_HCYL_REG);
> -               sel = (args[6] & ~0x10);
> -               if (drive->select.b.unit)
> -                       sel |= 0x10;

do_rw_taskfile() always sets LBA bit in Device register for LBA
capable disks, so converting HDIO_DRIVE_TASK to use taskfile
transport removes (theoretical?) possibility of sending CHS
commands to LBA capable disks.

This issue is addressed in my patch series.
